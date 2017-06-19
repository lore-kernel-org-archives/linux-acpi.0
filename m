From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 261/268] ftrace/x86: Fix triple fault with graph tracing and suspend-to-ram
Date: Mon, 19 Jun 2017 20:32:40 +0200
Message-ID: <1497897167-14556-262-git-send-email-w@1wt.eu>
References: <1497897167-14556-1-git-send-email-w@1wt.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497897167-14556-1-git-send-email-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux@roeck-us.net
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Willy Tarreau <w@1wt.eu>
List-Id: linux-acpi@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/x86/kernel/ftrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1ffc32d..8c43930 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -744,6 +744,18 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
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
2.8.0.rc2.1.gbe9624a
