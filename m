From: Thomas Renninger <trenn@suse.de>
Subject: Exit ACPI drivers immediately if acpi is disabled
Date: Fri, 21 Apr 2006 12:43:31 +0200
Message-ID: <200604211243.32276.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UdLSEXV/koQHUDM"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:21216 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932286AbWDUKnh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 06:43:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>

--Boundary-00=_UdLSEXV/koQHUDM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I could not resist to also remove the ACPI function trace
from init/exit functions... This has been done already recently IIRC,
please tell me if it's in your test tree or whether I should just do the
changes on top of the function trace removal patch.

Subject: Exit ACPI modules if acpi is disabled (via acpi=off)

If booting with acpi=off and loading the processor module, it
may happen that the kernel oopses when trying to unload the module again.
Better exit all ACPI modules immediately if booted with acpi=off.

 drivers/acpi/ac.c              |   13 +++++--------
 drivers/acpi/acpi_memhotplug.c |   13 +++++--------
 drivers/acpi/battery.c         |   13 +++++--------
 drivers/acpi/button.c          |   12 +++++-------
 drivers/acpi/container.c       |    3 +++
 drivers/acpi/fan.c             |   11 +++++------
 drivers/acpi/processor_core.c  |   13 +++++--------
 drivers/acpi/sony_acpi.c       |    3 +++
 drivers/acpi/thermal.c         |   13 ++++++-------
 drivers/acpi/video.c           |   15 ++++++---------
 10 files changed, 48 insertions(+), 61 deletions(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6.16/drivers/acpi/ac.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/ac.c
+++ linux-2.6.16/drivers/acpi/ac.c
@@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
 	if (!acpi_ac_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_ac_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_ac_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_ac_exit");
-
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
 	remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_ac_init);
Index: linux-2.6.16/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.16/drivers/acpi/acpi_memhotplug.c
@@ -489,12 +489,13 @@ static int __init acpi_memory_device_ini
 	int result;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
@@ -504,18 +505,16 @@ static int __init acpi_memory_device_ini
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_memory_device_exit(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
-
 	/*
 	 * Adding this to un-install notification handlers for all the device
 	 * handles.
@@ -529,8 +528,6 @@ static void __exit acpi_memory_device_ex
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
-
-	return_VOID;
 }
 
 module_init(acpi_memory_device_init);
Index: linux-2.6.16/drivers/acpi/battery.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/battery.c
+++ linux-2.6.16/drivers/acpi/battery.c
@@ -768,31 +768,28 @@ static int __init acpi_battery_init(void
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_battery_dir = proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
 	if (!acpi_battery_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_battery_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_battery_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_battery_exit");
-
 	acpi_bus_unregister_driver(&acpi_battery_driver);
 
 	remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_battery_init);
Index: linux-2.6.16/drivers/acpi/button.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/button.c
+++ linux-2.6.16/drivers/acpi/button.c
@@ -445,25 +445,24 @@ static int __init acpi_button_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_button_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_button_dir->owner = THIS_MODULE;
 	result = acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_button_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_button_exit");
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	if (acpi_power_dir)
@@ -474,7 +473,6 @@ static void __exit acpi_button_exit(void
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_button_init);
Index: linux-2.6.16/drivers/acpi/container.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/container.c
+++ linux-2.6.16/drivers/acpi/container.c
@@ -251,6 +251,9 @@ static int __init acpi_container_init(vo
 	int result = 0;
 	int action = INSTALL_NOTIFY_HANDLER;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	result = acpi_bus_register_driver(&acpi_container_driver);
 	if (result < 0) {
 		return (result);
Index: linux-2.6.16/drivers/acpi/fan.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/fan.c
+++ linux-2.6.16/drivers/acpi/fan.c
@@ -240,26 +240,25 @@ static int __init acpi_fan_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_fan_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_fan_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_fan_exit");
-
 	acpi_bus_unregister_driver(&acpi_fan_driver);
 
 	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -910,20 +910,21 @@ static int __init acpi_processor_init(vo
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return_VALUE(0);
+		return 0;
 	acpi_processor_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(0);
+		return 0;
 	}
 
 	acpi_processor_install_hotplug_notify();
@@ -932,13 +933,11 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_ppc_init();
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_processor_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_exit");
-
 	acpi_processor_ppc_exit();
 
 	acpi_thermal_cpufreq_exit();
@@ -948,8 +947,6 @@ static void __exit acpi_processor_exit(v
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_processor_init);
Index: linux-2.6.16/drivers/acpi/sony_acpi.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/sony_acpi.c
+++ linux-2.6.16/drivers/acpi/sony_acpi.c
@@ -366,6 +366,9 @@ static int __init sony_acpi_init(void)
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
 	if (!sony_acpi_dir) {
 		printk(LOG_PFX "unable to create /proc entry\n");
Index: linux-2.6.16/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/thermal.c
+++ linux-2.6.16/drivers/acpi/thermal.c
@@ -1400,20 +1400,21 @@ static int __init acpi_thermal_init(void
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_init");
-
+	if (acpi_disabled)
+		return -ENODEV;
+		
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_thermal_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_thermal_exit(void)
@@ -1423,8 +1424,6 @@ static void __exit acpi_thermal_exit(voi
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
 	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_thermal_init);
Index: linux-2.6.16/drivers/acpi/video.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/video.c
+++ linux-2.6.16/drivers/acpi/video.c
@@ -1850,36 +1850,33 @@ static int __init acpi_video_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_video_init");
-
 	/*
 	   acpi_dbg_level = 0xFFFFFFFF;
 	   acpi_dbg_layer = 0x08000000;
 	 */
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_video_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_video_bus);
 	if (result < 0) {
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_video_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_video_exit");
-
 	acpi_bus_unregister_driver(&acpi_video_bus);
 
 	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_video_init);

--Boundary-00=_UdLSEXV/koQHUDM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="acpi_exit_on_acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_exit_on_acpi_off"

Subject: Exit ACPI modules if acpi is disabled (via acpi=off)

If booting with acpi=off and loading the processor module, it
may happen that the kernel oopses when trying to unload the module again.
Better exit all ACPI modules immediately if booted with acpi=off.

 drivers/acpi/ac.c              |   13 +++++--------
 drivers/acpi/acpi_memhotplug.c |   13 +++++--------
 drivers/acpi/battery.c         |   13 +++++--------
 drivers/acpi/button.c          |   12 +++++-------
 drivers/acpi/container.c       |    3 +++
 drivers/acpi/fan.c             |   11 +++++------
 drivers/acpi/processor_core.c  |   13 +++++--------
 drivers/acpi/sony_acpi.c       |    3 +++
 drivers/acpi/thermal.c         |   13 ++++++-------
 drivers/acpi/video.c           |   15 ++++++---------
 10 files changed, 48 insertions(+), 61 deletions(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6.16/drivers/acpi/ac.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/ac.c
+++ linux-2.6.16/drivers/acpi/ac.c
@@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
 	if (!acpi_ac_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_ac_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_ac_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_ac_exit");
-
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
 	remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_ac_init);
Index: linux-2.6.16/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.16/drivers/acpi/acpi_memhotplug.c
@@ -489,12 +489,13 @@ static int __init acpi_memory_device_ini
 	int result;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
@@ -504,18 +505,16 @@ static int __init acpi_memory_device_ini
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_memory_device_exit(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
-
 	/*
 	 * Adding this to un-install notification handlers for all the device
 	 * handles.
@@ -529,8 +528,6 @@ static void __exit acpi_memory_device_ex
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
-
-	return_VOID;
 }
 
 module_init(acpi_memory_device_init);
Index: linux-2.6.16/drivers/acpi/battery.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/battery.c
+++ linux-2.6.16/drivers/acpi/battery.c
@@ -768,31 +768,28 @@ static int __init acpi_battery_init(void
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_battery_dir = proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
 	if (!acpi_battery_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_battery_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_battery_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_battery_exit");
-
 	acpi_bus_unregister_driver(&acpi_battery_driver);
 
 	remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_battery_init);
Index: linux-2.6.16/drivers/acpi/button.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/button.c
+++ linux-2.6.16/drivers/acpi/button.c
@@ -445,25 +445,24 @@ static int __init acpi_button_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_button_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_button_dir->owner = THIS_MODULE;
 	result = acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_button_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_button_exit");
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	if (acpi_power_dir)
@@ -474,7 +473,6 @@ static void __exit acpi_button_exit(void
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_button_init);
Index: linux-2.6.16/drivers/acpi/container.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/container.c
+++ linux-2.6.16/drivers/acpi/container.c
@@ -251,6 +251,9 @@ static int __init acpi_container_init(vo
 	int result = 0;
 	int action = INSTALL_NOTIFY_HANDLER;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	result = acpi_bus_register_driver(&acpi_container_driver);
 	if (result < 0) {
 		return (result);
Index: linux-2.6.16/drivers/acpi/fan.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/fan.c
+++ linux-2.6.16/drivers/acpi/fan.c
@@ -240,26 +240,25 @@ static int __init acpi_fan_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_fan_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_fan_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_fan_exit");
-
 	acpi_bus_unregister_driver(&acpi_fan_driver);
 
 	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -910,20 +910,21 @@ static int __init acpi_processor_init(vo
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_init");
+	if (acpi_disabled)
+		return -ENODEV;
 
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return_VALUE(0);
+		return 0;
 	acpi_processor_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(0);
+		return 0;
 	}
 
 	acpi_processor_install_hotplug_notify();
@@ -932,13 +933,11 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_ppc_init();
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_processor_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_exit");
-
 	acpi_processor_ppc_exit();
 
 	acpi_thermal_cpufreq_exit();
@@ -948,8 +947,6 @@ static void __exit acpi_processor_exit(v
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_processor_init);
Index: linux-2.6.16/drivers/acpi/sony_acpi.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/sony_acpi.c
+++ linux-2.6.16/drivers/acpi/sony_acpi.c
@@ -366,6 +366,9 @@ static int __init sony_acpi_init(void)
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
 	if (!sony_acpi_dir) {
 		printk(LOG_PFX "unable to create /proc entry\n");
Index: linux-2.6.16/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/thermal.c
+++ linux-2.6.16/drivers/acpi/thermal.c
@@ -1400,20 +1400,21 @@ static int __init acpi_thermal_init(void
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_init");
-
+	if (acpi_disabled)
+		return -ENODEV;
+		
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_thermal_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_thermal_exit(void)
@@ -1423,8 +1424,6 @@ static void __exit acpi_thermal_exit(voi
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
 	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_thermal_init);
Index: linux-2.6.16/drivers/acpi/video.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/video.c
+++ linux-2.6.16/drivers/acpi/video.c
@@ -1850,36 +1850,33 @@ static int __init acpi_video_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_video_init");
-
 	/*
 	   acpi_dbg_level = 0xFFFFFFFF;
 	   acpi_dbg_layer = 0x08000000;
 	 */
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_video_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_video_bus);
 	if (result < 0) {
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_video_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_video_exit");
-
 	acpi_bus_unregister_driver(&acpi_video_bus);
 
 	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-
-	return_VOID;
 }
 
 module_init(acpi_video_init);

--Boundary-00=_UdLSEXV/koQHUDM--
