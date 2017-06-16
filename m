From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 7/7] platform/x86: fujitsu-laptop: rework debugging
Date: Fri, 16 Jun 2017 06:40:58 +0200
Message-ID: <20170616044058.30443-8-kernel@kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34302 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdFPElS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2017 00:41:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id y25so3107409wrd.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jun 2017 21:41:17 -0700 (PDT)
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Using a dedicated Kconfig option for enabling debugging means the user
may be forced to recompile their kernel in order to gather debugging
information, which is inconvenient.  Replace custom debugging
infrastructure with standard logging functions, taking advantage of
dynamic debug.  Replace a pr_info() call inside an ACPI callback with an
acpi_handle_info() call.

The following mapping was used:

  - FUJLAPTOP_DBG_ERROR -> acpi_handle_err()
  - FUJLAPTOP_DBG_WARN  -> acpi_handle_info() / dev_info()
  - FUJLAPTOP_DBG_INFO  -> acpi_handle_debug()
  - FUJLAPTOP_DBG_TRACE -> acpi_handle_debug() / dev_dbg()

This means that some events which used to only be logged when the user
explicitly requested it will now be logged by default:

  - ACPI method evaluation errors,
  - unknown ACPI notification codes,
  - unknown hotkey scancodes.

The first type of events should happen rarely, if ever at all.  The rest
is interesting from driver development perspective as their presence in
the logs will mean the driver is unaware of certain events, handling of
which should be implemented.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/Kconfig          | 10 -----
 drivers/platform/x86/fujitsu-laptop.c | 78 +++++++++++++----------------------
 2 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 49a1d012f025..980419081ed7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -195,16 +195,6 @@ config FUJITSU_LAPTOP
 
 	  If you have a Fujitsu laptop, say Y or M here.
 
-config FUJITSU_LAPTOP_DEBUG
-	bool "Verbose debug mode for Fujitsu Laptop Extras"
-	depends on FUJITSU_LAPTOP
-	default n
-	---help---
-	  Enables extra debug output from the fujitsu extras driver, at the
-	  expense of a slight increase in driver size.
-
-	  If you are not sure, say N here.
-
 config FUJITSU_TABLET
        tristate "Fujitsu Tablet Extras"
        depends on ACPI
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 0861be36305d..d50872d96e63 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -110,22 +110,6 @@
 
 #define MAX_HOTKEY_RINGBUFFER_SIZE 100
 
-/* Debugging */
-#define FUJLAPTOP_DBG_ERROR	  0x0001
-#define FUJLAPTOP_DBG_WARN	  0x0002
-#define FUJLAPTOP_DBG_INFO	  0x0004
-#define FUJLAPTOP_DBG_TRACE	  0x0008
-
-#ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
-#define vdbg_printk(a_dbg_level, format, arg...) \
-	do { if (dbg_level & a_dbg_level) \
-		printk(KERN_DEBUG pr_fmt("%s: " format), __func__, ## arg); \
-	} while (0)
-#else
-#define vdbg_printk(a_dbg_level, format, arg...) \
-	do { } while (0)
-#endif
-
 /* Device controlling the backlight and associated keys */
 struct fujitsu_bl {
 	struct input_dev *input;
@@ -152,10 +136,6 @@ struct fujitsu_laptop {
 
 static struct acpi_device *fext;
 
-#ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
-static u32 dbg_level = 0x03;
-#endif
-
 /* Fujitsu ACPI interface function */
 
 static int call_fext_func(struct acpi_device *device,
@@ -174,12 +154,13 @@ static int call_fext_func(struct acpi_device *device,
 	status = acpi_evaluate_integer(device->handle, "FUNC", &arg_list,
 				       &value);
 	if (ACPI_FAILURE(status)) {
-		vdbg_printk(FUJLAPTOP_DBG_ERROR, "Failed to evaluate FUNC\n");
+		acpi_handle_err(device->handle, "Failed to evaluate FUNC\n");
 		return -ENODEV;
 	}
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n",
-		    func, op, feature, state, (int)value);
+	acpi_handle_debug(device->handle,
+			  "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n",
+			  func, op, feature, state, (int)value);
 	return value;
 }
 
@@ -206,16 +187,16 @@ static int set_lcd_level(struct acpi_device *device, int level)
 		break;
 	}
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "set lcd level via %s [%d]\n",
-		    method, level);
+	acpi_handle_debug(device->handle, "set lcd level via %s [%d]\n", method,
+			  level);
 
 	if (level < 0 || level >= priv->max_brightness)
 		return -EINVAL;
 
 	status = acpi_execute_simple_method(device->handle, method, level);
 	if (ACPI_FAILURE(status)) {
-		vdbg_printk(FUJLAPTOP_DBG_ERROR, "Failed to evaluate %s\n",
-			    method);
+		acpi_handle_err(device->handle, "Failed to evaluate %s\n",
+				method);
 		return -ENODEV;
 	}
 
@@ -230,7 +211,7 @@ static int get_lcd_level(struct acpi_device *device)
 	unsigned long long state = 0;
 	acpi_status status = AE_OK;
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get lcd level via GBLL\n");
+	acpi_handle_debug(device->handle, "get lcd level via GBLL\n");
 
 	status = acpi_evaluate_integer(device->handle, "GBLL", NULL, &state);
 	if (ACPI_FAILURE(status))
@@ -247,7 +228,7 @@ static int get_max_brightness(struct acpi_device *device)
 	unsigned long long state = 0;
 	acpi_status status = AE_OK;
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get max lcd level via RBLL\n");
+	acpi_handle_debug(device->handle, "get max lcd level via RBLL\n");
 
 	status = acpi_evaluate_integer(device->handle, "RBLL", NULL, &state);
 	if (ACPI_FAILURE(status))
@@ -440,8 +421,8 @@ static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
 	int oldb, newb;
 
 	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
-		vdbg_printk(FUJLAPTOP_DBG_WARN,
-			    "unsupported event [0x%x]\n", event);
+		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
+				 event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
 		return;
 	}
