From: Andrew Morton <akpm@osdl.org>
Subject: Re: Possible bug in ACPI
Date: Sun, 3 Dec 2006 12:27:31 -0800
Message-ID: <20061203122731.c9a514aa.akpm@osdl.org>
References: <20060919214724.GB2073@panelnet.cz>
	<20061109140416.db12bcbe.akpm@osdl.org>
	<20061202205140.GA12447@panelnet.cz>
	<20061202192632.d1815e5f.akpm@osdl.org>
	<457293AE.2060701@linux.intel.com>
	<20061203021216.e15b1d5d.akpm@osdl.org>
	<4572994C.6020603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:64219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760032AbWLCTbn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Dec 2006 14:31:43 -0500
In-Reply-To: <4572994C.6020603@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Dalibor Straka <dast@panelnet.cz>, jikos@jikos.cz, linux-acpi@vger.kernel.org

On Sun, 03 Dec 2006 12:30:52 +0300
Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:

> Andrew Morton wrote:
> > On Sun, 03 Dec 2006 12:06:54 +0300
> > Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
> >
> >   
> >> This is a patch reverted by Linus from rc6-git2 because it broke his 
> >> Compaq n620c, it refers to #5534 bug. Basically, kacpid deadlocks on 
> >> some new HP notebooks, and all incoming requests would be queued until 
> >> memory is over if this patch is not applied. On a bright side -- it's 
> >> not a memory leak...
> >> Patch, which works for Linus laptop and "looks acceptable" to Linus is 
> >> the last in #5534 list.
> >>     
> >
> > hm, if you say so.
> I forwarded Linus' mail to you...

I didn't receive it.

> >   The description in that patch is nowhere near complete
> > enough for me to be able to work out what it does.
> >
> >   
> Will update.
> 
> > The sys_sched_yield() is particularly incomprehensible and needs good
> > commenting.  You are, I hope, aware of the severe problems which yield()
> > causes when the system is busy?  The process which calls it will get
> > practically no CPU at all.
> >
> >   
> On Linus' machine, as soon as we execute deferred work, it's GPE becomes 
> enabled again and BIOS sends us a new event.
> So kacpid is always ready to run, while kacpi_notify don't have a chance 
> to run. sys_sched_yield() was added to
> give kacpi_notify a chance to run.
> I was thinking about lowering the priority of kacpid, is it better?

It all sounds horridly hacky, but I don't understand the problem well
enough to be able to recommend any solutions.  That's why I was hoping for
a decent description of the patch.

How does it relate to this? http://lkml.org/lkml/2006/8/8/336

> > Minor point: that patch has several unneded (and undesirable) casts of void*:
> >
> > +static void acpi_os_execute_notify(void *context)
> > +{
> > +	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
> > 	
> > please remove those.
> >   

I'll take that as an "OK" ;)
