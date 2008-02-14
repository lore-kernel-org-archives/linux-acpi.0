From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Do not pass NULL to acpi_get_handle() when
	looking for _EJD
Date: Thu, 14 Feb 2008 15:49:40 +0100
Message-ID: <1203000580.7977.703.camel@queen.suse.de>
References: <20080214124034.GA9708@homac.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:35161 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbYBNOtm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 09:49:42 -0500
In-Reply-To: <20080214124034.GA9708@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Thu, 2008-02-14 at 13:40 +0100, Holger Macht wrote:
> When trying to get the acpi_handle from an acpi_buffer, pass
> ACPI_ROOT_OBJECT instead of NULL to acpi_get_handle(). This fixes the
> detection of dock dependent bays.
> 
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 3fac011..d9b9143 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -609,7 +609,8 @@ acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
>  	status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);
>  	if (ACPI_SUCCESS(status)) {
>  		obj = buffer.pointer;
> -		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
> +		status = acpi_get_handle(ACPI_ROOT_OBJECT, obj->string.pointer,
> +					 ejd);
>  		kfree(buffer.pointer);
>  	}
>  	return status;
> 

I can verify that acpi_bus_get_ejd is totally useless without that
patch.
If "status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);"
succeeds (and AE_NOT_FOUND is not returned), the function will return
AE_BAD_PARAMETER, because NULL never makes sense as first argument of
acpi_get_handle:
status = acpi_get_handle(NULL, obj->string.pointer, ejd);

I can also verify that the correct handle is evaluated with this patch
on a recent ThinkPad, otherwise not.

Please add it, looks like a typo.

   Thomas

