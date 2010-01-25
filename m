From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v5 1/2] IPMI/ACPI: use ACPI detection mechanism firstly to detect IPMI system interface
Date: Mon, 25 Jan 2010 09:27:42 -0700
Message-ID: <201001250927.42985.bjorn.helgaas@hp.com>
References: <1264411473-11273-1-git-send-email-yakui.zhao@intel.com> <1264411473-11273-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:11279 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab0AYQ2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2010 11:28:11 -0500
In-Reply-To: <1264411473-11273-2-git-send-email-yakui.zhao@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforge.net

On Monday 25 January 2010 02:24:32 am yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Sometimes one IPMI system interface will be detected by several methods.
> For example: ACPI mechanism, SPMI table, DMI.
> In such case when one IPMI system interface can be detected in two mechanism,
> the second mechanism will fail in the detection and can't record which IPMI
> system interface is detected by it.
> 
> Use the ACPI detection mechanism firstly to detect the IPMI system interface
> so that we can know which IPMI system interface is detected in ACPI namespace and
> then install the IPMI opregion to enable ACPI to access the BMC controller. 
> But the hardcode detection mechanism is still put in the first order.
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Bjorn Helgaas <bjorn.helgaas@hp.com>

Looks great!

Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

> ---
>  drivers/char/ipmi/ipmi_si_intf.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 176f175..65dabd8 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -3197,6 +3197,10 @@ static __devinit int init_ipmi_si(void)
>  
>  	hardcode_find_bmc();
>  
> +#ifdef CONFIG_ACPI
> +	pnp_register_driver(&ipmi_pnp_driver);
> +#endif
> +
>  #ifdef CONFIG_DMI
>  	dmi_find_bmc();
>  #endif
> @@ -3204,9 +3208,6 @@ static __devinit int init_ipmi_si(void)
>  #ifdef CONFIG_ACPI
>  	spmi_find_bmc();
>  #endif
> -#ifdef CONFIG_ACPI
> -	pnp_register_driver(&ipmi_pnp_driver);
> -#endif
>  
>  #ifdef CONFIG_PCI
>  	rv = pci_register_driver(&ipmi_pci_driver);
> @@ -3330,6 +3331,7 @@ static __exit void cleanup_ipmi_si(void)
>  #ifdef CONFIG_PCI
>  	pci_unregister_driver(&ipmi_pci_driver);
>  #endif
> +
>  #ifdef CONFIG_ACPI
>  	pnp_unregister_driver(&ipmi_pnp_driver);
>  #endif


