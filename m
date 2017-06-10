From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Sat, 10 Jun 2017 00:07:40 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BED54@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <20170607120730.GZ1019@valkosipuli.retiisi.org.uk>
 <CAHp75Ve1GnJZH0KJDMdjHiEjNtpcsZgF6WnBHz+Bb9CDX2zYaQ@mail.gmail.com>
 <20170607200617.GD1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdFJAHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 20:07:43 -0400
In-Reply-To: <20170607200617.GD1019@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Hi Sakari, Andy,

> Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
> region driver
> 
> On Wed, Jun 07, 2017 at 04:37:12PM +0300, Andy Shevchenko wrote:
> > >> +static acpi_status ti_pmic_common_handler(u32 function,
> > > +                                       acpi_physical_address address,
> > > +                                       u32 bits, u64 *value,
> > > +                                       void *handler_context,
> >
> > > handler_context is unused.
> >
> > >> +                                                  int, int, u64 *),
> > >> +                                       int (*update)(struct regmap *,
> > >> +                                                     int, int, u64),
> > >> +                                       struct ti_pmic_table *table,
> > >> +                                       int table_size)
> >
> > I would even split this to have separate update() and get() paths
> > instead of having such a monster of parameters.
> 
> I'm not really worried about the two callbacks --- you have the compexity,
> which is agruably rather manageable, split into a number of caller functions. I'd
> rather keep it as-is.
> 

Ack

