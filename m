From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 21:00:31 +0100
Message-ID: <200802072100.32205.rjw@sisk.pl>
References: <47A5C399.7010405@free.fr> <20080207092035.GB1816@elf.ucw.cz> <47AB60C4.50602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39549 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbYBGUCN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 15:02:13 -0500
In-Reply-To: <47AB60C4.50602@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 7 of February 2008, matthieu castet wrote:
> Hi,
> 
> 
> Pavel Machek wrote:
> > Hi!
> > So I assume it is some kind of desktop?
> Yes.
> 
> >>
> >> ...if someone calls start as 0x1234:0, we are okay. But if some broken
> >> bios calls us as 0x1:0x234, we've got a problem.
> >
> > Well, in that case the signature/end_signature tests below would 
>  >trigger, no?
> 
> Yes, and for example the beep flag won't work.
> 
> >
> > Not sure what is going on... but if you remove all the stack
> > references, does it go up to 32-bit mode?
> Yes, but I end up with a kernel panic after console resume and some 
> resume stuff.
> 
>  > Looks like ss goes bonkers or the 32-bit opcodes are invalid in real 
> mode.
>  > Matthieu, can you try "pushw %ax; popw %ax;", please?
> I still crash.
> I also try to set ss to 0, and hardcode the stack (knowing we are loaded 
> at 0x1000). And it crash.
> 
> 
> I wonder if there a way to check that we are realy in real mode ?

Yes.  In real mode bit 0 of the cr0 register should be 0.

Thanks,
Rafael
