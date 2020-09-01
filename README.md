# EdgeIQ Evaluation Kit

## Requirements to run these scripts
These scripts assume that you are working with the following test environment or similar:

`host` - PC, Macbook, VM, etc. - used to run scripts and SSH to gateway
`gateway` - Embedded x86 or ARM device, Raspberry Pi 3/4, AWS VM, etc. - runs `edge` software
`sensors` - temp, voltage, motion, target to ping/poll SNMP

![enter image description here](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggUkxcblxuICBzdWJncmFwaCBMQU5cbiAgICBDKFtHYXRld2F5XSkgLS0tIHxtb2RidXN8IEooW3NlbnNvciAxXSlcbiAgICBDKFtHYXRld2F5XSkgLS4tIHxzbm1wfCBLKFtzZW5zb3IgMl0pXG4gICAgQyhbR2F0ZXdheV0pIC0uLSB8aHR0cHwgTChbc2Vuc29yIDNdKVxuICBlbmRcbiAgICBzdWJncmFwaCBJbnRlcm5ldFxuICAgICAgQVsoRWRnZUlRIEFQSSldID09PSBDKFtHYXRld2F5XSlcbiAgICBlbmRcbiAgICBzdWJncmFwaCBob3N0W01hY2Jvb2tdXG4gICAgICBFW2hvc3RdIC0uLT4gfGh0dHBzfCBBWyhFZGdlSVEgQVBJKV1cbiAgICAgIEVbaG9zdF0gLS4tIHxzc2h8IEMoW0dhdGV3YXldKVxuICAgIGVuZCIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0IiwidGhlbWVWYXJpYWJsZXMiOnsiYmFja2dyb3VuZCI6IndoaXRlIiwicHJpbWFyeUNvbG9yIjoiI0VDRUNGRiIsInNlY29uZGFyeUNvbG9yIjoiI2ZmZmZkZSIsInRlcnRpYXJ5Q29sb3IiOiJoc2woODAsIDEwMCUsIDk2LjI3NDUwOTgwMzklKSIsInByaW1hcnlCb3JkZXJDb2xvciI6ImhzbCgyNDAsIDYwJSwgODYuMjc0NTA5ODAzOSUpIiwic2Vjb25kYXJ5Qm9yZGVyQ29sb3IiOiJoc2woNjAsIDYwJSwgODMuNTI5NDExNzY0NyUpIiwidGVydGlhcnlCb3JkZXJDb2xvciI6ImhzbCg4MCwgNjAlLCA4Ni4yNzQ1MDk4MDM5JSkiLCJwcmltYXJ5VGV4dENvbG9yIjoiIzEzMTMwMCIsInNlY29uZGFyeVRleHRDb2xvciI6IiMwMDAwMjEiLCJ0ZXJ0aWFyeVRleHRDb2xvciI6InJnYig5LjUwMDAwMDAwMDEsIDkuNTAwMDAwMDAwMSwgOS41MDAwMDAwMDAxKSIsImxpbmVDb2xvciI6IiMzMzMzMzMiLCJ0ZXh0Q29sb3IiOiIjMzMzIiwibWFpbkJrZyI6IiNFQ0VDRkYiLCJzZWNvbmRCa2ciOiIjZmZmZmRlIiwiYm9yZGVyMSI6IiM5MzcwREIiLCJib3JkZXIyIjoiI2FhYWEzMyIsImFycm93aGVhZENvbG9yIjoiIzMzMzMzMyIsImZvbnRGYW1pbHkiOiJcInRyZWJ1Y2hldCBtc1wiLCB2ZXJkYW5hLCBhcmlhbCIsImZvbnRTaXplIjoiMTZweCIsImxhYmVsQmFja2dyb3VuZCI6IiNlOGU4ZTgiLCJub2RlQmtnIjoiI0VDRUNGRiIsIm5vZGVCb3JkZXIiOiIjOTM3MERCIiwiY2x1c3RlckJrZyI6IiNmZmZmZGUiLCJjbHVzdGVyQm9yZGVyIjoiI2FhYWEzMyIsImRlZmF1bHRMaW5rQ29sb3IiOiIjMzMzMzMzIiwidGl0bGVDb2xvciI6IiMzMzMiLCJlZGdlTGFiZWxCYWNrZ3JvdW5kIjoiI2U4ZThlOCIsImFjdG9yQm9yZGVyIjoiaHNsKDI1OS42MjYxNjgyMjQzLCA1OS43NzY1MzYzMTI4JSwgODcuOTAxOTYwNzg0MyUpIiwiYWN0b3JCa2ciOiIjRUNFQ0ZGIiwiYWN0b3JUZXh0Q29sb3IiOiJibGFjayIsImFjdG9yTGluZUNvbG9yIjoiZ3JleSIsInNpZ25hbENvbG9yIjoiIzMzMyIsInNpZ25hbFRleHRDb2xvciI6IiMzMzMiLCJsYWJlbEJveEJrZ0NvbG9yIjoiI0VDRUNGRiIsImxhYmVsQm94Qm9yZGVyQ29sb3IiOiJoc2woMjU5LjYyNjE2ODIyNDMsIDU5Ljc3NjUzNjMxMjglLCA4Ny45MDE5NjA3ODQzJSkiLCJsYWJlbFRleHRDb2xvciI6ImJsYWNrIiwibG9vcFRleHRDb2xvciI6ImJsYWNrIiwibm90ZUJvcmRlckNvbG9yIjoiI2FhYWEzMyIsIm5vdGVCa2dDb2xvciI6IiNmZmY1YWQiLCJub3RlVGV4dENvbG9yIjoiYmxhY2siLCJhY3RpdmF0aW9uQm9yZGVyQ29sb3IiOiIjNjY2IiwiYWN0aXZhdGlvbkJrZ0NvbG9yIjoiI2Y0ZjRmNCIsInNlcXVlbmNlTnVtYmVyQ29sb3IiOiJ3aGl0ZSIsInNlY3Rpb25Ca2dDb2xvciI6InJnYmEoMTAyLCAxMDIsIDI1NSwgMC40OSkiLCJhbHRTZWN0aW9uQmtnQ29sb3IiOiJ3aGl0ZSIsInNlY3Rpb25Ca2dDb2xvcjIiOiIjZmZmNDAwIiwidGFza0JvcmRlckNvbG9yIjoiIzUzNGZiYyIsInRhc2tCa2dDb2xvciI6IiM4YTkwZGQiLCJ0YXNrVGV4dExpZ2h0Q29sb3IiOiJ3aGl0ZSIsInRhc2tUZXh0Q29sb3IiOiJ3aGl0ZSIsInRhc2tUZXh0RGFya0NvbG9yIjoiYmxhY2siLCJ0YXNrVGV4dE91dHNpZGVDb2xvciI6ImJsYWNrIiwidGFza1RleHRDbGlja2FibGVDb2xvciI6IiMwMDMxNjMiLCJhY3RpdmVUYXNrQm9yZGVyQ29sb3IiOiIjNTM0ZmJjIiwiYWN0aXZlVGFza0JrZ0NvbG9yIjoiI2JmYzdmZiIsImdyaWRDb2xvciI6ImxpZ2h0Z3JleSIsImRvbmVUYXNrQmtnQ29sb3IiOiJsaWdodGdyZXkiLCJkb25lVGFza0JvcmRlckNvbG9yIjoiZ3JleSIsImNyaXRCb3JkZXJDb2xvciI6IiNmZjg4ODgiLCJjcml0QmtnQ29sb3IiOiJyZWQiLCJ0b2RheUxpbmVDb2xvciI6InJlZCIsImxhYmVsQ29sb3IiOiJibGFjayIsImVycm9yQmtnQ29sb3IiOiIjNTUyMjIyIiwiZXJyb3JUZXh0Q29sb3IiOiIjNTUyMjIyIiwiY2xhc3NUZXh0IjoiIzEzMTMwMCIsImZpbGxUeXBlMCI6IiNFQ0VDRkYiLCJmaWxsVHlwZTEiOiIjZmZmZmRlIiwiZmlsbFR5cGUyIjoiaHNsKDMwNCwgMTAwJSwgOTYuMjc0NTA5ODAzOSUpIiwiZmlsbFR5cGUzIjoiaHNsKDEyNCwgMTAwJSwgOTMuNTI5NDExNzY0NyUpIiwiZmlsbFR5cGU0IjoiaHNsKDE3NiwgMTAwJSwgOTYuMjc0NTA5ODAzOSUpIiwiZmlsbFR5cGU1IjoiaHNsKC00LCAxMDAlLCA5My41Mjk0MTE3NjQ3JSkiLCJmaWxsVHlwZTYiOiJoc2woOCwgMTAwJSwgOTYuMjc0NTA5ODAzOSUpIiwiZmlsbFR5cGU3IjoiaHNsKDE4OCwgMTAwJSwgOTMuNTI5NDExNzY0NyUpIn19LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)
Bash scripts are executed from a host, and will be using SSH to install the edge software on your gateway device.

