From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sat, 31 Oct 2009 10:54:57 +1100
Message-ID: <1256946897.6372.161.camel@pasglop>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera>
	 <200910301948.24473.rjw@sisk.pl>
	 <alpine.LFD.2.01.0910301228430.31845@localhost.localdomain>
	 <200910302132.44759.rjw@sisk.pl>
	 <alpine.LFD.2.01.0910301335570.31845@localhost.localdomain>
	 <alpine.LFD.2.01.0910301412500.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50295 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100AbZJ3XzY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Oct 2009 19:55:24 -0400
In-Reply-To: <alpine.LFD.2.01.0910301412500.31845@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jose Marino <braket@hotmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>


> Put another way: five years ago I would have felt that it could be 
> important that people can suspend and resume while they have a CD-ROM 
> mounted through a PCMCIA IDE card. Or something like that where you want 
> to keep session information.

I think you are a bit too much laptop centric :-) It's sadly still
common in the embedded space to use PCMCIA or Cardbus for ... root
filesystems.

Cheers,
Ben.


