From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in
 quirk_system_pci_resources()
Date: Mon, 29 Sep 2008 12:13:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org>
References: <200809290953.56565.bjorn.helgaas@hp.com> <200809290957.59813.bjorn.helgaas@hp.com> <alpine.LFD.1.10.0809290912060.3265@nehalem.linux-foundation.org> <48E11EFA.8010402@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <48E11EFA.8010402@keyaccess.nl>
Sender: linux-pci-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>
List-Id: linux-acpi@vger.kernel.org



On Mon, 29 Sep 2008, Rene Herman wrote:
> 
> I believe the possible issue is that resources that do _not_ (seem to) start
> at zero might also be disabled.

But that is irrelevant.

If we have registered them in the resource tree, then PnP must ignore 
them.

The fact is, this is not about being enabled or disabled. This is about 
the PnP tree containing resources that we already parsed from the PCI 
stuff, and once we've seen them as PCI resources, there's not really 
anything valuable in the PnP information.

			Linus
