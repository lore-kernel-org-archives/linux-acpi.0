From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] ACPI / gpio: Updates to properties
Date: Thu, 29 Sep 2016 14:26:50 +0200
Message-ID: <1990788.iFWTMD2uYN@vostro.rjw.lan>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com> <CAJZ5v0gkdZDnRjy_=tDys8LoKD2g5OZzOfNW6t+q8N3bw2ufUA@mail.gmail.com> <20160929070015.GH1218@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55762 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753068AbcI2MUX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Sep 2016 08:20:23 -0400
In-Reply-To: <20160929070015.GH1218@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, September 29, 2016 10:00:15 AM Mika Westerberg wrote:
> On Wed, Sep 28, 2016 at 11:32:46PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Fri, Sep 23, 2016 at 4:57 PM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > Hi,
> > >
> > > This series brings couple of useful GPIO related properties from Device
> > > Tree to ACPI _DSD device properties:
> > >
> > >   - Names for GPIO lines
> > >   - GPIO hogging
> > >   - Holes in GPIO property lists
> > >
> > > We are using these to get Intel Galileo better supported in the mainline
> > > kernel (but these may be useful for other boards as well). For example SPI
> > > chip select on Galileo is connected to a GPIO line so we need to be able to
> > > describe it in ACPI, and at the same time allow native chip selects.
> > >
> > > GPIO hogging can be used to set initial state of certain GPIOs available on
> > > the headers regardless of the BIOS settings (which may be wrong as it knows
> > > nothing about which devices have been connected).
> > >
> > > Mika Westerberg (5):
> > >   ACPI / documentation: Use recommended name in GPIO property names
> > >   ACPI / gpio: Add support for naming GPIOs
> > >   ACPI / gpio: Add hogging support
> > >   ACPI / property: Allow holes in reference properties
> > >   ACPI / gpio: Allow holes in list of GPIOs for a device
> > >
> > >  Documentation/acpi/gpio-properties.txt |  72 ++++++++++++++--
> > >  drivers/acpi/property.c                | 116 +++++++++++++++++++-------
> > >  drivers/gpio/gpiolib-acpi.c            | 147 ++++++++++++++++++++++++++++++---
> > >  include/linux/acpi.h                   |   3 +
> > >  4 files changed, 292 insertions(+), 46 deletions(-)
> > 
> > I would like to tackle patches [1/5] and [4/5] first, as they are core
> > patches and the rest is against gpiolib-acpi.
> 
> Works for me.
> 
> I can re-arrange the series so that the two core patches (1,4/5) are
> first and then the GPIO parts.
> 
> > Moreover, the documentation patch [1/5] looks like immediately applicable to me.
> 
> Yes, it just fixes the names to match what is preferred.

OK, I'll apply it then, no need to resend.

Thanks,
Rafael

