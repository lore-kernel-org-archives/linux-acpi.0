From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/11] thinkpad_acpi: static
Date: Thu, 14 Feb 2008 02:02:26 -0500
Message-ID: <1d5a2b54f39cab8ab8bee5290798ea6516c4a68c.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3160 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755933AbYBNHKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:44 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7ba1aca..e2c7edd 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1689,7 +1689,7 @@ static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_wakeup_reason =
 	__ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
 
-void hotkey_wakeup_reason_notify_change(void)
+static void hotkey_wakeup_reason_notify_change(void)
 {
 	if (tp_features.hotkey_mask)
 		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
@@ -1708,7 +1708,7 @@ static struct device_attribute dev_attr_hotkey_wakeup_hotunplug_complete =
 	__ATTR(wakeup_hotunplug_complete, S_IRUGO,
 	       hotkey_wakeup_hotunplug_complete_show, NULL);
 
-void hotkey_wakeup_hotunplug_complete_notify_change(void)
+static void hotkey_wakeup_hotunplug_complete_notify_change(void)
 {
 	if (tp_features.hotkey_mask)
 		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
-- 
1.5.4.1.122.gaa8d

