From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH 3/8] ACPI,	PCI: PCIe ASPM _OSC support capabilities
	called when root bridge added
Date: Wed, 29 Oct 2008 10:19:32 -0600
Message-ID: <1225297172.6725.101.camel@grinch>
References: <20081029054815.2263.40833.stgit@bob.kio>
	 <20081029054831.2263.81405.stgit@bob.kio> <4907FD78.7060202@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4907FD78.7060202@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

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

I'll fix this.

Andrew

> 
> Thanks,
> Kenji Kaneshige
> 
> 
