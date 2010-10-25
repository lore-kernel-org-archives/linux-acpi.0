From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to get more info of
	low-level IPMI device
Date: Mon, 25 Oct 2010 09:19:40 +0800
Message-ID: <1287969580.3885.89.camel@localhost.localdomain>
References: <1287738641-11490-1-git-send-email-yakui.zhao@intel.com>
	 <1287738641-11490-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39016 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab0JYBYm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Oct 2010 21:24:42 -0400
In-Reply-To: <1287738641-11490-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>

On Fri, 2010-10-22 at 17:10 +0800, Zhao, Yakui wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The IPMI smi_watcher will be used to catch the IPMI interface as they come or go.
> In order to communicate with the correct IPMI device, it should be confirmed
>  whether it is what we wanted especially on the system with multiple IPMI
> devices. But the new_smi callback function of smi_watcher provides very
> limited info(only the interface number and dev pointer) and there is no
> detailed info about the low level interface. For example: which mechansim
> registers the IPMI interface(ACPI, PCI, DMI and so on).
> 
> This is to add one interface that can get more info of low-level IPMI
> device. For example: the ACPI device handle will be returned for the pnp_acpi
> IPMI device.

Hi, Corey
    Does this patch set make sense?
    In this patch set the reference pointer is returned instead of
memory copy.

