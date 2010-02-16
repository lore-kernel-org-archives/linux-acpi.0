From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/7] acpi: fix &&/|| confusion in acpi_evaluate_string()
 (in comment)
Date: Tue, 16 Feb 2010 03:01:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002160300230.21595@localhost.localdomain>
References: <201002022237.o12Mbtwp018684@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:50017 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660Ab0BPIBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 03:01:33 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX00H7FCY564A0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 02:01:23 -0600 (CST)
In-reply-to: <201002022237.o12Mbtwp018684@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, roel.kluin@gmail.com

I think I'll just delete the dead acpi_evaluate_string() instead.

thanks for pointing it out,
Len Brown, Intel Open Source Technology Center

On Tue, 2 Feb 2010, akpm@linux-foundation.org wrote:

> From: Roel Kluin <roel.kluin@gmail.com>
> 
> This always evaluates to true.
> 
> It's between an #if 0 ... #endif.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/utils.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/utils.c~acpi-fix-confusion-in-acpi_evaluate_string-in-comment drivers/acpi/utils.c
> --- a/drivers/acpi/utils.c~acpi-fix-confusion-in-acpi_evaluate_string-in-comment
> +++ a/drivers/acpi/utils.c
> @@ -312,7 +312,7 @@ acpi_evaluate_string(acpi_handle handle,
>  	element = (acpi_object *) buffer.pointer;
>  
>  	if ((element->type != ACPI_TYPE_STRING)
> -	    || (element->type != ACPI_TYPE_BUFFER)
> +	    && (element->type != ACPI_TYPE_BUFFER)
>  	    || !element->string.length) {
>  		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
>  		return AE_BAD_DATA;
> _
> 
