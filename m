From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3] ftrace/x86/32: fix triple fault with graph tracing
 and suspend-to-ram
Date: Thu, 13 Apr 2017 21:11:53 -0500
Message-ID: <20170414021153.ummmwqxshnsdxin3@treble>
References: <5c1272269a580660703ed2eccf44308e790c7a98.1492123841.git.jpoimboe@redhat.com>
 <20170413190236.7a225767@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdDNCLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Apr 2017 22:11:55 -0400
Content-Disposition: inline
In-Reply-To: <20170413190236.7a225767@grimm.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, stable@kernel.org

On Thu, Apr 13, 2017 at 07:02:36PM -0400, Steven Rostedt wrote:
> On Thu, 13 Apr 2017 17:53:55 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On x86-32, with CONFIG_FIRMWARE and multiple CPUs, if you enable
> > function graph tracing and then suspend to RAM, it will triple fault and
> > reboot when it resumes.
> > 
> > The first fault happens when booting a secondary CPU:
> > 
> > startup_32_smp()
> >   load_ucode_ap()
> >     prepare_ftrace_return()
> >       ftrace_graph_is_dead()
> >         (accesses 'kill_ftrace_graph')
> > 
> > The early head_32.S code calls into load_ucode_ap(), which has an an
> > ftrace hook, so it calls prepare_ftrace_return(), which calls
> > ftrace_graph_is_dead(), which tries to access the global
> > 'kill_ftrace_graph' variable with a virtual address, causing a fault
> > because the CPU is still in real mode.
> > 
> > The fix is to add a check in prepare_ftrace_return() to make sure it's
> > running in protected mode before continuing.  The check makes sure the
> > stack pointer is a virtual kernel address.  It's a bit of a hack, but
> > it's not very intrusive and it works well enough.
> > 
> > For reference, here are a few other (more difficult) ways this could
> > have potentially been fixed:
> > 
> > - Move startup_32_smp()'s call to load_ucode_ap() down to *after* paging
> >   is enabled.  (No idea what that would break.)
> > 
> > - Track down load_ucode_ap()'s entire callee tree and mark all the
> >   functions 'notrace'.  (Probably not realistic.)
> > 
> > - Pause graph tracing in ftrace_suspend_notifier_call() or bringup_cpu()
> >   or __cpu_up(), and ensure that the pause facility can be queried from
> >   real mode.
> > 
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Cc: stable@kernel.org
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> This is pretty much the same thing we were talking about before, right?

Yeah, the same patch from before, now with more tags!

> If so, then:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

-- 
Josh
