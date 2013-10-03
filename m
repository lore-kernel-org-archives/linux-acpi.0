From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / thermal: fix trivial compilation error
Date: Thu, 03 Oct 2013 02:45:21 +0200
Message-ID: <5709858.i8kKxQnaqX@vostro.rjw.lan>
References: <1380618956-32051-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59104 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216Ab3JCAdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Oct 2013 20:33:55 -0400
In-Reply-To: <1380618956-32051-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Tuesday, October 01, 2013 12:15:56 PM Andy Shevchenko wrote:
> Previous patch didn't move callback function definitions before usage, thus we
> end up with ea compilation error. This patch fixes it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can you please fold this into the patch that was broken and resend?

Rafael


> ---
>  drivers/acpi/thermal.c | 73 ++++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 4c6e0a4..9230c36 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -978,6 +978,44 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
>  	}
>  }
>  
> +static int thermal_act(const struct dmi_system_id *d) {
> +
> +	if (act == 0) {
> +		pr_notice(PREFIX "%s detected: "
> +			  "disabling all active thermal trip points\n", d->ident);
> +		act = -1;
> +	}
> +	return 0;
> +}
> +
> +static int thermal_nocrt(const struct dmi_system_id *d) {
> +
> +	pr_notice(PREFIX "%s detected: "
> +		  "disabling all critical thermal trip point actions.\n", d->ident);
> +	nocrt = 1;
> +	return 0;
> +}
> +
> +static int thermal_tzp(const struct dmi_system_id *d) {
> +
> +	if (tzp == 0) {
> +		pr_notice(PREFIX "%s detected: "
> +			  "enabling thermal zone polling\n", d->ident);
> +		tzp = 300;	/* 300 dS = 30 Seconds */
> +	}
> +	return 0;
> +}
> +
> +static int thermal_psv(const struct dmi_system_id *d) {
> +
> +	if (psv == 0) {
> +		pr_notice(PREFIX "%s detected: "
> +			  "disabling all passive thermal trip points\n", d->ident);
> +		psv = -1;
> +	}
> +	return 0;
> +}
> +
>  static struct dmi_system_id thermal_dmi_table[] __initdata = {
>  	/*
>  	 * Award BIOS on this AOpen makes thermal control almost worthless.
> @@ -1199,39 +1237,4 @@ static int acpi_thermal_resume(struct device *dev)
>  }
>  #endif
>  
> -static int thermal_act(const struct dmi_system_id *d) {
> -
> -	if (act == 0) {
> -		pr_notice(PREFIX "%s detected: "
> -			  "disabling all active thermal trip points\n", d->ident);
> -		act = -1;
> -	}
> -	return 0;
> -}
> -static int thermal_nocrt(const struct dmi_system_id *d) {
> -
> -	pr_notice(PREFIX "%s detected: "
> -		  "disabling all critical thermal trip point actions.\n", d->ident);
> -	nocrt = 1;
> -	return 0;
> -}
> -static int thermal_tzp(const struct dmi_system_id *d) {
> -
> -	if (tzp == 0) {
> -		pr_notice(PREFIX "%s detected: "
> -			  "enabling thermal zone polling\n", d->ident);
> -		tzp = 300;	/* 300 dS = 30 Seconds */
> -	}
> -	return 0;
> -}
> -static int thermal_psv(const struct dmi_system_id *d) {
> -
> -	if (psv == 0) {
> -		pr_notice(PREFIX "%s detected: "
> -			  "disabling all passive thermal trip points\n", d->ident);
> -		psv = -1;
> -	}
> -	return 0;
> -}
> -
>  module_acpi_driver(acpi_thermal_driver);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
