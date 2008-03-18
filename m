From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/6] ACPI: lockdep warning on boot, 2.6.25-rc5
Date: Tue, 18 Mar 2008 02:02:07 -0400
Message-ID: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55486 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbYCRGG3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:29 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

This avoids the harmless WARNING by lockdep in acpi_processor_idle().

The reason for WARNING is because at the depth of idle handling code,
some of the idle handlers disable interrupts, some times, while returning from
the idle handler. After return, acpi_processor_idle and few other routines
in the file did an unconditional local_irq_enable(). With LOCKDEP, enabling
irq when it is already enabled generates the below WARNING.

> > [    0.593038] ------------[ cut here ]------------
> > [    0.593267] WARNING: at kernel/lockdep.c:2035 trace_hardirqs_on+0xa0/0x115()
> > [    0.593596] Modules linked in:
> > [    0.593756] Pid: 0, comm: swapper Not tainted 2.6.25-rc5 #8
> > [    0.594017]
> > [    0.594017] Call Trace:
> > [    0.594216]  [<ffffffff80231663>] warn_on_slowpath+0x58/0x6b
> > [    0.594495]  [<ffffffff80495966>] ? _spin_unlock_irqrestore+0x38/0x47
> > [    0.594809]  [<ffffffff80329a86>] ? acpi_os_release_lock+0x9/0xb
> > [    0.595103]  [<ffffffff80337840>] ? acpi_set_register+0x161/0x173
> > [    0.595401]  [<ffffffff8034c8d4>] ? acpi_processor_idle+0x1de/0x546
> > [    0.595706]  [<ffffffff8020a23b>] ? default_idle+0x0/0x73
> > [    0.595970]  [<ffffffff8024fc0e>] trace_hardirqs_on+0xa0/0x115
> > [    0.596049]  [<ffffffff8034c6f6>] ? acpi_processor_idle+0x0/0x546
> > [    0.596346]  [<ffffffff8034c8d4>] acpi_processor_idle+0x1de/0x546
> > [    0.596642]  [<ffffffff8020a23b>] ? default_idle+0x0/0x73
> > [    0.596912]  [<ffffffff8034c6f6>] ? acpi_processor_idle+0x0/0x546
> > [    0.597209]  [<ffffffff8020a23b>] ? default_idle+0x0/0x73
> > [    0.597472]  [<ffffffff8020a355>] cpu_idle+0xa7/0xd1
> > [    0.597717]  [<ffffffff80485fa1>] rest_init+0x55/0x57
> > [    0.597957]  [<ffffffff8062fb49>] start_kernel+0x29d/0x2a8
> > [    0.598215]  [<ffffffff8062f1da>] _sinittext+0x1da/0x1e1
> > [    0.598464]
> > [    0.598546] ---[ end trace 778e504de7e3b1e3 ]---

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6f3b217..e8e2d88 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -216,8 +216,10 @@ static void acpi_safe_halt(void)
 	 * test NEED_RESCHED:
 	 */
 	smp_mb();
-	if (!need_resched())
+	if (!need_resched()) {
 		safe_halt();
+		local_irq_disable();
+	}
 	current_thread_info()->status |= TS_POLLING;
 }
 
@@ -421,7 +423,9 @@ static void acpi_processor_idle(void)
 		else
 			acpi_safe_halt();
 
-		local_irq_enable();
+		if (irqs_disabled())
+			local_irq_enable();
+
 		return;
 	}
 
@@ -530,7 +534,9 @@ static void acpi_processor_idle(void)
 		 *       skew otherwise.
 		 */
 		sleep_ticks = 0xFFFFFFFF;
-		local_irq_enable();
+		if (irqs_disabled())
+			local_irq_enable();
+
 		break;
 
 	case ACPI_STATE_C2:
-- 
1.5.5.rc0.6.gdeda

