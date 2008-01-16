From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Set pnp_init_resource_table, pnp_resource_change, pnp_manual_config_dev deprecated
Date: Wed, 16 Jan 2008 16:56:58 -0500
Message-ID: <200801161656.58603.lenb@kernel.org>
References: <a8e1da0711290111m65b071cft90b4361ec0155096@mail.gmail.com> <1196389939.7234.1.camel@sli10-desk.sh.intel.com> <1196417657.23251.293.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56094 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYAQBAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:00:06 -0500
In-Reply-To: <1196417657.23251.293.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Shaohua Li <shaohua.li@intel.com>, Rene Herman <rene.herman@keyaccess.nl>, Dave Young <hidave.darkstar@gmail.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Thomas,
If you send me a checkpatch.pl clean version, I'll apply it for 2.6.25.

Also, how is the dynamic allocation of pnp resources coming along?
We'll be wanting to do that on day1 of 2.6.25 integration window.

thanks,
-Len

> I don't know how many externally built drivers, which are making use of
> this, could still be out there?
> What is the general policy for removing such old, rarely used and "being
> more a workaround than an interface" exported symbols?
> 
> This should be 2.6.24 material:
> 
> Mark pnp_init_resource_table, pnp_resource_change, pnp_manual_config_dev deprecated
> 
> Thanks to Rene Herman, the remaining calls to those functions got eliminated
> in the sound/isa layer recently.
> Those functions are a workaround for wrong BIOS pnp information and give
> drivers the possibility to override BIOS exported PNP resources.
> This can be done through sysfs since 2.6, therefore these functions should
> vanish rather soon, as dynamic allocation for PNP resources is depending
> on it.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> ---
>  include/linux/pnp.h |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.24-rc3-mm2/include/linux/pnp.h
> ===================================================================
> --- linux-2.6.24-rc3-mm2.orig/include/linux/pnp.h
> +++ linux-2.6.24-rc3-mm2/include/linux/pnp.h
> @@ -387,8 +387,8 @@ int pnp_register_dma_resource(struct pnp
>  int pnp_register_port_resource(struct pnp_option *option,
>  			       struct pnp_port *data);
>  int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
> -void pnp_init_resource_table(struct pnp_resource_table *table);
> -int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
> +void __deprecated pnp_init_resource_table(struct pnp_resource_table *table);
> +int __deprecated pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
>  			  int mode);
>  int pnp_auto_config_dev(struct pnp_dev *dev);
>  int pnp_validate_config(struct pnp_dev *dev);
> @@ -396,8 +396,8 @@ int pnp_start_dev(struct pnp_dev *dev);
>  int pnp_stop_dev(struct pnp_dev *dev);
>  int pnp_activate_dev(struct pnp_dev *dev);
>  int pnp_disable_dev(struct pnp_dev *dev);
> -void pnp_resource_change(struct resource *resource, resource_size_t start,
> -			 resource_size_t size);
> +void __deprecated pnp_resource_change(struct resource *resource, resource_size_t start,
> +				      resource_size_t size);
>  
>  /* protocol helpers */
>  int pnp_is_active(struct pnp_dev *dev);
> @@ -436,15 +436,15 @@ static inline int pnp_register_irq_resou
>  static inline int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data) { return -ENODEV; }
>  static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
>  static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
> -static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
> -static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
> +static inline void __deprecated pnp_init_resource_table(struct pnp_resource_table *table) { }
> +static inline int __deprecated pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
>  static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
> -static inline void pnp_resource_change(struct resource *resource, resource_size_t start, resource_size_t size) { }
> +static inline void __deprecated pnp_resource_change(struct resource *resource, resource_size_t start, resource_size_t size) { }
>  
>  /* protocol helpers */
>  static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
