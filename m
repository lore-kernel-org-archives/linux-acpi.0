From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/4] acer-wmi: Make device detection error messages more descriptive
Date: Tue, 11 Mar 2008 17:57:37 -0400
Message-ID: <200803111757.37771.lenb@kernel.org>
References: <20080224133412.2317.5802.stgit@pacifica> <20080224133424.2317.90354.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49757 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbYCKV6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 17:58:01 -0400
In-Reply-To: <20080224133424.2317.90354.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

On Sunday 24 February 2008, Carlos Corbacho wrote:
> The current device detection error messages are all copy & pasted - make
> them more descriptive so it's easier to see where in the code a problem
> occurs.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> ---
> 
>  drivers/misc/acer-wmi.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index d1d64db..99beeb8 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -1052,11 +1052,12 @@ static int __init acer_wmi_init(void)
>  
>  	if (wmi_has_guid(WMID_GUID2) && interface) {
>  		if (ACPI_FAILURE(WMID_set_capabilities())) {
> -			printk(ACER_ERR "Unable to detect available devices\n");
> +			printk(ACER_ERR "Unable to detect available WMID ");

While KERN_CONT will shut up checkpatch, I don't think
it isn't what you want here
since acer_wmi is loaded well afer we've gone SMP.

> +			printk(KERN_CONT "devices\n");

Instead, to get under 80 columns, you simpmly want to do something like this:

printk(ACER_ERR "Unable to detect available WMID "
	"devices");

as the pre-processor will concatenate adjacent strings for you at build time.

-Len

>  			return -ENODEV;
>  		}
>  	} else if (!wmi_has_guid(WMID_GUID2) && interface) {
> -		printk(ACER_ERR "Unable to detect available devices\n");
> +		printk(ACER_ERR "No WMID device detection method found\n");
>  		return -ENODEV;
>  	}
>  
> @@ -1064,7 +1065,8 @@ static int __init acer_wmi_init(void)
>  		interface = &AMW0_interface;
>  
>  		if (ACPI_FAILURE(AMW0_set_capabilities())) {
> -			printk(ACER_ERR "Unable to detect available devices\n");
> +			printk(ACER_ERR "Unable to detect available AMW0 ");
> +			printk(KERN_CONT "devices\n");
>  			return -ENODEV;
>  		}
>  	}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


