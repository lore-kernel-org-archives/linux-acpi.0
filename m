From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/7] dmaengine: dw: platform: power on device on
 shutdown
Date: Thu, 26 Nov 2015 19:58:32 +0200
Message-ID: <1448560712.15393.93.camel@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448551153-84719-6-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20151126170105.GE2309@localhost>
	 <1448558688.15393.85.camel@linux.intel.com>
	 <20151126174157.GI2309@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43368 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbbKZSCk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 13:02:40 -0500
In-Reply-To: <20151126174157.GI2309@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, 2015-11-26 at 23:11 +0530, Vinod Koul wrote:
> On Thu, Nov 26, 2015 at 07:24:48PM +0200, Andy Shevchenko wrote:
> > On Thu, 2015-11-26 at 22:31 +0530, Vinod Koul wrote:
> > > On Thu, Nov 26, 2015 at 05:19:11PM +0200, Andy Shevchenko wrote:
> > > > We have to call dw_dma_disable() to stop any ongoing transfer.
> > >=20
> > > Ok
> > >=20
> > > > On some platforms we can't do that since DMA device is powered
> > > > off.
> > >=20
> > > Umm, you said we have ongoing transfer which means DMA should be
> > > on..!!
> >=20
> > Yes, that's true for HSW/BDW and non-affected BYT/CHT.
>=20
> Can you please explain even when DMA is in use how can device be
> powered
> off? That does not sound right to me.=20

It can't, but the problem is we can't distinguish that in this routine!
We simple do *not* know the actual power state of DMA.

These calls *ensures* that DMA is powered on. Yes, the call to
dw_dma_off() when it used to be powered off sounds silly, I agree,
though I see no upstreamable (non-hackish) solution for that.

Previously I proposed to remove .shutdown hook completely, you were
objecting.

> Is this on GP DMA on BYT/CHT or
> something else?

Correct. Affected platforms are BYT-T and some or all of BSW/CHT
depending on firmware in use.

>=C2=A0
> > Like I mentioned here is no possibility to know which platform we
> > run
> > on.
> >=20
> > Would you like to test this on a real device? We can provide you a
> > login.
> >=20
> > >=20
> > > > Moreover we have no
> > > > possibility at that point to check if the platform is affected
> > > > or
> > > > not. That's
> > > > why we call pm_runtime_get_sync() / pm_runtime_put()
> > > > unconditionally. On the
> > > > other hand we can't use pm_runtime_suspended() because runtime
> > > > PM
> > > > framework is
> > > > not fully used by the driver.
> > >=20
> > > Shouldn't that be fixed?
> >=20
> > Do you have any solution how?
> >=20
> > Rough approach is to turn on it on channel allocation and turn off
> > on
> > freeing resources. The obvious downside of this solution is power
> > consumption of idling device.
>=20
> But in that case, the clients should not hold ref of dma chan when
> idle and
> allocate only when required which is a resonable expectation

There is not the case for few drivers. At least for us it's spi-pxa2xx
one. It requires channels on its ->probe() stage. Jarkko is Cc'ed here,
you may ask him as he is our maintainer for the SPI.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
