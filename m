From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Provide a spec conform OSI interface to the BIOS
Date: Sat, 19 Jul 2008 22:27:19 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807192224300.3543@localhost.localdomain>
References: <1216316268-24042-1-git-send-email-trenn@suse.de>
 <48804349.607@linux.intel.com> <200807181922.11728.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:34830 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbYGTC1l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 22:27:41 -0400
Received: from localhost.localdomain ([96.252.122.168])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K4A0070T9HLMY58@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 19 Jul 2008 21:27:22 -0500 (CDT)
In-reply-to: <200807181922.11728.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org



On Fri, 18 Jul 2008, Thomas Renninger wrote:

> On Friday 18 July 2008 09:16:25 am Andi Kleen wrote:
> > Thomas Renninger wrote:
> > > Introduce acpi_osi=windows_false boot parameter
> > > Introduce CONFIG_ACPI_OSI_SPEC_CONFORM config option
> >
> > Why are you adding the CONFIG option? 
> > In what circumstances would one 
> > set it? If anything I think this should be a boot option only for now.
> E.g. for OEMs that do not need to support all BIOSes in the world who 
> can just check for the config option and then know it behaves as written in 
> the spec and being able to support Linux and Windows through the same BIOS.
> 
> But you are right, the compile option only makes sense if acpi_osi="Windows 
> 2006" can be used to simulate a specific Windows OS via boot param, which is 
> not the case.
> 
> But I want the boot param. This one makes very much sense to test BIOSes 
> whether they stick to the ACPI spec and work fine on Linux without Windows 
> simulation. Is that ok?
> 
> > Probably needs more discussion first.
> I always wanted to write down the arguments again, but this takes a lot time.

> Will you accept the boot param only?

I don't see a case for this.

This workaround is needed only if there is a Linux bug.
I'd rather expose and fix that Linux bug than open
the door to sweeping it under the rug and making
Linux harder to maintain.

-Len