* `bash` - version 4.x or newer
* `curl` - tested against curl version 7.64.1
* `jq` - tested against version 1.6. See: <https://stedolan.github.io/jq>

Test environment:

## Setup

Update the [`setenv.sh`](setenv.sh) file with your

* EdgeIQ username and password
* SSH username for your gateway device
* Your gateway device MAC address and associated IP address
* Configure EdgeIQ Device Type - defaults to Raspberry Pi 3/4 running recent Debian/Ubuntu linux

## Examples

* EdgeIQ Portal: <https://app.edgeiq.io>
* EdgeIQ API Base URL: <https://api.edgeiq.io/api/v1/platform>
* EdgeIQ Documentation: <https://dev.edgeiq.io/>

The EdgeIQ local service is installed as a `systemd` managed service called `edge.service` so for example you can stop it using this command, `sudo systemctl stop edge`. The EdgeIQ local service is installed into `/opt/edge` and log files are located in a day time stamped file, e.g. `/opt/edge/log/edge.log.2020-05-18`.

> Warning: these test scripts do not currently protect against creating duplicate artifacts, nor do they detect if devices are present with the same target Unique ID. EdgeIQ will prevent you from creating duplicate devices with the same unique ID (which is good), however this may cause issues with the correct configuration by the scripts.

