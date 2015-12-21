From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI / LPSS: change 'does not' to 'does' in
 comment
Date: Mon, 21 Dec 2015 21:09:59 +0200
Message-ID: <1450724999.30729.251.camel@linux.intel.com>
References: <1450720245-67575-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <56783DEB.7040304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6719 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbbLUTJm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2015 14:09:42 -0500
In-Reply-To: <56783DEB.7040304@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Mon, 2015-12-21 at 10:59 -0700, Al Stone wrote:
> On 12/21/2015 10:50 AM, Andy Shevchenko wrote:
> > The LPSS DMA device does have neither _PS0 nor _PS3 method. Fix the
> > wording in
> > the comment line.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/acpi/acpi_lpss.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > index 84d3d90..6c6661d 100644
> > --- a/drivers/acpi/acpi_lpss.c
> > +++ b/drivers/acpi/acpi_lpss.c
> > @@ -95,7 +95,7 @@ static unsigned int lpss_quirks;
> > =C2=A0/*
> > =C2=A0 * LPSS_QUIRK_ALWAYS_POWER_ON: override power state for LPSS =
DMA
> > device.
> > =C2=A0 *
> > - * The LPSS DMA controller does not have neither _PS0 nor _PS3
> > method. Moreover
> > + * The LPSS DMA controller does have neither _PS0 nor _PS3 method.
> > Moreover
>=20
> Neither of the above are very clear.=C2=A0=C2=A0I think proper Englis=
h would
> be:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0The LPSS DMA controller has neither a _PS0 no=
r a _PS3 method.
>=20
> or, alternatively:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0The LPSS DMA controller does not have either =
a _PS0 or a _PS3
> method.
>=20
> This assumes that the point of the statement is to say that _PS0 and
> _PS3
> methods do not exist for the LPSS DMA controller.

Thanks! Will update this.

>=20
> > =C2=A0 * it can be powered off automatically whenever the last LPSS
> > device goes down.
> > =C2=A0 * In case of no power any access to the DMA controller will =
hang
> > the system.
> > =C2=A0 * The behaviour is reproduced on some HP laptops based on In=
tel
> > BayTrail as
> >=20
>=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
