From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 01/13] ACPI: thinkpad-acpi: BIOS backlight
	mode helper (v2)
Date: Thu, 10 Apr 2008 00:52:53 -0300
Message-ID: <1207799585-10112-2-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207799585-10112-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lenovo ThinkPads with generic ACPI backlight level control can be easily
set to react to keyboard brightness key presses in a more predictable way
than what they do when in "DOS / bootloader" mode after Linux brings
up the ACPI interface.

The switch to the ACPI backlight mode in the firmware is designed to be
safe to use only as an one way trapdoor.  One is not to force the firmware
to switch back to "DOS/bootloader" mode except by rebooting.  The mode
switch itself is performed by calling any of the ACPI _BCL methods at least
once.

When in ACPI mode, the backlight firmware just issues (standard) events for
the brightness up/down hot key presses along with the non-standard HKEY
events which thinkpad-acpi traps, and doesn't touch the hardware.

thinkpad-acpi will:

1. Place the ThinkPad firmware in ACPI backlight control mode
   if one is available
2. Suppress HKEY backlight change notifications by default
   to avoid double-reporting when ACPI video is loaded when
   the ThinkPad is in ACPI backlight control mode
3. Urge the user to load the ACPI video driver

The user is free to use either the ACPI video driver to get the brightness
key events, or to override the thinkpad-acpi default hotkey mask to get
them from thinkpad-acpi as well (this will result in duplicate events if
ACPI video is loaded, so let's hope distros won't screw this up).

Provided userspace is sane, all should work (and *keep* working), which is
more that can be said about the non-ACPI mode of the new Lenovo ThinkPad
BIOSes when coupled to current userspace and X.org drivers.

Full guidelines for backlight hot key reporting and use of the
thinkpad-acpi backlight interface have been added to the documentation.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |   49 +++++++
 drivers/misc/thinkpad_acpi.c            |  238 +++++++++++++++++--------------
 2 files changed, 182 insertions(+), 105 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 76cb428..bbc8275 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -571,6 +571,46 @@ netlink interface and the input layer interface, and don't bother at all
 with hotkey_report_mode.
 
 
+Brightness hotkey notes:
+
+These are the current sane choices for brightness key mapping in
+thinkpad-acpi:
+
+For IBM and Lenovo models *without* ACPI backlight control (the ones on
+which thinkpad-acpi will autoload its backlight interface by default,
+and on which ACPI video does not export a backlight interface):
+
+1. Don't enable or map the brightness hotkeys in thinkpad-acpi, as
+   these older firmware versions unfortunately won't respect the hotkey
+   mask for brightness keys anyway, and always reacts to them.  This
+   usually work fine, unless X.org is doing something to block the BIOS.
+   In that case, use (3) below.  This is the default mode of operation.
+
+2. Enable the hotkeys, but map them to something else that is NOT
+   KEY_BRIGHTNESS_UP/DOWN or any other keycode that would cause
+   userspace to try to change the backlight level, and use that as an
+   on-screen-display hint.
+
+3. IF AND ONLY IF X.org finds a way to block the firmware from
+   automatically changing the brightness, enable the hotkeys and map
+   them to KEY_BRIGHTNESS_UP and KEY_BRIGHTNESS_DOWN, and feed that to
+   something that calls xbacklight.  thinkpad-acpi will not be able to
+   change brightness in that case either, so you should disable its
+   backlight interface.
+
+For Lenovo models *with* ACPI backlight control:
+
+1. Load up ACPI video and use that.  ACPI video will report ACPI
+   events for brightness change keys.  Do not mess with thinkpad-acpi
+   defaults in this case.  thinkpad-acpi should not have anything to do
+   with backlight events in a scenario where ACPI video is loaded:
+   brightness hotkeys must be disabled, and the backlight interface is
+   to be kept disabled as well.  This is the default mode of operation.
+
+2. Do *NOT* load up ACPI video, enable the hotkeys in thinkpad-acpi,
+   and map them to KEY_BRIGHTNESS_UP and KEY_BRIGHTNESS_DOWN.  Process
+   these keys on userspace somehow (e.g. by calling xbacklight).
+
 Bluetooth
 ---------
 
@@ -1090,6 +1130,15 @@ it there will be the following attributes:
 		dim the display.
 
 
