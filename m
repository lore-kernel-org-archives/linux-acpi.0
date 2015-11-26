From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/7] dmaengine: dw: platform: power on device on
 shutdown
Date: Thu, 26 Nov 2015 23:11:57 +0530
Message-ID: <20151126174157.GI2309@localhost>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448551153-84719-6-git-send-email-andriy.shevchenko@linux.intel.com>
 <20151126170105.GE2309@localhost>
 <1448558688.15393.85.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64919 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbbKZRiD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 12:38:03 -0500
Content-Disposition: inline
In-Reply-To: <1448558688.15393.85.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Nov 26, 2015 at 07:24:48PM +0200, Andy Shevchenko wrote:
> On Thu, 2015-11-26 at 22:31 +0530, Vinod Koul wrote:
> > On Thu, Nov 26, 2015 at 05:19:11PM +0200, Andy Shevchenko wrote:
> > > We have to call dw_dma_disable() to stop any ongoing transfer.
> >=20
> > Ok
> >=20
> > > On some platforms we can't do that since DMA device is powered of=
f.
> >=20
> > Umm, you said we have ongoing transfer which means DMA should be
> > on..!!
>=20
> Yes, that's true for HSW/BDW and non-affected BYT/CHT.

Can you please explain even when DMA is in use how can device be powere=
d
off? That does not sound right to me. Is this on GP DMA on BYT/CHT or
something else?

>=20
> Like I mentioned here is no possibility to know which platform we run
> on.
>=20
> Would you like to test this on a real device? We can provide you a
> login.
>=20
> >=20
> > > Moreover we have no
> > > possibility at that point to check if the platform is affected or
> > > not. That's
> > > why we call pm_runtime_get_sync() / pm_runtime_put()
> > > unconditionally. On the
> > > other hand we can't use pm_runtime_suspended() because runtime PM
> > > framework is
> > > not fully used by the driver.
> >=20
> > Shouldn't that be fixed?
>=20
> Do you have any solution how?
>=20
> Rough approach is to turn on it on channel allocation and turn off on
> freeing resources. The obvious downside of this solution is power
> consumption of idling device.

But in that case, the clients should not hold ref of dma chan when idle=
 and
allocate only when required which is a resonable expectation

>=20
> In any case it might be done in the future and it's not a scope of th=
is
> series.

Sounds fine to me
>=20
> >=20
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > ---
> > > =A0drivers/dma/dw/platform.c | 12 ++++++++++++
> > > =A01 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.=
c
> > > index 68a4815..d0734e9 100644
> > > --- a/drivers/dma/dw/platform.c
> > > +++ b/drivers/dma/dw/platform.c
> > > @@ -239,7 +239,19 @@ static void dw_shutdown(struct platform_devi=
ce
> > > *pdev)
> > > =A0{
> > > =A0	struct dw_dma_chip *chip =3D platform_get_drvdata(pdev);
> > > =A0
> > > +	/*
> > > +	=A0* We have to call dw_dma_disable() to stop any ongoing
> > > transfer. On
> > > +	=A0* some platforms we can't do that since DMA device is
> > > powered off.
> > > +	=A0* Moreover we have no possibility to check if the
> > > platform is affected
> > > +	=A0* or not. That's why we call pm_runtime_get_sync() /
> > > pm_runtime_put()
> > > +	=A0* unconditionally. On the other hand we can't use
> > > +	=A0* pm_runtime_suspended() because runtime PM framework is
> > > not fully
> > > +	=A0* used by the driver.
> > > +	=A0*/
> > > +	pm_runtime_get_sync(chip->dev);
> > > =A0	dw_dma_disable(chip);
> > > +	pm_runtime_put_sync_suspend(chip->dev);
> > > +
> > > =A0	clk_disable_unprepare(chip->clk);
> > > =A0}
> > > =A0
> > > --=20
> > > 2.6.2
> > >=20
> >=20
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>=20

--=20
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
