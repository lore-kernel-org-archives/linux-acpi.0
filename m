From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function
 graph tracing
Date: Mon, 27 Mar 2017 09:08:43 -0500
Message-ID: <20170327140843.fx5y32rnc3mqiyke@treble>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
 <20170324181254.gouyrbmppukrrbb6@treble>
 <20170324144114.16a37d47@gandalf.local.home>
 <5766300.HtmE7iLEgV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbdC0OIw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 10:08:52 -0400
Content-Disposition: inline
In-Reply-To: <5766300.HtmE7iLEgV@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

On Sat, Mar 25, 2017 at 02:20:11PM +0100, Rafael J. Wysocki wrote:
> On Friday, March 24, 2017 02:41:14 PM Steven Rostedt wrote:
> > On Fri, 24 Mar 2017 13:12:54 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > 
> > > Instead I was able to "fix" it by ignoring ftrace calls in real mode:
> > > 
> > > -----
> > > index 8f3d9cf..5c0d0c6 100644
> > > --- a/arch/x86/kernel/ftrace.c
> > > +++ b/arch/x86/kernel/ftrace.c
> > > @@ -983,6 +983,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> > >  	unsigned long return_hooker = (unsigned long)
> > >  				&return_to_handler;
> > >  
> > > +	if (__builtin_return_address(0) < TASK_SIZE_MAX)
> > > +		return;
> > > +
> > >  	if (unlikely(ftrace_graph_is_dead()))
> > >  		return;
> > > ---------------
> > > 
> > > I'm not sure what the best fix should really be.  A few ideas off the
> > > top of my head:
> > > 
> > > - A real mode check similar to the above (except it should probably be
> > >   more precise)
> > 
> > The real mode check hack may be good enough for now. Make sure that
> > it's commented well.
> 
> Agreed.

Just to clarify, there are two bugs related to function graph tracing
and suspend/resume.  The original patch in this thread (which removes
'-Os' from the acpi Makefile) is still needed.

-- 
Josh
