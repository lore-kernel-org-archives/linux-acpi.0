From: Corey Minyard <minyard@acm.org>
Subject: Re: [RFC PATCH 1/2_v9] IPMI: Add one interface to get more info of
 low-level IPMI device
Date: Mon, 27 Sep 2010 08:27:27 -0500
Message-ID: <4CA09BBF.9040507@acm.org>
References: <1284537980-10094-1-git-send-email-yakui.zhao@intel.com>
 <1284537980-10094-2-git-send-email-yakui.zhao@intel.com>
 <1285551253.3776.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:58973 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0I0N1r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Sep 2010 09:27:47 -0400
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9E00LJ5QPSFH70@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 27 Sep 2010 08:27:28 -0500 (CDT)
In-reply-to: <1285551253.3776.4.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On 09/26/2010 08:34 PM, ykzhao wrote:
> On Wed, 2010-09-15 at 16:06 +0800, Zhao, Yakui wrote:
>    
>> From: Zhao Yakui<yakui.zhao@intel.com>
>>
>> The IPMI smi_watcher will be used to catch the IPMI interface as they come or go.
>> In order to communicate with the correct IPMI device, it should be confirmed
>>   whether it is what we wanted especially on the system with multiple IPMI
>> devices. But the new_smi callback function of smi_watcher provides very
>> limited info(only the interface number and dev pointer) and there is no
>> detailed info about the low level interface. For example: which mechanism
>> registers the IPMI interface(ACPI, PCI, DMI and so on).
>>
>> This is to add one interface that can get more info of low-level IPMI
>> device. For example: the ACPI device handle will be returned for the pnp_acpi
>> IPMI device.
>>      
> Hi, Corey
> 	
> 	Any comment about this patch? Does the interface make sense?
>    
Well, not exactly.  I think you have things in the right places, but the 
actual design of the interface has some issues.

+enum ipmi_addr_src {
+	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
+	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
+};
+union ipmi_smi_data{
+	/* If the other type of data is required, please add it	 */
+	u8 data[16];
+	struct {
+		void *acpi_handle;
+		struct device *dev;
+	} acpi_data;
+};

There's no value in providing a union of this type.  Plus you call it 
"ipmi_smi_data" and the function is get_smi_info.  I've learned that 
consistency is a good thing.

The address source and device are fairly universal, and the address 
source can be used as a key for the other stuff, so I think the 
following makes more sense.  Just:

struct ipmi_smi_info
{
         enum ipmi_addr_src add_src;
         struct device *dev;

         union {
                 struct {
                         acpi_handle acpi_handle;
                 } acpi_addr_info;
         } addr_info;
};

In the future, if more information is needed, it can be added to the 
structure.  Since there's no guarantee of a stable binary interface, no 
need for the character array.

You will also need ifdefs in here for ACPI, includes so acpi_handle is 
available, and you need to decide  how to do refcounts on "dev" and 
document that.

-corey

