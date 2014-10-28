From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part2 v3 05/24] x86, hpet: Use new irqdomain interfaces to allocate/free IRQ
Date: Tue, 28 Oct 2014 16:26:23 +0800
Message-ID: <1414484803-10311-6-git-send-email-jiang.liu@linux.intel.com>
References: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, x86@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Jiang Liu <jiang.liu@linux.intel.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Use new irqdomain interfaces to allocate/free IRQ for HPET, so we could
kill GENERIC_IRQ_LEGACY_ALLOC_HWIRQ later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/hpet.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 319bcb9372fe..24db2d33fab7 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -11,6 +11,7 @@
 #include <linux/cpu.h>
 #include <linux/pm.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <asm/fixmap.h>
 #include <asm/hpet.h>
@@ -476,7 +477,7 @@ static int hpet_msi_next_event(unsigned long delta,
 static int hpet_setup_msi_irq(unsigned int irq)
 {
 	if (x86_msi.setup_hpet_msi(irq, hpet_blockid)) {
-		irq_free_hwirq(irq);
+		irq_domain_free_irqs(irq, 1);
 		return -EINVAL;
 	}
 	return 0;
@@ -484,9 +485,10 @@ static int hpet_setup_msi_irq(unsigned int irq)
 
 static int hpet_assign_irq(struct hpet_dev *dev)
 {
-	unsigned int irq = irq_alloc_hwirq(-1);
+	int irq;
 
-	if (!irq)
+	irq = irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, NULL);
+	if (irq <= 0)
 		return -EINVAL;
 
 	irq_set_handler_data(irq, dev);
-- 
1.7.10.4
