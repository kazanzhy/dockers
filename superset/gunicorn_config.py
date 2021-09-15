bind = '0.0.0.0:8088'
daemon = False
reload = True
reload_engine = 'auto' # ('auto' | 'poll' | 'inotify')

workers = 4
worker_class = 'gevent'

timeout = 180
limit_request_line = 0
limit_request_field_size = 0
statsd_host = 'localhost:8125'