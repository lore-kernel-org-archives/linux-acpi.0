From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain during ->probe()
Date: Fri, 27 Nov 2015 00:15:51 +0100
Message-ID: <10907323.ZOUAMFPIfU@vostro.rjw.lan>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com> <565733A2.6050900@linux.intel.com> <1448556317.15393.77.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59983 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752850AbbKZWqJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2015 17:46:09 -0500
In-Reply-To: <1448556317.15393.77.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thursday, November 26, 2015 06:45:17 PM Andy Shevchenko wrote:
> On Thu, 2015-11-26 at 18:30 +0200, Jarkko Nikula wrote:
> > On 11/26/2015 05:19 PM, Andy Shevchenko wrote:
> > > This is an amendment to previously pushed commit 01ac170ba29a (ACPI
> > > / LPSS:
> > > allow to use specific PM domain during ->probe()). We can't assign
> > > anything to
> > > the platform device on ADD_DEVICE stage since it might be changed
> > > during
> > > unbound / bind cycle.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >   drivers/acpi/acpi_lpss.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > > index f9e0d09..e840229 100644
> > > --- a/drivers/acpi/acpi_lpss.c
> > > +++ b/drivers/acpi/acpi_lpss.c
> > > @@ -705,8 +705,14 @@ static int acpi_lpss_platform_notify(struct
> > > notifier_block *nb,
> > >   	}
> > > 
> > >   	switch (action) {
> > > -	case BUS_NOTIFY_ADD_DEVICE:
> > > +	case BUS_NOTIFY_BIND_DRIVER:
> > >   		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
> > > +		break;
> > > +	case BUS_NOTIFY_BIND_DRIVER_ERROR:
> > > +	case BUS_NOTIFY_UNBOUND_DRIVER:
> > > +		pdev->dev.pm_domain = NULL;
> > > +		break;
> > > +	case BUS_NOTIFY_ADD_DEVICE:
> > 
> > This won't fix like revert of original commit does.

Which commit exactly are you talking about, for reference?

> > Primary problem here 
> > is that there is no explicit power on at all during LPSS device probe
> > because dev->pm_domain is set before probing.
> 
> And we can't do this as in very original code of acpi_lpss.c since DMA
> has to be sure it's powered on while probing. We could guarantee this
> only in case when PM domain is assigned already and we do our quirk for
> it.
> 
> From my point of view we have to fix hang first since it's most painful
> case for users and their experience. Though I'm open to any better
> solution if you have any in mind.
> 
> > 
> > driver_probe_device
> >    platform_drv_prove
> >      dev_pm_domain_attach
> >        acpi_dev_pm_attach
> >          returns instantly because of dev->pm_domain is set

This looks like a candidate for the new PM domain callbacks, ->activate and
->dismiss.

->activate() is called before the probe, so it may power up things.

->dismiss() in turn is called in the failed probe case, so it can do the
cleanup.

Have you considered using these?

Thanks,
Rafael