Thanks.
    Yakui
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
> In this patch only the info of pnp_acpi IPMI is provided. If the detailed info
> is also required for other mechanism, please add them in the structure of
> ipmi_smi_info.
> 
>  drivers/char/ipmi/ipmi_msghandler.c |   26 ++++++++++++++++++++++++++
>  drivers/char/ipmi/ipmi_si_intf.c    |   28 ++++++++++++++++++++++++----
>  include/linux/ipmi.h                |   23 +++++++++++++++++++++++
>  include/linux/ipmi_smi.h            |   11 +++++++++++
>  4 files changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 4f3f8c9..6f4da59 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -970,6 +970,32 @@ out_kfree:
>  }
>  EXPORT_SYMBOL(ipmi_create_user);
>  
> +int ipmi_get_smi_info(int if_num, enum ipmi_addr_src type,
> +			struct ipmi_smi_info **data)
> +{
> +	int           rv = 0;
> +	ipmi_smi_t    intf;
> +	struct ipmi_smi_handlers *handlers;
> +
> +	mutex_lock(&ipmi_interfaces_mutex);
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +		if (intf->intf_num == if_num)
> +			goto found;
> +	}
> +	/* Not found, return an error */
> +	rv = -EINVAL;
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +	return rv;
> +
> +found:
> +	handlers = intf->handlers;
> +	rv = handlers->get_smi_info(intf->send_info, type, data);
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +
> +	return rv;
> +}
> +EXPORT_SYMBOL(ipmi_get_smi_info);
> +
>  static void free_user(struct kref *ref)
>  {
>  	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 7bd7c45..73b1c82 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -57,6 +57,7 @@
>  #include <asm/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/rcupdate.h>
> +#include <linux/ipmi.h>
>  #include <linux/ipmi_smi.h>
>  #include <asm/io.h>
>  #include "ipmi_si_sm.h"
> @@ -107,10 +108,6 @@ enum si_type {
>  };
>  static char *si_to_str[] = { "kcs", "smic", "bt" };
>  
> -enum ipmi_addr_src {
> -	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
> -	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> -};
>  static char *ipmi_addr_src_to_str[] = { NULL, "hotmod", "hardcoded", "SPMI",
>  					"ACPI", "SMBIOS", "PCI",
>  					"device-tree", "default" };
> @@ -291,6 +288,7 @@ struct smi_info {
>  	struct task_struct *thread;
>  
>  	struct list_head link;
> +	struct ipmi_smi_info smi_data;
>  };
>  
>  #define smi_inc_stat(smi, stat) \
> @@ -1186,6 +1184,22 @@ static int smi_start_processing(void       *send_info,
>  	return 0;
>  }
>  
> +static int get_smi_info(void *send_info,
> +			enum ipmi_addr_src type,
> +			struct ipmi_smi_info **data)
> +{
> +	struct smi_info *new_smi = send_info;
> +	struct ipmi_smi_info *smi_data = &new_smi->smi_data;
> +
> +	if (new_smi->addr_source != type)
> +		return -EINVAL;
> +
> +	smi_data->addr_src = type;
> +
> +	*data = smi_data;
> +	return 0;
> +}
> +
>  static void set_maintenance_mode(void *send_info, int enable)
>  {
>  	struct smi_info   *smi_info = send_info;
> @@ -1197,6 +1211,7 @@ static void set_maintenance_mode(void *send_info, int enable)
>  static struct ipmi_smi_handlers handlers = {
>  	.owner                  = THIS_MODULE,
>  	.start_processing       = smi_start_processing,
> +	.get_smi_info		= get_smi_info,
>  	.sender			= sender,
>  	.request_events		= request_events,
>  	.set_maintenance_mode   = set_maintenance_mode,
> @@ -2143,6 +2158,8 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
>  		return -ENOMEM;
>  
>  	info->addr_source = SI_ACPI;
> +	info->smi_data.smi_info.acpi_info.acpi_handle =
> +				acpi_dev->handle;
>  	printk(KERN_INFO PFX "probing via ACPI\n");
>  
>  	handle = acpi_dev->handle;
> @@ -3092,6 +3109,7 @@ static int try_smi_init(struct smi_info *new_smi)
>  {
>  	int rv = 0;
>  	int i;
> +	struct ipmi_smi_info *smi_data = &new_smi->smi_data;
>  
>  	printk(KERN_INFO PFX "Trying %s-specified %s state"
>  	       " machine at %s address 0x%lx, slave address 0x%x,"
> @@ -3217,6 +3235,8 @@ static int try_smi_init(struct smi_info *new_smi)
>  		new_smi->dev_registered = 1;
>  	}
>  
> +	smi_data->dev = new_smi->dev;
> +
>  	rv = ipmi_register_smi(&handlers,
>  			       new_smi,
>  			       &new_smi->device_id,
> diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
> index 65aae34..1ce428f 100644
> --- a/include/linux/ipmi.h
> +++ b/include/linux/ipmi.h
> @@ -454,6 +454,29 @@ unsigned int ipmi_addr_length(int addr_type);
>  /* Validate that the given IPMI address is valid. */
>  int ipmi_validate_addr(struct ipmi_addr *addr, int len);
>  
> +enum ipmi_addr_src {
> +	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
> +	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> +};
> +struct ipmi_smi_info{
> +	enum ipmi_addr_src addr_src;
> +	struct device *dev;
> +	union {
> +		/*
> +		 * Now only SI_ACPI info is provided. If the info is required
> +		 * for other type, please add it
> +		 */
> +#ifdef CONFIG_ACPI
> +		struct {
> +			void *acpi_handle;
> +		} acpi_info;
> +#endif
> +	} smi_info;
> +};
> +
> +/* This is to get the private info of ipmi_smi_t. The pointer is returned */
> +extern int ipmi_get_smi_info(int if_num, enum ipmi_addr_src type,
> +		struct ipmi_smi_info **data);
>  #endif /* __KERNEL__ */
>  
> 
> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> index 4b48318..bfa8f40 100644
> --- a/include/linux/ipmi_smi.h
> +++ b/include/linux/ipmi_smi.h
> @@ -86,6 +86,17 @@ struct ipmi_smi_handlers {
>  	int (*start_processing)(void       *send_info,
>  				ipmi_smi_t new_intf);
>  
> +	/*
> +	 * Get the detailed private info of the low level interface and return
> +	 * the corresponding pointer.
> +	 * For example: the ACPI device handle will be returned for the
> +	 * pnp_acpi IPMI device. Of course it will firstly compare the
> +	 * interface type of low-level interface(Hardcoded type, DMI,
> +	 * ACPI and so on). If the type doesn't match, it will return -EINVAL.
> +	 */
> +	int (*get_smi_info)(void *send_info, enum ipmi_addr_src type,
> +				struct ipmi_smi_info **data);
> +
>  	/* Called to enqueue an SMI message to be sent.  This
>  	   operation is not allowed to fail.  If an error occurs, it
>  	   should report back the error in a received message.  It may

