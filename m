From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH 7/7] x86: print out irq nr for msi/ht
Date: Wed, 24 Sep 2008 19:04:37 -0700
Message-ID: <1222308277-10984-7-git-send-email-yhlu.kernel@gmail.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
---
 arch/x86/kernel/hpet.c    |    3 +++
 arch/x86/kernel/io_apic.c |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 422c577..686505a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -467,6 +467,9 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 	irq_set_affinity(dev->irq, cpumask_of_cpu(dev->cpu));
 	enable_irq(dev->irq);
 
+	printk(KERN_DEBUG "hpet: %s is using irq %#x aka %d for MSI\n",
+			 dev->name, irq, irq);
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/io_apic.c b/arch/x86/kernel/io_apic.c
index 4cc9cb6..dc82397 100644
--- a/arch/x86/kernel/io_apic.c
+++ b/arch/x86/kernel/io_apic.c
@@ -3355,6 +3355,9 @@ static int setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc, int irq)
 #endif
 		set_irq_chip_and_handler_name(irq, &msi_chip, handle_edge_irq, "edge");
 
+	printk(KERN_DEBUG "PCI: %s is using irq %#x aka %d for MSI/MSI-X\n",
+			 pci_name(dev), irq, irq);
+
 	return 0;
 }
 
@@ -3587,6 +3590,7 @@ int arch_setup_hpet_msi(unsigned int irq)
 	hpet_msi_write(irq, &msg);
 	set_irq_chip_and_handler_name(irq, &hpet_msi_type, handle_edge_irq,
 		"edge");
+
 	return 0;
 }
 #endif
@@ -3683,6 +3687,9 @@ int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)
 
 		set_irq_chip_and_handler_name(irq, &ht_irq_chip,
 					      handle_edge_irq, "edge");
+
+		printk(KERN_DEBUG "PCI: %s is using irq %#x aka %d for HT\n",
+				 pci_name(dev), irq, irq);
 	}
 	return err;
 }
-- 
1.5.6
