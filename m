From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/34] tc1100-wmi - switch to using dev_pm_ops
Date: Thu, 24 Dec 2009 01:23:34 -0500
Message-ID: <8e698a3c47887fe5aa5e2252c27bb6ff416a07e4.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:52417 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbZLXGY0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:26 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV500MZM8GATMF7@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:11 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Also guard PM operations with CONFIG_PM.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/tc1100-wmi.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/tc1100-wmi.c
index fa2995b..dd33b51 100644
--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -194,7 +194,8 @@ static int __devexit tc1100_remove(struct platform_device *device)
 	return 0;
 }
 
-static int tc1100_suspend(struct platform_device *dev, pm_message_t state)
+#ifdef CONFIG_PM
+static int tc1100_suspend(struct device *dev)
 {
 	int ret;
 
@@ -206,10 +207,10 @@ static int tc1100_suspend(struct platform_device *dev, pm_message_t state)
 	if (ret)
 		return ret;
 
-	return ret;
+	return 0;
 }
 
-static int tc1100_resume(struct platform_device *dev)
+static int tc1100_resume(struct device *dev)
 {
 	int ret;
 
@@ -221,17 +222,26 @@ static int tc1100_resume(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	return ret;
+	return 0;
 }
 
+static const struct dev_pm_ops tc1100_pm_ops = {
+	.suspend	= tc1100_suspend,
+	.resume		= tc1100_resume,
+	.freeze		= tc1100_suspend,
+	.restore	= tc1100_resume,
+};
+#endif
+
 static struct platform_driver tc1100_driver = {
 	.driver = {
 		.name = "tc1100-wmi",
 		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &tc1100_pm_ops,
+#endif
 	},
 	.remove = __devexit_p(tc1100_remove),
-	.suspend = tc1100_suspend,
-	.resume = tc1100_resume,
 };
 
 static int __init tc1100_init(void)
-- 
1.6.0.6

