# Logstash
Logstash is a tool to collect, process, and forward events and log messages. Collection is accomplished via configurable input plugins including raw socket/packet communication, file tailing, and several message bus clients. There are many built-in patterns and plugins that are supported out-of-the-box by Logstash for filtering items such as words, numbers, and dates. If we cannot find the pattern we need, we can write own custom pattern. In our dCache billing log use-case so far, we put our pattern based on a standard dCache logstash template (Ref X).

## Logstash configuraiton for dCache billing log
