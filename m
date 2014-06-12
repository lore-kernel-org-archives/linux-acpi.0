From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Thu, 12 Jun 2014 15:19:36 +0800
Message-ID: <53995488.20308@intel.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20386 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470AbaFLHU1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 03:20:27 -0400
In-Reply-To: <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8812=E6=97=A5 14:55, David Rientjes wrote:
> On Thu, 12 Jun 2014, Lan Tianyu wrote:
>=20
>> Some machines'(E,G Lenovo Z480) ECs are not stable during boot up
>> and causes battery driver fails to be probed due to failure of getti=
ng
>> battery information from EC sometimes. After several retries, the
>> operation will work. This patch is to retry to get battery informati=
on 5
>> times if the first try fails.
>>
>> Reported-and-tested-by: naszar <naszar@ya.ru>
>> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D75581
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/battery.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index e48fc98..485009d 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/dmi.h>
>>  #include <linux/slab.h>
>>  #include <linux/suspend.h>
>> +#include <linux/delay.h>
>>  #include <asm/unaligned.h>
>> =20
>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>> @@ -1119,7 +1120,7 @@ static struct dmi_system_id bat_dmi_table[] =3D=
 {
>> =20
>>  static int acpi_battery_add(struct acpi_device *device)
>>  {
>> -	int result =3D 0;
>> +	int result =3D 0, retry =3D 5;
>>  	struct acpi_battery *battery =3D NULL;
>> =20
>>  	if (!device)
>> @@ -1135,7 +1136,16 @@ static int acpi_battery_add(struct acpi_devic=
e *device)
>>  	mutex_init(&battery->sysfs_lock);
>>  	if (acpi_has_method(battery->device->handle, "_BIX"))
>>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
>> +
>> +retry_get_info:
>>  	result =3D acpi_battery_update(battery, false);
>> +
>> +	if (result && retry) {
>> +		msleep(20);
>=20

Hi David:
	Thanks for review.

> We're really going to wait up to 20 * 5 =3D 100ms for acpi_battery_up=
date()=20
> to succeed?

No, this depends which retry acpi_battery_update() will succeed. For
most machines, there will be no delay.

> How are these the numbers that are determined to be optimal=20
> for probing?

So far, it depends the return values of executing ACPI methods. If they
were failed, the probing would not go further.

>=20
>> +		retry--;
>> +		goto retry_get_info;
>> +	}
>=20
> This most certainly could be rewritten as a for-loop and remove the u=
gly=20
> goto.

Ok. I will update.

>=20
>> +
>>  	if (result)
>>  		goto fail;
>>  #ifdef CONFIG_ACPI_PROCFS_POWER


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
