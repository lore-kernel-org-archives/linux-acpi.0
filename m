From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH] dax: use devm_add_action_or_reset()
Date: Tue,  5 Jul 2016 11:20:07 +0530
Message-ID: <1467697807-27067-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:52530 "EHLO
	g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcGEFz5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2016 01:55:57 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 8D6142995
	for <linux-acpi@vger.kernel.org>; Tue,  5 Jul 2016 05:55:56 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, jthumshirn@suse.de
Cc: ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linda.knippers@hpe.com, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

If devm_add_action() fails, we are explicitly calling the cleanup to free
the resources allocated. Use the helper devm_add_action_or_reset()
and return directly in case of error, since the cleanup function
has been already called by the helper if there was any error.

Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
---
 drivers/dax/dax.c  |  6 ++----
 drivers/dax/pmem.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/dax/dax.c b/drivers/dax/dax.c
index b891a12..803f395 100644
--- a/drivers/dax/dax.c
+++ b/drivers/dax/dax.c
@@ -211,11 +211,9 @@ int devm_create_dax_dev(struct dax_region *dax_region, struct resource *res,
 	}
 	dax_dev->dev = dev;
 
-	rc = devm_add_action(dax_region->dev, unregister_dax_dev, dev);
-	if (rc) {
-		unregister_dax_dev(dev);
+	rc = devm_add_action_or_reset(dax_region->dev, unregister_dax_dev, dev);
+	if (rc)
 		return rc;
-	}
 
 	return 0;
 
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index 55d510e..dfb1685 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -102,21 +102,19 @@ static int dax_pmem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = devm_add_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
-	if (rc) {
-		dax_pmem_percpu_exit(&dax_pmem->ref);
+	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
+							&dax_pmem->ref);
+	if (rc)
 		return rc;
-	}
 
 	addr = devm_memremap_pages(dev, &res, &dax_pmem->ref, altmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
-	rc = devm_add_action(dev, dax_pmem_percpu_kill, &dax_pmem->ref);
-	if (rc) {
-		dax_pmem_percpu_kill(&dax_pmem->ref);
+	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
+							&dax_pmem->ref);
+	if (rc)
 		return rc;
-	}
 
 	nd_region = to_nd_region(dev->parent);
 	dax_region = alloc_dax_region(dev, nd_region->id, &res,
-- 
1.9.1

