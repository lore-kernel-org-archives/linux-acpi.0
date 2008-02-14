From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI suspend: Execute _WAK with the right argument
Date: Thu, 14 Feb 2008 00:30:35 -0500
Message-ID: <200802140030.35658.lenb@kernel.org>
References: <200802130032.17636.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36154 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbYBNFbO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 00:31:14 -0500
In-Reply-To: <200802130032.17636.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Mirco Tischler <mt-ml@gmx.de>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

applied

thanks for quickly finding and fixing this 2.6.25-rc1 regression.

-len

On Tuesday 12 February 2008 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The _WAK global ACPI control method has to be called with the
> argument representing the sleep state being exited.  Make it happen.
> 
> Special thanks to Mirco Tischler <mt-ml@gmx.de> for reporting the
> problem and debugging.
> 
> Reported-by: Mirco Tischler <mt-ml@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/hardware/hwsleep.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> @@ -616,6 +616,7 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  		return_ACPI_STATUS(status);
>  	}
>  
> +	arg.integer.value = sleep_state;
>  	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>  		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