Note: you will need to run the `cleanup-demo-<timestamp>.sh` script between running each example as only one EdgeIQ Device can exist against a single `Unique_Id`.

### Simple Gateway example

In `simple_gateway` subdirectory, run the following commands.

1. Run [`create_edgeiq_configuration.sh`](simple_gateway/create_edgeiq_configuration.sh). This will configure an EdgeIQ Device that can be used to remotely manage your gateway
2. Run [`gateway_provision.sh`](simple_gateway/gateway_provision.sh). This will install the EdgeIQ SmartEdge software onto the gateway and associate it with the EdgeIQ Device configured in the previous step.

The `create_edgeiq_configuration.sh` script will create a `cleanup-demo-<timestamp>.sh` file that contains API commands to delete EdgeIQ artifacts created by the create script. The cleanup scripts will delete themselves upon successful completion.

There is a helper script [`query_entities.sh`](simple_gateway/query_entities.sh) that provides examples of various ways to query artifacts from EdgeIQ.

### Gateway with ModBus Sensor Device

This example shows how EdgeIQ can be configured to manage an edge gateway device with a connected Modbus sensor. The sensor data will be forwarded to an HTTP listener. The [`httpprint.py`](gateway_with_modbus_sensor/instance_files/httpprint.py) is an example of such a listener that will print out all HTTP messages that it receives.

Notes:

