From: Seblu <seblu@seblu.net>
Subject: Re: [PATCH 2/2] ACPI battery: update battery status first when
 querying from sysfs
Date: Tue, 2 Nov 2010 19:22:58 +0100
Message-ID: <AANLkTiknBGQUerWYVQ-4EnuYqYRNneK0PaRmcCdyCRyb@mail.gmail.com>
References: <1288668295.2234.174.camel@rui> <AANLkTikdc-NXUejUW4_LWZBQDf_8qJTPzuaBBLWucGAQ@mail.gmail.com>
 <1288675340.2234.176.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63366 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab0KBSXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2010 14:23:20 -0400
Received: by vws13 with SMTP id 13so5316010vws.19
        for <linux-acpi@vger.kernel.org>; Tue, 02 Nov 2010 11:23:19 -0700 (PDT)
In-Reply-To: <1288675340.2234.176.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cbou@mail.ru" <cbou@mail.ru>

On Tue, Nov 2, 2010 at 6:22 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Tue, 2010-11-02 at 12:13 +0800, Seblu wrote:
>> On Tue, Nov 2, 2010 at 4:24 AM, Zhang Rui <rui.zhang@intel.com> wrot=
e:
>> >
>> > Sometimes the Battery driver doesn't get notifications when it's
>> > plugged/unplugged. And this results in the incorrect Battery
>> > status reported by the power supply sysfs I/F.
>> >
>> > Update the Battery status first when querying from sysfs.
>> >
>> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> > ---
>> > =A0drivers/acpi/battery.c | =A0 =A03 +++
>> > =A01 file changed, 3 insertions(+)
>> >
>> > Index: linux-2.6/drivers/acpi/battery.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/battery.c
>> > +++ linux-2.6/drivers/acpi/battery.c
>> > @@ -184,6 +184,9 @@ static int acpi_battery_get_property(str
>> > =A0 =A0 =A0 =A0int ret =3D 0;
>> > =A0 =A0 =A0 =A0struct acpi_battery *battery =3D to_acpi_battery(ps=
y);
>> >
>> > + =A0 =A0 =A0 if (acpi_battery_update(battery))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> > +
>> > =A0 =A0 =A0 =A0if (acpi_battery_present(battery)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* run battery update only if it is=
 present */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_battery_get_state(battery);
>> >
>> >
>> >
>> Hello Zhang,
>>
>> i trying 2 times your patch and
>>
>> =A0$ make
>> =A0 CHK =A0 =A0 include/linux/version.h
>> =A0 CHK =A0 =A0 include/generated/utsrelease.h
>> =A0 CALL =A0 =A0scripts/checksyscalls.sh
>> =A0 CHK =A0 =A0 include/generated/compile.h
>> =A0 LD =A0 =A0 =A0drivers/acpi/acpi.o
>> =A0 LD =A0 =A0 =A0drivers/acpi/built-in.o
>> =A0 LD [M] =A0drivers/acpi/processor.o
>> =A0 CC [M] =A0drivers/acpi/battery.o
>> drivers/acpi/battery.c: In function =91acpi_battery_get_property=92:
>> drivers/acpi/battery.c:187:2: error: implicit declaration of functio=
n
>> =91acpi_battery_update=92
>> drivers/acpi/battery.c: At top level:
>> drivers/acpi/battery.c:611:12: error: static declaration of
>> =91acpi_battery_update=92 follows non-static declaration
>> drivers/acpi/battery.c:187:6: note: previous implicit declaration of
>> =91acpi_battery_update=92 was here
>> make[2]: *** [drivers/acpi/battery.o] Error 1
>> make[1]: *** [drivers/acpi] Error 2
>> make: *** [drivers] Error 2
>>
>> i've the same error on 2.6.37-rc1 and last linus git.
>>
> oops. wrong version attached.
> how about this one?
>
> Sometimes the Battery driver doesn't get notifications when it's
> plugged/unplugged. And this results in the incorrect Battery
> status reported by the power supply sysfs I/F.
>
> Update the Battery status first when querying from sysfs.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> =A0drivers/acpi/battery.c | =A0 =A05 +++++
> =A01 file changed, 5 insertions(+)
>
> Index: linux-2.6/drivers/acpi/battery.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/battery.c
> +++ linux-2.6/drivers/acpi/battery.c
> @@ -177,6 +177,8 @@ static int acpi_battery_is_charged(struc
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int acpi_battery_update(struct acpi_battery *battery);
> +
> =A0static int acpi_battery_get_property(struct power_supply *psy,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 enum power_supply_property psp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 union power_supply_propval *val)
> @@ -184,6 +186,9 @@ static int acpi_battery_get_property(str
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0struct acpi_battery *battery =3D to_acpi_battery(psy);
>
> + =A0 =A0 =A0 if (acpi_battery_update(battery))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> =A0 =A0 =A0 =A0if (acpi_battery_present(battery)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* run battery update only if it is pr=
esent */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_battery_get_state(battery);
>
>
>
>
I was not able to reproduce the problem with this patch. It smells good=
!

--=20
S=E9bastien Luttringer
www.seblu.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
