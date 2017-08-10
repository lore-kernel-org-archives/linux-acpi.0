From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ACPI/IORT: fix build regression without IOMMU
Date: Thu, 10 Aug 2017 14:11:00 +0200
Message-ID: <20170810121114.2509560-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <jroedel@suse.de>, Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

A recent change reintroduced a bug that had previously been
fixed by commit d49f2dedf33b ("ACPI/IORT: Fix CONFIG_IOMMU_API
dependency"):

drivers/acpi/arm64/iort.c: In function 'iort_iommu_configure':
drivers/acpi/arm64/iort.c:829:26: error: 'struct iommu_fwspec' has no member named 'ops'

This does the same change again, replacing another direct
reference to iommu_fwspec->ops with a helper function call.

Fixes: bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for IOMMUs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9cdd49289786..9565d572f8dd 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -826,7 +826,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * add_device callback for dev, replay it to get things in order.
 	 */
 	if (!err) {
-		ops = dev->iommu_fwspec->ops;
+		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
 		err = iort_add_device_replay(ops, dev);
 	}
 
-- 
2.9.0
