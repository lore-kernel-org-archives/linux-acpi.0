From: Qian Cai <cai@lca.pw>
Subject: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
Date: Mon, 24 Dec 2018 12:20:58 -0500
Message-ID: <20181224172058.56206-1-cai@lca.pw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-acpi@vger.kernel.org

rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
 { return NULL; }
 ^
drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
                                       ^~~~~~~~~~~~~~~~~~~~~
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fdd90ffceb85..5d29783ee5bd 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 #else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 { return NULL; }
 static inline int iort_add_device_replay(const struct iommu_ops *ops,
 					 struct device *dev)
-- 
2.17.2 (Apple Git-113)
