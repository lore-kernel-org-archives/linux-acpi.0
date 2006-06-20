From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/25] ia64 irq:  Dynamic irq support
Date: Tue, 20 Jun 2006 16:28:23 -0600
Message-ID: <11508425213795-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com>
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751371AbWFTW3X@vger.kernel.org>
In-Reply-To: <115084252131-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>Roland Dreier <rd>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/kernel/irq_ia64.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index f503530..b0189c7 100644
--- a/arch/ia64/kernel/irq_ia64.c
+++ b/arch/ia64/kernel/irq_ia64.c
@@ -31,6 +31,7 @@ #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/threads.h>
 #include <linux/bitops.h>
+#include <linux/irq.h>
 
 #include <asm/delay.h>
 #include <asm/intrinsics.h>
@@ -106,6 +107,28 @@ reserve_irq_vector (int vector)
 	return test_and_set_bit(pos, ia64_vector_mask);
 }
 
+/*
+ * Dynamic irq allocate and deallocation for MSI
+ */
+int create_irq(void)
+{
+	int vector;
+	unsigned long flags;
+
+	vector = assign_irq_vector(AUTO_ASSIGN);
+
+	if (vector >= 0)
+		dynamic_irq_init(irq);
+
+	return vector;
+}
+
+void destroy_irq(unsigned int irq)
+{
+	dynamic_irq_cleanup(irq);
+	free_irq_vector(irq);
+}
+
 #ifdef CONFIG_SMP
 #	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
 #else
-- 
1.4.0.gc07e
