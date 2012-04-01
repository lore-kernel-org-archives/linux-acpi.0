From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 01 Apr 2012 13:27:33 +0800
Message-ID: <1333258053.2939.22.camel@minggr>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Len Brown <lenb@kernel.org>, "Rafeal J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2012-04-01 at 02:18 +0800, Aaron Lu wrote:
> When entering D3 Cold from a higher device state, evaluate _PS3 first
> and then make the proper power transition.
> This is used to solve the ZPODD problem on AMD's platform, _PS3 on such
> platforms will power off the ODD device and thus make the device enter
> D3 cold state.
> 
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> Cc: Andiry Xu <andiry.xu@amd.com>
> Cc: Alex He <alex.he@amd.com>
> ---
>  drivers/acpi/bus.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 3263b68..68e593f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -227,6 +227,8 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
>  	int result = 0;
>  	acpi_status status = AE_OK;
>  	char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
> +	struct acpi_device_power_state *ps;
> +	u8 explicit_set;
>  
>  	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>  		return -EINVAL;
> @@ -239,7 +241,8 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
>  		return 0;
>  	}
>  
> -	if (!device->power.states[state].flags.valid) {
> +	ps = &device->power.states[state];
> +	if (!ps->flags.valid) {
>  		printk(KERN_WARNING PREFIX "Device does not support D%d\n", state);
>  		return -ENODEV;
>  	}
> @@ -263,7 +266,7 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
>  			if (result)
>  				goto end;
>  		}
> -		if (device->power.states[state].flags.explicit_set) {
> +		if (ps->flags.explicit_set) {
>  			status = acpi_evaluate_object(device->handle,
>  						      object_name, NULL, NULL);
>  			if (ACPI_FAILURE(status)) {
> @@ -272,7 +275,15 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
>  			}
>  		}
>  	} else {
> -		if (device->power.states[state].flags.explicit_set) {
> +		/* If state is D3 Cold, try to evaluate _PS3 first */
> +		if (state == ACPI_STATE_D3_COLD) {
> +			explicit_set = (ps - 1)->flags.explicit_set;
> +			object_name[3] -= 1;
> +		}

I'm not sure whether this works or not.

>From ACPI spec,

_PS3 "is used to put the specific device into its D3hot or D3 state"

D3 neither means D3hot nor D3cold. It's an old term before D3hot and
D3cold were introduced.

Another problem:

With your patch, both D3hot and D3cold will evaluate _PS3, right?

Will it have problem on AMD platform if you try to put ODD into D3hot
state? _PS3 is evaluated, so it actually enters D3Cold state.

Thanks,
Lin Ming

> +		else {
> +			explicit_set = ps->flags.explicit_set;
> +		}
> +		if (explicit_set) {
>  			status = acpi_evaluate_object(device->handle,
>  						      object_name, NULL, NULL);
>  			if (ACPI_FAILURE(status)) {
