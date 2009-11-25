From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 05/12] fujitsu-laptop: fix tests of acpi_evaluate_integer()
 return
Date: Wed, 25 Nov 2009 00:58:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911250057060.4058@localhost.localdomain>
References: <200911172227.nAHMRV26023190@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:35136 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbZKYF7U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 00:59:20 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN0031ZHY0PE73@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Nov 2009 23:58:54 -0600 (CST)
In-reply-to: <200911172227.nAHMRV26023190@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, roel.kluin@gmail.com, jwoithe@physics.adelaide.edu.au

On Tue, 17 Nov 2009, akpm@linux-foundation.org wrote:

> From: Roel Kluin <roel.kluin@gmail.com>
> 
> The wrong test was used acpi_status status is unsigned.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/platform/x86/fujitsu-laptop.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return drivers/platform/x86/fujitsu-laptop.c
> --- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return
> +++ a/drivers/platform/x86/fujitsu-laptop.c
> @@ -376,7 +376,7 @@ static int get_lcd_level(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> -	if (status < 0)
> +	if (ACPI_FAILURE(status))
>  		return status;

as status is a positive number, shouldn't we be returning something like 
-1 here on failure, rather than status?

>  
>  	fujitsu->brightness_level = state & 0x0fffffff;
> @@ -398,7 +398,7 @@ static int get_max_brightness(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
> -	if (status < 0)
> +	if (ACPI_FAILURE(status))
>  		return status;
>  
>  	fujitsu->max_brightness = state;
> _
> 
