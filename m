From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/41] ACPI: invoke acpi_sleep_init() earlier
Date: Tue, 13 Feb 2007 00:49:31 -0500
Message-ID: <11713458191475-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086AbXBMFuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:21 -0500
In-Reply-To: <11713458183917-git-send-email-lenb@kernel.org>
Message-Id: <aafbcd165a2a02e6dff173f66772b3148229ace8.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

late_initcall() is too late for acpi_sleep_init().
Call it directly from acpi_init code.

http://bugzilla.kernel.org/show_bug.cgi?id=7887

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c          |   13 ++++++++-----
 drivers/acpi/sleep/main.c   |    3 +--
 include/acpi/acpi_drivers.h |   10 ++++++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c26468d..41cebe5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -147,7 +147,7 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 			*state = ACPI_STATE_D0;
 	} else {
 		/*
-		 * Get the device's power state either directly (via _PSC) or 
+		 * Get the device's power state either directly (via _PSC) or
 		 * indirectly (via power resources).
 		 */
 		if (device->power.flags.explicit_get) {
@@ -462,7 +462,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 				  "Received BUS CHECK notification for device [%s]\n",
 				  device->pnp.bus_id));
 		result = acpi_bus_check_scope(device);
-		/* 
+		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
 		 */
@@ -473,7 +473,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 				  "Received DEVICE CHECK notification for device [%s]\n",
 				  device->pnp.bus_id));
 		result = acpi_bus_check_device(device, NULL);
-		/* 
+		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
 		 */
@@ -543,7 +543,7 @@ static int __init acpi_bus_init_irq(void)
 	char *message = NULL;
 
 
-	/* 
+	/*
 	 * Let the system know what interrupt model we are using by
 	 * evaluating the \_PIC object, if exists.
 	 */
@@ -684,7 +684,7 @@ static int __init acpi_bus_init(void)
 	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
 	 * is called).
 	 *
-	 * This is accomplished by looking for the ECDT table, and getting 
+	 * This is accomplished by looking for the ECDT table, and getting
 	 * the EC parameters out of that.
 	 */
 	status = acpi_ec_ecdt_probe();
@@ -699,6 +699,9 @@ static int __init acpi_bus_init(void)
 
 	printk(KERN_INFO PREFIX "Interpreter enabled\n");
 
+	/* Initialize sleep structures */
+	acpi_sleep_init();
+
 	/*
 	 * Get the system interrupt model and evaluate \_PIC.
 	 */
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 62ce87d..37a0930 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -200,7 +200,7 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{},
 };
 
-static int __init acpi_sleep_init(void)
+int __init acpi_sleep_init(void)
 {
 	int i = 0;
 
@@ -229,4 +229,3 @@ static int __init acpi_sleep_init(void)
 	return 0;
 }
 
-late_initcall(acpi_sleep_init);
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 4dc8a50..ce0e62f 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -128,4 +128,14 @@ extern void unregister_hotplug_dock_device(acpi_handle handle);
 #define register_hotplug_dock_device(h1, h2, c)	(-ENODEV)
 #define unregister_hotplug_dock_device(h)       do { } while(0)
 #endif
+
+/*--------------------------------------------------------------------------
+                                  Suspend/Resume
+  -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_SLEEP
+extern int acpi_sleep_init(void);
+#else
+#define acpi_sleep_init() do {} while (0)
+#endif
+
 #endif /*__ACPI_DRIVERS_H__*/
-- 
1.5.0.rc4.345.gb4d2
