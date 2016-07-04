From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH] nfit: use devm_add_action_or_reset()
Date: Mon,  4 Jul 2016 10:02:51 +0530
Message-ID: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:46599 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcGDEih (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 00:38:37 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 2190661A83
	for <linux-acpi@vger.kernel.org>; Mon,  4 Jul 2016 04:38:36 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linda.knippers@hpe.com, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

If devm_add_action() fails, we are explicitly calling the cleanup to free
the resources allocated. Lets use the helper devm_add_action_or_reset()
and return directly in case of error, since the cleanup function
has been already called by the helper if there was any error.

Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
---
 drivers/acpi/nfit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index c2ad967..44ebe1e 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1920,11 +1920,11 @@ static int acpi_nfit_insert_resource(struct acpi_nfit_desc *acpi_desc,
 	if (ret)
 		return ret;
 
-	ret = devm_add_action(acpi_desc->dev, acpi_nfit_remove_resource, res);
-	if (ret) {
-		remove_resource(res);
+	ret = devm_add_action_or_reset(acpi_desc->dev,
+					acpi_nfit_remove_resource,
+					res);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
1.9.1

