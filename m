From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Mon, 01 Jul 2013 15:59:28 +0200
Message-ID: <4129319.59EevnP3PH@vostro.rjw.lan>
References: <1372362463-4186-1-git-send-email-naresh.bhat@linaro.org> <CAFoFrHa_XsKaWDag_k3o_Lgizsf+qZUYPjBn9pvWSe83BY8sOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56074 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab3GANtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2013 09:49:55 -0400
In-Reply-To: <CAFoFrHa_XsKaWDag_k3o_Lgizsf+qZUYPjBn9pvWSe83BY8sOg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naresh Bhat <naresh.bhat@linaro.org>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, Patch Tracking <patches@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org

On Monday, July 01, 2013 05:31:46 PM Naresh Bhat wrote:
> Hi Rafeal,
>=20
> I appreciate if you give any feedback on the provided patch.

The patch is OK, but please add your sign-off.

Thanks,
Rafael


> On 28 June 2013 01:17,  <naresh.bhat@linaro.org> wrote:
> > From: Naresh Bhat <naresh.bhat@linaro.org>
> >
> >   CC      drivers/acpi/fan.o
> > drivers/acpi/fan.c: In function =E2=80=98fan_get_cur_state=E2=80=99=
:
> > drivers/acpi/fan.c:96:9: warning: =E2=80=98acpi_state=E2=80=99 may =
be used uninitialized in this function [-Wuninitialized]
> > ---
> >  drivers/acpi/fan.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> > index f815da8..f961435 100644
> > --- a/drivers/acpi/fan.c
> > +++ b/drivers/acpi/fan.c
> > @@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cooli=
ng_device *cdev, unsigned long
> >  {
> >         struct acpi_device *device =3D cdev->devdata;
> >         int result;
> > -       int acpi_state;
> > +       int acpi_state =3D ACPI_STATE_D0;
> >
> >         if (!device)
> >                 return -EINVAL;
> > --
> > 1.7.9.5
> >
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
