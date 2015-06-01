From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v3 20/36] metag, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:29 +0800
Message-ID: <1433145945-789-21-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32412 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065AbbFAIGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Jun 2015 04:06:49 -0400
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, James Hogan <james.hogan@imgtec.com>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-metag@vger.kernel.org

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/metag/kernel/irq.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/metag/kernel/irq.c b/arch/metag/kernel/irq.c
index 4f8f1f87ef11..a336094a7a6c 100644
--- a/arch/metag/kernel/irq.c
+++ b/arch/metag/kernel/irq.c
@@ -270,23 +270,25 @@ void migrate_irqs(void)
 
 	for_each_active_irq(i) {
 		struct irq_data *data = irq_get_irq_data(i);
+		struct cpumask *mask;
 		unsigned int newcpu;
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		mask = irq_data_get_affinity_mask(data);
+		if (!cpumask_test_cpu(cpu, mask))
 			continue;
 
-		newcpu = cpumask_any_and(data->affinity, cpu_online_mask);
+		newcpu = cpumask_any_and(mask, cpu_online_mask);
 
 		if (newcpu >= nr_cpu_ids) {
 			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 					    i, cpu);
 
-			cpumask_setall(data->affinity);
+			cpumask_setall(mask);
 		}
-		irq_set_affinity(i, data->affinity);
+		irq_set_affinity(i, mask);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
1.7.10.4

