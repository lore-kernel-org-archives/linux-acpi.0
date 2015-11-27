From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain
 during ->probe()
Date: Fri, 27 Nov 2015 12:01:25 +0200
Message-ID: <1448618485.15393.108.camel@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <565733A2.6050900@linux.intel.com>
	 <1448556317.15393.77.camel@linux.intel.com>
	 <565800CA.4040003@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <565800CA.4040003@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2015-11-27 at 09:05 +0200, Jarkko Nikula wrote:
> On 11/26/2015 06:45 PM, Andy Shevchenko wrote:
> > On Thu, 2015-11-26 at 18:30 +0200, Jarkko Nikula wrote:
> > > On 11/26/2015 05:19 PM, Andy Shevchenko wrote:
> > > > This is an amendment to previously pushed commit 01ac170ba29a
> > > > (ACPI
> > > > / LPSS:
> > > > allow to use specific PM domain during ->probe()). We can't
> > > > assign
> > > > anything to
> > > > the platform device on ADD_DEVICE stage since it might be
> > > > changed
> > > > during
> > > > unbound / bind cycle.
> > > >=20
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.c
> > > > om>
> > > > ---
> > > > =C2=A0=C2=A0=C2=A0drivers/acpi/acpi_lpss.c | 9 +++++++--
> > > > =C2=A0=C2=A0=C2=A01 file changed, 7 insertions(+), 2 deletions(=
-)
> > > >=20
> > > > diff --git a/drivers/acpi/acpi_lpss.c
> > > > b/drivers/acpi/acpi_lpss.c
> > > > index f9e0d09..e840229 100644
> > > > --- a/drivers/acpi/acpi_lpss.c
> > > > +++ b/drivers/acpi/acpi_lpss.c
> > > > @@ -705,8 +705,14 @@ static int
> > > > acpi_lpss_platform_notify(struct
> > > > notifier_block *nb,
> > > > =C2=A0=C2=A0=C2=A0	}
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0	switch (action) {
> > > > -	case BUS_NOTIFY_ADD_DEVICE:
> > > > +	case BUS_NOTIFY_BIND_DRIVER:
> > > > =C2=A0=C2=A0=C2=A0		pdev->dev.pm_domain =3D &acpi_lpss_pm_domai=
n;
> > > > +		break;
> > > > +	case BUS_NOTIFY_BIND_DRIVER_ERROR:
> > > > +	case BUS_NOTIFY_UNBOUND_DRIVER:
> > > > +		pdev->dev.pm_domain =3D NULL;
> > > > +		break;
> > > > +	case BUS_NOTIFY_ADD_DEVICE:
> > >=20
> > > This won't fix like revert of original commit does. Primary
> > > problem
> > > here
> > > is that there is no explicit power on at all during LPSS device
> > > probe
> > > because dev->pm_domain is set before probing.
> >=20
> > And we can't do this as in very original code of acpi_lpss.c since
> > DMA
> > has to be sure it's powered on while probing. We could guarantee
> > this
> > only in case when PM domain is assigned already and we do our quirk
> > for
> > it.
> >=20
> I'm not sure do I follow here. Is the power on chain different for
> LPSS=20
> DMA because setting the domain at BIND stage prevents the call to=20
> acpi_dev_pm_full_power() before driver probe? See below.
>=20
> driver_probe_device
> =C2=A0=C2=A0=C2=A0really_probe
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0driver_sysfs_add -> BUS_NOTIFY_BIND_DRI=
VER
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> platform_drv_prove
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_pm_domain_attach
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_dev_pm_att=
ach
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(dev->pm_domain) return -EEXIST;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(power_on) { acpi_dev_pm_full_power(adev);... }

And how exactly does it enable a power on DMA controller that doesn't
have _PS0 / _PS3 / _PSC methods?

Maybe I missed something obvious.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> probe
> =C2=A0=C2=A0=C2=A0driver_bound -> BUS_NOTIFY_BOUND_DRIVER


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
