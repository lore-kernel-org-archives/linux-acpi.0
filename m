From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Sat, 26 May 2007 14:31:04 -0300
Message-ID: <11802006652058-git-send-email-hmh@hmh.eng.br>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
 <11802006651698-git-send-email-hmh@hmh.eng.br>
 <11802006652128-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56095 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760559AbXEZRbK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 May 2007 13:31:10 -0400
In-Reply-To: <11802006652128-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi-devel@lists.sourceforge.net
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, dtor@mail.ru, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add a sysfs interface to allow userspace to modify the mapping between
ThinkPad hotkeys and the keycode input events they generate.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |  109 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index fad3bd0..5690247 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -809,6 +809,84 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_bios_mask =
 	__ATTR(hotkey_bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
 
+/* sysfs hotkey event_map ---------------------------------------------- */
+static ssize_t hotkey_event_map_read(struct kobject *kobj, char *buffer,
+					loff_t off, size_t count)
+{
+	int res;
+
+	BUG_ON(off < 0);
+
+	/* sanitize */
+	if (off > sizeof(hotkey_event_map))
+		return 0;
+	if (off + count > sizeof(hotkey_event_map))
+		count = sizeof(hotkey_event_map) - off;
+
+	if (count > 0) {
+		res = mutex_lock_interruptible(&hotkey_mutex);
+		if (res < 0)
+			return res;
+
+		/* Attribute is little-endian.  Since this driver is for 
+		 * ia32 and amd-64 only, conversion is not required */
+		memcpy(buffer, (char *)hotkey_event_map + off, count);
+
+		mutex_unlock(&hotkey_mutex);
+	}
+
+	return count;
+}
+
+static ssize_t hotkey_event_map_write(struct kobject *kobj, char *buffer,
+					loff_t off, size_t count)
+{
+	unsigned int i;
+	u16 *p;
+	int res;
+
+	/*
+	 * Due to weirdness in the sysfs bin attribute support,
+	 * for fixed-size attributes, we accept only full writes
+	 * of the entire buffer.
+	 *
+	 * Too bad we can't force a fixed size for the inode,
+	 * that would allow proper support.  On 2.6.20, a short
+	 * write can truncate the file(!) and break subsequent
+	 * reads of the binary attribute.
+	 */
+	if (off != 0 || count != sizeof(hotkey_event_map))
+		return -EINVAL;
+
+	/* validate buffer */
+	for (i = 0, p = (u16 *)buffer; i < count; i += 2, p++)
+		if (*p > KEY_MAX)
+			return -EINVAL;
+
+	res = mutex_lock_interruptible(&hotkey_mutex);
+	if (res < 0)
+		return res;
+
+	/* Attribute is little-endian.  Since this driver is for 
+	 * ia32 and amd-64 only, conversion is not required */
+	memcpy((char *)hotkey_event_map + off, buffer, count);
+
+	mutex_unlock(&hotkey_mutex);
+
+	return count;
+}
+
+static struct bin_attribute bin_attr_hotkey_event_map = {
+	.attr = {
+		.name = "hotkey_event_map",
+		.mode = S_IWUSR | S_IRUGO,
+		.owner = THIS_MODULE,
+		},
+	.size = sizeof(hotkey_event_map),
+	.read = hotkey_event_map_read,
+	.write = hotkey_event_map_write,
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_mask_attributes[] = {
@@ -862,6 +940,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 					hotkey_dev_attributes,
 					&tpacpi_pdev->dev.kobj);
 
+		if (!res) {
+			res = sysfs_create_bin_file(
+				&tpacpi_pdev->dev.kobj,
+				&bin_attr_hotkey_event_map);
+		}
+
 		if (res)
 			return res;
 
@@ -885,6 +969,9 @@ static void hotkey_exit(void)
 	}
 
 	if (hotkey_dev_attributes) {
+		sysfs_remove_bin_file(&tpacpi_pdev->dev.kobj,
+				      &bin_attr_hotkey_event_map);
+
 		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
 		hotkey_dev_attributes = NULL;
 	}
@@ -900,18 +987,28 @@ static void tpacpi_input_send_key(unsigned int keycode)
 	}
 }
 
+static void hotkey_send_input_event(int hkey)
+{
+	unsigned int keycode;
+
+	if (hkey > 0x1000 && hkey < 0x1011) {
+		mutex_lock(&hotkey_mutex);
+		keycode = hotkey_event_map[(hkey - 1) & 0x0f];
+		mutex_unlock(&hotkey_mutex);
+
+		tpacpi_input_send_key(keycode);
+	} else {
+		printk(IBM_ERR "unknown hotkey 0x%04x\n", hkey);
+	}
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	int hkey;
 
 	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
 		acpi_bus_generate_event(ibm->acpi->device, event, hkey);
-		if (hkey > 0x1000 && hkey < 0x1011) {
-			tpacpi_input_send_key(
-					hotkey_event_map[(hkey - 1) & 0x0f]);
-		} else {
-			printk(IBM_ERR "unknown hotkey 0x%04x\n", hkey);
-		}
+		hotkey_send_input_event(hkey);
 	} else {
 		printk(IBM_ERR "unknown hotkey event %d\n", event);
 		acpi_bus_generate_event(ibm->acpi->device, event, 0);
-- 
1.5.1.6

