From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/7] dmaengine: dw: platform: power on device on
 shutdown
Date: Thu, 26 Nov 2015 19:24:48 +0200
Message-ID: <1448558688.15393.85.camel@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448551153-84719-6-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20151126170105.GE2309@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59583 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbbKZRYl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 12:24:41 -0500
In-Reply-To: <20151126170105.GE2309@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, 2015-11-26 at 22:31 +0530, Vinod Koul wrote:
> On Thu, Nov 26, 2015 at 05:19:11PM +0200, Andy Shevchenko wrote:
> > We have to call dw_dma_disable() to stop any ongoing transfer.
>=20
> Ok
>=20
> > On some platforms we can't do that since DMA device is powered off.
>=20
> Umm, you said we have ongoing transfer which means DMA should be
> on..!!

Yes, that's true for HSW/BDW and non-affected BYT/CHT.

Like I mentioned here is no possibility to know which platform we run
on.

Would you like to test this on a real device? We can provide you a
login.

>=20
> > Moreover we have no
> > possibility at that point to check if the platform is affected or
> > not. That's
> > why we call pm_runtime_get_sync() / pm_runtime_put()
> > unconditionally. On the
> > other hand we can't use pm_runtime_suspended() because runtime PM
> > framework is
> > not fully used by the driver.
>=20
> Shouldn't that be fixed?

Do you have any solution how?

Rough approach is to turn on it on channel allocation and turn off on
freeing resources. The obvious downside of this solution is power
consumption of idling device.

In any case it might be done in the future and it's not a scope of this
series.

>=20
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/dma/dw/platform.c | 12 ++++++++++++
> > =C2=A01 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> > index 68a4815..d0734e9 100644
> > --- a/drivers/dma/dw/platform.c
> > +++ b/drivers/dma/dw/platform.c
> > @@ -239,7 +239,19 @@ static void dw_shutdown(struct platform_device
> > *pdev)
> > =C2=A0{
> > =C2=A0	struct dw_dma_chip *chip =3D platform_get_drvdata(pdev);
> > =C2=A0
> > +	/*
> > +	=C2=A0* We have to call dw_dma_disable() to stop any ongoing
> > transfer. On
> > +	=C2=A0* some platforms we can't do that since DMA device is
> > powered off.
> > +	=C2=A0* Moreover we have no possibility to check if the
> > platform is affected
> > +	=C2=A0* or not. That's why we call pm_runtime_get_sync() /
> > pm_runtime_put()
> > +	=C2=A0* unconditionally. On the other hand we can't use
> > +	=C2=A0* pm_runtime_suspended() because runtime PM framework is
> > not fully
> > +	=C2=A0* used by the driver.
> > +	=C2=A0*/
> > +	pm_runtime_get_sync(chip->dev);
> > =C2=A0	dw_dma_disable(chip);
> > +	pm_runtime_put_sync_suspend(chip->dev);
> > +
> > =C2=A0	clk_disable_unprepare(chip->clk);
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.6.2
> >=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
