From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/23] kprobes: check CONFIG_FREEZER instead of CONFIG_PM
Date: Fri, 16 Jan 2009 15:25:07 -0500
Message-ID: <5a4ccaf37ffece09ef33f1cfec67efa8ee56f967.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38904 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbZAPUZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK001C4ZEAETT0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:28 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Masami Hiramatsu <mhiramat@redhat.com>

Check CONFIG_FREEZER instead of CONFIG_PM because kprobe booster
depends on freeze_processes() and thaw_processes() when CONFIG_PREEMPT=y.

This fixes a linkage error which occurs when CONFIG_PREEMPT=y, CONFIG_PM=y
and CONFIG_FREEZER=n.

Reported-by: Cheng Renquan <crquan@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/kprobes.c |    2 +-
 arch/x86/kernel/kprobes.c  |    2 +-
 kernel/kprobes.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index f90be51..9adac44 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -870,7 +870,7 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		return 1;
 
 ss_probe:
-#if !defined(CONFIG_PREEMPT) || defined(CONFIG_PM)
+#if !defined(CONFIG_PREEMPT) || defined(CONFIG_FREEZER)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		ia64_psr(regs)->ri = p->ainsn.slot;
diff --git a/arch/x86/kernel/kprobes.c b/arch/x86/kernel/kprobes.c
index 884d985..e948b28 100644
--- a/arch/x86/kernel/kprobes.c
+++ b/arch/x86/kernel/kprobes.c
@@ -446,7 +446,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static void __kprobes setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb)
 {
-#if !defined(CONFIG_PREEMPT) || defined(CONFIG_PM)
+#if !defined(CONFIG_PREEMPT) || defined(CONFIG_FREEZER)
 	if (p->ainsn.boostable == 1 && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1b9cbdc..7ba8cd9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -123,7 +123,7 @@ static int collect_garbage_slots(void);
 static int __kprobes check_safety(void)
 {
 	int ret = 0;
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_PM)
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_FREEZER)
 	ret = freeze_processes();
 	if (ret == 0) {
 		struct task_struct *p, *q;
-- 
1.5.6.6

