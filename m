From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: Fix tests of acpi_evaluate_integer() return
Date: Mon, 12 Oct 2009 20:55:45 +0930 (CST)
Message-ID: <200910121125.n9CBPjRo002870@mercury.physics.adelaide.edu.au>
References: <4AD30F98.4010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:37531 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754786AbZJLL0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2009 07:26:39 -0400
In-Reply-To: <4AD30F98.4010904@gmail.com> from "Roel Kluin" at Oct 12, 2009 01:14:32 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

> The wrong test was used acpi_status status is unsigned.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index f35aee5..e3c21ee 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -376,7 +376,7 @@ static int get_lcd_level(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> -	if (status < 0)
> +	if (ACPI_FAILURE(status))
>  		return status;
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

Thanks Roel.  Looks perfectly reasonable to me.

Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
