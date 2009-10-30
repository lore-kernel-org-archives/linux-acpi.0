From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Fri, 30 Oct 2009 14:17:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910301412500.31845@localhost.localdomain>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200910301948.24473.rjw@sisk.pl> <alpine.LFD.2.01.0910301228430.31845@localhost.localdomain> <200910302132.44759.rjw@sisk.pl> <alpine.LFD.2.01.0910301335570.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49396 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932872AbZJ3VSD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Oct 2009 17:18:03 -0400
In-Reply-To: <alpine.LFD.2.01.0910301335570.31845@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jose Marino <braket@hotmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>



On Fri, 30 Oct 2009, Linus Torvalds wrote:
> 
> And partly exactly _because_ even Cardbus is starting to be "legacy", I'd 
> personally prefer to try to simplify the model to the point where we don't 
> have to think about all the subtle interactions. Just making suspend act 
> as an eject would mean that we'd never have to worry about how the CardBus 
> bridge interacts with the PCI layer at suspend/resume time.

Put another way: five years ago I would have felt that it could be 
important that people can suspend and resume while they have a CD-ROM 
mounted through a PCMCIA IDE card. Or something like that where you want 
to keep session information.

These days, that scenario is less interesting to begin with, and we're 
generally better at some of the hotplug issues anyway. Example: one of the 
reasons I used to like not causing an unplug event was because I had 
network cards, and hated setting up the connection again. These days, all 
distros come with networkmanager or similar, and hotplug networking just 
works (even if the "CD-ROM mounted" case probably still would cause 
problems).

So I think we used to have good reasons to try to maintain state over a 
suspend event, but many of those reasons have become weaker, while at the 
same time USB has meant that PCMCIA itself has become more of a 
"maintenance burden" rather than a "primary subsystem".

			Linus
