From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH 2.6.28-rc3] ACPI: fix inconsistent acpi event format
	(resent)
Date: Thu, 06 Nov 2008 00:55:29 +0800
Message-ID: <1225904129.17794.68.camel@yangyi-dev>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754989AbYKEI4Y@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=EF=BB=BFSubject: ACPI: fix inconsistent acpi event format
=46rom: Yi Yang <yi.y.yang@intel.com>

Hi, Len

Please ignore last one and use this patch, this patch also fixes other =
acpi event format=20
issues in another several acpi drivers.

Event format acpi generates for /proc/acpi/event is different from
that for generic netlink interface. Here are i got:

>From /proc/acpi/event, i got the following events when i suspend and
resume Acer's Aspire One:

battery BAT1 00000080 00000000
battery BAT1 00000081 00000000
ac_adapter ACAD 00000080 00000001
battery BAT1 00000080 00000000

But from generic netlink socket, i got the following events when i susp=
end
and resume Acer's Aspire One:

battery PNP0C0A:00 00000080 00000000
battery PNP0C0A:00 00000081 00000000
ac_adapter ACPI0003:00 00000080 00000001
battery PNP0C0A:00 00000080 00000000

Such inconsistent event format will make acpid or hald confused, this p=
atch
fixes this issue, it makes acpid or hald see the same thing no matter t=
hey use
/proc/acpi/event or generic netlink interface.

After applying this patch, event format i got from /proc/acpi/event and=
 generic
netlink interface is same, all of them are:

battery BAT1 00000080 00000000
battery BAT1 00000081 00000000
ac_adapter ACAD 00000080 00000001
battery BAT1 00000080 00000000

Please consider applying, thanks.

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 ac.c             |    2 +-
 battery.c        |    2 +-
 processor_core.c |    6 +++---
 thermal.c        |    8 ++++----
 wmi.c            |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index d72a1b6..9d8053b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -242,7 +242,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 =
event, void *data)
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event,
+						  device->pnp.bus_id, event,
 						  (u32) ac->state);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b2133e8..e52b336 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static void acpi_battery_notify(acpi_handle handle,=
 u32 event, void *data)
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
-					device->dev.bus_id, event,
+					device->pnp.bus_id, event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_cor=
e.c
index 24a362f..8bc0bd5 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -761,20 +761,20 @@ static void acpi_processor_notify(acpi_handle han=
dle, u32 event, void *data)
 		acpi_bus_generate_proc_event(device, event,
 					pr->performance_platform_limit);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event,
+						  device->pnp.bus_id, event,
 						  pr->performance_platform_limit);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_POWER:
 		acpi_processor_cst_has_changed(pr);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  device->pnp.bus_id, event, 0);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
 		acpi_processor_tstate_has_changed(pr);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  device->pnp.bus_id, event, 0);
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ad6cae9..d636d91 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -576,7 +576,7 @@ static int acpi_thermal_critical(struct acpi_therma=
l *tz)
 	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL=
,
 				tz->trips.critical.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					  tz->device->dev.bus_id,
+					  tz->device->pnp.bus_id,
 					  ACPI_THERMAL_NOTIFY_CRITICAL,
 					  tz->trips.critical.flags.enabled);
=20
@@ -605,7 +605,7 @@ static int acpi_thermal_hot(struct acpi_thermal *tz=
)
 	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
 				tz->trips.hot.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					  tz->device->dev.bus_id,
+					  tz->device->pnp.bus_id,
 					  ACPI_THERMAL_NOTIFY_HOT,
 					  tz->trips.hot.flags.enabled);
=20
@@ -1592,14 +1592,14 @@ static void acpi_thermal_notify(acpi_handle han=
dle, u32 event, void *data)
 		acpi_thermal_check(tz);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  device->pnp.bus_id, event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
 		acpi_thermal_check(tz);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  device->pnp.bus_id, event, 0);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 47cd7ba..07f1ba0 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -660,7 +660,7 @@ static void acpi_wmi_notify(acpi_handle handle, u32=
 event, void *data)
 				wblock->handler(event, wblock->handler_data);
=20
 			acpi_bus_generate_netlink_event(
-				device->pnp.device_class, device->dev.bus_id,
+				device->pnp.device_class, device->pnp.bus_id,
 				event, 0);
 			break;
 		}
