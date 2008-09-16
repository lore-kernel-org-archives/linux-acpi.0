From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH ?] ACPI: pr->id is unsigned
Date: Mon, 15 Sep 2008 21:32:20 -0400
Message-ID: <48CF0CA4.3090701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:4558 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYIOTc1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2008 15:32:27 -0400
Received: by ik-out-1112.google.com with SMTP id c30so2052696ika.5
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2008 12:32:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

since pr->id is unsigned, shouldn't something like
the patch below be applied?

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e36422a..75c0f76 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -667,7 +667,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 		return 0;
 	}
 
-	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
+	BUG_ON((pr->id >= nr_cpu_ids) || ((unsigned long)pr->id < 0));
 
 	/*
 	 * Buggy BIOS check
