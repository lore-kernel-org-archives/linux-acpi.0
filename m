From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] ACPI processor: fix theoretical memleak
Date: Wed, 16 Sep 2009 09:40:33 +0100
Message-ID: <4AB0A481.40306@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40216 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbZIPIkf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2009 04:40:35 -0400
Received: by ewy2 with SMTP id 2so1206396ewy.17
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2009 01:40:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/acpi/processor_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 38ad5ef..0eb4a94 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -781,8 +781,8 @@ static int acpi_processor_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	if (!zalloc_cpumask_var(&pr->throttling.shared_cpu_map, GFP_KERNEL)) {
-		kfree(pr);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_free_pr;
 	}
 
 	pr->handle = device->handle;
@@ -882,6 +882,8 @@ err_remove_fs:
 	acpi_processor_remove_fs(device);
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
+err_free_pr:
+	kfree(pr);
 
 	return result;
 }
-- 
1.6.3.2



