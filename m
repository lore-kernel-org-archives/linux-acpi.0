From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] ACPI battery: update battery status first when
 querying from sysfs
Date: Tue, 02 Nov 2010 13:22:20 +0800
Message-ID: <1288675340.2234.176.camel@rui>
References: <1288668295.2234.174.camel@rui>
	 <AANLkTikdc-NXUejUW4_LWZBQDf_8qJTPzuaBBLWucGAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1885 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936277Ab0KBFWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Nov 2010 01:22:12 -0400
In-Reply-To: <AANLkTikdc-NXUejUW4_LWZBQDf_8qJTPzuaBBLWucGAQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seblu <seblu@seblu.net>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cbou@mail.ru" <cbou@mail.ru>

On Tue, 2010-11-02 at 12:13 +0800, Seblu wrote:
> On Tue, Nov 2, 2010 at 4:24 AM, Zhang Rui <rui.zhang@intel.com> wrote=
:
> >
> > Sometimes the Battery driver doesn't get notifications when it's
> > plugged/unplugged. And this results in the incorrect Battery
> > status reported by the power supply sysfs I/F.
> >
> > Update the Battery status first when querying from sysfs.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/battery.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > Index: linux-2.6/drivers/acpi/battery.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/battery.c
> > +++ linux-2.6/drivers/acpi/battery.c
> > @@ -184,6 +184,9 @@ static int acpi_battery_get_property(str
> >        int ret =3D 0;
> >        struct acpi_battery *battery =3D to_acpi_battery(psy);
> >
> > +       if (acpi_battery_update(battery))
> > +               return -ENODEV;
> > +
> >        if (acpi_battery_present(battery)) {
> >                /* run battery update only if it is present */
> >                acpi_battery_get_state(battery);
> >
> >
> >
> Hello Zhang,
>=20
> i trying 2 times your patch and
>=20
>  $ make
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   LD      drivers/acpi/acpi.o
>   LD      drivers/acpi/built-in.o
>   LD [M]  drivers/acpi/processor.o
>   CC [M]  drivers/acpi/battery.o
> drivers/acpi/battery.c: In function =E2=80=98acpi_battery_get_propert=
y=E2=80=99:
> drivers/acpi/battery.c:187:2: error: implicit declaration of function
> =E2=80=98acpi_battery_update=E2=80=99
> drivers/acpi/battery.c: At top level:
> drivers/acpi/battery.c:611:12: error: static declaration of
> =E2=80=98acpi_battery_update=E2=80=99 follows non-static declaration
> drivers/acpi/battery.c:187:6: note: previous implicit declaration of
> =E2=80=98acpi_battery_update=E2=80=99 was here
> make[2]: *** [drivers/acpi/battery.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
>=20
> i've the same error on 2.6.37-rc1 and last linus git.
>=20
oops. wrong version attached.
how about this one?

Sometimes the Battery driver doesn't get notifications when it's
plugged/unplugged. And this results in the incorrect Battery
status reported by the power supply sysfs I/F.

Update the Battery status first when querying from sysfs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -177,6 +177,8 @@ static int acpi_battery_is_charged(struc
 	return 0;
 }
=20
+static int acpi_battery_update(struct acpi_battery *battery);
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -184,6 +186,9 @@ static int acpi_battery_get_property(str
 	int ret =3D 0;
 	struct acpi_battery *battery =3D to_acpi_battery(psy);
=20
+	if (acpi_battery_update(battery))
+		return -ENODEV;
+
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
