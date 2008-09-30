From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 13:16:54 -0600
Message-ID: <200809301316.55780.bjorn.helgaas@hp.com>
References: <200809290953.56565.bjorn.helgaas@hp.com> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org> <alpine.LFD.2.00.0809301052200.3436@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:26391 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYI3TSA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 15:18:00 -0400
In-Reply-To: <alpine.LFD.2.00.0809301052200.3436@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>

On Tuesday 30 September 2008 12:01:38 pm Linus Torvalds wrote:
> 
> On Tue, 30 Sep 2008, Linus Torvalds wrote:
> > 
> > In contrast, the PnP fixup thing is called from pnp_fixup_device, called 
> > from __pnp_add_device(), called from pnp_add_device() (and 
> > pnp_add_card(), but that should be later), and those in turn from
> > pnpacpi_add_device and pnpacpi_init(). 
> > 
> > And pnpacpi_init is _also_ a subsys_initcall [...]
> 
> Btw, why is that? We very much have a separate
> 
> 	/**
> 	 * Reserve motherboard resources after PCI claim BARs,
> 	 * but before PCI assign resources for uninitialized PCI devices
> 	 */
> 	fs_initcall(pnp_system_init);
> 
> which is called much later. That seems to be the _right_ point for any 
> quirks. It seems that the _real_ problem here is that the PnP device fixup 
> is simply called from the wrong point. Ie, why do we do device discovery - 
> and thus PnP quirks - in pnp_init (before the PCI bus is actually fully 
> initialized!), rather than in pnp_system_init?

Right.  The point of this quirk (quirk_system_pci_resources()) is to
prevent the PNP system driver from claiming resources that are actually
used by PCI.  So I don't think there's any reason to run it before we
bind the driver to the device.  PNP doesn't currently have any early/
late concept for quirks, but we probably should add one.

Feels like a post-2.6.27 project though.

Bjorn


