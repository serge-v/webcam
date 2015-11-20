watchdogd \
-n -d -t 8 \
--pretimeout 5 \
--pretimeout-action printf,log \
--softtimeout \
--softtimeout-action printf,log \
-e 'sleep 60' -w

