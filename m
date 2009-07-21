From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH v2 2/2] PCI Hotplug: acpiphp: get pci_bus from acpi
	handle correctly
Date: Tue, 21 Jul 2009 14:19:35 -0600
Message-ID: <20090721201935.GL32046@ldl.fc.hp.com>
References: <20090714204823.18933.40768.stgit@bob.kio> <200907201455.44959.bjorn.helgaas@hp.com> <20090721195755.GJ32046@ldl.fc.hp.com> <200907211415.47628.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:11443 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130AbZGUUTf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jul 2009 16:19:35 -0400
Content-Disposition: inline
In-Reply-To: <200907211415.47628.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: jbarnes@virtuousgeek.org, lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

* Bjorn Helgaas <bjorn.helgaas@hp.com>:
> On Tuesday 21 July 2009 01:57:55 pm Alex Chiang wrote:
> > * Bjorn Helgaas <bjorn.helgaas@hp.com>:
> > > On Tuesday 14 July 2009 02:53:33 pm Alex Chiang wrote:
> > > > +static struct pci_bus *pci_bus_from_handle(acpi_handle handle)
> > > > +{
> > > > +	struct pci_bus *pbus;
> > > > +
> > > > +	if (acpi_is_root_bridge(handle)) {
> > > > +		struct acpi_pci_root *root = acpi_pci_find_root(handle);
> > > > +		pbus = root->bus;
> > > > +	} else {
> > > > +		struct pci_dev *pdev = acpi_get_pci_dev(handle);
> > > > +		pbus = pdev->subordinate;
> > > > +		pci_dev_put(pdev);
> > > > +	}
> > > > +	return pbus;
> > > 
> > > I worry that acpi_is_root_bridge() merely checks the device IDs of
> > > "handle", which isn't quite the same as checking whether the pci_root
> > > driver has claimed "handle".
> > 
> > Hm, I understand this concern in a theoretical sense, but could
> > you explain more of what you're thinking about, and give me a
> > concrete example of something that might go wrong here?
> 
> My concern is only theoretical -- I could imagine a PNP0A03 device
> in the namespace (so acpi_is_root_bridge() is true) that has not been
> claimed by the pci_root driver (so acpi_pci_find_root() returns NULL).
> 
> I don't think this will happen in practice because pci_root can't be
> a module, but it's easier to analyze with just one check, since you
> can learn everything you need from acpi_pci_find_root() without also
> depending on acpi_is_root_bridge().

Ah, that makes sense.

I can respin one more time using your suggestion (although I'll
probably keep it factored out into a separate function).

Thanks.

/ac

