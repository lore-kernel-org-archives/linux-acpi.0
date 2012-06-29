From: Thadeu Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH missing/21] classmate-laptop: Use struct dev_pm_ops for
	power management
Date: Fri, 29 Jun 2012 08:39:53 -0300
Message-ID: <1340969993.24166.2.camel@Nokia-N900>
References: <201206232306.06602.rjw@sisk.pl>
	  <201206290011.53618.rjw@sisk.pl>
Reply-To: Thadeu Cascardo <cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from trem.minaslivre.org ([74.50.53.205]:36465 "EHLO
	grilo.cascardo.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2F2Lt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jun 2012 07:49:29 -0400
In-Reply-To: <201206290011.53618.rjw@sisk.pl>
Content-ID: <1340969992.24166.1.camel@Nokia-N900>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Daniel Oliveira Nascimento <don@syst.com.br>

----- Original message -----
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Make the classmate-laptop driver define its PM callbacks through
> a struct dev_pm_ops object rather than by using legacy PM hooks
> in struct acpi_device_ops.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>=20
> Hi all,
>=20
> I overlooked the classmate-laptop driver in the ACPI conversion to PM
> handling based on struct dev_pm_ops, so this one should go after [17/=
21]
> and the next patches should be renumbered.
>=20
> Thanks,
> Rafael
>=20
>=20
> ---
>=C2=A0  drivers/platform/x86/classmate-laptop.c |=C2=A0 =C2=A0  13 +++=
+++++-----
>=C2=A0  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> Index: linux/drivers/platform/x86/classmate-laptop.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/platform/x86/classmate-laptop.c
> +++ linux/drivers/platform/x86/classmate-laptop.c
> @@ -362,15 +362,18 @@ static int cmpc_tablet_remove(struct acp
>=C2=A0  =C2=A0=C2=A0=C2=A0 return cmpc_remove_acpi_notify_device(acpi)=
;
>=C2=A0  }
>=C2=A0 =20
> -static int cmpc_tablet_resume(struct acpi_device *acpi)
> +static int cmpc_tablet_resume(struct device *dev)
>=C2=A0  {
> -=C2=A0=C2=A0=C2=A0 struct input_dev *inputdev =3D dev_get_drvdata(&a=
cpi->dev);
> +=C2=A0=C2=A0=C2=A0 struct input_dev *inputdev =3D dev_get_drvdata(de=
v);
> +
>=C2=A0  =C2=A0=C2=A0=C2=A0 unsigned long long val =3D 0;
> -=C2=A0=C2=A0=C2=A0 if (ACPI_SUCCESS(cmpc_get_tablet(acpi->handle, &v=
al)))
> +=C2=A0=C2=A0=C2=A0 if (ACPI_SUCCESS(cmpc_get_tablet(to_acpi_device(d=
ev)->handle, &val)))
>=C2=A0  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 input_report_switch(inpu=
tdev, SW_TABLET_MODE, !val);
>=C2=A0  =C2=A0=C2=A0=C2=A0 return 0;
>=C2=A0  }
>=C2=A0 =20
> +static SIMPLE_DEV_PM_OPS(cmpc_tabled_pm, NULL, cmpc_tablet_resume);
> +
>=C2=A0  static const struct acpi_device_id cmpc_tablet_device_ids[] =3D=
 {
>=C2=A0  =C2=A0=C2=A0=C2=A0 {CMPC_TABLET_HID, 0},
>=C2=A0  =C2=A0=C2=A0=C2=A0 {"", 0}
> @@ -384,9 +387,9 @@ static struct acpi_driver cmpc_tablet_ac
>=C2=A0  =C2=A0=C2=A0=C2=A0 .ops =3D {
>=C2=A0  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .add =3D cmpc_tablet_add=
,
>=C2=A0  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .remove =3D cmpc_tablet_=
remove,
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .resume =3D cmpc_tablet_resume=
,
>=C2=A0  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .notify =3D cmpc_tablet_=
handler,
> -=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 .drv.pm =3D &cmpc_tabled_pm,
>=C2=A0  };
>=C2=A0 =20
>=C2=A0 =20

Aside from the typo tabled,

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
