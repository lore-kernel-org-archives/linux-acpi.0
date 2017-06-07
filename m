From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Wed, 7 Jun 2017 14:58:30 +0300
Message-ID: <20170607115827.GY1019@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jun 06, 2017 at 03:59:49PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> > The TPS68470 device is an advanced power management
> > unit that powers a Compact Camera Module (CCM),
> > generates clocks for image sensors, drives a dual
> > LED for Flash and incorporates two LED drivers for
> > general purpose indicators.
> >
> > This patch adds support for TPS68470 mfd device.
> 
> I dunno why you decide to send this out now, see my comments below.
> 
> > +static int tps68470_chip_init(struct tps68470 *tps)
> > +{
> > +       unsigned int version;
> > +       int ret;
> 
> > +       /* FIXME: configure these dynamically */
> 
> So, what prevents you to fix this?

Nothing I suppose. They're however not needed right now and can be
implemented later on if they're ever needed.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
