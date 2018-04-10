From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: [PATCH v1] battery: Add the ThinkPad battery status quirk
Date: Tue, 10 Apr 2018 16:17:13 +0200
Message-ID: <3A23A2DC-121E-4DA6-863D-EFEAF420A5FB@gmail.com>
References: <20180410090643.GA26554@thinkpad> <20180410105841.ne26heazhwwqjx7v@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410105841.ne26heazhwwqjx7v@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On April 10, 2018 12:58:41 PM GMT+02:00, Sebastian Reichel <sre@kernel=2Eo=
rg> wrote:
>Hi,
>
>On Tue, Apr 10, 2018 at 11:06:43AM +0200, Ognjen Galic wrote:
>> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
>> of "Unknown" when the battery is between the charge start and charge
>> stop thresholds=2E On Windows, it reports "Not Charging" so the quirk
>> has been added to fix the "Unknown" state=2E
>>=20
>> The chosen new state when the battery is not charging is "Fully
>Charged"
>> because a status of "Not Charging" breaks almost all applications in
>> userspace that depend on upower, because upower in itself can't
>handle
>> a state of "Not Charging", defaulting to "Unknown"=2E
>>=20
>> When we report "Fully Charged" instead of "Unknown", the userspace
>handles
>> everything just fine, displaying for example: "Fully Charged, 59%" in
>Xfce=2E
>
>This probably breaks dual-battery Thinkpads, that charges batteries
>alternating (so one of them is "not charging" without being "fully
>charged")=2E The correct fix is to teach upower the "not charging"
>state=2E It exists since the existance of the power supply kernel API,
>so missing support is a bug in UPower=2E

I did write a patch for upower, submitted it and tested it=2E The problem =
is the bug report has been open for a month now and nothing major is happen=
ing=2E And the userspace is still broken=2E


>
>-- Sebastian
>
>> This is a re-write of: https://patchwork=2Ekernel=2Eorg/patch/10205359/
>>=20
>> Signed-off-by: Ognjen Galic <smclt30p@gmail=2Ecom>
>> ---
>>  drivers/acpi/battery=2Ec | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/acpi/battery=2Ec b/drivers/acpi/battery=2Ec
>> index bdb24d63=2E=2Ecb4457a7 100644
>> --- a/drivers/acpi/battery=2Ec
>> +++ b/drivers/acpi/battery=2Ec
>> @@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
>>  static bool battery_driver_registered;
>>  static int battery_bix_broken_package;
>>  static int battery_notification_delay_ms;
>> +static int battery_quirk_thinkpad_full;
>>  static unsigned int cache_time =3D 1000;
>>  module_param(cache_time, uint, 0644);
>>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
>> @@ -233,7 +234,8 @@ static int acpi_battery_get_property(struct
>power_supply *psy,
>>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>>  		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>> -		else if (acpi_battery_is_charged(battery))
>> +		else if (acpi_battery_is_charged(battery) ||
>> +				battery_quirk_thinkpad_full)
>>  			val->intval =3D POWER_SUPPLY_STATUS_FULL;
>>  		else
>>  			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>> @@ -1332,6 +1334,13 @@ battery_notification_delay_quirk(const struct
>dmi_system_id *d)
>>  	return 0;
>>  }
>> =20
>> +static int __init
>> +battery_thinkpad_full_charged_quirk(const struct dmi_system_id *d)
>> +{
>> +	battery_quirk_thinkpad_full =3D 1;
>> +	return 0;
>> +}
>> +
>>  static const struct dmi_system_id bat_dmi_table[] __initconst =3D {
>>  	{
>>  		=2Ecallback =3D battery_bix_broken_package_quirk,
>> @@ -1349,6 +1358,14 @@ static const struct dmi_system_id
>bat_dmi_table[] __initconst =3D {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
>>  		},
>>  	},
>> +	{
>> +		=2Ecallback =3D battery_thinkpad_full_charged_quirk,
>> +		=2Eident =3D "Lenovo ThinkPad",
>> +		=2Ematches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
>> +		},
>> +	},
>>  	{},
>>  };
>> =20
>> --=20
>> 2=2E15=2E1
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
