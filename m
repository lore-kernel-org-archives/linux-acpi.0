From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v6 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Wed, 15 Nov 2017 03:08:26 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FD33B0@FMSMSX114.amr.corp.intel.com>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
 <20170814203900.qobophvzcrdtv34s@kekkonen.localdomain>
 <20171002165402.5ypqveemuz2ziuiq@valkosipuli.retiisi.org.uk>
 <1897738.1BtWKn31FQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35422 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757427AbdKODI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Nov 2017 22:08:27 -0500
In-Reply-To: <1897738.1BtWKn31FQ@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sakari Ailus <sakari.ailus@iki.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Rafael,

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Tuesday, October 03, 2017 4:44 AM
> To: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: Mani, Rajmohan <rajmohan.mani@intel.com>; linux-
> kernel@vger.kernel.org; linux-gpio@vger.kernel.org; linux-
> acpi@vger.kernel.org; Lee Jones <lee.jones@linaro.org>; Linus Walleij
> <linus.walleij@linaro.org>; Alexandre Courbot <gnurou@gmail.com>; Len
> Brown <lenb@kernel.org>; Andy Shevchenko <andy.shevchenko@gmail.com>
> Subject: Re: [PATCH v6 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
> region driver
> 
> On Monday, October 2, 2017 6:54:03 PM CEST Sakari Ailus wrote:
> > Hi Rafael,
> >
> > On Mon, Aug 14, 2017 at 11:39:00PM +0300, Sakari Ailus wrote:
> > > On Fri, Jul 28, 2017 at 05:30:26PM -0700, Rajmohan Mani wrote:
> > > > The Kabylake platform coreboot (Chrome OS equivalent of
> > > > BIOS) has defined 4 operation regions for the TI TPS68470 PMIC.
> > > > These operation regions are to enable/disable voltage regulators,
> > > > configure voltage regulators, enable/disable clocks and to
> > > > configure clocks.
> > > >
> > > > This config adds ACPI operation region support for TI TPS68470 PMIC.
> > > > TPS68470 device is an advanced power management unit that powers a
> > > > Compact Camera Module (CCM), generates clocks for image sensors,
> > > > drives a dual LED for flash and incorporates two LED drivers for
> > > > general purpose indicators.
> > > > This driver enables ACPI operation region support to control
> > > > voltage regulators and clocks for the TPS68470 PMIC.
> > > >
> > > > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > >
> > > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > The other two patches from the set are in v4.14-rc1.
> 
> Thanks!
> 
> I'll queue it up for 4.15 then.
> 

Thanks. This patch has landed in mainline kernel couple of days ago.

Raj
