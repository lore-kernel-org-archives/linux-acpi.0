From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 2/2]adjust initialization order
Date: Mon, 12 Sep 2005 13:22:27 +0800
Message-ID: <1126502548.5153.19.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
adjust the initialization order slightly, so PCI device enumeration is after
ACPI device enumeration.

Thanks,
Shaohua
---

 linux-2.6.13-root/drivers/acpi/Makefile |    6 +-
 linux-2.6.13-root/drivers/acpi/scan.c   |   66 +++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 16 deletions(-)

diff -puN drivers/acpi/Makefile~adjust_init_order drivers/acpi/Makefile
--- linux-2.6.13/drivers/acpi/Makefile~adjust_init_order	2005-09-05 13:51:23.000000000 +0800
+++ linux-2.6.13-root/drivers/acpi/Makefile	2005-09-05 13:51:23.000000000 +0800
@@ -37,6 +37,9 @@ endif
 
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
 obj-$(CONFIG_ACPI_BUS)		+= bus.o glue.o
+obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
+obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
+obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -49,11 +52,8 @@ obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
-obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
-obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
diff -puN drivers/acpi/scan.c~adjust_init_order drivers/acpi/scan.c
--- linux-2.6.13/drivers/acpi/scan.c~adjust_init_order	2005-09-05 13:51:23.000000000 +0800
+++ linux-2.6.13-root/drivers/acpi/scan.c	2005-09-05 13:51:23.000000000 +0800
@@ -716,6 +716,51 @@ acpi_bus_match (
 	return acpi_match_ids(device, driver->ids);
 }
 
+static void acpi_bind_child_devices(struct acpi_device *start)
+{
+	acpi_status		status;
+	struct acpi_device	*parent, *child;
+	acpi_handle		phandle, chandle;
+	u32			level = 1;
+
+	parent  = start;
+	phandle = start->handle;
+	child = chandle = NULL;
+
+	while ((level > 0) && parent) {
+		status = acpi_get_next_object(ACPI_TYPE_ANY, phandle,
+				chandle, &chandle);
+
+		/*
+		 * If this scope is exhausted then move our way back up.
+		 */
+		if (ACPI_FAILURE(status)) {
+			level--;
+			chandle = phandle;
+			acpi_get_parent(phandle, &phandle);
+			child = parent;
+			parent = parent->parent;
+
+			continue;
+		}
+
+		/*
+		 * If there is a device corresponding to chandle then
+		 * parse it
+		 */
+		if (acpi_bus_get_device(chandle, &child) == 0) {
+			if (child->flags.bus_address)
+				if (child->parent && child->parent->ops.bind)
+					child->parent->ops.bind(child);
+
+			level++;
+			phandle = chandle;
+			chandle = NULL;
+			parent = child;
+		}
+		continue;
+	}
+}
 
 /**
  * acpi_bus_driver_init 
@@ -746,7 +791,14 @@ acpi_bus_driver_init (
 	}
 
 	device->driver = driver;
-
+	/*
+	 * Bind _ADR-Based Devices
+	 * -----------------------
+	 * If there's a a bus address (_ADR) then we utilize the parent's
+	 * 'bind' function (if exists) to bind the ACPI- and natively-
+	 * enumerated device representations.
+	 */
+	acpi_bind_child_devices(device);
 	/*
 	 * TBD - Configuration Management: Assign resources to device based
 	 * upon possible configuration and currently allocated resources.
@@ -1334,18 +1386,6 @@ acpi_add_single_object (
 	acpi_device_register(device,parent);
 
 	/*
-	 * Bind _ADR-Based Devices
-	 * -----------------------
-	 * If there's a a bus address (_ADR) then we utilize the parent's 
-	 * 'bind' function (if exists) to bind the ACPI- and natively-
-	 * enumerated device representations.
-	 */
-	if (device->flags.bus_address) {
-		if (device->parent && device->parent->ops.bind)
-			device->parent->ops.bind(device);
-	}
-
-	/*
 	 * Locate & Attach Driver
 	 * ----------------------
 	 * If there's a hardware id (_HID) or compatible ids (_CID) we check
_




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
