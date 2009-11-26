From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [patch 05/12] fujitsu-laptop: fix tests of acpi_evaluate_integer()
Date: Thu, 26 Nov 2009 11:56:29 +1030 (CST)
Message-ID: <200911260126.nAQ1QTet016642@turbo.physics.adelaide.edu.au>
References: <4B0D10C7.6080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:35915 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711AbZKZB1Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 20:27:24 -0500
In-Reply-To: <4B0D10C7.6080603@gmail.com> from "Roel Kluin" at Nov 25, 2009 12:11:03 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org

> The wrong test was used, acpi_status status is unsigned. Callers
> expect an -errno on failure.

Ah, ok - fair enough.  The latter point wasn't clear to me.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> >>> The wrong test was used acpi_status status is unsigned.
> 
> >>> -	if (status < 0)
> >>> +	if (ACPI_FAILURE(status))
> >>>  		return status;
> >>
> >> as status is a positive number, shouldn't we be returning something like 
> >> -1 here on failure, rather than status?
> > 
> > These functions are called via the backlight_ops structure by the standard
> > backlight class framework and it seems, from a real quick look, that the API
> > treats numbers >=0 as valid data.  So something like this (untested, off the
> > top of my head) might be more appropriate:
> 
> >  	status =
> >  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> > -	if (status < 0)
> > -		return status;
> > +	if (ACPI_FAILURE(status))
> > +		return -status;
> 
> > Otherwise "return -1;" would be fine by me.  My only reason for going with
> > "-status" is that it might give some clue as to what went wrong.  Thoughts?
> 
> The acpi errors have an entirely different range, won't that confuse the
> caller? Maybe it's better to return an -errno and display the acpi error in
> a warning message.

If an errno is expected by the caller then I agree completely with this
suggestion; perhaps -EINVAL is the best choice?

> Also, acpi_fujitsu_add() and acpi_fujitsu_notify() ignore a get_lcd_level()
> error return. Is that ok?

In practice I don't expect it to cause any issues, but thanks for flagging
it - I'll look into it in more detail.  If the functions get this far it
means that the relevant ACPI object has been found in the hardware and that
therefore these functions should not fail.  In any case, a failure to
control the brightness does not necessarily mean that other functions
provided by that object are broken so it is arguably wrong to fail the
add/notify simply on the basis of a failed brightness read.

> e.g. something like:
> 
>  drivers/platform/x86/fujitsu-laptop.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index bcd4ba8..714c472 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -376,8 +376,10 @@ static int get_lcd_level(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> -	if (status < 0)
> -		return status;
> +	if (ACPI_FAILURE(status)) {
> +		pr_warning("%s failed, acpi error: %u\n", __func__, status);
> +		return -EINVAL;
> +	}
>  
>  	fujitsu->brightness_level = state & 0x0fffffff;
>  
> @@ -398,8 +400,10 @@ static int get_max_brightness(void)
>  
>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
> -	if (status < 0)
> -		return status;
> +	if (ACPI_FAILURE(status)) {
> +		pr_warning("%s failed, acpi error: %u\n", __func__, status);
> +		return -EINVAL;
> +	}
>  
>  	fujitsu->max_brightness = state;
>  
> 

Yes, I'd be happy with that.  It seems sensible to me given the
circumstances.

Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan
