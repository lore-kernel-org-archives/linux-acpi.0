From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function graph tracing
Date: Mon, 27 Mar 2017 18:59:03 +0200
Message-ID: <2351759.z3hZC86TjS@aspire.rjw.lan>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com> <5766300.HtmE7iLEgV@aspire.rjw.lan> <20170327140843.fx5y32rnc3mqiyke@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62600 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751314AbdC0RFE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 13:05:04 -0400
In-Reply-To: <20170327140843.fx5y32rnc3mqiyke@treble>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

On Monday, March 27, 2017 09:08:43 AM Josh Poimboeuf wrote:
> On Sat, Mar 25, 2017 at 02:20:11PM +0100, Rafael J. Wysocki wrote:
> > On Friday, March 24, 2017 02:41:14 PM Steven Rostedt wrote:
> > > On Fri, 24 Mar 2017 13:12:54 -0500
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > 
> > > > Instead I was able to "fix" it by ignoring ftrace calls in real mode:
> > > > 
> > > > -----
> > > > index 8f3d9cf..5c0d0c6 100644
> > > > --- a/arch/x86/kernel/ftrace.c
> > > > +++ b/arch/x86/kernel/ftrace.c
> > > > @@ -983,6 +983,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> > > >  	unsigned long return_hooker = (unsigned long)
> > > >  				&return_to_handler;
> > > >  
> > > > +	if (__builtin_return_address(0) < TASK_SIZE_MAX)
> > > > +		return;
> > > > +
> > > >  	if (unlikely(ftrace_graph_is_dead()))
> > > >  		return;
> > > > ---------------
> > > > 
> > > > I'm not sure what the best fix should really be.  A few ideas off the
> > > > top of my head:
> > > > 
> > > > - A real mode check similar to the above (except it should probably be
> > > >   more precise)
> > > 
> > > The real mode check hack may be good enough for now. Make sure that
> > > it's commented well.
> > 
> > Agreed.
> 
> Just to clarify, there are two bugs related to function graph tracing
> and suspend/resume.  The original patch in this thread (which removes
> '-Os' from the acpi Makefile) is still needed.

OK

Thanks,
Rafael

