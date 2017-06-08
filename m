From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual
 GPIO device
Date: Thu, 8 Jun 2017 08:45:41 -0700
Message-ID: <20170608154541.GH32509@fury>
References: <20170602151507.22391-1-hdegoede@redhat.com>
 <20170602151507.22391-2-hdegoede@redhat.com>
 <CAHp75Vcdznj2mB+msNvysrvRi3L-0j4c6vthOS8oAv1S9iYWKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44603 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdFHPpp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2017 11:45:45 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vcdznj2mB+msNvysrvRi3L-0j4c6vthOS8oAv1S9iYWKA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Wed, Jun 07, 2017 at 05:53:38PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 2, 2017 at 6:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Some peripherals on Bay Trail and Cherry Trail platforms signal a
> > Power Management Event (PME) to the Power Management Controller (PMC)
> > to wakeup the system. When this happens software needs to explicitly
> > clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
> > IRQ storm on IRQ 9.
> >
> > This is modelled in ACPI through the INT0002 ACPI device, which is
> > called a "Virtual GPIO controller" in ACPI because it defines the
> > event handler to call when the PME triggers through _AEI and _L02
> > methods as would be done for a real GPIO interrupt in ACPI.
> >
> > This commit adds a driver which registers the Virtual GPIOs expected
> > by the DSDT on these devices, letting gpiolib-acpi claim the
> > virtual GPIO and install a GPIO-interrupt handler which call the _L02
> > handler as it would for a real GPIO controller.
> >
> 
> Pushed to testing w/o Linus' tag (there is no one yet)

Will you be taking this through fixes Andy? For a 4.12-rc* target per Hans'
response to the cover letter?

-- 
Darren Hart
VMware Open Source Technology Center
