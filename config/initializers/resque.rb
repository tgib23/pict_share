# -*- coding: utf-8 -*-
Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:pictcollect:#{Rails.env}" # アプリ毎に異なるnamespaceを定義しておく
