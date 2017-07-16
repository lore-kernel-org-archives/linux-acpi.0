From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.2 79/95] ftrace/x86: Fix triple fault with graph tracing
 and suspend-to-ram
Date: Sun, 16 Jul 2017 14:56:38 +0100
Message-ID: <lsq.1500213398.46811066@decadent.org.uk>
References: <lsq.1500213394.718669679@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43206 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751731AbdGPN55 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Jul 2017 09:57:57 -0400
Content-Disposition: inline
In-Reply-To: <lsq.1500213394.718669679@decadent.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org

3.2.91-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/ftrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -404,6 +404,18 @@ void prepare_ftrace_return(unsigned long
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
 

