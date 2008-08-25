From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] patch acpi_introduce_evaluate_string.patch
Date: Mon, 25 Aug 2008 09:31:43 +0800
Message-ID: <1219627904.4116.18.camel@yakui_zhao.sh.intel.com>
References: <20080821174852.0689681d@hyperion.delvare>
	 <1219615897-21130-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56005 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbYHYBQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 21:16:45 -0400
In-Reply-To: <1219615897-21130-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: khali@linux-fr.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Mon, 2008-08-25 at 00:11 +0200, Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/acpi/utils.c    |   11 +++++------
>  include/acpi/acpi_bus.h |    4 ++++
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 1009261..250d7f1 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -295,15 +295,14 @@ acpi_evaluate_integer(acpi_handle handle,
>  
>  EXPORT_SYMBOL(acpi_evaluate_integer);
>  
It seems reasonable. 
But the returned buffer object will be appropriate. IMO it is
unnecessary to add the function of acpi_evaluate_string.

Thanks.



> -#if 0
>  acpi_status
>  acpi_evaluate_string(acpi_handle handle,
>  		     acpi_string pathname,
> -		     acpi_object_list * arguments, acpi_string * data)
> +		     struct acpi_object_list *arguments, acpi_string *data)
>  {
>  	acpi_status status = AE_OK;
> -	acpi_object *element = NULL;
> -	acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *element = NULL;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  
> 
>  	if (!data)
> @@ -315,7 +314,7 @@ acpi_evaluate_string(acpi_handle handle,
>  		return status;
>  	}
>  
> -	element = (acpi_object *) buffer.pointer;
> +	element = (union acpi_object *) buffer.pointer;
>  
>  	if ((element->type != ACPI_TYPE_STRING)
>  	    || (element->type != ACPI_TYPE_BUFFER)
> @@ -338,7 +337,7 @@ acpi_evaluate_string(acpi_handle handle,
>  
>  	return AE_OK;
>  }
> -#endif
> +EXPORT_SYMBOL(acpi_evaluate_string);
>  
>  acpi_status
>  acpi_evaluate_reference(acpi_handle handle,
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a5ac0bc..08a191f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -48,6 +48,10 @@ acpi_evaluate_integer(acpi_handle handle,
>  		      acpi_string pathname,
>  		      struct acpi_object_list *arguments, unsigned long *data);
>  acpi_status
> +acpi_evaluate_string(acpi_handle handle,
> +		     acpi_string pathname,
> +		     struct acpi_object_list *arguments, acpi_string *data);
> +acpi_status
>  acpi_evaluate_reference(acpi_handle handle,
>  			acpi_string pathname,
>  			struct acpi_object_list *arguments,

