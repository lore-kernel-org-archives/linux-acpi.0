From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / PM: Infer parent power state from child if unknown
Date: Tue, 11 Sep 2012 13:33:07 +0800
Message-ID: <20120911053305.GA2130@mint-spring.sh.intel.com>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com>
 <201209072032.55469.rjw@sisk.pl>
 <20120910003805.GA1590@mint-spring.sh.intel.com>
 <201209102150.22738.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201209102150.22738.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 10, 2012 at 09:50:22PM +0200, Rafael J. Wysocki wrote:
>  drivers/acpi/bus.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux/drivers/acpi/bus.c
> ===================================================================
> --- linux.orig/drivers/acpi/bus.c
> +++ linux/drivers/acpi/bus.c
> @@ -228,7 +228,16 @@ static int __acpi_bus_get_power(struct a
>  		result = psc;
>  	}
>  	/* The test below covers ACPI_STATE_UNKNOWN too. */
> -	if (result <= ACPI_STATE_D2) {
> +	if (result == ACPI_STATE_D0) {

Oops, I just realized that the check here is too early if device does
not have _PSC but _PRx, its parent will miss the chance to get power
state updated :-)

Sorry for not spotting this earlier.

-Aaron

> +		/*
> +		 * If we were unsure about the device parent's power state up to
> +		 * this point, the fact that the device is in D0 implies that
> +		 * the parent has to be in D0 too.
> +		 */
> +		if (device->parent
> +		    && device->parent->power.state == ACPI_STATE_UNKNOWN)
> +			device->parent->power.state = ACPI_STATE_D0;
> +	} else if (result <= ACPI_STATE_D2) {
>  	  ; /* Do nothing. */
>  	} else if (device->power.flags.power_resources) {
>  		int error = acpi_power_get_inferred_state(device, &result);
