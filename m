From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Date: Tue, 30 May 2006 12:25:39 +0200
Message-ID: <20060530102538.GA1662@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com> <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz> <20060525221744.GA1671@elf.ucw.cz> <1148601858.3070.62.camel@whizzy> <20060526071518.GC1699@elf.ucw.cz> <1148668175.7600.11.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63714 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932231AbWE3K0X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 May 2006 06:26:23 -0400
Content-Disposition: inline
In-Reply-To: <1148668175.7600.11.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> > > No, I would not expect PCI to work properly with the debug patch -
> > > basically all I did was prevent the oops and confirm that this is the
> > > issue, I did not actually solve the problem.
> > > 
> > > I need some way to prevent acpiphp from loading before dock is completed
> > > it's init.
> > > 
> > > I guess I will think about this some more.
> > 
> > Using different _init levels? Like putting dock at subsys_initcall()
> > while acpiphp at late_initcall()?
> > 								Pavel
> 
> Can you see if this works for you?  Revert the first debug patch I sent
> and apply this one instead (against -mm).

Tried it in 

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 17
EXTRAVERSION =-rc4-mm3

...and now kernel hangs, last messages being:

pci_hotplug: ... core version: 0.5
ibmphpd: ... 0.6
acpiphp: ... 0.5
acpiphp: Slot [1] registered

I tried hitting magic sysrq, but it did not seem to respond.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
