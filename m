From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] ACPI: create ACPI notifier chain
Date: Fri, 1 Feb 2008 23:02:43 -0500
Message-ID: <200802012302.43854.lenb@kernel.org>
References: <1201243686.4663.19.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54818 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbYBBEDD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2008 23:03:03 -0500
In-Reply-To: <1201243686.4663.19.camel@acpi-sony.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com

Applied.

thanks,
-Len

On Friday 25 January 2008 01:48, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> This patch is needed by the kernel mode graphics drivers.
> Create an ACPI notifier chain so that they can get
> notified upon hotkey events.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/event.c    |   28 ++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |    3 +++
>  2 files changed, 31 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/event.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/event.c
> +++ linux-2.6/drivers/acpi/event.c
> @@ -109,6 +109,34 @@ static const struct file_operations acpi
>  };
>  #endif	/* CONFIG_ACPI_PROC_EVENT */
>  
> +/* ACPI notifier chain */
> +BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
> +
> +int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
> +{
> +	struct acpi_bus_event event;
> +
> +	strcpy(event.device_class, dev->pnp.device_class);
> +	strcpy(event.bus_id, dev->pnp.bus_id);
> +	event.type = type;
> +	event.data = data;
> +	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
> +                        == NOTIFY_BAD) ? -EINVAL : 0;
> +}
> +EXPORT_SYMBOL(acpi_notifier_call_chain);
> +
> +int register_acpi_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&acpi_chain_head, nb);
> +}
> +EXPORT_SYMBOL(register_acpi_notifier);
> +
> +int unregister_acpi_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&acpi_chain_head, nb);
> +}
> +EXPORT_SYMBOL(unregister_acpi_notifier);
> +
>  #ifdef CONFIG_NET
>  static unsigned int acpi_event_seqnum;
>  struct acpi_genl_event {
> Index: linux-2.6/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/acpi_bus.h
> +++ linux-2.6/include/acpi/acpi_bus.h
> @@ -320,6 +320,9 @@ struct acpi_bus_event {
>  
>  extern struct kset acpi_subsys;
>  extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
> +extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
> +extern int register_acpi_notifier(struct notifier_block *);
> +extern int unregister_acpi_notifier(struct notifier_block *);
>  /*
>   * External Functions
>   */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
