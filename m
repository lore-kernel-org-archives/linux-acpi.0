From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
Date: Thu, 30 Jul 2009 17:13:49 +0930 (CST)
Message-ID: <200907300743.n6U7hnK6000821@mercury.physics.adelaide.edu.au>
References: <200907292214.31038.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754091AbZG3HoZ@vger.kernel.org>
In-Reply-To: <200907292214.31038.bzolnier@gmail.com> from "Bartlomiej Zolnierkiewicz" at Jul 29, 2009 10:14:30 PM
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com, Julia Lawall <julia@diku.dk>
List-Id: linux-acpi@vger.kernel.org

Hi Bart

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
> 
> This takes care of the following entries from Dan's list:
> 
> drivers/platform/x86/fujitsu-laptop.c +327 set_lcd_level(13) warning: variable derefenced before check 'fujitsu'
> drivers/platform/x86/fujitsu-laptop.c +358 set_lcd_level_alt(13) warning: variable derefenced before check 'fujitsu'

I'd rather keep the test for a non-null fujitsu in there, but obviously it's
kind of pointless doing it after the first dereference.  Since this fixup
overlaps with the one previously discussed with Julia I've taken the liberty
of consolidating these - I'll send the result to the list as a separate
email.

Regards
  jonathan

> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: corbet@lwn.net
> Cc: eteo@redhat.com
> Cc: Julia Lawall <julia@diku.dk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> Index: b/drivers/platform/x86/fujitsu-laptop.c
> ===================================================================
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -324,9 +324,6 @@ static int set_lcd_level(int level)
>  	if (level < 0 || level >= fujitsu->max_brightness)
>  		return -EINVAL;
>  
> -	if (!fujitsu)
> -		return -EINVAL;
> -
>  	status = acpi_get_handle(fujitsu->acpi_handle, "SBLL", &handle);
>  	if (ACPI_FAILURE(status)) {
>  		vdbg_printk(FUJLAPTOP_DBG_ERROR, "SBLL not present\n");
> @@ -355,9 +352,6 @@ static int set_lcd_level_alt(int level)
>  	if (level < 0 || level >= fujitsu->max_brightness)
>  		return -EINVAL;
>  
> -	if (!fujitsu)
> -		return -EINVAL;
> -
>  	status = acpi_get_handle(fujitsu->acpi_handle, "SBL2", &handle);
>  	if (ACPI_FAILURE(status)) {
>  		vdbg_printk(FUJLAPTOP_DBG_ERROR, "SBL2 not present\n");
