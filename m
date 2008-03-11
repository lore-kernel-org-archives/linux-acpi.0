From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] acer-wmi: Don't warn if mail LED cannot be detected
Date: Tue, 11 Mar 2008 17:59:50 -0400
Message-ID: <200803111759.50291.lenb@kernel.org>
References: <20080224133412.2317.5802.stgit@pacifica> <20080224133429.2317.72620.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47964 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYCLDWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 23:22:12 -0400
In-Reply-To: <20080224133429.2317.72620.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
-len

On Sunday 24 February 2008, Carlos Corbacho wrote:
> This warning confuses users, who think it is an error. Not detecting the
> mail LED simply means it isn't there, so let's not unduly panic users.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> ---
> 
>  drivers/misc/acer-wmi.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index 99beeb8..68b12d6 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -1071,10 +1071,8 @@ static int __init acer_wmi_init(void)
>  		}
>  	}
>  
> -	if (wmi_has_guid(AMW0_GUID1)) {
> -		if (ACPI_FAILURE(AMW0_find_mailled()))
> -			printk(ACER_ERR "Unable to detect mail LED\n");
> -	}
> +	if (wmi_has_guid(AMW0_GUID1))
> +		AMW0_find_mailled();
>  
>  	find_quirks();
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