+WARNING:
+
+    Whatever you do, do NOT ever call thinkpad-acpi backlight-level change
+    interface and the ACPI-based backlight level change interface
+    (available on newer BIOSes, and driven by the Linux ACPI video driver)
+    at the same time.  The two will interact in bad ways, do funny things,
+    and maybe reduce the life of the backlight lamps by needlessly kicking
+    its level up and down at every change.
+
 Volume control -- /proc/acpi/ibm/volume
 ---------------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6cb7812..2c85a2e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -225,6 +225,7 @@ static struct {
 	u32 light:1;
 	u32 light_status:1;
 	u32 bright_16levels:1;
+	u32 bright_acpimode:1;
 	u32 wan:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
@@ -807,6 +808,80 @@ static int parse_strtoul(const char *buf,
 	return 0;
 }
 
+static int __init tpacpi_query_bcl_levels(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	int rc;
+
+	if (ACPI_SUCCESS(acpi_evaluate_object(handle, NULL, NULL, &buffer))) {
+		obj = (union acpi_object *)buffer.pointer;
+		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
+			printk(TPACPI_ERR "Unknown _BCL data, "
+			       "please report this to %s\n", TPACPI_MAIL);
+			rc = 0;
+		} else {
+			rc = obj->package.count;
+		}
+	} else {
+		return 0;
+	}
+
+	kfree(buffer.pointer);
+	return rc;
+}
+
+static acpi_status __init tpacpi_acpi_walk_find_bcl(acpi_handle handle,
+					u32 lvl, void *context, void **rv)
+{
+	char name[ACPI_PATH_SEGMENT_LENGTH];
+	struct acpi_buffer buffer = { sizeof(name), &name };
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
+	    !strncmp("_BCL", name, sizeof(name) - 1)) {
+		BUG_ON(!rv || !*rv);
+		**(int **)rv = tpacpi_query_bcl_levels(handle);
+		return AE_CTRL_TERMINATE;
+	} else {
+		return AE_OK;
+	}
+}
+
+/*
+ * Returns 0 (no ACPI _BCL or _BCL invalid), or size of brightness map
+ */
+static int __init tpacpi_check_std_acpi_brightness_support(void)
+{
+	int status;
+	int bcl_levels = 0;
+	void *bcl_ptr = &bcl_levels;
+
+	if (!vid_handle) {
+		TPACPI_ACPIHANDLE_INIT(vid);
+	}
+	if (!vid_handle)
+		return 0;
+
+	/*
+	 * Search for a _BCL method, and execute it.  This is safe on all
+	 * ThinkPads, and as a side-effect, _BCL will place a Lenovo Vista
+	 * BIOS in ACPI backlight control mode.  We do NOT have to care
+	 * about calling the _BCL method in an enabled video device, any
+	 * will do for our purposes.
+	 */
+
+	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
+				     tpacpi_acpi_walk_find_bcl, NULL,
+				     &bcl_ptr);
+
+	if (ACPI_SUCCESS(status) && bcl_levels > 2) {
+		tp_features.bright_acpimode = 1;
+		return (bcl_levels - 2);
+	}
+
+	return 0;
+}
+
 /*************************************************************************
  * thinkpad-acpi driver attributes
  */
@@ -1887,6 +1962,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
 
+		/* These either have to go through ACPI video, or
+		 * act like in the IBM ThinkPads, so don't ever
+		 * enable them by default */
 		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
 		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
 
@@ -2091,6 +2169,32 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			set_bit(SW_TABLET_MODE, tpacpi_inputdev->swbit);
 		}
 
+		/* Do not issue duplicate brightness change events to
+		 * userspace */
+		if (!tp_features.bright_acpimode)
+			/* update bright_acpimode... */
+			tpacpi_check_std_acpi_brightness_support();
+
+		if (tp_features.bright_acpimode) {
+			printk(TPACPI_INFO
+			       "This ThinkPad has standard ACPI backlight "
+			       "brightness control, supported by the ACPI "
+			       "video driver\n");
+			printk(TPACPI_NOTICE
+			       "Disabling thinkpad-acpi brightness events "
+			       "by default...\n");
+
+			/* The hotkey_reserved_mask change below is not
+			 * necessary while the keys are at KEY_RESERVED in the
+			 * default map, but better safe than sorry, leave it
+			 * here as a marker of what we have to do, especially
+			 * when we finally become able to set this at runtime
+			 * on response to X.org requests */
+			hotkey_reserved_mask |=
+				(1 << TP_ACPI_HOTKEYSCAN_FNHOME)
+				| (1 << TP_ACPI_HOTKEYSCAN_FNEND);
+		}
+
 		dbg_printk(TPACPI_DBG_INIT,
 				"enabling hot key handling\n");
 		res = hotkey_status_set(1);
