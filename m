From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 1/7] irqchip/alpine-msi: Call IOMMU DMA mapping MSI message hook
Date: Sun, 31 Mar 2019 15:34:09 +0300
Message-ID: <1554035655-11352-2-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add missing IOMMU DMA mapping MSI message hook in compose_msi_msg()
callback for Alpine MSIx driver, to map the MSI physical address to
IOMMU IOVA for any device attached to IOMMU DMA ops domains.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
---
 drivers/irqchip/irq-alpine-msi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 23a3b87..ae2fca7 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-iommu.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/msi.h>
@@ -99,6 +100,12 @@ static void alpine_msix_compose_msi_msg(struct irq_data *data,
 	msg->address_hi = upper_32_bits(msg_addr);
 	msg->address_lo = lower_32_bits(msg_addr);
 	msg->data = 0;
+
+	/*
+	 * Mapping MSI address to IOMMU IOVA, relevant for devices associated
+	 * with IOMMU DMA ops domain.
+	 */
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static struct msi_domain_info alpine_msix_domain_info = {
-- 
2.7.4
