From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH 6/7] x86: irq no should not use hex in /proc/interrupts
Date: Wed, 24 Sep 2008 19:04:36 -0700
Message-ID: <1222308277-10984-6-git-send-email-yhlu.kernel@gmail.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
---
 arch/x86/kernel/irq_32.c |    2 +-
 arch/x86/kernel/irq_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index b2e1082..001772f 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -307,7 +307,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		action = desc->action;
 		if (!action && !any_count)
 			goto skip;
-		seq_printf(p, "%#x: ",i);
+		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index c2fca89..ec26610 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -112,7 +112,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		action = desc->action;
 		if (!action && !any_count)
 			goto skip;
-		seq_printf(p, "%#x: ",i);
+		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-- 
1.5.6
