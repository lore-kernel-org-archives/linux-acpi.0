From: Seblu <seblu@seblu.net>
Subject: Re: [PATCH 2/2] ACPI battery: update battery status first when
 querying from sysfs
Date: Tue, 2 Nov 2010 05:13:54 +0100
Message-ID: <AANLkTikdc-NXUejUW4_LWZBQDf_8qJTPzuaBBLWucGAQ@mail.gmail.com>
References: <1288668295.2234.174.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43595 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab0KBEOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2010 00:14:16 -0400
Received: by gyg4 with SMTP id 4so3734585gyg.19
        for <linux-acpi@vger.kernel.org>; Mon, 01 Nov 2010 21:14:15 -0700 (PDT)
In-Reply-To: <1288668295.2234.174.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, cbou@mail.ru

On Tue, Nov 2, 2010 at 4:24 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Sometimes the Battery driver doesn't get notifications when it's
> plugged/unplugged. And this results in the incorrect Battery
> status reported by the power supply sysfs I/F.
>
> Update the Battery status first when querying from sysfs.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> =A0drivers/acpi/battery.c | =A0 =A03 +++
> =A01 file changed, 3 insertions(+)
>
> Index: linux-2.6/drivers/acpi/battery.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/battery.c
> +++ linux-2.6/drivers/acpi/battery.c
> @@ -184,6 +184,9 @@ static int acpi_battery_get_property(str
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
Hello Zhang,

i trying 2 times your patch and

 $ make
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  LD      drivers/acpi/acpi.o
  LD      drivers/acpi/built-in.o
  LD [M]  drivers/acpi/processor.o
  CC [M]  drivers/acpi/battery.o
drivers/acpi/battery.c: In function =91acpi_battery_get_property=92:
drivers/acpi/battery.c:187:2: error: implicit declaration of function
=91acpi_battery_update=92
drivers/acpi/battery.c: At top level:
drivers/acpi/battery.c:611:12: error: static declaration of
=91acpi_battery_update=92 follows non-static declaration
drivers/acpi/battery.c:187:6: note: previous implicit declaration of
=91acpi_battery_update=92 was here
make[2]: *** [drivers/acpi/battery.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

i've the same error on 2.6.37-rc1 and last linus git.

Regards,


--=20
S=E9bastien Luttringer
www.seblu.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
