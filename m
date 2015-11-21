From: Linda Knippers <linda.knippers@hpe.com>
Subject: [PATCH 2/3] nfit: Fix the check for a successful NFIT merge
Date: Fri, 20 Nov 2015 19:05:48 -0500
Message-ID: <14dca14555121bafe98db66e897681d17b8dedc6.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6223.austin.hp.com ([15.73.96.124]:35433 "EHLO
	g1t6223.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759822AbbKUAGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2015 19:06:23 -0500
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, toshi.kani@hpe.com, elliott@hpe.com, rafael.j.wysocki@intel.com

Signed-off-by: Linda Knippers <linda.knippers@hpe.com>
---
 drivers/acpi/nfit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 710092a..c140194d 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1834,7 +1834,7 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 	nfit_saved = acpi_desc->nfit;
 	acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
 	ret = acpi_nfit_init(acpi_desc, buf.length);
-	if (!ret) {
+	if (ret) {
 		/* Merge failed, restore old nfit, and exit */
 		acpi_desc->nfit = nfit_saved;
 		dev_err(dev, "failed to merge updated NFIT\n");
-- 
1.8.3.1

