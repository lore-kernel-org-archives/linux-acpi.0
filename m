From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] ftrace/x86: Fix triple fault with graph tracing and suspend-to-ram
Date: Wed,  3 May 2017 14:23:27 +0200
Message-ID: <20170503122327.12095-49-jslaby@suse.cz>
References: <20170503122327.12095-1-jslaby@suse.cz>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38615 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751005AbdECMXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 May 2017 08:23:49 -0400
In-Reply-To: <20170503122327.12095-1-jslaby@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>

From: Josh Poimboeuf <jpoimboe@redhat.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 34a477e5297cbaa6ecc6e17c042a866e1cbe80d6 upstream.

On x86-32, with CONFIG_FIRMWARE and multiple CPUs, if you enable function
graph tracing and then suspend to RAM, it will triple fault and reboot when
it resumes.

The first fault happens when booting a secondary CPU:

startup_32_smp()
  load_ucode_ap()
    prepare_ftrace_return()
      ftrace_graph_is_dead()
        (accesses 'kill_ftrace_graph')

The early head_32.S code calls into load_ucode_ap(), which has an an
ftrace hook, so it calls prepare_ftrace_return(), which calls
ftrace_graph_is_dead(), which tries to access the global
'kill_ftrace_graph' variable with a virtual address, causing a fault
because the CPU is still in real mode.

The fix is to add a check in prepare_ftrace_return() to make sure it's
running in protected mode before continuing.  The check makes sure the
stack pointer is a virtual kernel address.  It's a bit of a hack, but
it's not very intrusive and it works well enough.

For reference, here are a few other (more difficult) ways this could
have potentially been fixed:

- Move startup_32_smp()'s call to load_ucode_ap() down to *after* paging
  is enabled.  (No idea what that would break.)

- Track down load_ucode_ap()'s entire callee tree and mark all the
  functions 'notrace'.  (Probably not realistic.)

- Pause graph tracing in ftrace_suspend_notifier_call() or bringup_cpu()
  or __cpu_up(), and ensure that the pause facility can be queried from
  real mode.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/5c1272269a580660703ed2eccf44308e790c7a98.1492123841.git.jpoimboe@redhat.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/kernel/ftrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index f8ab203fb676..b8162154e615 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -735,6 +735,18 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
+	/*
+	 * When resuming from suspend-to-ram, this function can be indirectly
+	 * called from early CPU startup code while the CPU is in real mode,
+	 * which would fail miserably.  Make sure the stack pointer is a
+	 * virtual address.
+	 *
+	 * This check isn't as accurate as virt_addr_valid(), but it should be
+	 * good enough for this purpose, and it's fast.
+	 */
+	if (unlikely((long)__builtin_frame_address(0) >= 0))
+		return;
+
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-- 
2.12.2

