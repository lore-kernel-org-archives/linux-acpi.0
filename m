From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Thu, 12 Jun 2014 16:14:10 +0800
Message-ID: <53996152.2000407@intel.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11128 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbaFLIO5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 04:14:57 -0400
In-Reply-To: <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8812=E6=97=A5 15:26, David Rientjes wrote:
> On Thu, 12 Jun 2014, Lan Tianyu wrote:
>=20
>>>> Some machines'(E,G Lenovo Z480) ECs are not stable during boot up
>>>> and causes battery driver fails to be probed due to failure of get=
ting
>>>> battery information from EC sometimes. After several retries, the
>>>> operation will work. This patch is to retry to get battery informa=
tion 5
>>>> times if the first try fails.
>>>>
>>>> Reported-and-tested-by: naszar <naszar@ya.ru>
>>>> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D75581
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>>>> ---
>>>>  drivers/acpi/battery.c | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>>> index e48fc98..485009d 100644
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
>>>> @@ -1135,7 +1136,16 @@ static int acpi_battery_add(struct acpi_dev=
ice *device)
>>>>  	mutex_init(&battery->sysfs_lock);
>>>>  	if (acpi_has_method(battery->device->handle, "_BIX"))
>>>>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
>>>> +
>>>> +retry_get_info:
>>>>  	result =3D acpi_battery_update(battery, false);
>>>> +
>>>> +	if (result && retry) {
>>>> +		msleep(20);
>>>
>>
>> Hi David:
>> 	Thanks for review.
>>
>>> We're really going to wait up to 20 * 5 =3D 100ms for acpi_battery_=
update()=20
>>> to succeed?
>>
>> No, this depends which retry acpi_battery_update() will succeed. For
>> most machines, there will be no delay.
>>
>=20
> Right, but you're willing to wait up to 100ms for it to succeed?  You=
're=20
> implementing x retries with y ms sleep in between, I'm asking how it =
is=20
> determined that the optimal values are x =3D 5 and y =3D 20. More dir=
ectly:
> is it possible to succeed at 101ms?

The retry time is set by randomly and not accurate because don't know
when EC will work normally. Set the retry time to 5 just in order to
make sure battery driver probing sucessfully every time,

>  Is it really likely to succeed after=20
> the first 20ms?
>=20

Yes, it's possible.
=46rom naszar's test log, acpi_battery_update() failed only once. But n=
ot
sure that this happens every time, treat it conservatively and set the
retry time to 5.
https://bugzilla.kernel.org/attachment.cgi?id=3D139081&action=3Dedit

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
