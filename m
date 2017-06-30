From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 1/2] acpi: thermal: update thermal_zone after enable
 the driver.
Date: Fri, 30 Jun 2017 10:40:34 +0800
Message-ID: <1498790434.2520.5.camel@intel.com>
References: <20170629165035.23101-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170629165035.23101-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2017-06-29 at 18:50 +0200, Enric Balletbo i Serra wrote:
> Use thermal_set_mode instead of just set the tz_enable variable when
> enabling the ACPI thermal driver. The purpose of this change is
> trigger
> a thermal_zone_device_update when driver switches from disabled to
> enabled mode so thermal_zone data is up-to-date.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> This patch is new from v1 [1]
> 
> [1] https://patchwork.kernel.org/patch/9804229/
> 
>  drivers/acpi/thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 1d0417b..9949458 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -930,7 +930,9 @@ static int
> acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	tz->tz_enabled = 1;
> +	result = thermal_set_mode(tz->thermal_zone,
> THERMAL_DEVICE_ENABLED);
> +	if (result)
> +		return result;

thermal core is responsible for checking the thermal zone "mode", and
set the polling properly, right after thermal_zone_device_being
registered.

Thus we need to do nothing, but just make sure tz->tz_enabled is set
properly before registering the zone.

thanks,
rui
>  
>  	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
>  		 tz->thermal_zone->id);
