From: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH] ibm-acpi: module loading fix, LED control fix
Date: Sat, 23 Oct 2004 01:06:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041023080608.GC26903@aero.ensim.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Len,

The attached patch fixes a couple of bugs introduced in the 0.5
release:

- The CMOS handle was incorrectly marked as required, breaking insmod
  on models without one;

- The BLED method was incorrectly required if LED is not defined,
  breaking LED control on the A21e.

Both fixes have been tested. The patch also includes minor doc and
comment changes. Please apply.

Thanks,
Boris

diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt
--- linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt	2004-10-23 00:42:47.288393936 -0700
+++ linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt	2004-10-23 00:43:47.625221344 -0700
@@ -1,7 +1,7 @@
 		    IBM ThinkPad ACPI Extras Driver
 
-                            Version 0.6
-                          19 October 2004
+                            Version 0.7
+                          23 October 2004
 
                Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
 		      http://ibm-acpi.sf.net/
@@ -370,8 +370,8 @@
 	0 - power
 	1 - battery (orange)
 	2 - battery (green)
-	3 - UltraBase dock
-	4 - UltraBay (in dock)
+	3 - UltraBase
+	4 - UltraBay
 	7 - standby
 
 All of the above can be turned on and off and can be made to blink.
diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c
--- linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2004-10-23 00:42:47.294393024 -0700
+++ linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c	2004-10-23 00:43:33.569358160 -0700
@@ -41,9 +41,11 @@
  *			experimental led control
  *			experimental acpi sounds
  *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
+ *  2004-10-23	0.7	fix module loading on A21e, A22p, T20, T21, X20
+ *			fix LED control on A21e
  */
 
-#define IBM_VERSION "0.6"
+#define IBM_VERSION "0.7"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -61,7 +63,6 @@
 #define IBM_URL "http://ibm-acpi.sf.net/"
 
 #define IBM_DIR IBM_NAME
-#define IBM_CLASS IBM_NAME
 
 #define IBM_LOG IBM_FILE ": "
 #define IBM_ERR	   KERN_ERR    IBM_LOG
@@ -84,7 +85,7 @@
 	static char        *object##_paths[] = { paths }
 
 IBM_HANDLE(ec, root,
-	   "\\_SB.PCI0.ISA.EC",    /* A21e, T20, T21, X20 */
+	   "\\_SB.PCI0.ISA.EC",    /* A21e, A22p, T20, T21, X20 */
 	   "\\_SB.PCI0.LPC.EC",    /* all others */
 );
 
@@ -97,24 +98,24 @@
 	   "\\UCMS",               /* R50, R50p, R51, T4x, X31, X40 */
 	   "\\CMOS",               /* A3x, G40, R32, T23, T30, X22, X24, X30 */
 	   "\\CMS",                /* R40, R40e */
-);
+);                                 /* A21e, A22p, T20, T21, X20 */
 
 IBM_HANDLE(dock, root,
 	   "\\_SB.GDCK",           /* X30, X31, X40 */
-	   "\\_SB.PCI0.DOCK",      /* T20, T21, X20 */
+	   "\\_SB.PCI0.DOCK",      /* A22p, T20, T21, X20 */
 	   "\\_SB.PCI0.PCI1.DOCK", /* all others */
 );                                 /* A21e, G40, R32, R40, R40e */
 
 IBM_HANDLE(bay, root,
 	   "\\_SB.PCI0.IDE0.SCND.MSTR");      /* all except A21e */
 IBM_HANDLE(bayej, root,
-	   "\\_SB.PCI0.IDE0.SCND.MSTR._EJ0"); /* all except A21e, A31, A31p */
+	   "\\_SB.PCI0.IDE0.SCND.MSTR._EJ0"); /* all except A2x, A3x */
 
-IBM_HANDLE(lght, root, "\\LGHT");  /* A21e, T20, T21, X20 */
+IBM_HANDLE(lght, root, "\\LGHT");  /* A21e, A22p, T20, T21, X20 */
 IBM_HANDLE(hkey, ec,   "HKEY");    /* all */
