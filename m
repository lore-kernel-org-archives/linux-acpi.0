From: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH] remove acpi_specific_hotkey kernel option
Date: Sat, 19 Mar 2005 04:00:53 -0800
Message-ID: <20050319120053.GV12172@aero.ensim.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, john-wanGne27zNesTnJN9+BGXg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Len,

The patch below (also attached) reverts part of the generic hotkey
patch, specifically the acpi_specific_hotkey kernel option, for the
following reasons:

- The default for this option is to disable several platform-specific
drivers. This would break existing setups relying on those drivers.

- The generic hotkey driver relies on userspace setup but no userspace
tools or configuration for common platforms exists. Making it the
default at this time is not appropriate.

- The generic hotkey driver does not claim any ACPI devices at insmod
time (since it doesn't know what HID to claim) and can therefore
coexist with a platform-specific driver. It can then be up to the user
to unload the undesired driver (or not compile it in the first place).

- The platform-specific drivers have more features than simply hot
keys. For example, ibm-acpi has 13 other features (none of which can
be implemented via standard ACPI methods).

The patch is against 2.6.12-rc1 + acpi-20050309. Please apply.

Regards,
Boris

diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/asus_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/asus_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/asus_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/asus_acpi.c	2005-03-19 03:19:48.908896304 -0800
@@ -1204,10 +1204,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(KERN_ERR "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
 		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/hotkey.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/hotkey.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/hotkey.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/hotkey.c	2005-03-19 03:20:15.022926368 -0800
@@ -907,11 +907,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (acpi_specific_hotkey_enabled) {
-		printk("Using specific hotkey driver\n");
-		return -ENODEV;
-	}
-
 	hotkey_proc_dir = proc_mkdir(HOTKEY_PROC, acpi_root_dir);
 	if (!hotkey_proc_dir) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/ibm_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/ibm_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/ibm_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/ibm_acpi.c	2005-03-19 03:20:28.120935168 -0800
@@ -1185,10 +1185,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(IBM_ERR "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	/* these handles are required */
 	if (IBM_HANDLE_INIT(ec,	  1) < 0 ||
 	    IBM_HANDLE_INIT(hkey, 1) < 0 ||
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/osl.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/osl.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/osl.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/osl.c	2005-03-19 03:21:17.608411928 -0800
@@ -71,9 +71,6 @@
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
-int acpi_specific_hotkey_enabled;
-EXPORT_SYMBOL(acpi_specific_hotkey_enabled);
-
 static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -1155,15 +1152,6 @@
 
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
 
-int __init
-acpi_hotkey_setup(char *str)
-{
-	acpi_specific_hotkey_enabled = TRUE;
-	return 1;
-}
-
-__setup("acpi_specific_hotkey", acpi_hotkey_setup);
-
 /*
  * max_cstate is defined in the base kernel so modules can
  * change it w/o depending on the state of the processor module.
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/toshiba_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/toshiba_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/toshiba_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/toshiba_acpi.c	2005-03-19 03:21:38.154288480 -0800
@@ -530,10 +530,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(MY_INFO "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	/* simple device detection: look for HCI method */
 	if (is_valid_acpi_path(METHOD_HCI_1))
 		method_hci = METHOD_HCI_1;
diff -Nur linux-2.6.12-rc1-acpi/include/acpi/acpi_drivers.h linux-2.6.12-rc1-acpi-bd/include/acpi/acpi_drivers.h
--- linux-2.6.12-rc1-acpi/include/acpi/acpi_drivers.h	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/include/acpi/acpi_drivers.h	2005-03-19 03:17:26.000000000 -0800
@@ -108,10 +108,4 @@
 
 int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
 
-/* --------------------------------------------------------------------------
-                                    Hot Keys
-   -------------------------------------------------------------------------- */
-
-extern int acpi_specific_hotkey_enabled;
-
 #endif /*__ACPI_DRIVERS_H__*/

--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="no-acpi-specific-hotkey.patch"

diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/asus_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/asus_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/asus_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/asus_acpi.c	2005-03-19 03:19:48.908896304 -0800
@@ -1204,10 +1204,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(KERN_ERR "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
 		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/hotkey.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/hotkey.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/hotkey.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/hotkey.c	2005-03-19 03:20:15.022926368 -0800
@@ -907,11 +907,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (acpi_specific_hotkey_enabled) {
-		printk("Using specific hotkey driver\n");
-		return -ENODEV;
-	}
-
 	hotkey_proc_dir = proc_mkdir(HOTKEY_PROC, acpi_root_dir);
 	if (!hotkey_proc_dir) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/ibm_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/ibm_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/ibm_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/ibm_acpi.c	2005-03-19 03:20:28.120935168 -0800
@@ -1185,10 +1185,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(IBM_ERR "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	/* these handles are required */
 	if (IBM_HANDLE_INIT(ec,	  1) < 0 ||
 	    IBM_HANDLE_INIT(hkey, 1) < 0 ||
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/osl.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/osl.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/osl.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/osl.c	2005-03-19 03:21:17.608411928 -0800
@@ -71,9 +71,6 @@
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
-int acpi_specific_hotkey_enabled;
-EXPORT_SYMBOL(acpi_specific_hotkey_enabled);
-
 static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -1155,15 +1152,6 @@
 
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
 
-int __init
-acpi_hotkey_setup(char *str)
-{
-	acpi_specific_hotkey_enabled = TRUE;
-	return 1;
-}
-
-__setup("acpi_specific_hotkey", acpi_hotkey_setup);
-
 /*
  * max_cstate is defined in the base kernel so modules can
  * change it w/o depending on the state of the processor module.
diff -Nur linux-2.6.12-rc1-acpi/drivers/acpi/toshiba_acpi.c linux-2.6.12-rc1-acpi-bd/drivers/acpi/toshiba_acpi.c
--- linux-2.6.12-rc1-acpi/drivers/acpi/toshiba_acpi.c	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/drivers/acpi/toshiba_acpi.c	2005-03-19 03:21:38.154288480 -0800
@@ -530,10 +530,6 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!acpi_specific_hotkey_enabled){
-		printk(MY_INFO "Using generic hotkey driver\n");
-		return -ENODEV;	
-	}
 	/* simple device detection: look for HCI method */
 	if (is_valid_acpi_path(METHOD_HCI_1))
 		method_hci = METHOD_HCI_1;
diff -Nur linux-2.6.12-rc1-acpi/include/acpi/acpi_drivers.h linux-2.6.12-rc1-acpi-bd/include/acpi/acpi_drivers.h
--- linux-2.6.12-rc1-acpi/include/acpi/acpi_drivers.h	2005-03-19 02:37:49.000000000 -0800
+++ linux-2.6.12-rc1-acpi-bd/include/acpi/acpi_drivers.h	2005-03-19 03:17:26.000000000 -0800
@@ -108,10 +108,4 @@
 
 int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
 
-/* --------------------------------------------------------------------------
-                                    Hot Keys
-   -------------------------------------------------------------------------- */
-
-extern int acpi_specific_hotkey_enabled;
-
 #endif /*__ACPI_DRIVERS_H__*/

--VACxsDaSTfeluoxK--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
