From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: [PATCH] ibm-acpi-0.8 (was Re: 2.6.10-rc1-mm3)
Date: Mon, 8 Nov 2004 17:30:13 -0800
Message-ID: <20041109013013.GA21832@aero.ensim.com>
References: <200411081334.18751.annabellesgarden@yahoo.de> <200411082240.02787.annabellesgarden@yahoo.de> <20041108153022.N14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261320AbUKIBcJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041108153022.N14339@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com, Chris Wright <chrisw@osdl.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 08, 2004 at 03:30:22PM -0800, Chris Wright wrote:
> 
> The init error cleanup paths are broken in that driver.  It creates the
> /proc/acpi/ibm dir and forgets to clean it up.  Partially that's due to
> returning directly from the macro IBM_HANDLE_INIT_REQ.  This should help.

Yikes. Guilty as charged.

I reworked Chris's patch a bit and tried both the error and non-error
case here. Len, if it looks good, please apply.

Thanks,
Boris

diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt
--- linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt	2004-10-23 00:43:47.000000000 -0700
+++ linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt	2004-11-08 17:11:49.894712632 -0800
@@ -1,7 +1,7 @@
 		    IBM ThinkPad ACPI Extras Driver
 
-                            Version 0.7
-                          23 October 2004
+                            Version 0.8
+                          8 November 2004
 
                Borislav Deianov <borislav@users.sf.net>
 		      http://ibm-acpi.sf.net/
diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c
--- linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2004-10-23 00:43:33.000000000 -0700
+++ linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c	2004-11-08 17:11:26.715236448 -0800
@@ -43,9 +43,11 @@
  *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
  *  2004-10-23	0.7	fix module loading on A21e, A22p, T20, T21, X20
  *			fix LED control on A21e
+ *  2004-11-08	0.8	fix init error case, don't return from a macro
+ *				thanks to Chris Wright <chrisw@osdl.org>
  */
 
-#define IBM_VERSION "0.7"
+#define IBM_VERSION "0.8"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1130,25 +1132,19 @@
 			return 0;
 	}
 	
+	*handle = NULL;
+
 	if (required) {
 		printk(IBM_ERR "%s object not found\n", name);
 		return -1;
 	}
 
-	*handle = NULL;
-
 	return 0;
 }
 
