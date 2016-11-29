From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] ACPI / APEI: Fix NMI notification handling
Date: Tue, 29 Nov 2016 13:43:59 -0500
Message-ID: <1480445039-3434-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933703AbcK2SoG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 13:44:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, linux-acpi@vger.kernel.org

When removing and adding cpu 0 on a system with GHES NMI the following stack
trace is seen when re-adding the cpu:

WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1349 setup_local_APIC+
Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 nfs fscache coretemp intel_ra
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.0-rc5+ #59
Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.01.00.0
ffffffff81c03e78 ffffffff81337905 0000000000000000 0000000000000000
ffffffff81c03eb8 ffffffff8107d9c1 00000545810aac4a 0000000000000000
00000000000000f0 0000000000000000 000081cb6440f1d0 0000000000000001
Call Trace:
[<ffffffff81337905>] dump_stack+0x63/0x8e
[<ffffffff8107d9c1>] __warn+0xd1/0xf0
[<ffffffff8107daad>] warn_slowpath_null+0x1d/0x20
[<ffffffff810522b5>] setup_local_APIC+0x275/0x370
[<ffffffff810523be>] apic_ap_setup+0xe/0x20
[<ffffffff8104f5a8>] start_secondary+0x48/0x180
[<ffffffff81d89aa0>] ? set_init_arg+0x55/0x55
[<ffffffff81d89120>] ? early_idt_handler_array+0x120/0x120
[<ffffffff81d895d6>] ? x86_64_start_reservations+0x2a/0x2c
[<ffffffff81d89715>] ? x86_64_start_kernel+0x13d/0x14c
---[ end trace 7b6555b6343ef9ee ]---

During the cpu bringup, wakeup_cpu_via_init_nmi() is called and issues an
NMI on CPU 0.  The GHES NMI handler, ghes_notify_nmi() runs the
ghes_proc_irq_work work queue which ends up setting IRQ_WORK_VECTOR
(0xf6).  The "faulty" IR line set at arch/x86/kernel/apic/apic.c:1349 is  also
0xf6 (specifically APIC IRR for irqs 255 to 224 is 0x400000) which confirms
that something has set the IRQ_WORK_VECTOR line prior to the APIC being
initialized.

Commit 2383844d4850 ("GHES: Elliminate double-loop in the NMI handler")
incorrectly modified the behavior such that the handler returns
NMI_HANDLED only if an error was processed, and incorrectly runs the ghes
work queue for every NMI.

This patch modifies the ghes_proc_irq_work() to run as it did prior to
2383844d4850 ("GHES: Elliminate double-loop in the NMI handler") by
properly returning NMI_HANDLED and only calling the work queue if
NMI_HANDLED has been set.

Fixes: 2383844d4850 ("GHES: Elliminate double-loop in the NMI handler")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/apei/ghes.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0d099a24f776..39c45efbcb3d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -858,17 +858,18 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		if (sev >= GHES_SEV_PANIC)
 			__ghes_panic(ghes);
 
+		ret = NMI_HANDLED;
+
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
 
 		__process_error(ghes);
 		ghes_clear_estatus(ghes);
-
-		ret = NMI_HANDLED;
 	}
 
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
-	irq_work_queue(&ghes_proc_irq_work);
+	if (ret == NMI_HANDLED)
+		irq_work_queue(&ghes_proc_irq_work);
 #endif
 	atomic_dec(&ghes_in_nmi);
 	return ret;
-- 
1.7.9.3

