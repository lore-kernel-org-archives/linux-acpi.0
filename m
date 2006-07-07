From: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] sleeping function called from invalid context during
 resume
Date: Fri, 7 Jul 2006 12:40:25 -0700
Message-ID: <20060707124025.b7e9b2e2.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF5EB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751049AbWGGTke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2006 15:40:34 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF5EB@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-acpi@vger.kernel.org

On Fri, 7 Jul 2006 12:32:41 -0400
"Brown, Len" <len.brown@intel.com> wrote:

>  
> >
> >> I think we need to get rid of the acpi_in_resume hack
> >> and use system_state != SYSTEM_RUNNING to address this.
> >
> >Well if hacks are OK it'd actually be reliable to do
> >
> >	/* comment goes here */
> >	kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> >
> >because the irqs_disabled() thing happens for well-defined reasons. 
> >Certainly that's better than looking at system_state (and I 
> >don't think we
> >leave SYSTEM_RUNNING during suspend/resume anyway).
> 
> If system_state != SYSTEM_RUNNING on resume, theen __might_sleep()
> would not have spit out the dump_stack() above.
> 
> This is exactly like boot -- we are bringing up the system
> and we need to configure interrupts, which runs AML,
> which calls kmalloc in a variety of ways, all of which call
> __might_sleep.
> 
> It seems simplest to have resume admit that it is like boot
> and that the early allocations with interrupts off simply
> must succeed or it is game-off.
> 

No, we shouldn't expand the use of system_state.  Code continues to be
merged which uses it.  If we also merge code which enhances its semantics
then we're getting into quadratically-increasing nastiness rather than
linearly-increasing.

Callers should tell callees what to do.  Callees shouldn't be peeking at
globals to work out what to do.

Lacking any other caller-passed indication, it would be much better for
acpi to look at irqs_disabled().  That's effectively a task-local,
cpu-local argument which was passed down to callees.  It's hacky - it's
like the PF_foo flags.  But it's heaps better than having all the kernel
fight over the state of a global.
