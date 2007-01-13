From: malattia@linux.it
Subject: [PATCH 2/11] Avoid dimness on resume.
Date: Sat, 13 Jan 2007 23:04:32 +0100
Message-ID: <11687258811866-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:52602 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXAMWGE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:04 -0500
In-Reply-To: <1168725881764-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

From: Andrew Morton <akpm@osdl.org>

Doesn't work.

Cc: Stelian Pop <stelian@popies.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |   49 +++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index e23522a..beb56b9 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -46,19 +46,6 @@ module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 			"the development of this driver");
 
-static int sony_acpi_add (struct acpi_device *device);
-static int sony_acpi_remove (struct acpi_device *device, int type);
-
-static struct acpi_driver sony_acpi_driver = {
-	.name	= ACPI_SNC_DRIVER_NAME,
-	.class	= ACPI_SNC_CLASS,
-	.ids	= ACPI_SNC_HID,
-	.ops	= {
-			.add	= sony_acpi_add,
-			.remove	= sony_acpi_remove,
-		  },
-};
-
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
 
@@ -69,6 +56,8 @@ static struct sony_acpi_value {
 	char			*acpiset;/* name of the ACPI get function */
 	int 			min;	 /* minimum allowed value or -1 */
 	int			max;	 /* maximum allowed value or -1 */
+	int			value;	 /* current setting */
+	int			valid;	 /* Has ever been set */
 	int			debug;	 /* active only in debug mode ? */
 } sony_acpi_values[] = {
 	{
@@ -239,10 +228,30 @@ static int sony_acpi_write(struct file *file, const char __user *buffer,
 
 	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
 		return -EIO;
-
+	item->value = value;
+	item->valid = 1;
 	return count;
 }
 
+static int sony_acpi_resume(struct acpi_device *device, int state)
+{
+	struct sony_acpi_value *item;
+
+	for (item = sony_acpi_values; item->name; item++) {
+		int ret;
+
+		if (!item->valid)
+			continue;
+		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
+					item->value, NULL);
+		if (ret < 0) {
+			printk("%s: %d\n", __FUNCTION__, ret);
+			break;
+		}
+	}
+	return 0;
+}
+
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	printk(LOG_PFX "sony_acpi_notify\n");
@@ -344,7 +353,6 @@ outwalk:
 	return result;
 }
 
-
 static int sony_acpi_remove(struct acpi_device *device, int type)
 {
 	acpi_status status;
@@ -367,6 +375,17 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static struct acpi_driver sony_acpi_driver = {
+	.name	= ACPI_SNC_DRIVER_NAME,
+	.class	= ACPI_SNC_CLASS,
+	.ids	= ACPI_SNC_HID,
+	.ops	= {
+			.add	= sony_acpi_add,
+			.remove	= sony_acpi_remove,
+			.resume = sony_acpi_resume,
+		  },
+};
+
 static int __init sony_acpi_init(void)
 {
 	int result;
-- 
1.4.4.2

