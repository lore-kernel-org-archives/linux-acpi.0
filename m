From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/9] fujitsu-laptop: fix tests of acpi_evaluate_integer()
 return
Date: Tue, 22 Dec 2009 15:28:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912221515560.5153@localhost.localdomain>
References: <200912220020.nBM0K065004744@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:61932 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZLVU2x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2009 15:28:53 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV200A6GM7ZQDV1@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 22 Dec 2009 14:28:50 -0600 (CST)
In-reply-to: <200912220020.nBM0K065004744@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, roel.kluin@gmail.com, jwoithe@physics.adelaide.edu.au

NAK, this patch is incorrect

On Mon, 21 Dec 2009, akpm@linux-foundation.org wrote:

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

backlight_show_actual_brightness() will stuff this return value in sysfs
no matter what you return.

I'm sure we don't want to return an acpi_status.

Looks like it should return 0 on failure, like thinkpad does.

>  
>  	fujitsu->brightness_level = state & 0x0fffffff;
> @@ -398,7 +398,7 @@ static int get_max_brightness(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
> -	if (status < 0)
> +	if (ACPI_FAILURE(status))
>  		return status;

needs to be return -1, since show_max_brightness is testing for < 0.

>  
>  	fujitsu->max_brightness = state;
> _
> 
