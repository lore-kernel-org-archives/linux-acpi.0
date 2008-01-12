From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Fix acpi_pm_device_sleep_state()
Date: Fri, 11 Jan 2008 23:46:04 -0500
Message-ID: <200801112346.04744.lenb@kernel.org>
References: <200801110010.38658.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57916 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbYALEqh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 23:46:37 -0500
In-Reply-To: <200801110010.38658.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday 10 January 2008 18:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Fix acpi_pm_device_sleep_state() to return the value returned
> by _SxD if the device is supposed to wake up the system from
> given sleep state and the evaluation of _SxW fails (e.g. _SxW
> is not present).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep/main.c
> +++ linux-2.6/drivers/acpi/sleep/main.c
> @@ -472,11 +472,20 @@ int acpi_pm_device_sleep_state(struct de
>  	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
>  	    (wake && adev->wakeup.state.enabled &&
>  	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
> +		acpi_status status;
> +
>  		acpi_method[3] = 'W';
> -		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
> -		/* Sanity check */
> -		if (d_max < d_min)
> +		status = acpi_evaluate_integer(handle, acpi_method, NULL,
> +						&d_max);
> +		if (ACPI_FAILURE(status)) {
> +			d_max = d_min;
> +		} else if (d_max < d_min) {
> +			/* Warn the user of the broken DSDT */
> +			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
> +				acpi_method);
> +			/* Sanitize it */
>  			d_min = d_max;
> +		}
>  	}
>  
>  	if (d_min_p)
> 

this patch looks correct, it fixes the bug where 
_SxD=2, _PRW=x, _SxW was absent, we would return D3 as legal,
when we should have returned D2.

applied to acpi test.

BTW.  We currently don't use *d_min_p
and I can't imagine when and why we ever would,
so it would be fine with me if you simplify by deleting it.

Also, the last line of this block comment can be deleted,
though that was true before this patch also:

acpi_pci_choose_state() block comment can now be updated to delete this line:

* currently we simply return _SxD, if present.

thanks,
-Len

