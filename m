From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in
 quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 11:13:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0809301107500.3262@nehalem.linux-foundation.org>
References: <200809290953.56565.bjorn.helgaas@hp.com> <200809290957.59813.bjorn.helgaas@hp.com> <alpine.LFD.1.10.0809290912060.3265@nehalem.linux-foundation.org> <48E11EFA.8010402@keyaccess.nl> <alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org>
 <48E1EF0E.8030006@keyaccess.nl> <alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org> <48E24C6F.3030903@keyaccess.nl> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0809301052200.3436@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0809301052200.3436@nehalem.linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>
List-Id: linux-acpi@vger.kernel.org



On Tue, 30 Sep 2008, Linus Torvalds wrote:
> 
> Hmm?  Bjorn? Everything that is true about "pnp_system_init" should be 
> equally true abote pnpacpi_init and pnpbios_init, no?

Side note: unlike the more radical "move all arch driver initcalls 
earlier", this one actually works for me. But it does cause 
pnp_system_init() to actually run before pnpacpi_init and pnpbios_init, 
due to the link order within PnP. That seems ok, since the system/acpi/pnp 
drivers should all be just different versions of PnP drivers, but I 
thought I'd mention it. Maybe there is some PnP internal reason why 
pnp_system_init should run after the pnp_acpi/bios_init functions.

(And if so, then just changing the order in drivers/pnp/Makefile would fix 
it up again).

Bjorn, is there any reason why this isn't the right thign to do?

Rene - I have this suspicion that just doing this part should already fix 
your issues with _no_ other patch, since now anything PnP does is after 
all the PCI setup code anyway. So does your sound card (or whatever it 
was) work by just doing the subsys_initcall -> fs_initcall change in PnP?

		Linus
