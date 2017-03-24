From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function
 graph tracing
Date: Fri, 24 Mar 2017 13:12:54 -0500
Message-ID: <20170324181254.gouyrbmppukrrbb6@treble>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
 <c6c72c7a0199bc79fdbe2318713e35d9@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934718AbdCXSNM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 14:13:12 -0400
Content-Disposition: inline
In-Reply-To: <c6c72c7a0199bc79fdbe2318713e35d9@molgen.mpg.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Mar 21, 2017 at 09:44:03PM +0100, Paul Menzel wrote:
> I checked out Linux 4.9.16, applied your patch on top, and copied the Debian
> 4.9 Linux kernel configuration, did `make menuconfig`, disabled building
> debugging symbols, and executed `ARCH=i386 make -j40 deb-pkg`.
> 
> I installed that package on the Lenovo X60, and the result with tracing
> enabled has improved. The system suspends without a crash. Unfortunately,
> instead of resuming when pressing the power button, it starts from scratch.
> Suspend and resume without tracing enabled works though.
> 
> I’ll try to collect logs, but I don’t know, if there will be any, if the
> system just resets.
> 
> Maybe, this can be reproduced in QEMU?

So I was able to recreate this issue in qemu, and after some hours of
debugging I managed to figure it out.

It's rebooting during the resume because of a triple fault in
prepare_ftrace_return().

acpi wakeup for secondary cpu
  startup_32_smp()
    load_ucode_ap()
      prepare_ftrace_return()
        ftrace_graph_is_dead()
	  dereferences virtual address (kill_ftrace_graph) in real mode <-- BOOM

I tried fixing it by changing load_ucode_ap() to notrace, but that
function calls some other functions which also have mcount hooks, which
call other functions, etc.

Instead I was able to "fix" it by ignoring ftrace calls in real mode:

-----
index 8f3d9cf..5c0d0c6 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -983,6 +983,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
+	if (__builtin_return_address(0) < TASK_SIZE_MAX)
+		return;
+
 	if (unlikely(ftrace_graph_is_dead()))
 		return;
---------------

I'm not sure what the best fix should really be.  A few ideas off the
top of my head:

- A real mode check similar to the above (except it should probably be
  more precise)

- Make tracing_graph_pause a percpu variable so that it can be read from
  prepare_ftrace_return()

- pause_graph_tracing() from ftrace_suspend_notifier_call()

Steven, thoughts?

-- 
Josh
