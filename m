From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Thu, 8 Jun 2017 00:12:56 +0300
Message-ID: <20170607211256.GF1019@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
 <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vef=c54O8Xd+aM+eWWVt7nLsczT48WbgrdiOVyWv6xMcg@mail.gmail.com>
 <20170607201050.GE1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vfz=5Siysbzmtyv8TUKs+S+EMBHd8T7zSV-vF+-FEoSaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vfz=5Siysbzmtyv8TUKs+S+EMBHd8T7zSV-vF+-FEoSaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 07, 2017 at 11:40:27PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 7, 2017 at 11:10 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > On Wed, Jun 07, 2017 at 04:40:13PM +0300, Andy Shevchenko wrote:
> >> On Wed, Jun 7, 2017 at 3:15 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> >> > On Tue, Jun 06, 2017 at 05:23:56PM +0300, Andy Shevchenko wrote:
> 
> >> >> Follow the pattern, please, I suppose
> >> >> ti_pmic_tps68470.c
> >>
> >> Would it work for you?
> >
> > This is still a different driver from the tps68470 driver which is an MFD
> > driver. For clarity, I'd keep pmic as part of the name (and I'd use
> > tps68470_pmic_ prefix for internal symbols, too).
> >
> > As PMICs are typically linked to the kernel (vs. being modules), there's no
> > issue with the module name. I would suppose few if any PMICs will be
> > compiled as modules in general.
> >
> > It's not a big deal though. I'm fine either way.
> 
> Okay, let's agree on  tps68470_pmic for internal prefix and for file name?

Ack. Thanks!

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
