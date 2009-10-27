From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Tue, 27 Oct 2009 18:52:45 +0300
Message-ID: <4AE7174D.8090007@gmail.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:57295 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbZJ0Pwn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 11:52:43 -0400
Received: by fg-out-1718.google.com with SMTP id 16so318763fgg.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 08:52:48 -0700 (PDT)
In-Reply-To: <20091027063637.GA22237@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Shaohua,

Could you also make it take a spec string as argument, not a prepared
byte buffer?

Regards,
Alex.


Shaohua Li =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Add an API to execute _OSC. A lot of devices can have this method, so=
 add a
> generic API.
>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/bus.c   |   72 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>  include/linux/acpi.h |    9 ++++++
>  2 files changed, 81 insertions(+)
>
> Index: linux/drivers/acpi/bus.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/acpi/bus.c	2009-10-27 13:50:24.000000000 +0800
> +++ linux/drivers/acpi/bus.c	2009-10-27 14:02:30.000000000 +0800
> @@ -344,6 +344,78 @@ bool acpi_bus_can_wakeup(acpi_handle han
> =20
>  EXPORT_SYMBOL(acpi_bus_can_wakeup);
> =20
> +acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context=
 *context)
> +{
> +	acpi_status status;
> +	struct acpi_object_list input;
> +	union acpi_object in_params[4];
> +	union acpi_object *out_obj;
> +	u32 errors;
> +
> +	if (!context)
> +		return AE_ERROR;
> +	context->ret.length =3D ACPI_ALLOCATE_BUFFER;
> +	context->ret.pointer =3D NULL;
> +
> +	/* Setting up input parameters */
> +	input.count =3D 4;
> +	input.pointer =3D in_params;
> +	in_params[0].type 		=3D ACPI_TYPE_BUFFER;
> +	in_params[0].buffer.length 	=3D 16;
> +	in_params[0].buffer.pointer	=3D context->uuid;
> +	in_params[1].type 		=3D ACPI_TYPE_INTEGER;
> +	in_params[1].integer.value 	=3D context->rev;
> +	in_params[2].type 		=3D ACPI_TYPE_INTEGER;
> +	in_params[2].integer.value	=3D context->cap.length/sizeof(u32);
> +	in_params[3].type		=3D ACPI_TYPE_BUFFER;
> +	in_params[3].buffer.length 	=3D context->cap.length;
> +	in_params[3].buffer.pointer 	=3D context->cap.pointer;
> +
> +	status =3D acpi_evaluate_object(handle, "_OSC", &input, &context->r=
et);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	/* return buffer should have the same length as cap buffer */
> +	if (context->ret.length !=3D context->cap.length)
> +		return AE_NULL_OBJECT;
> +
> +	out_obj =3D context->ret.pointer;
> +	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> +		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
> +		status =3D AE_TYPE;
> +		goto out_kfree;
> +	}
> +	/* Need to ignore the bit0 in result code */
> +	errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
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
> +			status =3D AE_SUPPORT;
> +			goto out_kfree;
> +		}
> +		status =3D AE_ERROR;
> +		goto out_kfree;
> +	}
> +out_success:
> +	return AE_OK;
> +
> +out_kfree:
> +	kfree(context->ret.pointer);
> +	context->ret.pointer =3D NULL;
> +	return status;
> +}
> +EXPORT_SYMBOL(acpi_run_osc);
> +
>  /* -----------------------------------------------------------------=
---------
>                                  Event Management
>     -----------------------------------------------------------------=
--------- */
> Index: linux/include/linux/acpi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/linux/acpi.h	2009-10-27 13:50:24.000000000 +08=
00
> +++ linux/include/linux/acpi.h	2009-10-27 13:50:35.000000000 +0800
> @@ -253,6 +253,13 @@ void __init acpi_old_suspend_ordering(vo
>  void __init acpi_s4_no_nvs(void);
>  #endif /* CONFIG_PM_SLEEP */
> =20
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
> =20
> +acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context=
 *context);
> +
>  /* _OSC DW1 Definition (OS Support Fields) */
>  #define OSC_EXT_PCI_CONFIG_SUPPORT		1
>  #define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
