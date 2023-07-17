# docker_elasticsearch_exec

Custom Docker image to be used with [BEAURIS](https://gitlab.com/beaur1s/beauris)

Will create a custom user, *chown* ES data to that user, launch ES, and run a user command.

NB: Due to bash limitation (no dot in variable name), the usual ES env variables, such as `xpack.security.enabled`, will not work if this image is launched from a gitlab-ci file.

You can avoid this by setting the "ES_ARGS" variable, and it will be added to the launch script.
Please include the "-E" before your variable, like so: *-Ediscovery.type=single-node*

If no user command is provided, it will simply launch ES in the foreground.

Available env variables:

```
ES_ARGS: (Optional) ES env variables, formatted as such: "-Ediscovery.type=single-node"
ES_USER: (Optional, require UID) Custom ES user. Default to 'elasticsearch'
ES_UID: (Optional), require RUN_USER) Custom ES user UID.
RUN_USER: (Optional, require UID) Custom user for custom command
UID: (Optional), require RUN_USER) Custom user UID for custom command
```
