From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Fri, 02 Jun 2017 14:10:33 +0300
Message-ID: <1496401833.28981.48.camel@linux.intel.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
         <CACRpkdb9C0+3SLm9guYqHA_e+F4Tt3mbJJA00+d5PsjeuwzrpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb9C0+3SLm9guYqHA_e+F4Tt3mbJJA00+d5PsjeuwzrpA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2017-06-01 at 17:23 +0200, Linus Walleij wrote:
> On Wed, May 24, 2017 at 12:42 PM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> 
> Please move this thing to drivers/platform/x86.

I'm fine to take it as long it has your Ack.

> > +         Some peripherals on Baytrail and Cherrytrail platforms
> > signal
> > +         PME to the PMC to wakeup the system. When this happens
> > software
> 
> Spell out the acronyms.

PME is standard of PCI, Power Management Event.

PMC — Power Management Controller

PME_B0 — PME Bus 0

STS — status (obviously :-) )

GPE — General Purpose Event (in ACPI terms)

> (...)
> > + * Some peripherals on Bay Trail and Cherry Trail platforms signal
> > PME to the
> > + * PMC to wakeup the system. When this happens software needs to
> > clear the
> > + * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm
> > on IRQ 9.
> 
> Spell out acronyms.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
