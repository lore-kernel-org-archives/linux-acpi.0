From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH 3/8] ACPI,	PCI: PCIe ASPM _OSC support capabilities
	called when root bridge added
Date: Wed, 29 Oct 2008 16:57:44 -0600
Message-ID: <1225321064.6794.129.camel@bluto.andrew>
References: <20081029054815.2263.40833.stgit@bob.kio>
	 <20081029054831.2263.81405.stgit@bob.kio> <4907FD78.7060202@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:1689 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508AbYJ2W5q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 18:57:46 -0400
In-Reply-To: <4907FD78.7060202@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx

On Wed, 2008-10-29 at 15:06 +0900, Kenji Kaneshige wrote:
> Andrew Patterson wrote:
> > ACPI, PCI: PCIe ASPM _OSC support capabilities called when root bridge added
> > 
> > The _OSC capabilities OSC_ACTIVE_STATE_PWR_SUPPORT and
> > OSC_CLOCK_PWR_CAPABILITY_SUPPORT are set when the root bridge is added
> > with pci_acpi_osc_support(), so we no longer need to do it in the
> > ASPM driver.
> > ---
> > 
> >  drivers/acpi/pci_root.c |    4 ++++
> >  drivers/pci/pcie/aspm.c |   22 ----------------------
> >  2 files changed, 4 insertions(+), 22 deletions(-)
> > 
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 47df4a8..4d60629 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -214,6 +214,10 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
> >  	pci_acpi_osc_support(device->handle,
> >  			     OSC_EXT_PCI_CONFIG_SUPPORT |
> >  			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
> > +#ifdef CONFIG_PCIEASPM
> > +			     OSC_ACTIVE_STATE_PWR_SUPPORT |
> > +			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
> > +#endif
> 
> Don't we need to check 'aspm_disabled'?

Added the function pcie_aspm_enabled, which is checked before adding the
ASPM capabilities to the flags.  Which also means I can remove the
#ifdef CONFIG_PCIEASPM.

Andrew

> 
> Thanks,
> Kenji Kaneshige
> 
> 

