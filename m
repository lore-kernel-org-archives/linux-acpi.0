From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/14] dell-wmi: sys_init_module: 'dell_wmi'->init suspiciously
 returned 21, it should follow 0/-E convention
Date: Wed, 30 Dec 2009 02:36:24 -0500
Message-ID: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57065 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZL3Hgm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:42 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVG00JNRFT3OAJ4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:42 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
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

