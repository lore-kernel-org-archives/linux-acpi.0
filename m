From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 14/14] dell-wmi: Convert to the WMI bus infrastructure
Date: Mon, 30 Nov 2015 17:06:04 -0800
Message-ID: <37ea7ee002b3dcf50b2cdb22c94f8d25251109d2.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/dell-wmi.c | 132 ++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 7c3ebda811ca..48423e53bf94 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -35,6 +35,7 @@
 #include <linux/acpi.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/wmi.h>
 #include <acpi/video.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
@@ -47,13 +48,17 @@ static int acpi_video;
 
 MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
 
+struct dell_wmi_priv {
+	struct input_dev *input_dev;
+};
+
 /*
  * Certain keys are flagged as KE_IGNORE. All of these are either
  * notifications (rather than requests for change) or are also sent
  * via the keyboard controller so should not be sent again.
  */
 
-static const struct key_entry dell_wmi_legacy_keymap[] __initconst = {
+static const struct key_entry dell_wmi_legacy_keymap[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
 	{ KE_KEY, 0xe045, { KEY_PROG1 } },
@@ -119,7 +124,7 @@ struct dell_bios_hotkey_table {
 static const struct dell_bios_hotkey_table *dell_bios_hotkey_table;
 
 /* Uninitialized entries here are KEY_RESERVED == 0. */
-static const u16 bios_to_linux_keycode[256] __initconst = {
+static const u16 bios_to_linux_keycode[256] = {
 	[0]	= KEY_MEDIA,
 	[1]	= KEY_NEXTSONG,
 	[2]	= KEY_PLAYPAUSE,
@@ -163,7 +168,7 @@ static const u16 bios_to_linux_keycode[256] __initconst = {
 };
 
 /* These are applied if the hk table is present and doesn't override them. */
-static const struct key_entry dell_wmi_extra_keymap[] __initconst = {
+static const struct key_entry dell_wmi_extra_keymap[] = {
 	/* Fn-lock */
 	{ KE_IGNORE, 0x151, { KEY_RESERVED } },
 
@@ -183,13 +188,12 @@ static const struct key_entry dell_wmi_extra_keymap[] __initconst = {
 	{ KE_IGNORE, 0x155, { KEY_RESERVED } },
 };
 
-static struct input_dev *dell_wmi_input_dev;
-
-static void dell_wmi_process_key(int reported_key)
+static void dell_wmi_process_key(struct wmi_device *wdev, int reported_key)
 {
+	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
 
-	key = sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
+	key = sparse_keymap_entry_from_scancode(priv->input_dev,
 						reported_key);
 	if (!key) {
 		pr_info("Unknown key with scancode 0x%x pressed\n",
@@ -204,33 +208,18 @@ static void dell_wmi_process_key(int reported_key)
 	     key->keycode == KEY_BRIGHTNESSDOWN) && acpi_video)
 		return;
 
-	sparse_keymap_report_entry(dell_wmi_input_dev, key, 1, true);
+	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
 }
 
-static void dell_wmi_notify(u32 value, void *context)
+static void dell_wmi_notify(struct wmi_device *wdev,
+			    union acpi_object *obj)
 {
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
 	acpi_size buffer_size;
 	u16 *buffer_entry, *buffer_end;
 	int len, i;
 
-	status = wmi_get_event_data(value, &response);
-	if (status != AE_OK) {
-		pr_warn("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj = (union acpi_object *)response.pointer;
-	if (!obj) {
-		pr_warn("no response\n");
-		return;
-	}
-
 	if (obj->type != ACPI_TYPE_BUFFER) {
 		pr_warn("bad response type %x\n", obj->type);
-		kfree(obj);
 		return;
 	}
 
@@ -242,12 +231,11 @@ static void dell_wmi_notify(u32 value, void *context)
 
 	if (!dell_new_hk_type) {
 		if (buffer_size >= 3 && buffer_entry[1] == 0x0)
-			dell_wmi_process_key(buffer_entry[2]);
+			dell_wmi_process_key(wdev, buffer_entry[2]);
 		else if (buffer_size >= 2)
-			dell_wmi_process_key(buffer_entry[1]);
+			dell_wmi_process_key(wdev, buffer_entry[1]);
 		else
 			pr_info("Received unknown WMI event\n");
-		kfree(obj);
 		return;
 	}
 
@@ -293,7 +281,7 @@ static void dell_wmi_notify(u32 value, void *context)
 		case 0x10:
 			/* Keys pressed */
 			for (i = 2; i < len; ++i)
-				dell_wmi_process_key(buffer_entry[i]);
+				dell_wmi_process_key(wdev, buffer_entry[i]);
 			break;
 		case 0x11:
 			for (i = 2; i < len; ++i) {
@@ -334,7 +322,6 @@ static void dell_wmi_notify(u32 value, void *context)
 
 	}
 
-	kfree(obj);
 }
 
 static const struct key_entry * __init dell_wmi_prepare_new_keymap(void)
@@ -407,17 +394,18 @@ skip:
 	return keymap;
 }
 
-static int __init dell_wmi_input_setup(void)
+static int dell_wmi_input_setup(struct wmi_device *wdev)
 {
 	int err;
+	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 
-	dell_wmi_input_dev = input_allocate_device();
-	if (!dell_wmi_input_dev)
+	priv->input_dev = input_allocate_device();
+	if (!priv->input_dev)
 		return -ENOMEM;
 
-	dell_wmi_input_dev->name = "Dell WMI hotkeys";
-	dell_wmi_input_dev->phys = "wmi/input0";
-	dell_wmi_input_dev->id.bustype = BUS_HOST;
+	priv->input_dev->name = "Dell WMI hotkeys";
+	priv->input_dev->id.bustype = BUS_HOST;
+	priv->input_dev->dev.parent = &wdev->dev;
 
 	if (dell_new_hk_type) {
 		const struct key_entry *keymap = dell_wmi_prepare_new_keymap();
@@ -426,7 +414,7 @@ static int __init dell_wmi_input_setup(void)
 			goto err_free_dev;
 		}
 
-		err = sparse_keymap_setup(dell_wmi_input_dev, keymap, NULL);
+		err = sparse_keymap_setup(priv->input_dev, keymap, NULL);
 
 		/*
 		 * Sparse keymap library makes a copy of keymap so we
@@ -434,29 +422,31 @@ static int __init dell_wmi_input_setup(void)
 		 */
 		kfree(keymap);
 	} else {
-		err = sparse_keymap_setup(dell_wmi_input_dev,
+		err = sparse_keymap_setup(priv->input_dev,
 					  dell_wmi_legacy_keymap, NULL);
 	}
 	if (err)
 		goto err_free_dev;
 
-	err = input_register_device(dell_wmi_input_dev);
+	err = input_register_device(priv->input_dev);
 	if (err)
 		goto err_free_keymap;
 
 	return 0;
 
  err_free_keymap:
-	sparse_keymap_free(dell_wmi_input_dev);
+	sparse_keymap_free(priv->input_dev);
  err_free_dev:
-	input_free_device(dell_wmi_input_dev);
+	input_free_device(priv->input_dev);
 	return err;
 }
 
-static void dell_wmi_input_destroy(void)
+static void dell_wmi_input_destroy(struct wmi_device *wdev)
 {
-	sparse_keymap_free(dell_wmi_input_dev);
-	input_unregister_device(dell_wmi_input_dev);
+	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	sparse_keymap_free(priv->input_dev);
+	input_unregister_device(priv->input_dev);
 }
 
 static void __init find_hk_type(const struct dmi_header *dm, void *dummy)
@@ -468,38 +458,48 @@ static void __init find_hk_type(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-static int __init dell_wmi_init(void)
+static int dell_wmi_probe(struct wmi_device *wdev)
 {
-	int err;
-	acpi_status status;
+	struct dell_wmi_priv *priv = devm_kzalloc(
+		&wdev->dev, sizeof(struct dell_wmi_priv), GFP_KERNEL);
 
-	if (!wmi_has_guid(DELL_EVENT_GUID)) {
-		pr_warn("No known WMI GUID found\n");
-		return -ENODEV;
-	}
+	dev_set_drvdata(&wdev->dev, priv);
+
+	return dell_wmi_input_setup(wdev);
+}
 
+static int dell_wmi_remove(struct wmi_device *wdev)
+{
+	dell_wmi_input_destroy(wdev);
+	return 0;
+}
+
+static const struct wmi_device_id dell_wmi_id_table[] = {
+	{ .guid_string = DELL_EVENT_GUID },
+	{ },
+};
+
+static struct wmi_driver dell_wmi_driver = {
+	.driver = {
+		.name = "dell-wmi",
+	},
+	.id_table = dell_wmi_id_table,
+	.probe = dell_wmi_probe,
+	.remove = dell_wmi_remove,
+	.notify = dell_wmi_notify,
+};
+
+static int __init dell_wmi_init(void)
+{
 	dmi_walk(find_hk_type, NULL);
 	acpi_video = acpi_video_get_backlight_type() != acpi_backlight_vendor;
 
-	err = dell_wmi_input_setup();
-	if (err)
-		return err;
-
-	status = wmi_install_notify_handler(DELL_EVENT_GUID,
-					 dell_wmi_notify, NULL);
-	if (ACPI_FAILURE(status)) {
-		dell_wmi_input_destroy();
-		pr_err("Unable to register notify handler - %d\n", status);
-		return -ENODEV;
-	}
-
-	return 0;
+	return wmi_driver_register(&dell_wmi_driver);
 }
 module_init(dell_wmi_init);
 
 static void __exit dell_wmi_exit(void)
 {
-	wmi_remove_notify_handler(DELL_EVENT_GUID);
-	dell_wmi_input_destroy();
+	wmi_driver_unregister(&dell_wmi_driver);
 }
 module_exit(dell_wmi_exit);
-- 
2.5.0
