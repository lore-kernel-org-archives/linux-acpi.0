From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH 5/7] x86: fix typo in irq_desc array
Date: Wed, 24 Sep 2008 19:04:35 -0700
Message-ID: <1222308277-10984-5-git-send-email-yhlu.kernel@gmail.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

when SPARSE_IRQ is not used, should still use irq_desc->lock

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
---
 kernel/irq/handle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 7f625fb..fb6bdb6 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -253,7 +253,7 @@ struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
 		.chip = &no_irq_chip,
 		.handle_irq = handle_bad_irq,
 		.depth = 1,
-		.lock = __SPIN_LOCK_UNLOCKED(sparse_irqs->lock),
+		.lock = __SPIN_LOCK_UNLOCKED(irq_desc->lock),
 #ifdef CONFIG_SMP
 		.affinity = CPU_MASK_ALL
 #endif
-- 
1.5.6
