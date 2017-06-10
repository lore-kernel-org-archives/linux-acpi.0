From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Sat, 10 Jun 2017 00:10:41 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BED6B@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
 <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vef=c54O8Xd+aM+eWWVt7nLsczT48WbgrdiOVyWv6xMcg@mail.gmail.com>
 <20170607201050.GE1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vfz=5Siysbzmtyv8TUKs+S+EMBHd8T7zSV-vF+-FEoSaA@mail.gmail.com>
 <20170607211256.GF1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26649 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdFJAKn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 20:10:43 -0400
In-Reply-To: <20170607211256.GF1019@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Hi Sakari, Andy,

> Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
> region driver
> 
> On Wed, Jun 07, 2017 at 11:40:27PM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 7, 2017 at 11:10 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > > On Wed, Jun 07, 2017 at 04:40:13PM +0300, Andy Shevchenko wrote:
> > >> On Wed, Jun 7, 2017 at 3:15 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > >> > On Tue, Jun 06, 2017 at 05:23:56PM +0300, Andy Shevchenko wrote:
> >
> > >> >> Follow the pattern, please, I suppose ti_pmic_tps68470.c
> > >>
> > >> Would it work for you?
> > >
> > > This is still a different driver from the tps68470 driver which is
> > > an MFD driver. For clarity, I'd keep pmic as part of the name (and
> > > I'd use tps68470_pmic_ prefix for internal symbols, too).
> > >
> > > As PMICs are typically linked to the kernel (vs. being modules),
> > > there's no issue with the module name. I would suppose few if any
> > > PMICs will be compiled as modules in general.
> > >
> > > It's not a big deal though. I'm fine either way.
> >
> > Okay, let's agree on  tps68470_pmic for internal prefix and for file name?
> 
> Ack. Thanks!
> 

Ack
