From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH  2/16] ACPI pci_slot: Fix dmi table for Fujitsu
	PRIMEQUEST (Not for mainline!)
Date: Fri, 21 Mar 2008 10:04:57 -0600
Message-ID: <20080321160457.GF17292@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E3353F.3090500@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:16600 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYCUQE6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 12:04:58 -0400
Content-Disposition: inline
In-Reply-To: <47E3353F.3090500@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> Fix DMI table entry for Fujitsu PRIMEQUEST.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Merged, thanks.

/ac

> 
> ---
>  drivers/acpi/pci_slot.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.25-rc6/drivers/acpi/pci_slot.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/drivers/acpi/pci_slot.c
> +++ linux-2.6.25-rc6/drivers/acpi/pci_slot.c
> @@ -332,10 +332,10 @@ static struct dmi_system_id acpi_pci_slo
>  	 */
>  	{
>  	 .callback = do_sta_before_sun,
> -	 .ident = "Fujitsu Limited Primequest",
> +	 .ident = "Fujitsu PRIMEQUEST",
>  	 .matches = {
> -		DMI_MATCH(DMI_BIOS_VENDOR, "Fujitsu"),
> -		DMI_MATCH(DMI_BIOS_VERSION, "2.35"),
> +		DMI_MATCH(DMI_BIOS_VENDOR, "FUJITSU LIMITED"),
> +		DMI_MATCH(DMI_BIOS_VERSION, "PRIMEQUEST"),
>  		},
>  	},
>  	{}
> 
> 
