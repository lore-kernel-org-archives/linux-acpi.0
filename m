From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 09/12] Fix incorrect handling PCI-Express Root Bridge _HID
Date: Sat, 14 Oct 2006 04:07:49 -0400
Message-ID: <200610140407.49927.len.brown@intel.com>
References: <200610102120.k9ALKeBx024290@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58567 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1160999AbWJNIFQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:05:16 -0400
In-Reply-To: <200610102120.k9ALKeBx024290@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, eiichiro.oiwa.nm@hitachi.com

This was applied to (2.6.20-bound) ACPICA, and I've cherry-picked it
to apply to 2.6.19, and will send it to stable as well.

thanks,
-Len

On Tuesday 10 October 2006 17:20, akpm@osdl.org wrote:
> From: <eiichiro.oiwa.nm@hitachi.com>
> 
> Lifted from http://bugzilla.kernel.org/show_bug.cgi?id=7145
> 
> PCI Bus Topology:
> 
> [CPU] [CPU]        [CPU]  [CPU]
>   |      |BUS        |     |   BUS
> --+--+---+---      --+--+--+------
>      |                  |
>  [Root Bridge]*1-----[Root Bridge]*1
>      |      |           \        \
>  [Bridge]   |        [PCI-e slot] [PCI-e slot]
>     | |    [PCI-e slot]
>     | \
>     | [PCI-e slot]
>     |
>     |
>  [PCI Bridge]
>     |     \
>     |      [PCI-X slot]
>     |
>  [PCI-X slot]
> 
> *1: PCI Express Root Bridge.
> 
> I could not get correct PCI Express BUS number from the structure of
> acpi_object_extra.  I always get zero as BUS number regardless of BUS
> location.  I found that there is incorrect comparison with _HID (PNP0A08)
> in acpi/events/evrgnini.c and PCI Express _BBN method always fail. 
> Therefore, we get always get zero as PCI Express bus number.
> 
> I suggest the following patch.
> 
> Cc: "Brown, Len" <len.brown@intel.com>
> Cc: <linux-acpi@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/events/evrgnini.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid drivers/acpi/events/evrgnini.c
> --- a/drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid
> +++ a/drivers/acpi/events/evrgnini.c
> @@ -225,12 +225,12 @@ acpi_ev_pci_config_region_setup(acpi_han
>  				if (!
>  				    (ACPI_STRNCMP
>  				     (object_hID.value, PCI_ROOT_HID_STRING,
> -				      sizeof(PCI_ROOT_HID_STRING))
> +				      sizeof(PCI_ROOT_HID_STRING)))
>  				     ||
>  				     !(ACPI_STRNCMP
>  				       (object_hID.value,
>  					PCI_EXPRESS_ROOT_HID_STRING,
> -					sizeof(PCI_EXPRESS_ROOT_HID_STRING)))))
> +					sizeof(PCI_EXPRESS_ROOT_HID_STRING))))
>  				{
>  
>  					/* Install a handler for this PCI root bridge */
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
