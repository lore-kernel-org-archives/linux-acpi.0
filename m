From: Stephen Hemminger <shemminger-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] 2/3 ACPI resource handling
Date: 11 Feb 2003 14:14:54 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1045001693.17351.62.camel@dell_ss3.pdx.osdl.net>
References: <200302111459.35380.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200302111459.35380.bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
To: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-02-11 at 13:59, Bjorn Helgaas wrote:
> Note that this contains a couple structure copies; don't know your
> philosophy on those.
> 
> Bjorn
> 
> 
> diff -ur acpi-2/drivers/acpi/resources/rsxface.c acpi-3/drivers/acpi/resources/rsxface.c
> --- acpi-2/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:47.000000000 -0700
> +++ acpi-3/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:52.000000000 -0700
> @@ -316,3 +316,65 @@
>  	status = acpi_rs_set_srs_method_data (device_handle, in_buffer);
>  	return_ACPI_STATUS (status);
>  }
> +
> +
> +#define copy_field(out, in, field)	out->field = in->field
> +#define copy_address(out, in)					\
> +	copy_field(out, in, resource_type);			\
> +	copy_field(out, in, producer_consumer);			\
> +	copy_field(out, in, decode);				\
> +	copy_field(out, in, min_address_fixed);			\
> +	copy_field(out, in, max_address_fixed);			\
> +	copy_field(out, in, attribute);				\
> +	copy_field(out, in, granularity);			\
> +	copy_field(out, in, min_address_range);			\
> +	copy_field(out, in, max_address_range);			\
> +	copy_field(out, in, address_translation_offset);	\
> +	copy_field(out, in, address_length);			\
> +	copy_field(out, in, resource_source);

If ACPI just used normal (ie short) variable names, then ugly macros
like this would not be necessary.
