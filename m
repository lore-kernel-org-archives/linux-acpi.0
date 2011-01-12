From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/48] ACPI / PM: Rename acpi_power_off_device()
Date: Wed, 12 Jan 2011 05:19:38 -0500
Message-ID: <36237fa0a711c309a38d7a7a9aed727e0eb76449.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1ALRAb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:31 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:25 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Rename acpi_power_off_device() to acpi_power_off() in analogy with
acpi_power_on().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 0003f10..ac02af4 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -219,7 +219,7 @@ static int acpi_power_on(acpi_handle handle)
 	return result;
 }
 
-static int acpi_power_off_device(acpi_handle handle)
+static int acpi_power_off(acpi_handle handle)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -268,7 +268,7 @@ static void __acpi_power_off_list(struct acpi_handle_list *list, int num_res)
 	int i;
 
 	for (i = num_res - 1; i >= 0 ; i--)
-		acpi_power_off_device(list->handles[i]);
+		acpi_power_off(list->handles[i]);
 }
 
 static void acpi_power_off_list(struct acpi_handle_list *list)
@@ -430,8 +430,7 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev)
 
 	/* Close power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
-		int ret = acpi_power_off_device(
-				dev->wakeup.resources.handles[i]);
+		int ret = acpi_power_off(dev->wakeup.resources.handles[i]);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
-- 
1.7.4.rc1.7.g2cf08

