From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Hide _OSI warning if osi_linux is enabled
Date: Wed, 16 Jan 2008 20:05:55 -0500
Message-ID: <200801162005.57261.lenb@kernel.org>
References: <1194376316.31834.215.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47553 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbYAQBGT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:06:19 -0500
In-Reply-To: <1194376316.31834.215.camel@bling>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Tuesday 06 November 2007 14:11, Alex Williamson wrote:
> 
>    Seems like we don't need to print a big ugly warning when osi_linux
> is already properly enabled.  Thanks,

True if "properly enabled" were not an oxymoron:-)
i need to hack on this code a bit so that it doesn't
complain when DMI or the user enabled it, but otherwise does.

thanks,
-Len

> 	Alex
> 
> Signed-off-by: Alex Williamson <alex.williamson@hp.com>
> --
> 
> diff -r c7f1be4e5832 drivers/acpi/osl.c
> --- a/drivers/acpi/osl.c	Thu Nov 01 12:09:33 2007 -0700
> +++ b/drivers/acpi/osl.c	Tue Nov 06 12:08:38 2007 -0700
> @@ -1167,14 +1167,15 @@ acpi_os_validate_interface (char *interf
>  	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
>  		return AE_OK;
>  	if (!strcmp("Linux", interface)) {
> +		if (osi_linux)
> +			return AE_OK;
> +
>  		printk(KERN_WARNING PREFIX
>  			"System BIOS is requesting _OSI(Linux)\n");
>  		printk(KERN_WARNING PREFIX
>  			"If \"acpi_osi=Linux\" works better,\n"
>  			"Please send dmidecode "
>  			"to linux-acpi@vger.kernel.org\n");
> -		if(osi_linux)
> -			return AE_OK;
>  	}
>  	return AE_SUPPORT;
>  }
> 
> 

