From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] ftrace/x86: fix x86-32 triple fault with graph tracing and
 suspend-to-ram
Date: Mon, 27 Mar 2017 09:54:41 -0500
Message-ID: <20170327145441.aybim6rmc6nxelij@treble>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
 <20170324181254.gouyrbmppukrrbb6@treble>
 <20170324144114.16a37d47@gandalf.local.home>
 <5766300.HtmE7iLEgV@aspire.rjw.lan>
 <20170327140843.fx5y32rnc3mqiyke@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdC0Oyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 10:54:44 -0400
Content-Disposition: inline
In-Reply-To: <20170327140843.fx5y32rnc3mqiyke@treble>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On x86-32, with CONFIG_FIRMWARE and multiple CPUs, if you enable
function graph tracing and then suspend to RAM, it will triple fault and
reboot when it resumes.

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

For reference, here are a few other ways this could have potentially
been fixed:

- Move startup_32_smp()'s call to load_ucode_ap() down to *after* paging
  is enabled.  (No idea what that would break.)

- Track down load_ucode_ap()'s entire callee tree and mark all the
  functions 'notrace'.  (Probably not realistic.)

- Pause graph tracing in ftrace_suspend_notifier_call() or bringup_cpu()
  or __cpu_up(), and ensure that the pause facility can be queried from
  real mode.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/ftrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8f3d9cf..1c5c4e2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -983,6 +983,17 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
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
+	if (unlikely((long)__builtin_frame_address(0) >= 0)) return;
+
 	if (unlikely(ftrace_graph_is_dead()))
 		return;
 
-- 
2.7.4

