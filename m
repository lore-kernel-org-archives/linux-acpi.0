From: Len Brown <lenb@kernel.org>
Subject: why kexec (was Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable
 when unused)
Date: Fri, 09 Jan 2009 01:55:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090144220.4091@localhost.localdomain>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
 <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
 <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
 <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
 <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
 <494C023F.6070207@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49278 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZAIGzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 01:55:17 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD600B72Z80P4S6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 00:55:13 -0600 (CST)
In-reply-to: <494C023F.6070207@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-acpi@vger.kernel.org

> >> maybe could have one switch in /proc so could not disable that for
> >> some kexec path...
> > 
> > I fail to comprehend the benefits of kexec,
> > and the requirements that kexec puts on the kernel, other than:
> > 
> > # CONFIG_KEXEC is not set
> > 
> 
> for me: it is a tools that i could use to make sure root-cause is in FW, and BIOS guys will not kick back the ball to os team.
> after modifying table or hw reg in first kernel, and kexec even stock kernel, everything will work well.

For ACPI, we already have the ability to override the BIOS tables
upon the 1st boot.

I don't know which BIOS guys you refer to,
but when we find a BIOS bug and have access to
the associated BIOS developer, we've never needed
to do such a demonstration to convince them they have a bug.

kexec seems like a science project that has a chance of working
only under extremely controlled conditions.
I have no problem with that, as long as it is not built into my kernel.

But say kexec is useful to somebody out there -- what are
the requirements that kexec puts on the kernel?

-Len