@@ -450,8 +431,8 @@ static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
 	get_lcd_level(device);
 	newb = priv->brightness_level;
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "brightness button event [%i -> %i]\n",
-		    oldb, newb);
+	acpi_handle_debug(device->handle,
+			  "brightness button event [%i -> %i]\n", oldb, newb);
 
 	if (oldb == newb)
 		return;
@@ -797,7 +778,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0
 		&& (i++) < MAX_HOTKEY_RINGBUFFER_SIZE)
 		; /* No action, result is discarded */
-	vdbg_printk(FUJLAPTOP_DBG_INFO, "Discarded %i ringbuffer entries\n", i);
+	acpi_handle_debug(device->handle, "Discarded %i ringbuffer entries\n",
+			  i);
 
 	priv->flags_supported = call_fext_func(device, FUNC_FLAGS, 0x0, 0x0,
 					       0x0);
@@ -812,8 +794,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 						   0x0);
 
 	/* Suspect this is a keymap of the application panel, print it */
-	pr_info("BTNI: [0x%x]\n", call_fext_func(device,
-						 FUNC_BUTTONS, 0x0, 0x0, 0x0));
+	acpi_handle_info(device->handle, "BTNI: [0x%x]\n",
+			 call_fext_func(device, FUNC_BUTTONS, 0x0, 0x0, 0x0));
 
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
@@ -847,14 +829,14 @@ static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 
 	if (priv->scancode_count == ARRAY_SIZE(priv->scancode_buf)) {
-		vdbg_printk(FUJLAPTOP_DBG_WARN,
-			    "Could not push scancode [0x%x]\n", scancode);
+		dev_info(&priv->input->dev, "Could not push scancode [0x%x]\n",
+			 scancode);
 		return;
 	}
 	priv->scancode_buf[priv->scancode_count++] = scancode;
 	sparse_keymap_report_event(priv->input, scancode, 1, false);
-	vdbg_printk(FUJLAPTOP_DBG_TRACE,
-		    "Push scancode into buffer [0x%x]\n", scancode);
+	dev_dbg(&priv->input->dev, "Push scancode into buffer [0x%x]\n",
+		scancode);
 }
 
 static void acpi_fujitsu_laptop_release(struct acpi_device *device)
@@ -865,8 +847,8 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	while (priv->scancode_count > 0) {
 		scancode = priv->scancode_buf[--priv->scancode_count];
 		sparse_keymap_report_event(priv->input, scancode, 0, false);
-		vdbg_printk(FUJLAPTOP_DBG_TRACE,
-			    "Pop scancode from buffer [0x%x]\n", scancode);
+		dev_dbg(&priv->input->dev, "Pop scancode from buffer [0x%x]\n",
+			scancode);
 	}
 }
 
@@ -877,8 +859,8 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	unsigned int irb;
 
 	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
-		vdbg_printk(FUJLAPTOP_DBG_WARN,
-			    "Unsupported event [0x%x]\n", event);
+		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
+				 event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
 		return;
 	}
@@ -896,8 +878,8 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 		else if (scancode == 0)
 			acpi_fujitsu_laptop_release(device);
 		else
-			vdbg_printk(FUJLAPTOP_DBG_WARN,
-				    "Unknown GIRB result [%x]\n", irb);
+			acpi_handle_info(device->handle,
+					 "Unknown GIRB result [%x]\n", irb);
 	}
 
 	/* On some models (first seen on the Skylake-based Lifebook
@@ -999,10 +981,6 @@ module_param(use_alt_lcd_levels, int, 0644);
 MODULE_PARM_DESC(use_alt_lcd_levels, "Interface used for setting LCD brightness level (-1 = auto, 0 = force SBLL, 1 = force SBL2)");
 module_param(disable_brightness_adjust, bool, 0644);
 MODULE_PARM_DESC(disable_brightness_adjust, "Disable LCD brightness adjustment");
-#ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
-module_param_named(debug, dbg_level, uint, 0644);
-MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
-#endif
 
 MODULE_AUTHOR("Jonathan Woithe, Peter Gruber, Tony Vroon");
 MODULE_DESCRIPTION("Fujitsu laptop extras support");
-- 
2.13.1

