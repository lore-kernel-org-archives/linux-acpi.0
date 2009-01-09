From: Len Brown <lenb@kernel.org>
Subject: Re: why kexec (was Re: [PATCH 2/2] ACPI: PCI Interrupt Links --
 disable when unused)
Date: Fri, 09 Jan 2009 05:30:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090520450.4091@localhost.localdomain>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
 <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
 <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
 <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
 <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
 <494C023F.6070207@kernel.org>
 <alpine.LFD.2.00.0901090144220.4091@localhost.localdomain>
 <86802c440901082324g50138f71tcd705b909205be6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:44784 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZAIKa3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:30:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700H8X944WQF2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:28:53 -0600 (CST)
In-reply-to: <86802c440901082324g50138f71tcd705b909205be6e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-acpi@vger.kernel.org



> On Thu, Jan 8, 2009 at 10:55 PM, Len Brown <lenb@kernel.org> wrote:
> >> >> maybe could have one switch in /proc so could not disable that for
> >> >> some kexec path...
> >> >
> >> > I fail to comprehend the benefits of kexec,
> >> > and the requirements that kexec puts on the kernel, other than:
> >> >
> >> > # CONFIG_KEXEC is not set
> >> >
> >>
> >> for me: it is a tools that i could use to make sure root-cause is in FW, and BIOS guys will not kick back the ball to os team.
> >> after modifying table or hw reg in first kernel, and kexec even stock kernel, everything will work well.
> >
> > For ACPI, we already have the ability to override the BIOS tables
> > upon the 1st boot.
> >
> > I don't know which BIOS guys you refer to,
> > but when we find a BIOS bug and have access to
> > the associated BIOS developer, we've never needed
> > to do such a demonstration to convince them they have a bug.
> 
> Your BIOS developer must have enough time or have bunch of BIOS engineers.

Reasonable engineers do not need their own bugs
handed to them on a silver platter.

> > kexec seems like a science project that has a chance of working
> > only under extremely controlled conditions.
> > I have no problem with that, as long as it is not built into my kernel.
> 
> could reduce boot time.

Effort would be better spent on reducing boot time w/ kexec.

> or some system has problem with reset...
> 
> or linuxbios + tinykernel to kexec final production kernel.
> here linuxbios only init ram and basic pci resource allocation ...

My understanding is that the linuxbios people realized
that creating a BIOS that boots Linux (tiny or not)
only to then boot Linux again, was sort of subgenius.
So they re-named linuxbios to be coreboot and now
they talk about loading a "payload"....

> > But say kexec is useful to somebody out there -- what are
> > the requirements that kexec puts on the kernel?
> 
> the support got into the mainline kernel several years ago... from 2.6.16?

I'm afraid I'm not being clear.
This conversation started when you suggested that we should
put a hook in to ask ACPI to manipulate Link state
for the benefit of kexec.

My question is, what else does kexec need to properly
manage the state of the sytem?

I don't think that question has an answer.
I don't think it will ever have an answer.
I think that kexec is a viable concept only
under conditions I don't care about.

-Len


