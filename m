From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if
	battery is absent
Date: Sat, 27 Oct 2007 22:42:49 +0400
Message-ID: <20071027184249.GA2982@zarina>
References: <200710272054.31160.arvidjaar@mail.ru>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757505AbXJ0Sox@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200710272054.31160.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 27, 2007 at 08:54:30PM +0400, Andrey Borzenkov wrote:
> I am not exactly sure about this one ... what other power_supply class drivers 
> do? Should I fix HAL instead (but then, I do not know whether HAL is the only 
> application that is using this interface).

Well, PROP_PRESENT wasn't my idea, currently it's used by pmu and
olpc drivers becuase it's not trivial to register/unregister their
batteries on physical insertion/removal. I have some plans to teach
at least pmu batteries to not use PROP_PRESENT. I don't have any
OLPC, thus I can't convert it.

To sum this: the good way to handle "missing" batteries is to
unregister them, so they'll not show up in the /sys/class/power_supply.
Is that possible with the ACPI?

The good example is ds2760 batteries:

drivers/power/ds2760_battery.c - is platform device
drivers/w1/slaves/w1_ds2760.c - is w1 slave, which
registers/unregisters pdevs on the detection/removal.

> Subject: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if battery is absent

Bad idea. Don't use present attribute, if possible.

> From: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> Ensure that we always have "present" attribute in sysfs. This is compatible
> with procfs case where we had "present: no" if battery was not available.
> 
> This fixes HAL battery detection where it does pretend battery is present
> but canot provide any value for it.
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> ---
> 
>  drivers/acpi/battery.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 681e26b..6e67fcd 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -187,6 +187,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static enum power_supply_property missing_battery_props[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +};
> +
>  static enum power_supply_property charge_battery_props[] = {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
> @@ -389,8 +393,13 @@ static int acpi_battery_update(struct acpi_battery *battery)
>  {
>  	int saved_present = acpi_battery_present(battery);
>  	int result = acpi_battery_get_status(battery);
> -	if (result || !acpi_battery_present(battery))
> +	if (result)
>  		return result;
> +	if (!acpi_battery_present(battery)) {
> +		battery->bat.properties = missing_battery_props;
> +		battery->bat.num_properties = ARRAY_SIZE(missing_battery_props);
> +		return result;
> +	}
>  	if (saved_present != acpi_battery_present(battery) ||
>  	    !battery->update_time) {
>  		battery->update_time = 0;

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
