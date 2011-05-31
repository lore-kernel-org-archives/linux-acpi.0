From: "Joey Lee" <jlee@novell.com>
Subject: Re: bug in acer-wmi.c, wmid3_set_device_status(),
 initialization of params.
Date: Mon, 30 May 2011 21:39:46 -0600
Message-ID: <4DE4EFA2020000230002D46C@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@joern.heissler.de
Cc: linux-acpi@vger.kernel.org

Hi Joern,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2011-05-31 =E6=96=BC 15:03 +1200=EF=BC=8CJo=
ern Heissler =E6=8F=90=E5=88=B0=EF=BC=9A
> Hello,
>=20
> I think I have found a bug in acer-wmi.c,
> commit 987dfbaa65b2c3568b85e29d2598da08a011ee09:
>=20
> The function wmid3_set_device_status contains:
>=20
>     struct wmid3_gds_input_param params =3D {
>         .function_num =3D 0x1,
>         .hotkey_number =3D 0x01,
>         .devices =3D ACER_WMID3_GDS_WIRELESS &
>                 ACER_WMID3_GDS_THREEG &
>                 ACER_WMID3_GDS_WIMAX &
>                 ACER_WMID3_GDS_BLUETOOTH,
>     };
>=20
> (1<<0) & (1<<6) & (1<<7) & (1<<11) is zero. Meant bitwise or?
>=20

OK, it's my mistake, must be OR but not AND.
I will generate a fix patch, I will test it again, please kindly help
test it later.

> And could someone please update the driver to support my laptop?
> See https://bugzilla.kernel.org/show_bug.cgi?id=3D36322 for details :=
-)
>=20
> Cheery
> Joern Heissler

I will take look at.


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
