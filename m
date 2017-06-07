From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Wed, 7 Jun 2017 23:06:17 +0300
Message-ID: <20170607200617.GD1019@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <20170607120730.GZ1019@valkosipuli.retiisi.org.uk>
 <CAHp75Ve1GnJZH0KJDMdjHiEjNtpcsZgF6WnBHz+Bb9CDX2zYaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Ve1GnJZH0KJDMdjHiEjNtpcsZgF6WnBHz+Bb9CDX2zYaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 07, 2017 at 04:37:12PM +0300, Andy Shevchenko wrote:
> >> +static acpi_status ti_pmic_common_handler(u32 function,
> > +                                       acpi_physical_address address,
> > +                                       u32 bits, u64 *value,
> > +                                       void *handler_context,
> 
> > handler_context is unused.
> 
> >> +                                                  int, int, u64 *),
> >> +                                       int (*update)(struct regmap *,
> >> +                                                     int, int, u64),
> >> +                                       struct ti_pmic_table *table,
> >> +                                       int table_size)
> 
> I would even split this to have separate update() and get() paths
> instead of having such a monster of parameters.

I'm not really worried about the two callbacks --- you have the compexity,
which is agruably rather manageable, split into a number of caller
functions. I'd rather keep it as-is.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
