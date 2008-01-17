From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Enable _OSI(Linux) for Xen HVM domains
Date: Wed, 16 Jan 2008 19:44:48 -0500
Message-ID: <200801161944.48250.lenb@kernel.org>
References: <1194375906.31834.211.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbYAQA77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 19:59:59 -0500
In-Reply-To: <1194375906.31834.211.camel@bling>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Keir Fraser <keir@xensource.com>

On Tuesday 06 November 2007 14:05, Alex Williamson wrote:
> 
>    I'd like to enable _OSI(Linux) for Xen HVM domains.  As I understand
> it, the main reason for disabling _OSI(Linux) by default is to avoid
> dealing with a myriad of systems with broken Linux code paths in their
> BIOS (while we know the Windows code path is functional).  With fully
> virtualized Xen domains, the "BIOS" code is provided from the Xen
> project (or separate open source tree in the case on ia64).  We can
> therefore verify the Linux code path works and we can take advantage of
> the _OSI call to make optimization in the hypervisor based on the
> guest's response.  The patch below enables this feature on both x86 and
> ia64 Xen via the existing DMI hook.  Thanks,
> 
> 	Alex
> 
> Signed-off-by: Alex Williamson <alex.williamson@hp.com>
> Acked-by: Keir Fraser <keir@xensource.com>
> --
> 
> diff -r c7f1be4e5832 drivers/acpi/osl.c
> --- a/drivers/acpi/osl.c	Thu Nov 01 12:09:33 2007 -0700
> +++ b/drivers/acpi/osl.c	Fri Nov 02 15:30:23 2007 -0700
> @@ -1225,6 +1225,14 @@ static struct dmi_system_id acpi_osl_dmi
>  		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
>  		     },
>  	 },
> +	{
> +	 .callback = dmi_osi_linux,
> +	 .ident = "Xen HVM domU",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Xen"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "HVM domU"),
> +		     },
> +	 },
>  	{}
>  };
>  #endif /* CONFIG_DMI */
> 
> 

Hi Alex,

I think it is fine for the "BIOS" to use the OSI mechanism to ask about the OS.
However, the string "Linux" is probably not a good choice for the string.

The reason we deleted OSI(Linux) by default is because it is ill-defined.
A good OSI string would be much more specific, ie. label something
that is well defined, or at least include version information.

eg. "ACPI 3.0 Thermal Model" means that an OS implements the
ACPI 3.0 extensions to the thermal model (which we don't, BTW).

The problem with "Linux" is that
A. it is usually used by mistake, inherited from the Intel
   reference BIOS which unfortunately referenced it.
   Sometimes it does things like disable the HPET -- totally random.

B. it is used on purpose, but for reasons that
   may not be valid in all versions of Linux.
   eg. the enabling S3 video re-post on resume.
   This is very snappy, until you have a native Linux
   graphics device driver than can do it in a fraction
   of the time... etc.

so if you're looking at a specific property of the OS,
it would be better to build that string into the OS --
giving you the option to no longer build in that string
if that specific property changes in a different version...

thanks,
-Len
