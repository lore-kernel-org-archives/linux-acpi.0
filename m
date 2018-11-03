From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Sat, 3 Nov 2018 12:28:43 +0100
Message-ID: <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
References: <20181103065732.12134-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181103065732.12134-1-jprvita@endlessm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-kernel@vger.kernel.org, linux@endlessm.com, =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 03-11-18 07:57, João Paulo Rechi Vita wrote:
> Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> "Discharging" on some machines when AC was connected but the battery was
> not charging. But now on these machines the battery status is reported
> as "Not charging" even when the battery is fully charged.
> 
> This commit takes the battery capacity into consideration when checking
> if "Not charging" should be returned and "Full" is returned when the
> capacity is 100%.
> 
> Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>

acpi_battery_handle_discharging() only gets called if the ACPI_BATTERY_STATE_DISCHARGING
bit is set by the firmware in that case if we are not actually discharging
returning POWER_SUPPLY_STATUS_NOT_CHARGING is the only correct thing to do,
we should never return POWER_SUPPLY_STATUS_FULL when the
ACPI_BATTERY_STATE_DISCHARGING bit is set.

I was about to point you to the upower bug for upower not
handling POWER_SUPPLY_STATUS_NOT_CHARGING as well as it
could atm, but I see you've already found that and are working
on fixing that. That is great, thank you.

As for this kernel-side fix I do not believe that fixing thus in
the kernel is the right thing to do. We try to stay away from
heuristics using full_charge_capacity in the kernel since that
is not really reliable / deterministic.

Regards,

Hans




> ---
>   drivers/acpi/battery.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index cb97b6105f52..82e194290f01 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -217,8 +217,12 @@ static int acpi_battery_handle_discharging(struct acpi_battery *battery)
>   	 * was plugged in and the device thus did not start a new charge cycle.
>   	 */
>   	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
> -	    battery->rate_now == 0)
> +	    battery->rate_now == 0) {
> +		if (battery->capacity_now && battery->full_charge_capacity &&
> +		    battery->capacity_now / battery->full_charge_capacity == 1)
> +			return POWER_SUPPLY_STATUS_FULL;
>   		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	}
>   
>   	return POWER_SUPPLY_STATUS_DISCHARGING;
>   }
> 
