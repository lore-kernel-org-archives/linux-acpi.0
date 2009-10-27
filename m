From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 2/3] cleanup pci root _OSC
Date: Tue, 27 Oct 2009 17:00:19 +0900
Message-ID: <4AE6A893.7020301@jp.fujitsu.com>
References: <20091027063700.GB22237@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32978 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbZJ0IAe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 04:00:34 -0400
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id n9R80cnM005362
	for <linux-acpi@vger.kernel.org> (envelope-from kaneshige.kenji@jp.fujitsu.com);
	Tue, 27 Oct 2009 17:00:38 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AD9645DE4C
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:38 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 0956F45DE55
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:38 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id E47DBE18013
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:37 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 98C4C1DB8038
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 17:00:34 +0900 (JST)
In-Reply-To: <20091027063700.GB22237@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Looks good.

Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Shaohua Li wrote:
> Cleanup pci_root _OSC code.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/pci_root.c |   73 ++++++++----------------------------------------
>  include/linux/acpi.h    |    5 +--
>  2 files changed, 16 insertions(+), 62 deletions(-)
> 
> Index: linux/drivers/acpi/pci_root.c
> ===================================================================
> --- linux.orig/drivers/acpi/pci_root.c	2009-10-27 13:50:17.000000000 +0800
> +++ linux/drivers/acpi/pci_root.c	2009-10-27 14:03:17.000000000 +0800
> @@ -208,66 +208,19 @@ static u8 OSC_UUID[16] = {0x5B, 0x4D, 0x
>  static acpi_status acpi_pci_run_osc(acpi_handle handle,
>  				    const u32 *capbuf, u32 *retval)
>  {
> +	struct acpi_osc_context context = {
> +		.uuid = OSC_UUID,
> +		.rev = 1,
> +		.cap.length = 12,
> +		.cap.pointer = (void *)capbuf,
> +	};
>  	acpi_status status;
> -	struct acpi_object_list input;
> -	union acpi_object in_params[4];
> -	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> -	union acpi_object *out_obj;
> -	u32 errors;
> -
> -	/* Setting up input parameters */
> -	input.count = 4;
> -	input.pointer = in_params;
> -	in_params[0].type 		= ACPI_TYPE_BUFFER;
> -	in_params[0].buffer.length 	= 16;
> -	in_params[0].buffer.pointer	= OSC_UUID;
> -	in_params[1].type 		= ACPI_TYPE_INTEGER;
> -	in_params[1].integer.value 	= 1;
> -	in_params[2].type 		= ACPI_TYPE_INTEGER;
> -	in_params[2].integer.value	= 3;
> -	in_params[3].type		= ACPI_TYPE_BUFFER;
> -	in_params[3].buffer.length 	= 12;
> -	in_params[3].buffer.pointer 	= (u8 *)capbuf;
>  
> -	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
> -	if (ACPI_FAILURE(status))
> -		return status;
> -
> -	if (!output.length)
> -		return AE_NULL_OBJECT;
> -
> -	out_obj = output.pointer;
> -	if (out_obj->type != ACPI_TYPE_BUFFER) {
> -		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
> -		status = AE_TYPE;
> -		goto out_kfree;
> -	}
> -	/* Need to ignore the bit0 in result code */
> -	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> -	if (errors) {
> -		if (errors & OSC_REQUEST_ERROR)
> -			printk(KERN_DEBUG "_OSC request failed\n");
> -		if (errors & OSC_INVALID_UUID_ERROR)
> -			printk(KERN_DEBUG "_OSC invalid UUID\n");
> -		if (errors & OSC_INVALID_REVISION_ERROR)
> -			printk(KERN_DEBUG "_OSC invalid revision\n");
> -		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> -			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
> -				goto out_success;
> -			printk(KERN_DEBUG
> -			       "Firmware did not grant requested _OSC control\n");
> -			status = AE_SUPPORT;
> -			goto out_kfree;
> -		}
> -		status = AE_ERROR;
> -		goto out_kfree;
> +	status = acpi_run_osc(handle, &context);
> +	if (ACPI_SUCCESS(status)) {
> +		*retval = *((u32 *)(context.ret.pointer + 8));
> +		kfree(context.ret.pointer);
>  	}
> -out_success:
> -	*retval = *((u32 *)(out_obj->buffer.pointer + 8));
> -	status = AE_OK;
> -
> -out_kfree:
> -	kfree(output.pointer);
>  	return status;
>  }
>  
> @@ -277,10 +230,10 @@ static acpi_status acpi_pci_query_osc(st
>  	u32 support_set, result, capbuf[3];
>  
>  	/* do _OSC query for all possible controls */
> -	support_set = root->osc_support_set | (flags & OSC_SUPPORT_MASKS);
> +	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
>  	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
>  	capbuf[OSC_SUPPORT_TYPE] = support_set;
> -	capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
> +	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
>  
>  	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>  	if (ACPI_SUCCESS(status)) {
> @@ -427,7 +380,7 @@ acpi_status acpi_pci_osc_control_set(acp
>  	if (ACPI_FAILURE(status))
>  		return status;
>  
> -	control_req = (flags & OSC_CONTROL_MASKS);
> +	control_req = (flags & OSC_PCI_CONTROL_MASKS);
>  	if (!control_req)
>  		return AE_TYPE;
>  
> Index: linux/include/linux/acpi.h
> ===================================================================
> --- linux.orig/include/linux/acpi.h	2009-10-27 13:50:35.000000000 +0800
> +++ linux/include/linux/acpi.h	2009-10-27 14:03:17.000000000 +0800
> @@ -263,7 +263,6 @@ struct acpi_osc_context {
>  #define OSC_QUERY_TYPE			0
>  #define OSC_SUPPORT_TYPE 		1
>  #define OSC_CONTROL_TYPE		2
> -#define OSC_SUPPORT_MASKS		0x1f
>  
>  /* _OSC DW0 Definition */
>  #define OSC_QUERY_ENABLE		1
> @@ -274,12 +273,14 @@ struct acpi_osc_context {
>  
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  
> +/* PCI defined _OSC bits */
>  /* _OSC DW1 Definition (OS Support Fields) */
>  #define OSC_EXT_PCI_CONFIG_SUPPORT		1
>  #define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
>  #define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
>  #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
>  #define OSC_MSI_SUPPORT				16
> +#define OSC_PCI_SUPPORT_MASKS			0x1f
>  
>  /* _OSC DW1 Definition (OS Control Fields) */
>  #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
> @@ -288,7 +289,7 @@ acpi_status acpi_run_osc(acpi_handle han
>  #define OSC_PCI_EXPRESS_AER_CONTROL		8
>  #define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
>  
> -#define OSC_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
> +#define OSC_PCI_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
>  				OSC_SHPC_NATIVE_HP_CONTROL | 		\
>  				OSC_PCI_EXPRESS_PME_CONTROL |		\
>  				OSC_PCI_EXPRESS_AER_CONTROL |		\
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