@@ -4273,100 +4377,6 @@ static struct backlight_ops ibm_backlight_data = {
 
 /* --------------------------------------------------------------------- */
 
-static int __init tpacpi_query_bcll_levels(acpi_handle handle)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	int rc;
-
-	if (ACPI_SUCCESS(acpi_evaluate_object(handle, NULL, NULL, &buffer))) {
-		obj = (union acpi_object *)buffer.pointer;
-		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-			printk(TPACPI_ERR "Unknown BCLL data, "
-			       "please report this to %s\n", TPACPI_MAIL);
-			rc = 0;
-		} else {
-			rc = obj->package.count;
-		}
-	} else {
-		return 0;
-	}
-
-	kfree(buffer.pointer);
-	return rc;
-}
-
-static acpi_status __init brightness_find_bcll(acpi_handle handle, u32 lvl,
-					void *context, void **rv)
-{
-	char name[ACPI_PATH_SEGMENT_LENGTH];
-	struct acpi_buffer buffer = { sizeof(name), &name };
-
-	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
-	    !strncmp("BCLL", name, sizeof(name) - 1)) {
-		if (tpacpi_query_bcll_levels(handle) == 16) {
-			*rv = handle;
-			return AE_CTRL_TERMINATE;
-		} else {
-			return AE_OK;
-		}
-	} else {
-		return AE_OK;
-	}
-}
-
-static int __init brightness_check_levels(void)
-{
-	int status;
-	void *found_node = NULL;
-
-	if (!vid_handle) {
-		TPACPI_ACPIHANDLE_INIT(vid);
-	}
-	if (!vid_handle)
-		return 0;
-
-	/* Search for a BCLL package with 16 levels */
-	status = acpi_walk_namespace(ACPI_TYPE_PACKAGE, vid_handle, 3,
-					brightness_find_bcll, NULL,
-					&found_node);
-
-	return (ACPI_SUCCESS(status) && found_node != NULL);
-}
-
-static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
-					void *context, void **rv)
-{
-	char name[ACPI_PATH_SEGMENT_LENGTH];
-	struct acpi_buffer buffer = { sizeof(name), &name };
-
-	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
-	    !strncmp("_BCL", name, sizeof(name) - 1)) {
-		*rv = handle;
-		return AE_CTRL_TERMINATE;
-	} else {
-		return AE_OK;
-	}
-}
-
-static int __init brightness_check_std_acpi_support(void)
-{
-	int status;
-	void *found_node = NULL;
-
-	if (!vid_handle) {
-		TPACPI_ACPIHANDLE_INIT(vid);
-	}
-	if (!vid_handle)
-		return 0;
-
-	/* Search for a _BCL method, but don't execute it */
-	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
-				     brightness_find_bcl, NULL, &found_node);
-
-	return (ACPI_SUCCESS(status) && found_node != NULL);
-}
-
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
@@ -4375,13 +4385,19 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 
 	mutex_init(&brightness_mutex);
 
-	if (!brightness_enable) {
-		dbg_printk(TPACPI_DBG_INIT,
-			   "brightness support disabled by "
-			   "module parameter\n");
-		return 1;
-	} else if (brightness_enable > 1) {
-		if (brightness_check_std_acpi_support()) {
+	/*
+	 * We always attempt to detect acpi support, so as to switch
+	 * Lenovo Vista BIOS to ACPI brightness mode even if we are not
+	 * going to publish a backlight interface
+	 */
+	b = tpacpi_check_std_acpi_brightness_support();
+	if (b > 0) {
+		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
+			printk(TPACPI_NOTICE
+			       "Lenovo BIOS switched to ACPI backlight "
+			       "control mode\n");
+		}
+		if (brightness_enable > 1) {
 			printk(TPACPI_NOTICE
 			       "standard ACPI backlight interface "
 			       "available, not loading native one...\n");
@@ -4389,6 +4405,22 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		}
 	}
 
+	if (!brightness_enable) {
+		dbg_printk(TPACPI_DBG_INIT,
+			   "brightness support disabled by "
+			   "module parameter\n");
+		return 1;
+	}
+
+	if (b > 16) {
+		printk(TPACPI_ERR
+		       "Unsupported brightness interface, "
+		       "please contact %s\n", TPACPI_MAIL);
+		return 1;
+	}
+	if (b == 16)
+		tp_features.bright_16levels = 1;
+
 	if (!brightness_mode) {
 		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
 			brightness_mode = 2;
@@ -4402,10 +4434,6 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (brightness_mode > 3)
 		return -EINVAL;
 
-	tp_features.bright_16levels =
-			thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO &&
-			brightness_check_levels();
-
 	b = brightness_get(NULL);
 	if (b < 0)
 		return 1;
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
