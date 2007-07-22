From: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/77] ACPI: battery: make internal names consistent with battery "state"
Date: Sun, 22 Jul 2007 05:13:46 -0400
Message-ID: <11850957033938-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47794 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761013AbXGVJPE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:04 -0400
In-Reply-To: <11850957022956-git-send-email-len.brown@intel.com>
Message-Id: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

Cleanup -- No functional changes.

Battery state is currently exported in a proc "state" file.
Update associated #defines and routines to be consistent.

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e64c76c..df04f87 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -44,7 +44,7 @@
 #define ACPI_BATTERY_HID		"PNP0C0A"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_FILE_INFO		"info"
-#define ACPI_BATTERY_FILE_STATUS	"state"
+#define ACPI_BATTERY_FILE_STATE		"state"
 #define ACPI_BATTERY_FILE_ALARM		"alarm"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
@@ -76,7 +76,7 @@ static struct acpi_driver acpi_battery_driver = {
 		},
 };
 
-struct acpi_battery_status {
+struct acpi_battery_state {
 	acpi_integer state;
 	acpi_integer present_rate;
 	acpi_integer remaining_capacity;
@@ -183,8 +183,8 @@ acpi_battery_get_info(struct acpi_battery *battery,
 }
 
 static int
-acpi_battery_get_status(struct acpi_battery *battery,
-			struct acpi_battery_status **bst)
+acpi_battery_get_state(struct acpi_battery *battery,
+			struct acpi_battery_state **bst)
 {
 	int result = 0;
 	acpi_status status = 0;
@@ -425,7 +425,7 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 {
 	int result = 0;
 	struct acpi_battery *battery = seq->private;
-	struct acpi_battery_status *bst = NULL;
+	struct acpi_battery_state *bst = NULL;
 	char *units = "?";
 
 
@@ -449,9 +449,9 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 
 	/* Battery Status (_BST) */
 
-	result = acpi_battery_get_status(battery, &bst);
+	result = acpi_battery_get_state(battery, &bst);
 	if (result || !bst) {
-		seq_printf(seq, "ERROR: Unable to read battery status\n");
+		seq_printf(seq, "ERROR: Unable to read battery state\n");
 		goto end;
 	}
 
@@ -621,7 +621,7 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 	}
 
 	/* 'status' [R] */
-	entry = create_proc_entry(ACPI_BATTERY_FILE_STATUS,
+	entry = create_proc_entry(ACPI_BATTERY_FILE_STATE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
 		return -ENODEV;
@@ -652,7 +652,7 @@ static int acpi_battery_remove_fs(struct acpi_device *device)
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
 				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BATTERY_FILE_STATUS,
+		remove_proc_entry(ACPI_BATTERY_FILE_STATE,
 				  acpi_device_dir(device));
 		remove_proc_entry(ACPI_BATTERY_FILE_INFO,
 				  acpi_device_dir(device));
-- 
1.5.3.rc2.22.g69a9b
