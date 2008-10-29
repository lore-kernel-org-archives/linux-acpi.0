From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH 7/8] PCI: check if MSI is enabled before adding _OSC
	support capability
Date: Wed, 29 Oct 2008 15:57:05 -0600
Message-ID: <1225317425.6794.125.camel@bluto.andrew>
References: <20081029054815.2263.40833.stgit@bob.kio>
	 <20081029054851.2263.36283.stgit@bob.kio>
	 <200810290833.19690.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200810290833.19690.bjorn.helgaas@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

On Wed, 2008-10-29 at 08:33 -0600, Bjorn Helgaas wrote:
> On Tuesday 28 October 2008 11:48:51 pm Andrew Patterson wrote:
> > PCI: check if MSI is enabled before adding _OSC support capability
> > 
> > Ensure that pci=nomsi is not set before adding the _OSC support capability
> > OSC_MSI_SUPPORT to the root bridge.
> > 
> > Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
> > ---
> > 
> >  drivers/acpi/pci_root.c |   20 +++++++++++---------
> >  1 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 75a59ea..32afd02 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -194,6 +194,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
> >  	unsigned long long value = 0;
> >  	acpi_handle handle = NULL;
> >  	struct acpi_device *child;
> > +	u32 flags;
> >  
> >  
> >  	if (!device)
> > @@ -211,17 +212,18 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
> >  
> >  	device->ops.bind = acpi_pci_bind;
> >  
> > -	pci_acpi_osc_support(device->handle,
> > -			     OSC_EXT_PCI_CONFIG_SUPPORT |
> > -			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
> > -#ifdef CONFIG_PCI_MSI
> > -			     OSC_MSI_SUPPORT |
> > -#endif
> > +	flags = (OSC_EXT_PCI_CONFIG_SUPPORT |
> > +		 OSC_PCI_SEGMENT_GROUPS_SUPPORT |
> >  #ifdef CONFIG_PCIEASPM
> > -			     OSC_ACTIVE_STATE_PWR_SUPPORT |
> > -			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
> > +		 OSC_ACTIVE_STATE_PWR_SUPPORT |
> > +		 OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
> > +#endif
> > +		 0);
> > +#ifdef CONFIG_PCI_MSI
> > +	if (pci_msi_enabled())
> > +		flags |= OSC_MSI_SUPPORT;
> >  #endif
> > -			     0);
> > +	pci_acpi_osc_support(device->handle, flags);
> 
> I think this should be folded into patch 5/8.  Otherwise, bisection
> won't work across this series because at patch 5, we always add
> OSC_MSI_SUPPORT, regardless of "pci=nomsi".
> 

Done.

> If you introduce "flags" in patch 2/8, the rest of the patches will
> be clearer (and it will facilitate a useful dev_warn() when
> pci_acpi_osc_support() fails).

Done.

> 
> You don't need the "#ifdef CONFIG_PCI_MSI" here, do you?

No, Removed.

> 
> Bjorn
> 

Andrew