> Thanks.
>    
>> Signed-off-by: Zhao Yakui<yakui.zhao@intel.com>
>> ---
>> In this patch only the info of pnp_acpi IPMI is provided. If the detailed info
>> is also required for other mechanism, we can redesign the structure of
>> ipmi_smi_data and fill it correctly.
>>
>>   drivers/char/ipmi/ipmi_msghandler.c |   26 ++++++++++++++++++++++++++
>>   drivers/char/ipmi/ipmi_si_intf.c    |   24 ++++++++++++++++++++----
>>   include/linux/ipmi.h                |   16 ++++++++++++++++
>>   include/linux/ipmi_smi.h            |   11 +++++++++++
>>   4 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>> index 4f3f8c9..f82d426 100644
>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>> @@ -970,6 +970,32 @@ out_kfree:
>>   }
>>   EXPORT_SYMBOL(ipmi_create_user);
>>
>> +int ipmi_get_smi_info(int if_num, enum ipmi_addr_src type,
>> +			union ipmi_smi_data *data)
>> +{
>> +	int           rv = 0;
>> +	ipmi_smi_t    intf;
>> +	struct ipmi_smi_handlers *handlers;
>> +
>> +	mutex_lock(&ipmi_interfaces_mutex);
>> +	list_for_each_entry_rcu(intf,&ipmi_interfaces, link) {
>> +		if (intf->intf_num == if_num)
>> +			goto found;
>> +	}
>> +	/* Not found, return an error */
>> +	rv = -EINVAL;
>> +	mutex_unlock(&ipmi_interfaces_mutex);
>> +	return rv;
>> +
>> +found:
>> +	handlers = intf->handlers;
>> +	rv = handlers->get_smi_info(intf->send_info, type, data);
>> +	mutex_unlock(&ipmi_interfaces_mutex);
>> +
>> +	return rv;
>> +}
>> +EXPORT_SYMBOL(ipmi_get_smi_info);
>> +
>>   static void free_user(struct kref *ref)
>>   {
>>   	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>> index 3822b4f..ebb87b4 100644
>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -57,6 +57,7 @@
>>   #include<asm/irq.h>
>>   #include<linux/interrupt.h>
>>   #include<linux/rcupdate.h>
>> +#include<linux/ipmi.h>
>>   #include<linux/ipmi_smi.h>
>>   #include<asm/io.h>
>>   #include "ipmi_si_sm.h"
>> @@ -107,10 +108,6 @@ enum si_type {
>>   };
>>   static char *si_to_str[] = { "kcs", "smic", "bt" };
>>
>> -enum ipmi_addr_src {
>> -	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
>> -	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
>> -};
>>   static char *ipmi_addr_src_to_str[] = { NULL, "hotmod", "hardcoded", "SPMI",
>>   					"ACPI", "SMBIOS", "PCI",
>>   					"device-tree", "default" };
>> @@ -291,6 +288,7 @@ struct smi_info {
>>   	struct task_struct *thread;
>>
>>   	struct list_head link;
>> +	union ipmi_smi_data smi_data;
>>   };
>>
>>   #define smi_inc_stat(smi, stat) \
>> @@ -1183,6 +1181,21 @@ static int smi_start_processing(void       *send_info,
>>   	return 0;
>>   }
>>
>> +static int get_smi_info(void *send_info,
>> +			enum ipmi_addr_src type,
>> +			union ipmi_smi_data *data)
>> +{
>> +	struct smi_info *new_smi = send_info;
>> +	union ipmi_smi_data *smi_data =&new_smi->smi_data;
>> +
>> +	if (new_smi->addr_source != type)
>> +		return -EINVAL;
>> +
>> +	memcpy(data, smi_data, sizeof(*smi_data));
>> +
>> +	return 0;
>> +}
>> +
>>   static void set_maintenance_mode(void *send_info, int enable)
>>   {
>>   	struct smi_info   *smi_info = send_info;
>> @@ -1194,6 +1207,7 @@ static void set_maintenance_mode(void *send_info, int enable)
>>   static struct ipmi_smi_handlers handlers = {
>>   	.owner                  = THIS_MODULE,
>>   	.start_processing       = smi_start_processing,
>> +	.get_smi_info		= get_smi_info,
>>   	.sender			= sender,
>>   	.request_events		= request_events,
>>   	.set_maintenance_mode   = set_maintenance_mode,
>> @@ -2140,6 +2154,8 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
>>   		return -ENOMEM;
>>
>>   	info->addr_source = SI_ACPI;
>> +	info->smi_data.acpi_data.acpi_handle = acpi_dev->handle;
>> +	info->smi_data.acpi_data.dev =&dev->dev;
>>   	printk(KERN_INFO PFX "probing via ACPI\n");
>>
>>   	handle = acpi_dev->handle;
>> diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
>> index 65aae34..04e4a90 100644
>> --- a/include/linux/ipmi.h
>> +++ b/include/linux/ipmi.h
>> @@ -454,6 +454,22 @@ unsigned int ipmi_addr_length(int addr_type);
>>   /* Validate that the given IPMI address is valid. */
>>   int ipmi_validate_addr(struct ipmi_addr *addr, int len);
>>
>> +enum ipmi_addr_src {
>> +	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
>> +	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
>> +};
>> +union ipmi_smi_data{
>> +	/* If the other type of data is required, please add it	 */
>> +	u8 data[16];
>> +	struct {
>> +		void *acpi_handle;
>> +		struct device *dev;
>> +	} acpi_data;
>> +};
>> +
>> +/* This is to get the private info of ipmi_smi_t */
>> +extern int ipmi_get_smi_info(int if_num, enum ipmi_addr_src type,
>> +		union ipmi_smi_data *data);
>>   #endif /* __KERNEL__ */
>>
>>
>> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
>> index 4b48318..d5bae83 100644
>> --- a/include/linux/ipmi_smi.h
>> +++ b/include/linux/ipmi_smi.h
>> @@ -86,6 +86,17 @@ struct ipmi_smi_handlers {
>>   	int (*start_processing)(void       *send_info,
>>   				ipmi_smi_t new_intf);
>>
>> +	/*
>> +	 * Get the detailed private info of the low level interface and store
>> +	 * it into the union structure of ipmi_smi_data. For example: the
>> +	 * ACPI device handle will be returned for the pnp_acpi IPMI device.
>> +	 * Of course it will firstly compare the interface type of low-level
>> +	 * interface(Hardcoded type, DMI, ACPI and so on). If the type doesn't
>> +	 * match, it will return -EINVAL.
>> +	 */
>> +	int (*get_smi_info)(void *send_info, enum ipmi_addr_src type,
>> +				union ipmi_smi_data *data);
>> +
>>   	/* Called to enqueue an SMI message to be sent.  This
>>   	   operation is not allowed to fail.  If an error occurs, it
>>   	   should report back the error in a received message.  It may
>>      
>    

