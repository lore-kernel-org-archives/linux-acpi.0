From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function graph tracing
Date: Sat, 25 Mar 2017 14:20:11 +0100
Message-ID: <5766300.HtmE7iLEgV@aspire.rjw.lan>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com> <20170324181254.gouyrbmppukrrbb6@treble> <20170324144114.16a37d47@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62530 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750766AbdCYNZu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 25 Mar 2017 09:25:50 -0400
In-Reply-To: <20170324144114.16a37d47@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

On Friday, March 24, 2017 02:41:14 PM Steven Rostedt wrote:
> On Fri, 24 Mar 2017 13:12:54 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> 
> > Instead I was able to "fix" it by ignoring ftrace calls in real mode:
> > 
> > -----
> > index 8f3d9cf..5c0d0c6 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -983,6 +983,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> >  	unsigned long return_hooker = (unsigned long)
> >  				&return_to_handler;
> >  
> > +	if (__builtin_return_address(0) < TASK_SIZE_MAX)
> > +		return;
> > +
> >  	if (unlikely(ftrace_graph_is_dead()))
> >  		return;
> > ---------------
> > 
> > I'm not sure what the best fix should really be.  A few ideas off the
> > top of my head:
> > 
> > - A real mode check similar to the above (except it should probably be
> >   more precise)
> 
> The real mode check hack may be good enough for now. Make sure that
> it's commented well.

Agreed.

Thanks,
Rafael

