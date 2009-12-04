From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] tc1100-wmi - switch to using dev_pm_ops
Date: Fri, 04 Dec 2009 00:36:20 -0800
Message-ID: <20091204083620.22509.60571.stgit@localhost.localdomain>
References: <20091204083422.22509.74768.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:39430 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbZLDIgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 03:36:15 -0500
Received: by mail-yw0-f182.google.com with SMTP id 12so2356843ywh.21
        for <linux-acpi@vger.kernel.org>; Fri, 04 Dec 2009 00:36:22 -0800 (PST)
In-Reply-To: <20091204083422.22509.74768.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

Also guard PM operations with CONFIG_PM.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
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

