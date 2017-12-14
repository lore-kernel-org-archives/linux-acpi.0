From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/3] ACPI: Add GPE number in wakeup device list
Date: Thu, 14 Dec 2017 14:38:42 +0800
Message-ID: <845bbddc6aa4226c51c2cec61c2f451368ad7422.1513233415.git.lv.zheng@intel.com>
References: <cover.1513233415.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:61938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbdLNGip (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 01:38:45 -0500
In-Reply-To: <cover.1513233415.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch adds GPE wakeup number in /proc/acpi/wakeup.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 652f19e..32fdec4 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -24,7 +24,7 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
 	struct list_head *node, *next;
 
-	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
+	seq_printf(seq, "Device\tS-state\tGPE\t  Status   Sysfs node\n");
 
 	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
@@ -35,9 +35,10 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 		if (!dev->wakeup.flags.valid)
 			continue;
 
-		seq_printf(seq, "%s\t  S%d\t",
+		seq_printf(seq, "%s\t  S%d\t%02x\t",
 			   dev->pnp.bus_id,
-			   (u32) dev->wakeup.sleep_state);
+			   (u32) dev->wakeup.sleep_state,
+			   (u8) dev->wakeup.gpe_number);
 
 		mutex_lock(&dev->physical_node_lock);
 
-- 
2.7.4

