From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 9/9] ThinkPad ACPI: fix possible NULL pointer dereference
Date: Tue, 29 Apr 2008 04:16:25 -0400
Message-ID: <200804290416.25482.lenb@kernel.org>
References: <200804182027.m3IKRUlu013564@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55956 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582AbYD2IRP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 04:17:15 -0400
In-Reply-To: <200804182027.m3IKRUlu013564@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, gorcunov@gmail.com, hmh@hmh.eng.br

applied

thanks,
-len

On Friday 18 April 2008, akpm@linux-foundation.org wrote:
> From: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> Fix potential NULL pointer dereference if kstrdup failed
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/misc/thinkpad_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/misc/thinkpad_acpi.c~thinkpad-acpi-fix-possible-null-pointer-dereference drivers/misc/thinkpad_acpi.c
> --- a/drivers/misc/thinkpad_acpi.c~thinkpad-acpi-fix-possible-null-pointer-dereference
> +++ a/drivers/misc/thinkpad_acpi.c
> @@ -5826,7 +5826,7 @@ static void __init get_thinkpad_model_da
>  
>  	tp->model_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_VERSION),
>  					GFP_KERNEL);
> -	if (strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
> +	if (tp->model_str && strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
>  		kfree(tp->model_str);
>  		tp->model_str = NULL;
>  	}
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


