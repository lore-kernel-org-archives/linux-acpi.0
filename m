From: Josh Taylor <joshua.taylor0@gmail.com>
Subject: [PATCH 3/3] Drivers: acpi: Updated strict_strtoul command.
Date: Fri, 28 Sep 2012 17:21:26 -0400
Message-ID: <1348867286-25218-1-git-send-email-joshua.taylor0@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48944 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031516Ab2I1VVt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2012 17:21:49 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so258322qad.19
        for <linux-acpi@vger.kernel.org>; Fri, 28 Sep 2012 14:21:49 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Josh Taylor <joshua.taylor0@gmail.com>

Fixed pr_warn issue.

Signed-off-by: Josh Taylor <joshua.taylor0@gmail.com>
---
 drivers/acpi/acpi_pad.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index af4aad6..16fa979 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -286,7 +286,7 @@ static ssize_t acpi_pad_rrtime_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
-	if (strict_strtoul(buf, 0, &num))
+	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
 		return -EINVAL;
@@ -309,7 +309,7 @@ static ssize_t acpi_pad_idlepct_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
-	if (strict_strtoul(buf, 0, &num))
+	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
 		return -EINVAL;
@@ -332,7 +332,7 @@ static ssize_t acpi_pad_idlecpus_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
-	if (strict_strtoul(buf, 0, &num))
+	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(num);
@@ -457,7 +457,7 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 			dev_name(&device->dev), event, 0);
 		break;
 	default:
-		printk(KERN_WARNING "Unsupported event [0x%x]\n", event);
+		pr_warn("Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
1.7.9.5

