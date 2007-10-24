From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6 patch] acpi/ec.c: fix use-after-free
Date: Wed, 24 Oct 2007 21:15:18 +0400
Message-ID: <471F7DA6.2060907@gmail.com>
References: <20071024162600.GD30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:8380 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbXJXRPa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 13:15:30 -0400
Received: by hu-out-0506.google.com with SMTP id 19so232620hue
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 10:15:28 -0700 (PDT)
In-Reply-To: <20071024162600.GD30533@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian,

commit 30c08574da0ead1a47797ce028218ce5b2de61c7 can not introduce use-after-free.

Please check...

Regards,
Alex.
Adrian Bunk wrote:
> This patch fixes a use-after-free introduced by
> commit 30c08574da0ead1a47797ce028218ce5b2de61c7.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> --- linux-2.6/drivers/acpi/ec.c.old	2007-10-23 19:39:47.000000000 +0200
> +++ linux-2.6/drivers/acpi/ec.c	2007-10-23 19:34:55.000000000 +0200
> @@ -434,11 +442,11 @@
>  EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
>  
>  void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
>  {
> -	struct acpi_ec_query_handler *handler;
> +	struct acpi_ec_query_handler *handler, *tmp;
>  	mutex_lock(&ec->lock);
> -	list_for_each_entry(handler, &ec->list, node) {
> +	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
>  		if (query_bit == handler->query_bit) {
>  			list_del(&handler->node);
>  			kfree(handler);
>  		}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