-#define IBM_HANDLE_INIT_REQ(object) do {                                      \
-        if (ibm_handle_init(#object, &object##_handle, *object##_parent,      \
-		object##_paths, sizeof(object##_paths)/sizeof(char *), 1) < 0)\
-		return -ENODEV;                                               \
-} while (0)
-
-#define IBM_HANDLE_INIT(object)                                           \
-	ibm_handle_init(#object, &object##_handle, *object##_parent,      \
-		object##_paths, sizeof(object##_paths)/sizeof(char *), 0)
+#define IBM_HANDLE_INIT(object, required)				\
+	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
+		object##_paths, sizeof(object##_paths)/sizeof(char*), required)
 
 
 static void ibm_param(char *feature, char *cmd)
@@ -1184,6 +1180,27 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
+	/* these handles are required */
+	if (IBM_HANDLE_INIT(ec,	  1) < 0 ||
+	    IBM_HANDLE_INIT(hkey, 1) < 0 ||
+	    IBM_HANDLE_INIT(vid,  1) < 0 ||
+	    IBM_HANDLE_INIT(beep, 1) < 0)
+		return -ENODEV;
+
+	/* these handles have alternatives */
+	IBM_HANDLE_INIT(lght, 0);
+	if (IBM_HANDLE_INIT(cmos, !lght_handle) < 0)
+		return -ENODEV;
+	IBM_HANDLE_INIT(sysl, 0);
+	if (IBM_HANDLE_INIT(led, !sysl_handle) < 0)
+		return -ENODEV;
+
+	/* these handles are not required */
+	IBM_HANDLE_INIT(dock,  0);
+	IBM_HANDLE_INIT(bay,   0);
+	IBM_HANDLE_INIT(bayej, 0);
+	IBM_HANDLE_INIT(bled,  0);
+
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
@@ -1191,29 +1208,6 @@
 	}
 	proc_dir->owner = THIS_MODULE;
 	
-	IBM_HANDLE_INIT_REQ(ec);
-	IBM_HANDLE_INIT_REQ(hkey);
-	IBM_HANDLE_INIT_REQ(vid);
-	IBM_HANDLE_INIT(cmos);
-	IBM_HANDLE_INIT(lght);
-	IBM_HANDLE_INIT(dock);
-	IBM_HANDLE_INIT(bay);
-	IBM_HANDLE_INIT(bayej);
-	IBM_HANDLE_INIT(led);
-	IBM_HANDLE_INIT(sysl);
-	IBM_HANDLE_INIT(bled);
-	IBM_HANDLE_INIT_REQ(beep);
-
-	if (!cmos_handle && !lght_handle) {
-		printk(IBM_ERR "neither cmos nor lght object found\n");
-		return -ENODEV;
-	}
-
-	if (!led_handle && !sysl_handle) {
-		printk(IBM_ERR "neither led nor sysl object found\n");
-		return -ENODEV;
-	}
-
 	for (i=0; i<NUM_IBMS; i++) {
 		ret = ibm_init(&ibms[i]);
 		if (ret < 0) {

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ibm-acpi-0.8.patch"

diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt
--- linux-2.6.10-rc1-ibm-acpi.orig/Documentation/ibm-acpi.txt	2004-10-23 00:43:47.000000000 -0700
+++ linux-2.6.10-rc1-ibm-acpi/Documentation/ibm-acpi.txt	2004-11-08 17:11:49.894712632 -0800
@@ -1,7 +1,7 @@
 		    IBM ThinkPad ACPI Extras Driver
 
-                            Version 0.7
-                          23 October 2004
+                            Version 0.8
+                          8 November 2004
 
                Borislav Deianov <borislav@users.sf.net>
 		      http://ibm-acpi.sf.net/
diff -Nur linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c
--- linux-2.6.10-rc1-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2004-10-23 00:43:33.000000000 -0700
+++ linux-2.6.10-rc1-ibm-acpi/drivers/acpi/ibm_acpi.c	2004-11-08 17:11:26.715236448 -0800
@@ -43,9 +43,11 @@
  *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
  *  2004-10-23	0.7	fix module loading on A21e, A22p, T20, T21, X20
  *			fix LED control on A21e
+ *  2004-11-08	0.8	fix init error case, don't return from a macro
+ *				thanks to Chris Wright <chrisw@osdl.org>
  */
 
-#define IBM_VERSION "0.7"
+#define IBM_VERSION "0.8"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1130,25 +1132,19 @@
 			return 0;
 	}
 	
+	*handle = NULL;
+
 	if (required) {
 		printk(IBM_ERR "%s object not found\n", name);
 		return -1;
 	}
 
-	*handle = NULL;
-
 	return 0;
 }
 
-#define IBM_HANDLE_INIT_REQ(object) do {                                      \
-        if (ibm_handle_init(#object, &object##_handle, *object##_parent,      \
-		object##_paths, sizeof(object##_paths)/sizeof(char *), 1) < 0)\
-		return -ENODEV;                                               \
-} while (0)
-
-#define IBM_HANDLE_INIT(object)                                           \
-	ibm_handle_init(#object, &object##_handle, *object##_parent,      \
-		object##_paths, sizeof(object##_paths)/sizeof(char *), 0)
+#define IBM_HANDLE_INIT(object, required)				\
+	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
+		object##_paths, sizeof(object##_paths)/sizeof(char*), required)
 
 
 static void ibm_param(char *feature, char *cmd)
@@ -1184,6 +1180,27 @@
 	if (acpi_disabled)
 		return -ENODEV;
 
+	/* these handles are required */
+	if (IBM_HANDLE_INIT(ec,	  1) < 0 ||
+	    IBM_HANDLE_INIT(hkey, 1) < 0 ||
+	    IBM_HANDLE_INIT(vid,  1) < 0 ||
+	    IBM_HANDLE_INIT(beep, 1) < 0)
+		return -ENODEV;
+
+	/* these handles have alternatives */
+	IBM_HANDLE_INIT(lght, 0);
+	if (IBM_HANDLE_INIT(cmos, !lght_handle) < 0)
+		return -ENODEV;
+	IBM_HANDLE_INIT(sysl, 0);
+	if (IBM_HANDLE_INIT(led, !sysl_handle) < 0)
+		return -ENODEV;
+
+	/* these handles are not required */
+	IBM_HANDLE_INIT(dock,  0);
+	IBM_HANDLE_INIT(bay,   0);
+	IBM_HANDLE_INIT(bayej, 0);
+	IBM_HANDLE_INIT(bled,  0);
+
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
@@ -1191,29 +1208,6 @@
 	}
 	proc_dir->owner = THIS_MODULE;
 	
-	IBM_HANDLE_INIT_REQ(ec);
-	IBM_HANDLE_INIT_REQ(hkey);
-	IBM_HANDLE_INIT_REQ(vid);
-	IBM_HANDLE_INIT(cmos);
-	IBM_HANDLE_INIT(lght);
-	IBM_HANDLE_INIT(dock);
-	IBM_HANDLE_INIT(bay);
-	IBM_HANDLE_INIT(bayej);
-	IBM_HANDLE_INIT(led);
-	IBM_HANDLE_INIT(sysl);
-	IBM_HANDLE_INIT(bled);
-	IBM_HANDLE_INIT_REQ(beep);
-
-	if (!cmos_handle && !lght_handle) {
-		printk(IBM_ERR "neither cmos nor lght object found\n");
-		return -ENODEV;
-	}
-
-	if (!led_handle && !sysl_handle) {
-		printk(IBM_ERR "neither led nor sysl object found\n");
-		return -ENODEV;
-	}
-
 	for (i=0; i<NUM_IBMS; i++) {
 		ret = ibm_init(&ibms[i]);
 		if (ret < 0) {

--6sX45UoQRIJXqkqR--
