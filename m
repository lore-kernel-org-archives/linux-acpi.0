From: Len Brown <lenb@kernel.org>
Subject: Re: Working DSDT+SSDT, what's next?
Date: Thu, 06 May 2010 02:00:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005060152340.23230@localhost.localdomain>
References: <f95d4e7ce96630fd1e07c05fd8ab2504@127.0.0.1>
 <4BCBE05D.5090600@erley.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:44116 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0EFGBI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 02:01:08 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00KDEI1JX013@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 01:01:08 -0500 (CDT)
In-reply-to: <4BCBE05D.5090600@erley.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pat Erley <pat-lkml@erley.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 19 Apr 2010, Pat Erley wrote:

> Ok, I've continued learning, more info injected below:
> 
> On 04/16/10 14:42, pat-lkml@erley.org wrote:
> > Ok, first time poster, long time reader.  
> > 
> > I have a Clevo D900T mobo based laptop.  These were only ever produced
> > with p4 5xx series chips, but the chipset (ICH6) supports the 6xx series. 
> > Because it was never produced with a 6xx cpu, a bios was never released
> > that supported things like EIST or EM64T.  EM64T worked fine, out of the
> > box.  EIST did not (due to no SSDT tables with PSS/PCT/PPC methods).  I was
> > able to get EIST working with a hacked-up DSDT, but I'm curious if I'm
> > doing everything I should.
> > 
> > Intel CPU Spec: http://processorfinder.intel.com/details.aspx?sSpec=SL8Q7
> > Intel Data Sheet:
> > http://download.intel.com/design/Pentium4/datashts/303128.pdf
> > 
> > Right now, I just have 2 C States, for 3.0Ghz and 2.8Ghz.  It's my
> > understanding that these are the only speeds EIST can do in this CPU.  

Those are P-states, not C-states.

> > now, the questions:
> > 
> > 1. Is there something I should be doing with a _CSD type entry in my
> > CPU{0,1} entries to signify that they're HT?
> 
> Yep, I needed to add a pair of _CSD entries.  EIST is now adjusting speeds correctly!

That's funny, P-states and EIST have nothing to do with _CSD.

> > 3. How do I determine VID values? 
> >    a. I've just lowered VID 1 by 1, loading the system until it became
> > unstable, at which point I added 1 and called it good
> >    b. Is there any advantage to multiple VID's with 1 VID?  IE:
> > 3ghz@1.45V, 3Ghz@1.25V
>
> People in linux-pch have helped me here

you're on very thin ice here.
In theory, the BIOS is supposed to match the capabilities of the 
motherboard.  The BIOS may not expose something on the motherboard
because it may be broken.

> > 4. in the PSS table, the first entry (3000,2800 in my case), are those
> > just for show?
> 
> Still don't have an answer here.
>
> > 5. Are there additional features the CPU supports that, due to bios
> > limitation, I should enable this way (C1E?)

C1 and C1E are identical from an OS point of view.

> Ok, I now now I need to come up with a _CST table (unless one of the other tables is doing this...)
> to enable C-States, and C1E in particular...
> Anyone have any pointers on where to start on this?
> All of the info I seem to be able to find are for C2Q and newer CPUs, 
> not older P4s like what I have.
>  
> > outline of what I've done: http://pat.erley.org/Other/P4EISTSSDT

Honestly, Pat, if you want to slow down a P4,
just use p4clockmod until you can get more capable hardware.

-Len Brown, Intel Open Source Technology Center

