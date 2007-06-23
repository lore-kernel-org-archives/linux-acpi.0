From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI EC: Add support for non-AML EC query handlers
Date: Sat, 23 Jun 2007 16:07:22 -0400
Message-ID: <200706231607.22872.lenb@kernel.org>
References: <20070529123823.20303.55101.stgit@z61m> <20070529124302.20303.99116.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55293 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbXFWUHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Jun 2007 16:07:33 -0400
In-Reply-To: <20070529124302.20303.99116.stgit@z61m>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org

What is the benefit of this patch?
(it would be good to say in the check-in comments...hint hint)

Also, if you want your git commit author tag to be
"Alexey Starikovskiy <astarikovskiy@suse.de>" as you mentioned earlier,
then this would be a good time to cut over to sending patches From
and signed-off-by that address.

thanks,
-Len

On Tuesday 29 May 2007 08:43, Alexey Starikovskiy wrote:
> Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
> ---
> 
>  drivers/acpi/ec.c |  175 ++++++++++++++++++++++++++++++++++++++---------------
>  1 files changed, 125 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index ffb8361..10e8510 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -34,6 +34,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/interrupt.h>
> +#include <linux/list.h>
>  #include <asm/io.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> @@ -43,6 +44,7 @@
>  #define ACPI_EC_HID			"PNP0C09"
>  #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
>  #define ACPI_EC_FILE_INFO		"info"
> +
>  #undef PREFIX
>  #define PREFIX				"ACPI: EC: "
>  
> @@ -60,6 +62,7 @@ enum ec_command {
>  	ACPI_EC_BURST_DISABLE = 0x83,
>  	ACPI_EC_COMMAND_QUERY = 0x84,
>  };
> +
>  /* EC events */
>  enum ec_event {
>  	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
> @@ -93,6 +96,16 @@ static struct acpi_driver acpi_ec_driver = {
>  
>  /* If we find an EC via the ECDT, we need to keep a ptr to its context */
>  /* External interfaces use first EC only, so remember */
> +typedef int (*acpi_ec_query_func) (void *data);
> +
> +struct acpi_ec_query_handler {
> +	struct list_head node;
> +	acpi_ec_query_func func;
> +	acpi_handle handle;
> +	void *data;
> +	u8 query_bit;
> +};
> +
>  static struct acpi_ec {
>  	acpi_handle handle;
>  	unsigned long gpe;
> @@ -103,6 +116,7 @@ static struct acpi_ec {
>  	atomic_t query_pending;
>  	atomic_t event_count;
>  	wait_queue_head_t wait;
> +	struct list_head list;
>  } *boot_ec, *first_ec;
>  
>  /* --------------------------------------------------------------------------
> @@ -393,21 +407,67 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
>  /* --------------------------------------------------------------------------
>                                  Event Management
>     -------------------------------------------------------------------------- */
> +int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
> +			      acpi_handle handle, acpi_ec_query_func func,
> +			      void *data)
> +{
> +	struct acpi_ec_query_handler *handler =
> +	    kzalloc(sizeof(struct acpi_ec_query_handler), GFP_KERNEL);
> +	if (!handler)
> +		return -ENOMEM;
> +
> +	handler->query_bit = query_bit;
> +	handler->handle = handle;
> +	handler->func = func;
> +	handler->data = data;
> +	mutex_lock(&ec->lock);
> +	list_add_tail(&handler->node, &ec->list);
> +	mutex_unlock(&ec->lock);
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
> +
> +void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
> +{
> +	struct acpi_ec_query_handler *handler;
> +	mutex_lock(&ec->lock);
> +	list_for_each_entry(handler, &ec->list, node) {
> +		if (query_bit == handler->query_bit) {
> +			list_del(&handler->node);
> +			kfree(handler);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ec->lock);
> +}
> +
> +EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
>  
>  static void acpi_ec_gpe_query(void *ec_cxt)
>  {
>  	struct acpi_ec *ec = ec_cxt;
>  	u8 value = 0;
> -	char object_name[8];
> +	struct acpi_ec_query_handler *handler, copy;
>  
>  	if (!ec || acpi_ec_query(ec, &value))
>  		return;
> -
> -	snprintf(object_name, 8, "_Q%2.2X", value);
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s", object_name));
> -
> -	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
> +	mutex_lock(&ec->lock);
> +	list_for_each_entry(handler, &ec->list, node) {
> +		if (value == handler->query_bit) {
> +			/* have custom handler for this bit */
> +			memcpy(&copy, handler, sizeof(copy));
> +			mutex_unlock(&ec->lock);
> +			if (copy.func) {
> +				copy.func(copy.data);
> +			} else if (copy.handle) {
> +				acpi_evaluate_object(copy.handle, NULL, NULL, NULL);
> +			}
> +			return;
> +		}
> +	}
> +	mutex_unlock(&ec->lock);
> +	printk(KERN_ERR PREFIX "Handler for query 0x%x is not found!\n", value);
>  }
>  
>  static u32 acpi_ec_gpe_handler(void *data)
> @@ -426,8 +486,7 @@ static u32 acpi_ec_gpe_handler(void *data)
>  	if ((value & ACPI_EC_FLAG_SCI) && !atomic_read(&ec->query_pending)) {
>  		atomic_set(&ec->query_pending, 1);
>  		status =
> -		    acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query,
> -				    ec);
> +		    acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
>  	}
>  
>  	return status == AE_OK ?
> @@ -574,9 +633,6 @@ static int acpi_ec_remove_fs(struct acpi_device *device)
>  static acpi_status
>  ec_parse_io_ports(struct acpi_resource *resource, void *context);
>  
> -static acpi_status
> -ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval);
> -
>  static struct acpi_ec *make_acpi_ec(void)
>  {
>  	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
> @@ -587,13 +643,52 @@ static struct acpi_ec *make_acpi_ec(void)
>  	atomic_set(&ec->event_count, 1);
>  	mutex_init(&ec->lock);
>  	init_waitqueue_head(&ec->wait);
> +	INIT_LIST_HEAD(&ec->list);
>  
>  	return ec;
>  }
>  
> +static acpi_status
> +acpi_ec_register_query_methods(acpi_handle handle, u32 level,
> +			       void *context, void **return_value)
> +{
> +	struct acpi_namespace_node *node = handle;
> +	struct acpi_ec *ec = context;
> +	int value = 0;
> +	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
> +		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
> +	}
> +	return AE_OK;
> +}
> +
> +static int ec_parse_device(struct acpi_ec *ec, acpi_handle handle)
> +{
> +	if (ACPI_FAILURE(acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     ec_parse_io_ports, ec)))
> +		return -EINVAL;
> +
> +	/* Get GPE bit assignment (EC events). */
> +	/* TODO: Add support for _GPE returning a package */
> +	if (ACPI_FAILURE(acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe)))
> +		return -EINVAL;
> +
> +	/* Use the global lock for all EC transactions? */
> +	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
> +
> +	/* Find and register all query methods */
> +	acpi_walk_namespace(ACPI_TYPE_METHOD, handle, 1,
> +			    acpi_ec_register_query_methods, ec, NULL);
> +
> +	ec->handle = handle;
> +
> +	printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx",
> +			  ec->gpe, ec->command_addr, ec->data_addr);
> +
> +	return 0;
> +}
> +
>  static int acpi_ec_add(struct acpi_device *device)
>  {
> -	acpi_status status = AE_OK;
>  	struct acpi_ec *ec = NULL;
>  
>  	if (!device)
> @@ -606,8 +701,7 @@ static int acpi_ec_add(struct acpi_device *device)
>  	if (!ec)
>  		return -ENOMEM;
>  
> -	status = ec_parse_device(device->handle, 0, ec, NULL);
> -	if (status != AE_CTRL_TERMINATE) {
> +	if (ec_parse_device(ec, device->handle)) {
>  		kfree(ec);
>  		return -EINVAL;
>  	}
> @@ -618,6 +712,8 @@ static int acpi_ec_add(struct acpi_device *device)
>  			/* We might have incorrect info for GL at boot time */
>  			mutex_lock(&boot_ec->lock);
>  			boot_ec->global_lock = ec->global_lock;
> +			/* Copy handlers from new ec into boot ec */
> +			list_splice(&ec->list, &boot_ec->list);
>  			mutex_unlock(&boot_ec->lock);
>  			kfree(ec);
>  			ec = boot_ec;
> @@ -628,18 +724,24 @@ static int acpi_ec_add(struct acpi_device *device)
>  	acpi_driver_data(device) = ec;
>  
>  	acpi_ec_add_fs(device);
> -
>  	return 0;
>  }
>  
>  static int acpi_ec_remove(struct acpi_device *device, int type)
>  {
>  	struct acpi_ec *ec;
> +	struct acpi_ec_query_handler *handler;
>  
>  	if (!device)
>  		return -EINVAL;
>  
>  	ec = acpi_driver_data(device);
> +	mutex_lock(&ec->lock);
> +	list_for_each_entry(handler, &ec->list, node) {
> +		list_del(&handler->node);
> +		kfree(handler);
> +	}
> +	mutex_unlock(&ec->lock);
>  	acpi_ec_remove_fs(device);
>  	acpi_driver_data(device) = NULL;
>  	if (ec == first_ec)
> @@ -695,15 +797,13 @@ static int ec_install_handlers(struct acpi_ec *ec)
>  		return -ENODEV;
>  	}
>  
> -	/* EC is fully operational, allow queries */
> -	atomic_set(&ec->query_pending, 0);
> -
>  	return 0;
>  }
>  
>  static int acpi_ec_start(struct acpi_device *device)
>  {
>  	struct acpi_ec *ec;
> +	int ret = 0;
>  
>  	if (!device)
>  		return -EINVAL;
> @@ -714,10 +814,13 @@ static int acpi_ec_start(struct acpi_device *device)
>  		return -EINVAL;
>  
>  	/* Boot EC is already working */
> -	if (ec == boot_ec)
> -		return 0;
> +	if (ec != boot_ec)
> +		ret = ec_install_handlers(ec);
> +
> +	/* EC is fully operational, allow queries */
> +	atomic_set(&ec->query_pending, 0);
>  
> -	return ec_install_handlers(ec);
> +	return ret;
>  }
>  
>  static int acpi_ec_stop(struct acpi_device *device, int type)
> @@ -749,34 +852,6 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
>  	return 0;
>  }
>  
> -static acpi_status
> -ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
> -{
> -	acpi_status status;
> -
> -	struct acpi_ec *ec = context;
> -	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> -				     ec_parse_io_ports, ec);
> -	if (ACPI_FAILURE(status))
> -		return status;
> -
> -	/* Get GPE bit assignment (EC events). */
> -	/* TODO: Add support for _GPE returning a package */
> -	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
> -	if (ACPI_FAILURE(status))
> -		return status;
> -
> -	/* Use the global lock for all EC transactions? */
> -	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
> -
> -	ec->handle = handle;
> -
> -	printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx",
> -			  ec->gpe, ec->command_addr, ec->data_addr);
> -
> -	return AE_CTRL_TERMINATE;
> -}
> -
>  int __init acpi_ec_ecdt_probe(void)
>  {
>  	int ret;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
