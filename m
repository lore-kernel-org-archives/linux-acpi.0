From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] dell-wmi: sys_init_module: 'dell_wmi'->init suspiciously
 returned 21, it should follow 0/-E convention
Date: Sat, 26 Dec 2009 23:15:36 -0500
Message-ID: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1261887124.git.len.brown@intel.com>
References: <1261887338-29981-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:39689 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZL0EQJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 23:16:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVA00FODMITM4V6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 26 Dec 2009 22:16:06 -0600 (CST)
In-reply-to: <1261887338-29981-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg@redhat.com, carlos@strangeworlds.co.uk, anisse@astier.eu, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

wmi_install_notify_handler() returns an acpi_error,
but dell_wmi_init() needs return a -errno style error.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-wmi.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 916ccb2..4c7e702 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -323,6 +323,7 @@ static int __init dell_wmi_input_setup(void)
 static int __init dell_wmi_init(void)
 {
 	int err;
+	acpi_status status;
 
 	if (wmi_has_guid(DELL_EVENT_GUID)) {
 		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
@@ -336,14 +337,14 @@ static int __init dell_wmi_init(void)
 	if (err)
 		return err;
 
-	err = wmi_install_notify_handler(DELL_EVENT_GUID,
+	status = wmi_install_notify_handler(DELL_EVENT_GUID,
 					 dell_wmi_notify, NULL);
-	if (err) {
+	if (ACPI_FAILURE(status)) {
 		input_unregister_device(dell_wmi_input_dev);
 		printk(KERN_ERR
 			"dell-wmi: Unable to register notify handler - %d\n",
-			err);
-		return err;
+			status);
+		return -ENODEV;
 	}
 
 	return 0;
-- 
1.6.0.6

