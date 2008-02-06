From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 00:03:04 +0100
Message-ID: <200802070003.05543.rjw@sisk.pl>
References: <47A5C399.7010405@free.fr> <47AA3763.7000106@free.fr> <20080206224308.GA1630@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60764 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762358AbYBFXEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 18:04:54 -0500
In-Reply-To: <20080206224308.GA1630@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: matthieu castet <castet.matthieu@free.fr>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Wednesday, 6 of February 2008, Pavel Machek wrote:
> Hi!
> 
> >>>>>> instead of existing stack setup. That helped on one of my test-boxes
> >>>>> Thanks, I will try that.
> >>>>> Because clearing the flags imply pop/push in the stack it could be the 
> >>>>> problem
> >>>> That doesn't help : it still crash in pushl $0.
> >>>>
> >>> All stack stuff in wakeup_code crash for me.
> >>> I tried to change the stack position, make sure upper bit of %esp are 
> >>> clear, ... nothing work.
> >>> What's are strange is that according to my x86 manual, in real mode the 
> >>> failure can only happen if the stack wrap which is not the case here.
> >>> Any x86 guru advice ?
> >>>
> >>> If I remove stack access (remove clearing flag stuff, not call to video 
> >>> stuff) the resume works.
> >>
> >> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
> >> see if that breaks?
> > Yes that also break.

Interesting.

> Not sure what is going on...

Looks like ss goes bonkers or the 32-bit opcodes are invalid in real mode.

Matthieu, can you try "pushw %ax; popw %ax;", please?

Rafael
