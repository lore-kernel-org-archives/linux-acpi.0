From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH 7/8] PCI: check if MSI is enabled before adding _OSC
	support capability
Date: Thu, 30 Oct 2008 04:51:50 +0000
Message-ID: <1225342310.6725.112.camel@grinch>
References: <20081029054815.2263.40833.stgit@bob.kio>
	 <20081029054851.2263.36283.stgit@bob.kio> <49080088.4040903@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:30426 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYJ3Evy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2008 00:51:54 -0400
In-Reply-To: <49080088.4040903@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx

On Wed, 2008-10-29 at 15:19 +0900, Kenji Kaneshige wrote:
> Andrew Patterson wrote:
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
> >  
> >  	/* 
> >  	 * Segment
> 
> I think the 'pci_msi_enable' variable can be changed after
> acpi_pci_root_add() is called by quirk_disable_all_msi()
> (in driver/pci/quirk.c).

I am not sure what to do about this one.  I think the correct thing to
do is use Matthew's as yet unwritten root bridge iterator function to
remove the OSC_MSI_SUPPORT flag for all root bridges. I suspect that it
will not hurt to have this flag set given that we disable the use of all
MSI.

Andrew

> Thanks,
> Kenji Kaneshige
> 


