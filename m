From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Thu, 20 Jul 2017 09:15:34 +0100
Message-ID: <20170720081534.jy3ajvtgm45u4bic@dell>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
 <20170607115827.GY1019@valkosipuli.retiisi.org.uk>
 <6F87890CF0F5204F892DEA1EF0D77A59725BECB0@FMSMSX114.amr.corp.intel.com>
 <20170612082038.x6z3rx2bknxmfyfp@dell>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF469@FMSMSX114.amr.corp.intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725DCCC2@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35446 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934584AbdGTIPi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 04:15:38 -0400
Received: by mail-wr0-f182.google.com with SMTP id k71so13985778wrc.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2017 01:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725DCCC2@FMSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: 'Sakari Ailus' <sakari.ailus@iki.fi>, 'Andy Shevchenko' <andy.shevchenko@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-gpio@vger.kernel.org'" <linux-gpio@vger.kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Alexandre Courbot' <gnurou@gmail.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Len Brown' <lenb@kernel.org>

On Wed, 19 Jul 2017, Mani, Rajmohan wrote:

> Hi Lee,
> 
> > > On Fri, 09 Jun 2017, Mani, Rajmohan wrote:
> > >
> > > > Hi Andy,
> > > >
> > > > > On Tue, Jun 06, 2017 at 03:59:49PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani
> > > > > <rajmohan.mani@intel.com> wrote:
> > > > > > > The TPS68470 device is an advanced power management unit that
> > > > > > > powers a Compact Camera Module (CCM), generates clocks for
> > > > > > > image sensors, drives a dual LED for Flash and incorporates
> > > > > > > two LED drivers for general purpose indicators.
> > > > > > >
> > > > > > > This patch adds support for TPS68470 mfd device.
> > > > > >
> > > > > > I dunno why you decide to send this out now, see my comments
> > below.
> > > > > >
> > > > > > > +static int tps68470_chip_init(struct tps68470 *tps) {
> > > > > > > +       unsigned int version;
> > > > > > > +       int ret;
> > > > > >
> > > > > > > +       /* FIXME: configure these dynamically */
> > > > > >
> > > > > > So, what prevents you to fix this?
> > > > >
> > > > > Nothing I suppose. They're however not needed right now and can be
> > > > > implemented later on if they're ever needed.
> > > > >
> > > >
> > > > Ack
> > >
> > > What does this mean?  Is the plan to fix it or not?  I don't want
> > > FIXMEs in the code that a) can be fixed right away or b) might never be
> > fixed.
> > >
> > 
> > I meant that this can be implemented later on, if there's a need.
> > I will look into this and see how this can be fixed.
> > 
> 
> Thanks for your patience.
> This is fixed with v4 of this series.

Great, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
