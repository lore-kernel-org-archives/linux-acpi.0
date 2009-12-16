From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] ipmi/acpi: Fix the building error in ipmi module
Date: Wed, 16 Dec 2009 08:52:42 -0700
Message-ID: <200912160852.43206.bjorn.helgaas@hp.com>
References: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:22083 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZLPPwp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:52:45 -0500
In-Reply-To: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforege.net

On Wednesday 16 December 2009 07:40:29 am yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> When the IPMI module is selected as module, it will complain the
> following building error.
> >ERROR: "pnpacpi_protocol" [drivers/char/ipmi/ipmi_si.ko] undefined!
> 
> Fix the above building error.

This is already fixed in Len's tree, so we don't need this patch.

> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/pnp/pnpacpi/core.c |    7 +++++++
>  include/linux/pnp.h        |   11 +++--------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index 8dd0f37..8eebbe4 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -155,6 +155,13 @@ struct pnp_protocol pnpacpi_protocol = {
>  #endif
>  };
>  
> +struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> +{
> +	if (dev->protocol == &pnpacpi_protocol)
> +		return dev->data;
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pnp_acpi_device);
>  static int __init pnpacpi_add_device(struct acpi_device *device)
>  {
>  	acpi_handle temp = NULL;
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index 7c4193e..0ae2c64 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -335,16 +335,11 @@ extern struct pnp_protocol pnpbios_protocol;
>  #endif
>  
>  #ifdef CONFIG_PNPACPI
> -extern struct pnp_protocol pnpacpi_protocol;
>  
> -static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> -{
> -	if (dev->protocol == &pnpacpi_protocol)
> -		return dev->data;
> -	return NULL;
> -}
> +extern struct acpi_device *pnp_acpi_device(struct pnp_dev *dev);
>  #else
> -#define pnp_acpi_device(dev) 0
> +static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> +{ return NULL; }
>  #endif
>  
>  /* status */