-IBM_HANDLE(led,  ec,   "LED");     /* all except A21e, T20, T21, X20 */
-IBM_HANDLE(sysl, ec,   "SYSL");    /* A21e, T20, T21, X20 */
-IBM_HANDLE(bled, ec,   "BLED");    /* T20, T21, X20 */
+IBM_HANDLE(led,  ec,   "LED");     /* all except A21e, A22p, T20, T21, X20 */
+IBM_HANDLE(sysl, ec,   "SYSL");    /* A21e, A22p, T20, T21, X20 */
+IBM_HANDLE(bled, ec,   "BLED");    /* A22p, T20, T21, X20 */
 IBM_HANDLE(beep, ec,   "BEEP");    /* all models */
 
 struct ibm_struct {
@@ -318,7 +319,7 @@
 			 &ibm->state.hotkey.status,
 			 &ibm->state.hotkey.mask);
 	if (ret < 0) {
-		/* mask not supported on A21e, T20, T21, X20, X22, X24 */
+		/* mask not supported on A21e, A22p, T20, T21, X20, X22, X24 */
 		ibm->supported = 0;
 		ret = hotkey_get(ibm,
 				 &ibm->state.hotkey.status,
@@ -691,7 +692,7 @@
 
 static int bay_init(struct ibm_struct *ibm)
 {
-	/* bay not supported on A21e, G40, R32, R40e */
+	/* bay not supported on A21e, A22p, A31, A31p, G40, R32, R40e */
 	ibm->supported = bay_handle && bayej_handle &&
 		acpi_evalf(bay_handle, NULL, "_STA", "qv");
 
@@ -740,7 +741,7 @@
 {
 	int len = 0;
 
-	/* cmos not supported on A21e, T20, T21, X20 */
+	/* cmos not supported on A21e, A22p, T20, T21, X20 */
 	if (!cmos_handle)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else {
@@ -788,9 +789,6 @@
 	unsigned int led;
 	int led_cmd, sysl_cmd, bled_a, bled_b;
 
-	if (!led_handle && !bled_handle)
-		return -EINVAL;
-
 	while ((cmd = next_cmd(&buf))) {
 		if (sscanf(cmd, "%u", &led) != 1)
 			return -EINVAL;
@@ -1196,7 +1194,7 @@
 	IBM_HANDLE_INIT_REQ(ec);
 	IBM_HANDLE_INIT_REQ(hkey);
 	IBM_HANDLE_INIT_REQ(vid);
-	IBM_HANDLE_INIT_REQ(cmos);
+	IBM_HANDLE_INIT(cmos);
 	IBM_HANDLE_INIT(lght);
 	IBM_HANDLE_INIT(dock);
 	IBM_HANDLE_INIT(bay);
@@ -1206,6 +1204,11 @@
 	IBM_HANDLE_INIT(bled);
 	IBM_HANDLE_INIT_REQ(beep);
 
+	if (!cmos_handle && !lght_handle) {
+		printk(IBM_ERR "neither cmos nor lght object found\n");
+		return -ENODEV;
+	}
+
 	if (!led_handle && !sysl_handle) {
 		printk(IBM_ERR "neither led nor sysl object found\n");
 		return -ENODEV;

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ibm-acpi-0.7.patch"

diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt
--- linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt	2004-10-23 00:42:47.288393936 -0700
+++ linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt	2004-10-23 00:43:47.625221344 -0700
@@ -1,7 +1,7 @@
 		    IBM ThinkPad ACPI Extras Driver
 
-                            Version 0.6
-                          19 October 2004
+                            Version 0.7
+                          23 October 2004
 
                Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
 		      http://ibm-acpi.sf.net/
@@ -370,8 +370,8 @@
 	0 - power
 	1 - battery (orange)
 	2 - battery (green)
-	3 - UltraBase dock
-	4 - UltraBay (in dock)
+	3 - UltraBase
+	4 - UltraBay
 	7 - standby
 
 All of the above can be turned on and off and can be made to blink.
diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c
--- linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2004-10-23 00:42:47.294393024 -0700
+++ linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c	2004-10-23 00:43:33.569358160 -0700
@@ -41,9 +41,11 @@
  *			experimental led control
  *			experimental acpi sounds
  *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
+ *  2004-10-23	0.7	fix module loading on A21e, A22p, T20, T21, X20
+ *			fix LED control on A21e
  */
 
-#define IBM_VERSION "0.6"
+#define IBM_VERSION "0.7"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -61,7 +63,6 @@
 #define IBM_URL "http://ibm-acpi.sf.net/"
 
 #define IBM_DIR IBM_NAME
-#define IBM_CLASS IBM_NAME
 
 #define IBM_LOG IBM_FILE ": "
 #define IBM_ERR	   KERN_ERR    IBM_LOG
@@ -84,7 +85,7 @@
 	static char        *object##_paths[] = { paths }
 
 IBM_HANDLE(ec, root,
-	   "\\_SB.PCI0.ISA.EC",    /* A21e, T20, T21, X20 */
+	   "\\_SB.PCI0.ISA.EC",    /* A21e, A22p, T20, T21, X20 */
 	   "\\_SB.PCI0.LPC.EC",    /* all others */
 );
 
@@ -97,24 +98,24 @@
 	   "\\UCMS",               /* R50, R50p, R51, T4x, X31, X40 */
 	   "\\CMOS",               /* A3x, G40, R32, T23, T30, X22, X24, X30 */
 	   "\\CMS",                /* R40, R40e */
-);
+);                                 /* A21e, A22p, T20, T21, X20 */
 
 IBM_HANDLE(dock, root,
 	   "\\_SB.GDCK",           /* X30, X31, X40 */
-	   "\\_SB.PCI0.DOCK",      /* T20, T21, X20 */
+	   "\\_SB.PCI0.DOCK",      /* A22p, T20, T21, X20 */
 	   "\\_SB.PCI0.PCI1.DOCK", /* all others */
 );                                 /* A21e, G40, R32, R40, R40e */
 
 IBM_HANDLE(bay, root,
 	   "\\_SB.PCI0.IDE0.SCND.MSTR");      /* all except A21e */
 IBM_HANDLE(bayej, root,
-	   "\\_SB.PCI0.IDE0.SCND.MSTR._EJ0"); /* all except A21e, A31, A31p */
+	   "\\_SB.PCI0.IDE0.SCND.MSTR._EJ0"); /* all except A2x, A3x */
 
-IBM_HANDLE(lght, root, "\\LGHT");  /* A21e, T20, T21, X20 */
+IBM_HANDLE(lght, root, "\\LGHT");  /* A21e, A22p, T20, T21, X20 */
 IBM_HANDLE(hkey, ec,   "HKEY");    /* all */
-IBM_HANDLE(led,  ec,   "LED");     /* all except A21e, T20, T21, X20 */
-IBM_HANDLE(sysl, ec,   "SYSL");    /* A21e, T20, T21, X20 */
-IBM_HANDLE(bled, ec,   "BLED");    /* T20, T21, X20 */
+IBM_HANDLE(led,  ec,   "LED");     /* all except A21e, A22p, T20, T21, X20 */
+IBM_HANDLE(sysl, ec,   "SYSL");    /* A21e, A22p, T20, T21, X20 */
+IBM_HANDLE(bled, ec,   "BLED");    /* A22p, T20, T21, X20 */
 IBM_HANDLE(beep, ec,   "BEEP");    /* all models */
 
 struct ibm_struct {
@@ -318,7 +319,7 @@
 			 &ibm->state.hotkey.status,
 			 &ibm->state.hotkey.mask);
 	if (ret < 0) {
-		/* mask not supported on A21e, T20, T21, X20, X22, X24 */
+		/* mask not supported on A21e, A22p, T20, T21, X20, X22, X24 */
 		ibm->supported = 0;
 		ret = hotkey_get(ibm,
 				 &ibm->state.hotkey.status,
@@ -691,7 +692,7 @@
 
 static int bay_init(struct ibm_struct *ibm)
 {
-	/* bay not supported on A21e, G40, R32, R40e */
+	/* bay not supported on A21e, A22p, A31, A31p, G40, R32, R40e */
 	ibm->supported = bay_handle && bayej_handle &&
 		acpi_evalf(bay_handle, NULL, "_STA", "qv");
 
@@ -740,7 +741,7 @@
 {
 	int len = 0;
 
-	/* cmos not supported on A21e, T20, T21, X20 */
+	/* cmos not supported on A21e, A22p, T20, T21, X20 */
 	if (!cmos_handle)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else {
@@ -788,9 +789,6 @@
 	unsigned int led;
 	int led_cmd, sysl_cmd, bled_a, bled_b;
 
-	if (!led_handle && !bled_handle)
-		return -EINVAL;
-
 	while ((cmd = next_cmd(&buf))) {
 		if (sscanf(cmd, "%u", &led) != 1)
 			return -EINVAL;
@@ -1196,7 +1194,7 @@
 	IBM_HANDLE_INIT_REQ(ec);
 	IBM_HANDLE_INIT_REQ(hkey);
 	IBM_HANDLE_INIT_REQ(vid);
-	IBM_HANDLE_INIT_REQ(cmos);
+	IBM_HANDLE_INIT(cmos);
 	IBM_HANDLE_INIT(lght);
 	IBM_HANDLE_INIT(dock);
 	IBM_HANDLE_INIT(bay);
@@ -1206,6 +1204,11 @@
 	IBM_HANDLE_INIT(bled);
 	IBM_HANDLE_INIT_REQ(beep);
 
+	if (!cmos_handle && !lght_handle) {
+		printk(IBM_ERR "neither cmos nor lght object found\n");
+		return -ENODEV;
+	}
+
 	if (!led_handle && !sysl_handle) {
 		printk(IBM_ERR "neither led nor sysl object found\n");
 		return -ENODEV;

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
