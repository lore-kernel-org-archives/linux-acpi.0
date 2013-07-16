From: shuox.liu@intel.com
Subject: [PATCH] pnp: avoid inaccurate resource name
Date: Tue, 16 Jul 2013 16:23:44 +0800
Message-ID: <1373963024-5237-1-git-send-email-shuox.liu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com, rjw@sisk.pl, lenb@kernel.org, yanmin_zhang@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

From: Liu ShuoX <shuox.liu@intel.com>

Set temporary variable as 0 to avoid garbage string output from
/proc/iomem after register resources, and reset to pnp dev name.

Signed-off-by: Liu ShuoX <shuox.liu@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c | 2 +-
 drivers/pnp/resource.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 9847ab1..167f3d0 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -180,7 +180,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	struct pnp_dev *dev = data;
 	struct acpi_resource_dma *dma;
 	struct acpi_resource_vendor_typed *vendor_typed;
-	struct resource r;
+	struct resource r = {0};
 	int i, flags;
 
 	if (acpi_dev_resource_memory(res, &r)
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 3e6db1c..d95e101 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -515,6 +515,7 @@ struct pnp_resource *pnp_add_resource(struct pnp_dev *dev,
 	}
 
 	pnp_res->res = *res;
+	pnp_res->res.name = dev->name;
 	dev_dbg(&dev->dev, "%pR\n", res);
 	return pnp_res;
 }
-- 
1.8.3
