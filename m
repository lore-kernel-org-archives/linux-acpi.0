From: Corey Minyard <minyard@acm.org>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to
 get more info of low-level IPMI device
Date: Wed, 27 Oct 2010 11:13:30 -0500
Message-ID: <4CC84FAA.9040401@acm.org>
References: <1288084454-560-1-git-send-email-yakui.zhao@intel.com>
	<1288084454-560-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-reply-to: <1288084454-560-2-git-send-email-yakui.zhao@intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

I think you miss the point of a refcount.  The refcount is to keep the 
data structure around even if the device has gone away, so that any 
users may not crash.  Just having a counter in the IPMI structure and 
then decrementing the device refcount is not going to accomplish anything.

And you don't really need to refcount the IPMI structure.  (And if you 
did, you would need to use a refcount structure and you would need to 
keep from freeing the IPMI structure until the refcount went to zero.)  
You just need to increment the refcount on the device structure, and 
whoever gets the device structure needs to be responsible for 
decrementing it's refcount.

I'd also prefer to not have a struct ipmi_smi_info in the IPMI data 
structure.  Just pull the data from existing sources.

-corey

On 10/26/2010 04:14 AM, yakui.zhao@intel.com wrote:
> From: Zhao Yakui<yakui.zhao@intel.com>
>
> The IPMI smi_watcher will be used to catch the IPMI interface as they come or go.
> In order to communicate with the correct IPMI device, it should be confirmed
>   whether it is what we wanted especially on the system with multiple IPMI
> devices. But the new_smi callback function of smi_watcher provides very
> limited info(only the interface number and dev pointer) and there is no
> detailed info about the low level interface. For example: which mechansim
> registers the IPMI interface(ACPI, PCI, DMI and so on).
>
> This is to add one interface that can get more info of low-level IPMI
> device. For example: the ACPI device handle will be returned for the pnp_acpi
> IPMI device.
>
> Signed-off-by: Zhao Yakui<yakui.zhao@intel.com>
> ---
>   drivers/char/ipmi/ipmi_msghandler.c |   46 ++++++++++++++++++++++++++++++++
>   drivers/char/ipmi/ipmi_si_intf.c    |   49 +++++++++++++++++++++++++++++++---
>   include/linux/ipmi.h                |   29 ++++++++++++++++++++
>   include/linux/ipmi_smi.h            |    8 +++++
>   4 files changed, 127 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 4f3f8c9..e323edb 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -970,6 +970,52 @@ out_kfree:
>   }
>   EXPORT_SYMBOL(ipmi_create_user);
>
> +int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
> +{
> +	int           rv = 0;
> +	ipmi_smi_t    intf;
> +	struct ipmi_smi_handlers *handlers;
> +
> +	mutex_lock(&ipmi_interfaces_mutex);
> +	list_for_each_entry_rcu(intf,&ipmi_interfaces, link) {
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
> +	rv = handlers->get_smi_info(intf->send_info, data);
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +
> +	return rv;
> +}
> +EXPORT_SYMBOL(ipmi_get_smi_info);
> +
> +void ipmi_put_smi_info(int if_num)
> +{
> +	ipmi_smi_t    intf;
> +	struct ipmi_smi_handlers *handlers;
> +
> +	mutex_lock(&ipmi_interfaces_mutex);
> +	list_for_each_entry_rcu(intf,&ipmi_interfaces, link) {
> +		if (intf->intf_num == if_num)
> +			goto found;
> +	}
> +	/* Not found, return */
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +	return;
> +
> +found:
> +	handlers = intf->handlers;
> +	handlers->put_smi_info(intf->send_info);
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +}
> +EXPORT_SYMBOL(ipmi_put_smi_info);
> +
>   static void free_user(struct kref *ref)
>   {
>   	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 7bd7c45..d313018 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -57,6 +57,7 @@
>   #include<asm/irq.h>
>   #include<linux/interrupt.h>
>   #include<linux/rcupdate.h>
> +#include<linux/ipmi.h>
>   #include<linux/ipmi_smi.h>
>   #include<asm/io.h>
>   #include "ipmi_si_sm.h"
> @@ -107,10 +108,6 @@ enum si_type {
>   };
>   static char *si_to_str[] = { "kcs", "smic", "bt" };
>
> -enum ipmi_addr_src {
> -	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
> -	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> -};
>   static char *ipmi_addr_src_to_str[] = { NULL, "hotmod", "hardcoded", "SPMI",
>   					"ACPI", "SMBIOS", "PCI",
>   					"device-tree", "default" };
> @@ -291,6 +288,12 @@ struct smi_info {
>   	struct task_struct *thread;
>
>   	struct list_head link;
> +	/*
> +	 * Count the refcount of smi_data->dev related with the function
> +	 * of ipmi_get_smi_info/ipmi_put_smi_info.
> +	 */
> +	atomic_t	smi_info_ref;
> +	struct ipmi_smi_info smi_data;
>   };
>
>   #define smi_inc_stat(smi, stat) \
> @@ -1186,6 +1189,27 @@ static int smi_start_processing(void       *send_info,
>   	return 0;
>   }
>
> +static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
> +{
> +	struct smi_info *new_smi = send_info;
> +	struct ipmi_smi_info *smi_data =&new_smi->smi_data;
> +
> +	get_device(new_smi->dev);
> +	memcpy(data, smi_data, sizeof(*smi_data));
> +	smi_data->addr_src = new_smi->addr_source;
> +	atomic_inc(&new_smi->smi_info_ref);
> +
> +	return 0;
> +}
> +
> +static void put_smi_info(void *send_info)
> +{
> +	struct smi_info *new_smi = send_info;
> +
> +	put_device(new_smi->dev);
> +	atomic_dec(&new_smi->smi_info_ref);
> +}
> +
>   static void set_maintenance_mode(void *send_info, int enable)
>   {
>   	struct smi_info   *smi_info = send_info;
> @@ -1197,6 +1221,8 @@ static void set_maintenance_mode(void *send_info, int enable)
>   static struct ipmi_smi_handlers handlers = {
>   	.owner                  = THIS_MODULE,
>   	.start_processing       = smi_start_processing,
> +	.get_smi_info		= get_smi_info,
> +	.put_smi_info		= put_smi_info,
>   	.sender			= sender,
>   	.request_events		= request_events,
>   	.set_maintenance_mode   = set_maintenance_mode,
> @@ -2143,6 +2169,8 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
>   		return -ENOMEM;
>
>   	info->addr_source = SI_ACPI;
> +	info->smi_data.addr_info.acpi_info.acpi_handle =
> +				acpi_dev->handle;
>   	printk(KERN_INFO PFX "probing via ACPI\n");
>
>   	handle = acpi_dev->handle;
> @@ -3092,6 +3120,7 @@ static int try_smi_init(struct smi_info *new_smi)
>   {
>   	int rv = 0;
>   	int i;
> +	struct ipmi_smi_info *smi_data;
>
>   	printk(KERN_INFO PFX "Trying %s-specified %s state"
>   	       " machine at %s address 0x%lx, slave address 0x%x,"
> @@ -3255,6 +3284,9 @@ static int try_smi_init(struct smi_info *new_smi)
>
>   	dev_info(new_smi->dev, "IPMI %s interface initialized\n",
>   		 si_to_str[new_smi->si_type]);
> +	smi_data =&new_smi->smi_data;
> +	smi_data->dev = new_smi->dev;
> +	atomic_set(&new_smi->smi_info_ref, 0);
>
>   	return 0;
>
> @@ -3501,7 +3533,14 @@ static void cleanup_one_si(struct smi_info *to_clean)
>   		printk(KERN_ERR PFX "Unable to unregister device: errno=%d\n",
>   		       rv);
>   	}
> -
> +	/* maybe the caller doesn't release the refcount of dev, which is
> +	 * increased by calling the function of ipmi_get_smi_info. So try
> +	 * to help it.
> +	 */
> +	while (atomic_read(&to_clean->smi_info_ref)) {
> +		put_device(to_clean->dev);
> +		atomic_dec(&to_clean->smi_info_ref);
> +	}
>   	if (to_clean->handlers)
>   		to_clean->handlers->cleanup(to_clean->si_sm);
>
> diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
> index 65aae34..9a0c72e 100644
> --- a/include/linux/ipmi.h
> +++ b/include/linux/ipmi.h
> @@ -454,6 +454,35 @@ unsigned int ipmi_addr_length(int addr_type);
>   /* Validate that the given IPMI address is valid. */
>   int ipmi_validate_addr(struct ipmi_addr *addr, int len);
>
> +enum ipmi_addr_src {
> +	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
> +	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> +};
> +struct ipmi_smi_info {
> +	enum ipmi_addr_src addr_src;
> +	struct device *dev;
> +	/*
> +	 * The addr_info can provide more detailed info of one IPMI device.
> +	 * Now only SI_ACPI info is provided. And it depends on the SI_ACPI
> +	 * address type. If the info is required for other address type, please
> +	 * add it.
> +	 */
> +	union {
> +		/* the acpi_info element is defined for the SI_ACPI
> +		 * address type
> +		 */
> +		struct {
> +			void *acpi_handle;
> +		} acpi_info;
> +	} addr_info;
> +};
> +
> +/* This is to get the private info of ipmi_smi_t */
> +extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data);
> +/* This is to decrease refcount of dev added in the function of
> + * ipmi_get_smi_info
> + */
> +extern void ipmi_put_smi_info(int if_num);
>   #endif /* __KERNEL__ */
>
>
> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> index 4b48318..b99942d 100644
> --- a/include/linux/ipmi_smi.h
> +++ b/include/linux/ipmi_smi.h
> @@ -86,6 +86,14 @@ struct ipmi_smi_handlers {
>   	int (*start_processing)(void       *send_info,
>   				ipmi_smi_t new_intf);
>
> +	/*
> +	 * Get the detailed private info of the low level interface and store
> +	 * it into the structure of ipmi_smi_data. For example: the
> +	 * ACPI device handle will be returned for the pnp_acpi IPMI device.
> +	 */
> +	int (*get_smi_info)(void *send_info, struct ipmi_smi_info *data);
> +
> +	void (*put_smi_info)(void *send_info);
>   	/* Called to enqueue an SMI message to be sent.  This
>   	   operation is not allowed to fail.  If an error occurs, it
>   	   should report back the error in a received message.  It may
>    


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
