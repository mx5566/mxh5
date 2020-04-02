

(function() {
	if (window.qb_bridge == undefined) {
		// check ua to make sure it's our lite version instead of other browsers
		var ua = navigator.userAgent.toLowerCase();
		if (ua.indexOf('mqqbrowser/5') != -1) {
			window.qb_bridge = {
				nativeExec : function(service, action, callbackId, argsJson) {
					return prompt(argsJson, 'mtt:[' + [service, action, callbackId] + ']');
				}
			};
		} else {
			console.warn('Not a qq browser or version too old');
			return;
		}
	}


	qb_bridge.callbackId = Math.floor(Math.random() * 2000000000);
	qb_bridge.callbacks = {};

	qb_bridge.exec = function(success, fail, service, action, args) {
		var callbackId = service + qb_bridge.callbackId++,
			argsJson = args ? JSON.stringify(args) : "";

		if (success || fail) {
			qb_bridge.callbacks[callbackId] = {success:success, fail:fail};
		}

		var ret = qb_bridge.nativeExec(service, action, callbackId, argsJson);
		if (ret === 'true') {
			return true;
		} else if (ret === 'false') {
			return false;
		} else {
			return ret;
		}
	};

	qb_bridge.callbackFromNative = function(callbackId, args) {
		var callback = qb_bridge.callbacks[callbackId];
		var argsJson = JSON.parse(args); 

		if (callback) {
			if (argsJson.succ) {
				callback.success && callback.success(argsJson.msg);
			} else {
				callback.fail && callback.fail(argsJson.msg);
			}

			if (!argsJson.keep) {
				delete qb_bridge.callbacks[callbackId];
			}
		}
	};

	qb_bridge.createEvent = function(type, data) {
	    var event = document.createEvent('Events');
	    event.initEvent(type, false, false);
	    if (data) {
	        for (var i in data) {
	            if (data.hasOwnProperty(i)) {
	                event[i] = data[i];
	            }
	        }
	    }
	    return event;
	}

	qb_bridge.fireEvent = function(type, params) {
		var channel = qb_channel[type];
		if (channel) {
			var data = params && JSON.parse(params);
			var evt = qb_bridge.createEvent(type, data);
			channel.fire(evt);
		};
	}


	var QbChannel = function (type) {
		this.type = type;
		this.handlers = {};
		this.numHandlers = 0;
		this.onHasSubscribersChange = null;
	}
	,
	    qb_channel = {
	        create: function(type) {
	            return qb_channel[type] = new QbChannel(type);
	        },
	        nextGuid: 0,
	    };

	QbChannel.prototype.subscribe = function(f) {
	    var func = f,
	        guid = f.observer_guid;

	    if (!guid) {
	        // first time any channel has seen this subscriber
	        guid = '' + qb_channel.nextGuid++;
	    }
	    func.observer_guid = guid;
	    f.observer_guid = guid;

	    // Don't add the same handler more than once.
	    if (!this.handlers[guid]) {
	        this.handlers[guid] = func;
	        this.numHandlers++;
	        if (this.numHandlers == 1) {
	            this.onHasSubscribersChange && this.onHasSubscribersChange();
	        }
	    }
	};

	/**
	 * Unsubscribes the function with the given guid from the channel.
	 */
	QbChannel.prototype.unsubscribe = function(f) {
	    var guid = f.observer_guid,
	        handler = this.handlers[guid];
	    if (handler) {
	        delete this.handlers[guid];
	        this.numHandlers--;
	        if (this.numHandlers === 0) {
	            this.onHasSubscribersChange && this.onHasSubscribersChange();
	        }
	    }
	};

	/**
	 * Calls all functions subscribed to this channel.
	 */
	QbChannel.prototype.fire = function(e) {
	    if (this.numHandlers) {
	        // Copy the values first so that it is safe to modify it from within
	        // callbacks.
	        var toCall = [];
	        for (var item in this.handlers) {
	            toCall.push(this.handlers[item]);
	        }
	        for (var i = 0; i < toCall.length; ++i) {
	            toCall[i](e);
	        }
	    }
	};

	window.qb = {
		/**
		 * QQ浏览器版本号，如"5.0"
		 *
		 * @since 5.0
		 */
		get appVersion() { return qb_bridge.exec(null, null, "qb", "appVersion", null);},

		/**
		 * QQ浏览器UA
		 *
		 * @since 5.0
		 */
		get qua() { return qb_bridge.exec(null, null, "qb", "qua", null); },

		/**
		 * 调起浏览器分享界面
		 *
		 * @param {ShareParams} params 
		 * @since 5.0
		 */
		share : function(params) {
			qb_bridge.exec(null, null, "qb", "share", params);
		},

		/**
		 * 显示native的toast弹框
		 *
		 * @param {String} text 要显示的消息文本
		 * @param {Integer} duration 消息显示时长，必须是0或者1. 0较短，1较长
		 */
		toast : function(text, duration) {
			qb_bridge.exec(null, null, "qb", "toast", {text: text, duration: duration});
		},

		/**
		 * 播放系统beep提示音
		 *
		 * @param {Integer} times 播放次数
		 */
		beep : function(times) {
			qb_bridge.exec(null, null, 'qb', 'beep', {times: times});
		},

		/**
		 * 手机震动
		 *
		 * @param {Long} milliseconds 震动时间（毫秒）
		 */
		vibrate : function(milliseconds) {
			qb_bridge.exec(null, null, 'qb', 'vibrate', {milliseconds: milliseconds});
		},


		/**
		 * 添加QQ浏览器扩展事件监听器。
		 *
		 * @param {String} type 'onvolumedown' | 'onvolumeup'
		 * @param {Function} handler 事件回调函数
		 * @param {Boolean} capture 
		 */
		addEventListener : function(type, handler, capture) {
			if (type !== 'onvolumedown' && type !== 'onvolumeup') {
					return;
			}

			var channel = qb_channel[type];
			if (!channel) {
				channel = qb_channel.create(type);
				channel.onHasSubscribersChange = function() {
					qb_bridge.exec(null, null, "qb", "subscribeChanged", {numHandlers:this.numHandlers, type:type});
				}
			}
			channel.subscribe(handler);
		},

		/**
		 * 移除QQ浏览器扩展事件监听器
		 */
		removeEventListener : function(type, handler, capture) {
			if (type !== 'onvolumedown' && type !== 'onvolumeup') {
					return;
			}

			var channel = qb_channel[type];
			if (channel) {
				channel.unsubscribe(handler);
			};
		},

		/**
		 * 设备相关信息
		 *
		 * @since 5.0
		 */
		device : {
			/**
			 * 操作系统版本，如2.3
			 *
			 * @since 5.0
			 */
			get version() { return qb_bridge.exec(null, null, "device", "version", null);},

			/**
			 * 厂商定义的设备型号
			 *
			 * @since 5.0
			 */
			get model() { return qb_bridge.exec(null, null, "device", "model", null);},

			/**
			 * 设备平台（Android）
			 *
			 * @since 5.0
			 */
			get platform() { return qb_bridge.exec(null, null, "device", "platform", null);}, 
		},

		skin : {
			/**
			 * 获取当前是否是夜间模式
			 *
			 * @since 5.0
			 */
			get nightmodeEnabled() {
				return qb_bridge.exec(null, null, "skin", "nightmodeEnabled", null);
			}
		},

		connection : {
			/**
			 * 获取当前网络连接的类型：'none', 'wifi', '2g', '3g', 'unknown'
			 *
			 * @return {String}
			 * @since 5.0
			 */
			get type() {
				return qb_bridge.exec(null, null, "connection", "type", null);
			},

			/**
			 * 监听网络切换事件。
			 *
			 * @param {String} type 'onchange'
			 * @param {Function} handler 网络切换事件处理函数
			 *
			 * @since 5.0
			 */
			addEventListener : function(type, handler, capture) {
				if (type !== 'onchange') {
					return;
				}

				var realType = 'onconnectionchange';
				var channel = qb_channel[realType];
				if (!channel) {
					channel = qb_channel.create(realType);
					channel.onHasSubscribersChange = function() {
						qb_bridge.exec(null, null, "connection", "subscribeChanged", {numHandlers:this.numHandlers});
					}
				}
				channel.subscribe(handler);
			},

			/**
			 * 移除网络切换事件监听。
			 *
			 * @param type 'onchange'
			 */
			removeEventListener : function(type, handler, capture) {
				if (type !== 'onchange') {
					return;
				}

				var realType = 'onconnectionchange';
				var channel = qb_channel[realType];
				if (channel) {
					channel.unsubscribe(handler);
				};
			},
		},

		/**
		 * 屏幕控制。基于W3C Screen Orientation API
		 *
		 * @since 5.0
		 */
		screen : {
			/**
			 * 当前屏幕方向（'portrait' | 'landscape')
			 *
			 * @since 5.0
			 */
			get orientation() { return qb_bridge.exec(null, null, "screen", "orientation", null);},

			/**
			 * 锁定屏幕方向
			 *
			 * @param orientation 'portrait' | 'landscape'
			 *
			 * @return {Boolean} true 成功, false 非法参数
			 *
			 * @since 5.0
			 */
			lockOrientation : function(orientation) {
				return qb_bridge.exec(null, null, "screen", "lockOrientation", {"orientation" : orientation});
			},

			/**
			 * 取消屏幕锁定。
			 *
			 * @since 5.0
			 */
			unlockOrientation : function() {
				qb_bridge.exec(null, null, "screen", "unlockOrientation", null);
			},

			/**
			 * 获取当前是否全屏状态。
			 *
			 * @since 5.0
			 */
			get fullscreenEnabled() {
				return qb_bridge.exec(null, null, "screen", "fullscreenEnabled", null);
			},

			/**
			 * 请求全屏模式，全屏以后浏览器地址栏和工具栏将不在显示。注：轻应用框架中暂不支持全屏模式
			 *
			 * @since 5.0
			 */
			requestFullscreen : function() {
				return qb_bridge.exec(null, null, "screen", "requestFullScreen", null);
			},

			/**
			 * 退出全屏模式。注：退出全屏不会改变用户设置；如果用户设置了全屏模式，调用该函数以后浏览器将保持全屏模式。
			 *
			 * @since 5.0
			 */
			exitFullscreen : function() {
				return qb_bridge.exec(null, null, "screen", "exitFullScreen", null);
			},

			/**
			 * 监听旋转屏幕方向事件
			 *
			 * @param {String} type 'onorientationchange'
			 * @param {Function} handler 屏幕旋转事件回调函数
			 * @param {Boolean} capture
			 *
			 * @since 5.0
			 */
			addEventListener : function(type, handler, capture) {
				if (type !== 'onorientationchange') {
					return;
				}

				var channel = qb_channel['onorientationchange'];
				if (!channel) {
					channel = qb_channel.create('onorientationchange');
					channel.onHasSubscribersChange = function() {
						qb_bridge.exec(null, null, "screen", "subscribeChanged", {numHandlers:this.numHandlers});
					}
				}
				channel.subscribe(handler);
			},

			removeEventListener : function(type, handler, capture) {
				var channel = qb_channel[type];
				if (channel) {
					channel.unsubscribe(handler);
				};
			},
		},

		push : {
			/**
			 * 向QQ浏览器push后台注册。
			 *
			 * @param {String} uid 用户id
			 * @param {String} feature
			 * @param {Function} callback 后台返回注册结果回调
			 *
			 * @since 5.0
			 */
			tokenFeature: function(uid, feature, callback) {
				return qb_bridge.exec(callback, null, "push", "tokenFeature", {uid: uid, feature: feature});
			}
		},
	};
})();