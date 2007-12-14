From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH] ACPI: ignore the error about the _CRS of LINK device
Date: Fri, 14 Dec 2007 17:43:10 -0500
Message-ID: <200712141743.10524.lenb@kernel.org>
References: <1197274521.20098.10.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935130AbXLNWnY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Dec 2007 17:43:24 -0500
In-Reply-To: <1197274521.20098.10.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

That's funny,
I thought we already ignored errors from _CRS on link devices.
perhaps the errors we ignore are slightly different --
we ignore an IRQ0, but here the return value isn't
formatted correctly -- we should probably follow the same path...

-Len

On Monday 10 December 2007 03:15, Zhao Yakui wrote:
> Hi, All
> 	The following error message can be found in the dmesg of bug8896.
> 	 ACPI Error (uteval-0269): Return object type is incorrect
> [\_SB_.PCI0.ALKD._CRS] (Node da4b49f0), AE_TYPE
> 	ACPI Error (uteval-0275): Type returned from _CRS was incorrect:
> Integer, expected Btypes: 4 [20060707]
> 	ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
> 	And the above error message is related to the following	BIOS Bug.
> 	Method (_CRS, 0, NotSerialized)
>                 {
>                     Return (0x00)
>                 }
> 
> Can we ignore the error about the _CRS method of LINK device and select
> IRQ from the possible IRQ list returned by _PRS method?
> 
> Thanks.
> 	
> 
> 
> Subject: ACPI : Ignore the error about the _CRS of LINK device
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> Ignore the error about the _CRS method of LINK device and select
> IRQ from possible IRQ list returned by _PRS method.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8896
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/pci_link.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.24-rc4/drivers/acpi/pci_link.c
> ===================================================================
> --- linux-2.6.24-rc4.orig/drivers/acpi/pci_link.c
> +++ linux-2.6.24-rc4/drivers/acpi/pci_link.c
> @@ -385,9 +385,16 @@ static int acpi_pci_link_set(struct acpi
>  
>  	/* Query _CRS, set link->irq.active */
>  	result = acpi_pci_link_get_current(link);
> -	if (result) {
> -		goto end;
> -	}
> +	if (result == ENODEV) {
> +		/*
> +		 * Ignore the error about the _CRS method of Link device and
> +		 * select IRQ from the Possible IRQ list
> +		 * returned by _PRS method.
> +		 */
> +                printk(KERN_WARNING "Ignore error LINK CRS method.\n");
> +                link->irq.active = irq;
> +                result = 0;
> +        }
>  
>  	/*
>  	 * Is current setting not what we set?
> 
