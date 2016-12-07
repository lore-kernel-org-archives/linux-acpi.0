From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH V1] acpi : nfit : core :- No need of devm functions
Date: Wed,  7 Dec 2016 21:12:36 +0530
Message-ID: <1481125356-7806-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34403 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbcLGP6A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2016 10:58:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, joeyli.kernel@gmail.com, toshi.kani@hpe.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

In function acpi_nfit_init_interleave_set, the memory allocated
for 'info' is live within the function only. After the allocation
it is immediately freed with devm_kfree. There is no need to
allocate memory for 'info' with devm function so replace
devm_kzalloc with kzalloc and devm_kfree with kfree.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/nfit/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 71a7d07..bd7e4e7 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1631,7 +1631,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	if (!nd_set)
 		return -ENOMEM;
 
-	info = devm_kzalloc(dev, sizeof_nfit_set_info(nr), GFP_KERNEL);
+	info = kzalloc(sizeof_nfit_set_info(nr), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
@@ -1644,6 +1644,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 		if (!memdev || !nfit_mem->dcr) {
 			dev_err(dev, "%s: failed to find DCR\n", __func__);
+			kfree(info);
 			return -ENODEV;
 		}
 
@@ -1655,7 +1656,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 			cmp_map, NULL);
 	nd_set->cookie = nd_fletcher64(info, sizeof_nfit_set_info(nr), 0);
 	ndr_desc->nd_set = nd_set;
-	devm_kfree(dev, info);
+	kfree(info);
 
 	return 0;
 }
-- 
2.7.4

