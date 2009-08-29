From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/11] SFI: Simple Firmware Interface - v3
Date: Fri, 28 Aug 2009 20:14:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281949560.27023@localhost.localdomain>
References: <1250282295-25216-1-git-send-email-lenb@kernel.org>
 <20090817100628.GA21498@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:45918 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbZH2AOV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 20:14:21 -0400
In-reply-to: <20090817100628.GA21498@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


> Ok, this iteration is even nicer.

Thank you, Ingo, both for the thoughtful review,
and your kind words.

>   Reviewed-by: Ingo Molnar <mingo@elte.hu>
> 
> A patch technical request/suggestion. I guess you'd like to keep 
> these bits in the ACPI tree, so that you can test it and merge it 
> with ongoing ACPI changes, right?
> 
> That would be fine to me for all the arch/x86/ touching patches, 
> except for this one:
> 
>  [PATCH 05/11] ACPI, x86: expose some IO-APIC routines when CONFIG_ACPI=n
> 
> I'd like to pick this one up into tip:x86/apic, because there's 
> ongoing work in this area. (also, by the looks of it, i'd not be 
> surprised if this patch needed some testing. This is fragile code 
> with quirky Kconfig dependencies.)
> 
> I can create a standalone topic for this (based on .31-rc6), 
> containing this single commit, which you could pull into the ACPI 
> tree? That way we both can have this commit and nobody is held up, 
> and both trees can be pushed to Linus in the .32 merge window, 
> independently of each other.

Sure.

Go ahead and pull that patch onto an 2.6.31-rc8 based branch from here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git for-ingo

As the previous patches did not depend on it, I simply rebased that
one to rc8 and moved the other patches after it.

Yes, I use a single git database for ACPI and SFI so they can
share things such as this patch, but rather than make SFI a
branch in the kernel.org ACPI tree, it has its own tree,
since most of SFI is independent of ACPI.

thanks,
-Len Brown, Intel Open Source Technology Center


