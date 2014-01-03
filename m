From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 04/10] IOMMU: iommu_unique_seq_id()
Date: Thu,  2 Jan 2014 16:08:11 -0800
Message-ID: <1388707697-16800-5-git-send-email-yinghai@kernel.org>
References: <1388707697-16800-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388707697-16800-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, x86 <x86@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Joerg Roedel <joro@8bytes.org>, Donald Dutile <ddutile@redhat.com>
List-Id: linux-acpi@vger.kernel.org

So for hot-remove/hot-add will reuse seq_id.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Donald Dutile <ddutile@redhat.com>
---
 drivers/iommu/dmar.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index a14867c..f5e0718 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -785,11 +785,22 @@ out:
 	return err;
 }
 
+static DECLARE_BITMAP(iommu_allocated, 1024);
+
+static int iommu_unique_seq_id(void)
+{
+	int id;
+
+	id = find_first_zero_bit(iommu_allocated, 1024);
+	__set_bit(id, iommu_allocated);
+
+	return id;
+}
+
 int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
 	u32 ver, sts;
-	static int iommu_allocated = 0;
 	int agaw = 0;
 	int msagaw = 0;
 	int err;
@@ -803,7 +814,7 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (!iommu)
 		return -ENOMEM;
 
-	iommu->seq_id = iommu_allocated++;
+	iommu->seq_id = iommu_unique_seq_id();
 	sprintf (iommu->name, "dmar%d", iommu->seq_id);
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
@@ -855,6 +866,7 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
  err_unmap:
 	unmap_iommu(iommu);
  error:
+	__clear_bit(iommu->seq_id, iommu_allocated);
 	kfree(iommu);
 	return err;
 }
@@ -869,6 +881,8 @@ void free_iommu(struct intel_iommu *iommu)
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
+	__clear_bit(iommu->seq_id, iommu_allocated);
+
 	kfree(iommu);
 }
 
-- 
1.8.4
