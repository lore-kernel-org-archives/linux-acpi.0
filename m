From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain
 during ->probe()
Date: Thu, 26 Nov 2015 18:45:17 +0200
Message-ID: <1448556317.15393.77.camel@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <565733A2.6050900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4479 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbbKZQrR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 11:47:17 -0500
In-Reply-To: <565733A2.6050900@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, 2015-11-26 at 18:30 +0200, Jarkko Nikula wrote:
> On 11/26/2015 05:19 PM, Andy Shevchenko wrote:
> > This is an amendment to previously pushed commit 01ac170ba29a (ACPI
> > / LPSS:
> > allow to use specific PM domain during ->probe()). We can't assign
> > anything to
> > the platform device on ADD_DEVICE stage since it might be changed
> > during
> > unbound / bind cycle.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0 drivers/acpi/acpi_lpss.c | 9 +++++++--
> > =C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > index f9e0d09..e840229 100644
> > --- a/drivers/acpi/acpi_lpss.c
> > +++ b/drivers/acpi/acpi_lpss.c
> > @@ -705,8 +705,14 @@ static int acpi_lpss_platform_notify(struct
> > notifier_block *nb,
> > =C2=A0=C2=A0	}
> >=20
> > =C2=A0=C2=A0	switch (action) {
> > -	case BUS_NOTIFY_ADD_DEVICE:
> > +	case BUS_NOTIFY_BIND_DRIVER:
> > =C2=A0=C2=A0		pdev->dev.pm_domain =3D &acpi_lpss_pm_domain;
> > +		break;
> > +	case BUS_NOTIFY_BIND_DRIVER_ERROR:
> > +	case BUS_NOTIFY_UNBOUND_DRIVER:
> > +		pdev->dev.pm_domain =3D NULL;
> > +		break;
> > +	case BUS_NOTIFY_ADD_DEVICE:
>=20
> This won't fix like revert of original commit does. Primary problem
> here=20
> is that there is no explicit power on at all during LPSS device probe
> because dev->pm_domain is set before probing.

And we can't do this as in very original code of acpi_lpss.c since DMA
has to be sure it's powered on while probing. We could guarantee this
only in case when PM domain is assigned already and we do our quirk for
it.

=46rom my point of view we have to fix hang first since it's most painf=
ul
case for users and their experience. Though I'm open to any better
solution if you have any in mind.

>=20
> driver_probe_device
> =C2=A0=C2=A0=C2=A0platform_drv_prove
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_pm_domain_attach
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_dev_pm_attach
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0returns instant=
ly because of dev->pm_domain is set
>=20
> Problem got unnoticed because devices are on during boot but=20
> rmmod/modprobe cycle will hit it.
>=20
> With this patch situation remains the same but works if you assign
> the=20
> domain after probing when BUS_NOTIFY_BOUND_DRIVER notification comes=20
> (s/BUS_NOTIFY_BIND_DRIVER/BUS_NOTIFY_BOUND_DRIVER/ above).
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
