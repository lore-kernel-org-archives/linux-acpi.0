From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 7/8] PCI: check if MSI is enabled before adding _OSC support capability
Date: Wed, 29 Oct 2008 08:33:19 -0600
Message-ID: <200810290833.19690.bjorn.helgaas@hp.com>
References: <20081029054815.2263.40833.stgit@bob.kio> <20081029054851.2263.36283.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:47570 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYJ2OdX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 10:33:23 -0400
In-Reply-To: <20081029054851.2263.36283.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx

On Tuesday 28 October 2008 11:48:51 pm Andrew Patterson wrote:
> PCI: check if MSI is enabled before adding _OSC support capability
> 
> Ensure that pci=nomsi is not set before adding the _OSC support capability
> OSC_MSI_SUPPORT to the root bridge.
> 
> Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
> ---
> 
>  drivers/acpi/pci_root.c |   20 +++++++++++---------
>  1 files changed, 11 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 75a59ea..32afd02 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -194,6 +194,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  	unsigned long long value = 0;
>  	acpi_handle handle = NULL;
>  	struct acpi_device *child;
> +	u32 flags;
>  
>  
>  	if (!device)
> @@ -211,17 +212,18 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  
>  	device->ops.bind = acpi_pci_bind;
>  
> -	pci_acpi_osc_support(device->handle,
> -			     OSC_EXT_PCI_CONFIG_SUPPORT |
> -			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
> -#ifdef CONFIG_PCI_MSI
> -			     OSC_MSI_SUPPORT |
> -#endif
> +	flags = (OSC_EXT_PCI_CONFIG_SUPPORT |
> +		 OSC_PCI_SEGMENT_GROUPS_SUPPORT |
>  #ifdef CONFIG_PCIEASPM
> -			     OSC_ACTIVE_STATE_PWR_SUPPORT |
> -			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
> +		 OSC_ACTIVE_STATE_PWR_SUPPORT |
> +		 OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
> +#endif
> +		 0);
> +#ifdef CONFIG_PCI_MSI
> +	if (pci_msi_enabled())
> +		flags |= OSC_MSI_SUPPORT;
>  #endif
> -			     0);
> +	pci_acpi_osc_support(device->handle, flags);

I think this should be folded into patch 5/8.  Otherwise, bisection
won't work across this series because at patch 5, we always add
OSC_MSI_SUPPORT, regardless of "pci=nomsi".

If you introduce "flags" in patch 2/8, the rest of the patches will
be clearer (and it will facilitate a useful dev_warn() when
pci_acpi_osc_support() fails).

You don't need the "#ifdef CONFIG_PCI_MSI" here, do you?

Bjorn
