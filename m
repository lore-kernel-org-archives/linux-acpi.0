From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Tue, 27 Oct 2009 16:59:51 +0900
Message-ID: <4AE6A877.3090502@jp.fujitsu.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52340 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbZJ0IAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 04:00:06 -0400
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id n9R80AEI011632
	for <linux-acpi@vger.kernel.org> (envelope-from kaneshige.kenji@jp.fujitsu.com);
	Tue, 27 Oct 2009 17:00:10 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id B001B45DE51
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:09 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BC7D45DE4C
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:09 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B0881DB803C
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:07 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id F24541DB805A
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:03 +0900 (JST)
In-Reply-To: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Looks good.

Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Shaohua Li wrote:
> Add an API to execute _OSC. A lot of devices can have this method, so add a
> generic API.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/bus.c   |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |    9 ++++++
>  2 files changed, 81 insertions(+)
> 
> Index: linux/drivers/acpi/bus.c
> ===================================================================
> --- linux.orig/drivers/acpi/bus.c	2009-10-27 13:50:24.000000000 +0800
> +++ linux/drivers/acpi/bus.c	2009-10-27 14:02:30.000000000 +0800
> @@ -344,6 +344,78 @@ bool acpi_bus_can_wakeup(acpi_handle han
>  
>  EXPORT_SYMBOL(acpi_bus_can_wakeup);
>  
> +acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
> +{
> +	acpi_status status;
> +	struct acpi_object_list input;
> +	union acpi_object in_params[4];
> +	union acpi_object *out_obj;
> +	u32 errors;
> +
> +	if (!context)
> +		return AE_ERROR;
> +	context->ret.length = ACPI_ALLOCATE_BUFFER;
> +	context->ret.pointer = NULL;
> +
> +	/* Setting up input parameters */
> +	input.count = 4;
> +	input.pointer = in_params;
> +	in_params[0].type 		= ACPI_TYPE_BUFFER;
> +	in_params[0].buffer.length 	= 16;
> +	in_params[0].buffer.pointer	= context->uuid;
> +	in_params[1].type 		= ACPI_TYPE_INTEGER;
> +	in_params[1].integer.value 	= context->rev;
> +	in_params[2].type 		= ACPI_TYPE_INTEGER;
> +	in_params[2].integer.value	= context->cap.length/sizeof(u32);
> +	in_params[3].type		= ACPI_TYPE_BUFFER;
> +	in_params[3].buffer.length 	= context->cap.length;
> +	in_params[3].buffer.pointer 	= context->cap.pointer;
> +
> +	status = acpi_evaluate_object(handle, "_OSC", &input, &context->ret);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	/* return buffer should have the same length as cap buffer */
> +	if (context->ret.length != context->cap.length)
> +		return AE_NULL_OBJECT;
> +
> +	out_obj = context->ret.pointer;
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
> +		status = AE_TYPE;
> +		goto out_kfree;
> +	}
> +	/* Need to ignore the bit0 in result code */
> +	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> +	if (errors) {
> +		if (errors & OSC_REQUEST_ERROR)
> +			printk(KERN_DEBUG "_OSC request failed\n");
> +		if (errors & OSC_INVALID_UUID_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid UUID\n");
> +		if (errors & OSC_INVALID_REVISION_ERROR)
> +			printk(KERN_DEBUG "_OSC invalid revision\n");
> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> +			if (((u32 *)context->cap.pointer)[OSC_QUERY_TYPE]
> +			    & OSC_QUERY_ENABLE)
> +				goto out_success;
> +			printk(KERN_DEBUG
> +			       "Firmware did not grant requested _OSC control\n");
> +			status = AE_SUPPORT;
> +			goto out_kfree;
> +		}
> +		status = AE_ERROR;
> +		goto out_kfree;
> +	}
> +out_success:
> +	return AE_OK;
> +
> +out_kfree:
> +	kfree(context->ret.pointer);
> +	context->ret.pointer = NULL;
> +	return status;
> +}
> +EXPORT_SYMBOL(acpi_run_osc);
> +
>  /* --------------------------------------------------------------------------
>                                  Event Management
>     -------------------------------------------------------------------------- */
> Index: linux/include/linux/acpi.h
> ===================================================================
> --- linux.orig/include/linux/acpi.h	2009-10-27 13:50:24.000000000 +0800
> +++ linux/include/linux/acpi.h	2009-10-27 13:50:35.000000000 +0800
> @@ -253,6 +253,13 @@ void __init acpi_old_suspend_ordering(vo
>  void __init acpi_s4_no_nvs(void);
>  #endif /* CONFIG_PM_SLEEP */
>  
> +struct acpi_osc_context {
> +	u8 *uuid;
> +	int rev;
> +	struct acpi_buffer cap; /* arg2/arg3 */
> +	struct acpi_buffer ret; /* free by caller if success */
> +};
> +
>  #define OSC_QUERY_TYPE			0
>  #define OSC_SUPPORT_TYPE 		1
>  #define OSC_CONTROL_TYPE		2
> @@ -265,6 +272,8 @@ void __init acpi_s4_no_nvs(void);
>  #define OSC_INVALID_REVISION_ERROR	8
>  #define OSC_CAPABILITIES_MASK_ERROR	16
>  
> +acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
> +
>  /* _OSC DW1 Definition (OS Support Fields) */
>  #define OSC_EXT_PCI_CONFIG_SUPPORT		1
>  #define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


