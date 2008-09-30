From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in
 quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 12:44:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0809301241300.3262@nehalem.linux-foundation.org>
References: <200809290953.56565.bjorn.helgaas@hp.com> <200809290957.59813.bjorn.helgaas@hp.com> <alpine.LFD.1.10.0809290912060.3265@nehalem.linux-foundation.org> <48E11EFA.8010402@keyaccess.nl> <alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org>
 <48E1EF0E.8030006@keyaccess.nl> <alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org> <48E24C6F.3030903@keyaccess.nl> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org> <alpine.LFD.2.00.0809301001280.3389@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0809301015210.4651@nehalem.linux-foundation.org> <48E27E23.20400@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <48E27E23.20400@keyaccess.nl>
Sender: linux-pci-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-acpi@vger.kernel.org



On Tue, 30 Sep 2008, Rene Herman wrote:
> 
> Yes, I also get that oops but other than that, both link order versions you
> sent out work -- ie, booting with acpi=noirq gets me to a functional system
> with the quirk having run for PNP0c02 (acpi=off disables all of PNP0c02) and
> doing its job.

Ok. But that means that the last patch I sent out - the one that _only_ 
changes the order for PnP itself, and moves pnpacpi_init and pnpbios_init 
to be fs_initcalls - should also work, and have none of he other 
interactions. Yes?

> For some reason only some of your messages seem to be making it into my inbox
> (in order, at least) but either of these that is:
> 
> http://lkml.org/lkml/2008/9/30/242
> http://lkml.org/lkml/2008/9/30/261

Don't know why you can't see the messages, but in case this one comes
through but not the other ones, look at the third patch in

	http://lkml.org/lkml/2008/9/30/283

instead.

		Linus
