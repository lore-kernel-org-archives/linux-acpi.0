From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 86/86] ftrace/x86: Fix triple fault with graph tracing and suspend-to-ram
Date: Thu,  4 May 2017 11:04:51 +0200
Message-ID: <71fc7fc71ce6cca6885b17f89d55e676178c31d1.1493888632.git.jslaby@suse.cz>
References: <13a6a971c9165237531c2870da03084a6becc905.1493888632.git.jslaby@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <13a6a971c9165237531c2870da03084a6becc905.1493888632.git.jslaby@suse.cz>
In-Reply-To: <cover.1493888632.git.jslaby@suse.cz>
References: <cover.1493888632.git.jslaby@suse.cz>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-acpi@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

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
