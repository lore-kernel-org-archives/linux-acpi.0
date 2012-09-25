From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI: free memory on an error path
Date: Tue, 25 Sep 2012 10:01:03 +0300
Message-ID: <20120925070103.GA23009@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:39943 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2IYHBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2012 03:01:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

We should free "physical_node" if before returning the error code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.  Introduced in 1033f9041d5 "ACPI: Allow ACPI
binding with USB-3.0 hub".

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index d1a2d74..cfeecac 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -159,7 +159,7 @@ static int acpi_bind_one(struct device *dev, acpi_handle handle)
 	if (physical_node->node_id >= ACPI_MAX_PHYSICAL_NODE) {
 		retval = -ENOSPC;
 		mutex_unlock(&acpi_dev->physical_node_lock);
-		goto err;
+		goto free_node;
 	}
 
 	set_bit(physical_node->node_id, acpi_dev->physical_node_id_bitmap);
@@ -185,6 +185,8 @@ static int acpi_bind_one(struct device *dev, acpi_handle handle)
 
 	return 0;
 
+free_node:
+	kfree(physical_node);
  err:
 	put_device(dev);
 	return retval;
