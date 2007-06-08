From: Holger Macht <hmacht@suse.de>
Subject: Re: Docking support?
Date: Fri, 8 Jun 2007 13:00:30 +0000 (UTC)
Message-ID: <20361107150045.GA25276@homac.suse.de>
References: <20070608104706.GA10553@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:57789 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937562AbXFHNAU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 09:00:20 -0400
Date: Fri, 7 Nov 2036 16:00:45 +0100
Content-Disposition: inline
In-Reply-To: <20070608104706.GA10553@implementation>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, kristen.c.accardi@intel.com, linux-acpi@vger.kernel.org

On Fri 08. Jun - 18:47:06, Samuel Thibault wrote:
[...]
> Also, I'd really like to receive ACPI docking events in userland for
> triggering video devices configuration for instance.

Via udev. Unfortunately....

I just tries and it doesn't work properly.

Dock driver contains something like this:

---
       /*
        * here we need to generate the undock
        * event prior to actually doing the undock
        * so that the device struct still exists.
        */
        dock_event(ds, event, UNDOCK_EVENT);
        hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
        undock(ds);
        eject_dock(ds);
---

When udev receives the KOBJ_CHANGE event triggered by dock_event(), some
application or udev itself does read the content of
/sys/devices/platform/dock.0/docked. But the value is not updated
yet. Checking manually with cat, it sometimes even needs up to two seconds
for the right value (0) to show up. So we cannot rely on getting the real
state at the point in time where the udev event is received.

At first, function dock_event(..) doesn't need any of the passed
arguments. It only makes use of the static platform_device dock_device
object to execute a kobject_uevent(). So wouldn't it be save to execute
the dock_event() _after_ actually undocking? Something like the following?

Signed-off-by: Holger Macht <hmacht@suse.de>
---
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 4546bf8..46df53e 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -63,8 +63,6 @@ struct dock_dependent_device {
 };
 
 #define DOCK_DOCKING	0x00000001
-#define DOCK_EVENT	3
-#define UNDOCK_EVENT	2
 
 static struct dock_station *dock_station;
 
@@ -325,7 +323,7 @@ static void hotplug_dock_devices(struct
 	mutex_unlock(&ds->hp_lock);
 }
 
-static void dock_event(struct dock_station *ds, u32 event, int num)
+static void dock_event(void)
 {
 	struct device *dev = &dock_device.dev;
 	/*
@@ -537,12 +535,6 @@ static int handle_eject_request(struct d
 	if (dock_in_progress(ds))
 		return -EBUSY;
 
-	/*
-	 * here we need to generate the undock
-	 * event prior to actually doing the undock
-	 * so that the device struct still exists.
-	 */
-	dock_event(ds, event, UNDOCK_EVENT);
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
 	eject_dock(ds);
@@ -551,6 +543,8 @@ static int handle_eject_request(struct d
 		return -EBUSY;
 	}
 
+	dock_event();
+
 	return 0;
 }
 
@@ -581,8 +575,8 @@ static void dock_notify(acpi_handle hand
 						   event, NULL);
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
-			dock_event(ds, event, DOCK_EVENT);
-		}
+			dock_event();
+		} 
 		break;
 	case ACPI_NOTIFY_DEVICE_CHECK:
 	/*