* These scripts were tested against the free [diagslave](https://www.modbusdriver.com/diagslave.html) Modbus simulator, e.g. `diagslave -m tcp`.
* To use the included [`httpprint.py`](gateway_with_modbus_sensor/instance_files/httpprint.py), you need to have a recent version of Python 3 installed. e.g. `python3 httpprint.py`
* To see the `httpprint.py` output, run on the gateway device, e.g. Raspberry Pi, the following command `journalctl -f -all -u httpprint`.

In `gateway_with_modbus_sensor` subdirectory, run the following commands.

1. Run [`create_edgeiq_configuration.sh`](gateway_with_modbus_sensor/create_edgeiq_configuration.sh). This will configure an EdgeIQ Device that can be used to remotely manage your gateway
2. Run [`gateway_provision.sh`](gateway_with_modbus_sensor/gateway_provision.sh). This will install the EdgeIQ SmartEdge software onto the gateway and associate it with the EdgeIQ Device configured in the previous step.

The `create_edgeiq_configuration.sh` script will create a `cleanup-demo-<timestamp>.sh` file that contains API commands to delete EdgeIQ artifacts created by the create script. The cleanup scripts will delete themselves upon successful completion.

There are some helper scripts:

* [`query_entities.sh`](gateway_with_modbus_sensor/query_entities.sh) provides examples of querying EdgeIQ for specific devices based on `unique_id` and that have a `demo` tag. More details on Query parameters [here](https://dev.edgeiq.io/docs/api-overrview#query-string-operators)
* [`diagslave_install.sh`](gateway_with_modbus_sensor/instance_files/diagslave_install.sh) is an example of how to install diagslave Modbus simulator as a systemd service. Must be run as root, e.g., `sudo ./diagslave_install.sh`. You can then use `journalctl -f --all -u diagslave` to follow logs. Note the `--all` options overcomes the `[xxB blob data]` by converting the binary output from diagslave.

The Modbus sensor/simulator and the HTTP Listener should be running **BEFORE** running these scripts.

### Gateway with Attached ModBus Sensor Device

This example shows how EdgeIQ can be configured to manage an edge gateway device with a connected Modbus sensor. The ModBus sensor is modeled as an attached device to the Gateway device. Otherwise this example is identical to Gateway with ModBus Sensor example. The sensor data will be forwarded to an HTTP listener. The [`httpprint.py`](gateway_with_attached_sensor/instance_files/httpprint.py) is an example of such a listener that will print out all HTTP messages that it receives.

Notes:

* These scripts were tested against the free [diagslave](https://www.modbusdriver.com/diagslave.html) Modbus simulator, e.g. `diagslave -m tcp`.
* To use the included [`httpprint.py`](gateway_with_attached_sensor/instance_files/httpprint.py), you need to have a recent version of Python 3 installed. e.g. `python3 httpprint.py`
* To see the `httpprint.py` output, run on the gateway device, e.g. Raspberry Pi, the following command `journalctl -f -all -u httpprint`.

In `gateway_with_attached_sensor` subdirectory, run the following commands.

1. Run [`create_edgeiq_configuration.sh`](gateway_with_attached_sensor/create_edgeiq_configuration.sh). This will configure an EdgeIQ Device that can be used to remotely manage your gateway
2. Run [`gateway_provision.sh`](gateway_with_attached_sensor/gateway_provision.sh). This will install the EdgeIQ SmartEdge software onto the gateway and associate it with the EdgeIQ Device configured in the previous step.

The `create_edgeiq_configuration.sh` script will create a `cleanup-demo-<timestamp>.sh` file that contains API commands to delete EdgeIQ artifacts created by the create script. The cleanup scripts will delete themselves upon successful completion.

There are some helper scripts:


* [`query_entities.sh`](gateway_with_attached_sensor/query_entities.sh) provides examples of querying EdgeIQ for specific devices based on `unique_id` and that have a `demo` tag. More details on Query parameters [here](https://dev.edgeiq.io/docs/api-overrview#query-string-operators)
* [`diagslave_install.sh`](gateway_with_attached_sensor/diagslave_install.sh) is an example of how to install diagslave Modbus simulator as a systemd service. Must be run as root, e.g., `sudo ./diagslave_install.sh`. You can then use `journalctl -f --all -u diagslave` to follow logs. Note the `--all` options overcomes the `[xxB blob data]` by converting the binary output from diagslave.

The Modbus sensor/simulator and the HTTP Listener should be running **BEFORE** running these scripts.

### Gateway with Attached SNMP Sensor Device

This example shows how EdgeIQ can be configured to manage an edge gateway device with a connected SNMP sensor. The SNMP sensor is modeled as an attached device to the Gateway device. The sensor data will be forwarded to an HTTP listener. The [`httpprint.py`](gateway_with_attached_sensor_snmp/instance_files/httpprint.py) is an example of such a listener that will print out all HTTP messages that it receives.



Notes:

* These scripts were tested against the raspberry pi raspian running a gateway local `snmpd` installed by [`gateway_provision.sh`](gateway_with_attached_sensor_snmp/gateway_provision.sh)
* To use the included [`httpprint.py`](gateway_with_attached_sensor_snmp/instance_files/httpprint.py), you need to have a recent version of Python 3 installed. e.g. `python3 httpprint.py`
* To see the `httpprint.py` output, run on the gateway device, e.g. Raspberry Pi, the following command `journalctl -f -all -u httpprint`.

In `gateway_with_attached_sensor_snmp` subdirectory, run the following commands.

1. Run [`create_edgeiq_configuration.sh`](gateway_with_attached_sensor_snmp/create_edgeiq_configuration.sh). This will configure an EdgeIQ Device that can be used to remotely manage your gateway
2. Run [`gateway_provision.sh`](gateway_with_attached_sensor_snmp/gateway_provision.sh). This will install the EdgeIQ SmartEdge software onto the gateway and associate it with the EdgeIQ Device configured in the previous step.

The `create_edgeiq_configuration.sh` script will create a `cleanup-demo-<timestamp>.sh` file that contains API commands to delete EdgeIQ artifacts created by the create script. The cleanup scripts will delete themselves upon successful completion.

There are some helper scripts:

* [`query_entities.sh`](gateway_with_attached_sensor_snmp/query_entities.sh) provides examples of querying EdgeIQ for specific devices based on `unique_id` and that have a `demo` tag. More details on Query parameters [here](https://dev.edgeiq.io/docs/api-overrview#query-string-operators)
