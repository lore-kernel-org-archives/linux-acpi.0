From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Date: Mon,  7 Jan 2019 16:42:07 +0000
Message-ID: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

From: Qian Cai <cai@lca.pw>

Commit 8097e53eaba2 ("ACPI/IORT: Use helper functions to access
dev->iommu_fwspec") changed by mistake the iort_fwspec_iommu_ops() stub
definition (compiled in when CONFIG_IOMMU_API=n), that caused the
following compilation failure:

drivers/acpi/arm64/iort.c:880:1: error: expected identifier or
'(' before '{' token
 { return NULL; }
 ^
drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops'
used but never defined
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
                                       ^~~~~~~~~~~~~~~~~~~~~

Fix it.

Fixes: 8097e53eaba2 ("ACPI/IORT: Use helper functions to access dev->iommu_fwspec")
Signed-off-by: Qian Cai <cai@lca.pw>
[lorenzo.pieralisi@arm.com: updated tags and log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
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
2.19.2
