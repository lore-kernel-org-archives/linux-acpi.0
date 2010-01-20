From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4 1/2] IPMI/ACPI: use ACPI detection mechanism firstly to detect IPMI system interface
Date: Wed, 20 Jan 2010 09:51:48 -0700
Message-ID: <201001200951.49462.bjorn.helgaas@hp.com>
References: <1262051060-23245-1-git-send-email-yakui.zhao@intel.com> <1262051060-23245-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:2896 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0ATQvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2010 11:51:51 -0500
In-Reply-To: <1262051060-23245-2-git-send-email-yakui.zhao@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforge.net

On Monday 28 December 2009 06:44:19 pm yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Sometimes one IPMI system interface will be detected by several methods.
> For example: ACPI mechanism, SPMI table, DMI or hardcode mechanism.
> In such case when one IPMI system interface can be detected in two mechanism,
> the second mechanism will fail in the detection and can't record which IPMI
> system interface is detected by it.
> 
> Use the ACPI detection mechanism firstly to detect the IPMI system interface
> so that we can know which IPMI system interface is detected in ACPI namespace.
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 176f175..3f6ca11 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -3195,6 +3195,10 @@ static __devinit int init_ipmi_si(void)
>  
>  	printk(KERN_INFO "IPMI System Interface driver.\n");
>  
> +#ifdef CONFIG_ACPI
> +	pnp_register_driver(&ipmi_pnp_driver);
> +#endif
> +
>  	hardcode_find_bmc();

The usual practice is to handle devices explicitly specified by
module parameters first.  That way, the driver should work with
no module parameters in most cases, but the user can specify the
device location manually if necessary to work around a firmware
bug.

For that reason, I would use this order instead:

	hardcode_find_bmc();
	pnp_register_driver();
	...

>  #ifdef CONFIG_DMI
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


