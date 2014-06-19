From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V2] ACPI/Battery: Retry to get Battery information if
 failed during probing
Date: Thu, 19 Jun 2014 14:48:09 +0800
Message-ID: <53A287A9.7000203@intel.com>
References: <1402988994-27067-1-git-send-email-tianyu.lan@intel.com> <1474004.fDjayHqHT9@vostro.rjw.lan> <alpine.DEB.2.02.1406181515160.21927@chino.kir.corp.google.com> <2223803.V8Foed99uq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25202 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266AbaFSGtI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2014 02:49:08 -0400
In-Reply-To: <2223803.V8Foed99uq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: David Rientjes <rientjes@google.com>, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8819=E6=97=A5 07:00, Rafael J. Wysocki wrote:
> On Wednesday, June 18, 2014 03:15:47 PM David Rientjes wrote:
>> On Tue, 17 Jun 2014, Rafael J. Wysocki wrote:
>>
>>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>>> index e48fc98..8ed93a3 100644
>>>> --- a/drivers/acpi/battery.c
>>>> +++ b/drivers/acpi/battery.c
>>>> @@ -34,6 +34,7 @@
>>>>  #include <linux/dmi.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/suspend.h>
>>>> +#include <linux/delay.h>
>>>>  #include <asm/unaligned.h>
>>>> =20
>>>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>>>> @@ -1119,7 +1120,7 @@ static struct dmi_system_id bat_dmi_table[] =
=3D {
>>>> =20
>>>>  static int acpi_battery_add(struct acpi_device *device)
>>>>  {
>>>> -	int result =3D 0;
>>>> +	int result =3D 0, retry =3D 5;
>>>>  	struct acpi_battery *battery =3D NULL;
>>>> =20
>>>>  	if (!device)
>>>> @@ -1135,9 +1136,20 @@ static int acpi_battery_add(struct acpi_dev=
ice *device)
>>>>  	mutex_init(&battery->sysfs_lock);
>>>>  	if (acpi_has_method(battery->device->handle, "_BIX"))
>>>>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
>>>> -	result =3D acpi_battery_update(battery, false);
>>>> +
>>>> +	/*
>>>> +	 * Some machines'(E,G Lenovo Z480) ECs are not stable
>>>> +	 * during boot up and this causes battery driver fails to be
>>>> +	 * probed due to failure of getting battery information
>>>> +	 * from EC sometimes. After several retries, the operation
>>>> +	 * may work. So add retry code here and 20ms sleep between
>>>> +	 * every retries.
>>>> +	 */
>>>> +	while ((result =3D acpi_battery_update(battery, false)) && retry=
--)
>>>> +		msleep(20);
>>>>  	if (result)
>>>>  		goto fail;
>>>
>>> Why not to write this as
>>>
>>> 	for (;;) {
>>> 		result =3D acpi_battery_update(battery, false);
>>> 		if (!result)
>>> 			break;
>>> 		else if (!--retry)
>>> 			goto fail;
>>>
>>> 		msleep(20);
>>> 	}
>>>
>>
>> I suggested a similar for loop earlier, I think it's cleaner.
>=20
> Precisely.  And it would be even more clean to introduce
>=20
> static bool acpi_battery_update_retry(struct acpi_battery *battery)
> {
> 	int retry, ret;
>=20
> 	for (retry =3D 5; retry; retry--) {
> 		ret =3D acpi_battery_update(battery, false);
> 		if (!ret)
> 			break;
>=20
> 		msleep(20);
> 	}
> 	return ret;
> }
>=20
> and use that instead of the open-coded loop.

Ok. I will update patch like this.

>=20
> Rafael
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
