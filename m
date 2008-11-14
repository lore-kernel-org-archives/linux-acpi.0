From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/4] ACPI: call core init functions explicitly instead of
	using initcalls
Date: Fri, 14 Nov 2008 16:03:04 -0700
Message-ID: <20081114230304.18623.36790.stgit@bob.kio>
References: <20081114230117.18623.8172.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:46409 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbYKNXDF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 18:03:05 -0500
In-Reply-To: <20081114230117.18623.8172.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

These functions:
    init_acpi_device_notify()
    acpi_debug_init()
    acpi_scan_init()
    acpi_system_init()
    acpi_power_init()
are all parts of the ACPI core.  None can be compiled or loaded
separately.  So we might as well call them directly from acpi_init()
rather than using initcalls, which depend on module link order to
make things happen in the correct order.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Makefile    |   15 ++++++---------
 drivers/acpi/acpi_core.h |   19 +++++++++++++++++++
 drivers/acpi/bus.c       |   10 ++++++++++
 drivers/acpi/debug.c     |   10 +++-------
 drivers/acpi/glue.c      |    8 +++-----
 drivers/acpi/power.c     |    8 +-------
 drivers/acpi/scan.c      |    8 +-------
 drivers/acpi/system.c    |   10 ++--------
 8 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3c0c933..9ab533e 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -19,7 +19,7 @@ obj-y				+= tables.o
 obj-$(CONFIG_X86)		+= blacklist.o
 
 #
-# ACPI Core Subsystem (Interpreter)
+# ACPI CA Core Subsystem (Interpreter)
 #
 obj-y				+= osl.o utils.o reboot.o\
 				   dispatcher/ events/ executer/ hardware/ \
@@ -36,10 +36,10 @@ processor-objs	+= processor_perflib.o
 endif
 
 obj-y				+= sleep/
-obj-y				+= bus.o glue.o
-obj-y				+= scan.o
-# Keep EC driver first. Initialization of others depend on it.
-obj-y				+= ec.o
+obj-y				+= bus.o scan.o ec.o power.o
+obj-y				+= glue.o
+obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
+
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -55,14 +55,11 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-y				+= power.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
-obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_WMI)		+= wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
-obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
-obj-$(CONFIG_ACPI_SBS)		+= sbs.o
+obj-$(CONFIG_ACPI_SBS)		+= sbshc.o sbs.o
diff --git a/drivers/acpi/acpi_core.h b/drivers/acpi/acpi_core.h
index 1f98674..dbce692 100644
--- a/drivers/acpi/acpi_core.h
+++ b/drivers/acpi/acpi_core.h
@@ -1,3 +1,22 @@
+/* Functions internal to the Linux OSPM (the "ACPI core" in Linux terms) */
+
+int init_acpi_device_notify(void);
+int acpi_scan_init(void);
+int acpi_power_init(void);
+
+#if defined(CONFIG_ACPI_DEBUG) && defined(CONFIG_ACPI_PROCFS)
+int acpi_debug_init(void);
+#else
+static inline int acpi_debug_init(void) { return 0; }
+#endif
+
+
+#ifdef CONFIG_ACPI_SYSTEM
+int acpi_system_init(void);
+#else
+static inline int acpi_system_init(void) { return 0; }
+#endif
+
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bd2d60f..8c78949 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -855,6 +855,7 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
+	init_acpi_device_notify();
 	result = acpi_bus_init();
 
 	if (!result) {
@@ -869,11 +870,20 @@ static int __init acpi_init(void)
 		}
 	} else
 		disable_acpi();
+
 	/*
 	 * If the laptop falls into the DMI check table, the power state check
 	 * will be disabled in the course of device power transistion.
 	 */
 	dmi_check_system(power_nocheck_dmi_table);
+
+	if (acpi_disabled)
+		return result;
+
+	acpi_debug_init();
+	acpi_scan_init();
+	acpi_system_init();
+	acpi_power_init();
 	return result;
 }
 
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index c483968..224c3d1 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -11,6 +11,8 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acglobal.h>
 
+#include "acpi_core.h"
+
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debug");
 
@@ -299,16 +301,12 @@ acpi_system_write_debug(struct file *file,
 	return count;
 }
 
-static int __init acpi_debug_init(void)
+int __init acpi_debug_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	/* 'debug_layer' [R/W] */
 	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
 	entry =
@@ -340,6 +338,4 @@ static int __init acpi_debug_init(void)
 	error = -ENODEV;
 	goto Done;
 }
-
-subsys_initcall(acpi_debug_init);
 #endif
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index adec3d1..bd3b5c9 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -12,6 +12,8 @@
 #include <linux/rwsem.h>
 #include <linux/acpi.h>
 
+#include "acpi_core.h"
+
 #define ACPI_GLUE_DEBUG	0
 #if ACPI_GLUE_DEBUG
 #define DBG(x...) printk(PREFIX x)
@@ -286,10 +288,8 @@ static int acpi_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-static int __init init_acpi_device_notify(void)
+int __init init_acpi_device_notify(void)
 {
-	if (acpi_disabled)
-		return 0;
 	if (platform_notify || platform_notify_remove) {
 		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
 		return 0;
@@ -298,5 +298,3 @@ static int __init init_acpi_device_notify(void)
 	platform_notify_remove = acpi_platform_notify_remove;
 	return 0;
 }
-
-arch_initcall(init_acpi_device_notify);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index bb7d50d..99ce34a 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -769,14 +769,10 @@ static int acpi_power_resume(struct acpi_device *device)
 	return 0;
 }
 
-static int __init acpi_power_init(void)
+int __init acpi_power_init(void)
 {
 	int result = 0;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	INIT_LIST_HEAD(&acpi_power_resource_list);
 
 	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
@@ -791,5 +787,3 @@ static int __init acpi_power_init(void)
 
 	return 0;
 }
-
-subsys_initcall(acpi_power_init);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0193e9c..642a301 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1538,15 +1538,11 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 }
 
 
-static int __init acpi_scan_init(void)
+int __init acpi_scan_init(void)
 {
 	int result;
 	struct acpi_bus_ops ops;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 	ops.acpi_op_start = 1;
@@ -1579,5 +1575,3 @@ static int __init acpi_scan_init(void)
       Done:
 	return result;
 }
-
-subsys_initcall(acpi_scan_init);
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 6e4107f..d2a5d2c 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -630,20 +630,14 @@ static int acpi_system_procfs_init(void)
 }
 #endif
 
-static int __init acpi_system_init(void)
+int __init acpi_system_init(void)
 {
-	int result = 0;
-
-	if (acpi_disabled)
-		return 0;
+	int result;
 
 	result = acpi_system_procfs_init();
 	if (result)
 		return result;
 
 	result = acpi_system_sysfs_init();
-
 	return result;
 }
-
-subsys_initcall(acpi_system_init);

