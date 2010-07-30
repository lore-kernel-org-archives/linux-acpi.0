From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] ACPI/PCI: do not preserve query result
Date: Fri, 30 Jul 2010 14:42:02 +0200
Message-ID: <201007301442.03241.rjw@sisk.pl>
References: <201007282323.56351.rjw@sisk.pl> <4C526E3E.3000600@jp.fujitsu.com> <4C526F5B.2050202@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47058 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756608Ab0G3Mnt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jul 2010 08:43:49 -0400
In-Reply-To: <4C526F5B.2050202@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

On Friday, July 30, 2010, Kenji Kaneshige wrote:
> Currently, all the _OSC controls are queried at the same time in
> acpi_pci_osc_support() and the result is preserved for later
> acpi_pci_osc_control_set() call. But query result can vary depending
> on the combination of requested controls. Therefore, query result must
> not be preserved.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

IMHO it would be _much_ simpler to change the definition of
acpi_pci_osc_control_get() in my original patch so that it executes
acp_pci_query_osc() unconditionally.

Rafael


> ---
>  drivers/acpi/pci_root.c |   49 ++++++++++++++++++++++++++----------------------
>  include/acpi/acpi_bus.h |    3 --
>  2 files changed, 27 insertions(+), 25 deletions(-)
> 
> Index: linux-2.6.35-rc6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.35-rc6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6.35-rc6/drivers/acpi/pci_root.c
> @@ -230,35 +230,42 @@ static acpi_status acpi_pci_run_osc(acpi
>  	return status;
>  }
>  
> -static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
> +static acpi_status acpi_pci_osc_control_query(struct acpi_pci_root *root,
> +					      u32 flags, u32 *result)
>  {
> -	acpi_status status;
> -	u32 result;
> -
> -	/* do _OSC query for all possible controls */
> -	flags &= OSC_PCI_SUPPORT_MASKS;
> -	status = acpi_pci_run_osc(root->device->handle,
> -				  root->osc_support_set | flags,
> -				  OSC_PCI_CONTROL_MASKS,
> -				  true, &result);
> -	if (ACPI_SUCCESS(status)) {
> -		root->osc_support_set |= flags;
> -		root->osc_control_qry = result;
> -		root->osc_queried = 1;
> +	/* No need to run _OSC if requested control bits are already granted */
> +	flags &= OSC_PCI_CONTROL_MASKS;
> +	if ((root->osc_control_set & flags) == flags) {
> +		*result = root->osc_control_set;
> +		return AE_OK;
>  	}
> -	return status;
> +	return acpi_pci_run_osc(root->device->handle,
> +				root->osc_support_set,
> +				root->osc_control_set | flags,
> +				true, result);
>  }
>  
>  static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
>  {
>  	acpi_status status;
>  	acpi_handle tmp;
> +	u32 result;
>  
>  	status = acpi_get_handle(root->device->handle, "_OSC", &tmp);
>  	if (ACPI_FAILURE(status))
>  		return status;
>  	mutex_lock(&osc_lock);
> -	status = acpi_pci_query_osc(root, flags);
> +	/* No need to run _OSC if requested support bits are already set */
> +	flags &= OSC_PCI_SUPPORT_MASKS;
> +	if ((root->osc_support_set & flags) == flags)
> +		goto out;
> +	status = acpi_pci_run_osc(root->device->handle,
> +				  root->osc_support_set | flags,
> +				  root->osc_control_set,
> +				  true, &result);
> +	if (ACPI_SUCCESS(status))
> +		root->osc_support_set |= flags;
> +out:
>  	mutex_unlock(&osc_lock);
>  	return status;
>  }
> @@ -399,12 +406,10 @@ acpi_status acpi_pci_osc_control_set(acp
>  		goto out;
>  
>  	/* Need to query controls first before requesting them */
> -	if (!root->osc_queried) {
> -		status = acpi_pci_query_osc(root, root->osc_support_set);
> -		if (ACPI_FAILURE(status))
> -			goto out;
> -	}
> -	if ((root->osc_control_qry & control_req) != control_req) {
> +	status = acpi_pci_osc_control_query(root, control_req, &result);
> +	if (ACPI_FAILURE(status))
> +		goto out;
> +	if ((result & control_req) != control_req) {
>  		printk(KERN_DEBUG
>  		       "Firmware did not grant requested _OSC control\n");
>  		status = AE_SUPPORT;
> Index: linux-2.6.35-rc6/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.35-rc6.orig/include/acpi/acpi_bus.h
> +++ linux-2.6.35-rc6/include/acpi/acpi_bus.h
> @@ -377,9 +377,6 @@ struct acpi_pci_root {
>  
>  	u32 osc_support_set;	/* _OSC state of support bits */
>  	u32 osc_control_set;	/* _OSC state of control bits */
> -	u32 osc_control_qry;	/* the latest _OSC query result */
> -
> -	u32 osc_queried:1;	/* has _OSC control been queried? */
>  };
>  
>  /* helper */
> 
> 
> 

