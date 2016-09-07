From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI / CPPC: fix error return code in acpi_cppc_processor_probe()
Date: Wed,  7 Sep 2016 15:39:51 +0000
Message-ID: <1473262791-10341-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36175 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757444AbcIGPj6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2016 11:39:58 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so1064424pab.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Sep 2016 08:39:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -ENODEV from the get_cpu_device() error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ed58883..480a7e1 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -766,8 +766,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Add per logical CPU nodes for reading its feedback counters. */
 	cpu_dev = get_cpu_device(pr->id);
-	if (!cpu_dev)
+	if (!cpu_dev) {
+		ret = -ENODEV;
 		goto out_free;
+	}
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");

