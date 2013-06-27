From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Thu, 27 Jun 2013 21:29:39 +0200
Message-ID: <1990033.Jb3giURhtn@vostro.rjw.lan>
References: <1372331314-31010-1-git-send-email-naresh.bhat@linaro.org> <6743122.cV0P3hQa28@vostro.rjw.lan> <CAFoFrHaUbjHbvDDVO0+1j4WSTdhdrWF64MrNvzKNJXaLKSv_jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53469 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab3F0TUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 15:20:09 -0400
In-Reply-To: <CAFoFrHaUbjHbvDDVO0+1j4WSTdhdrWF64MrNvzKNJXaLKSv_jw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naresh Bhat <naresh.bhat@linaro.org>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org

On Thursday, June 27, 2013 06:37:35 PM Naresh Bhat wrote:
> Hi Rafael,
>=20
> You mean I need to initialize using ACPI_STATE_D0 ? and resend the pa=
tch ?

Yes, please.

Although this is a false positive anyway ...

Thanks,
Rafael


> On 27 June 2013 17:58, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, June 27, 2013 04:38:34 PM naresh.bhat@linaro.org wrote=
:
> >> From: Naresh Bhat <naresh.bhat@linaro.org>
> >>
> >>   CC      drivers/acpi/fan.o
> >> drivers/acpi/fan.c: In function =E2=80=98fan_get_cur_state=E2=80=99=
:
> >> drivers/acpi/fan.c:96:9: warning: =E2=80=98acpi_state=E2=80=99 may=
 be used uninitialized in this function [-Wuninitialized]
> >> ---
> >>  drivers/acpi/fan.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> >> index f815da8..f61f7fd 100644
> >> --- a/drivers/acpi/fan.c
> >> +++ b/drivers/acpi/fan.c
> >> @@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cool=
ing_device *cdev, unsigned long
> >>  {
> >>       struct acpi_device *device =3D cdev->devdata;
> >>       int result;
> >> -     int acpi_state;
> >> +     int acpi_state =3D 0;
> >
> > Please use an appropriate symbol here.
> >
> >>
> >>       if (!device)
> >>               return -EINVAL;
> >>
> >
> > Thanks,
> > Rafael
> >
> >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
