From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3] pinctrl: Align Cannon Lake GPIO number space with
 Windows
Date: Wed, 29 Nov 2017 15:09:04 +0200
Message-ID: <20171129130904.GQ22431@lahna.fi.intel.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
 <CACRpkdbPk-78bTnL36a3i0xUxep-RYVXLifCVQW+ymw0Nuvy=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbPk-78bTnL36a3i0xUxep-RYVXLifCVQW+ymw0Nuvy=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 29, 2017 at 01:49:01PM +0100, Linus Walleij wrote:
> On Mon, Nov 27, 2017 at 2:54 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > It turns out that the Cannon Lake GPIO driver in Windows uses different
> > GPIO numbering scheme than what Linux uses. Instead of hardware numbers it
> > has "banks" of 32 pins even if the hardware group actually does not have
> > that many pins. This is problematic for Linux because BIOS uses the same
> > Windows numbering scheme in ACPI GpioIo/GpioInt resources, making Linux to
> > pick a wrong pin.
> >
> > For example the SD card detection GPIO resource in BIOS ACPI tables looks
> > like:
> >
> >   GpioInt (...) {231} // vSD3_CD_B
> >
> > Where the real hardware number would be 180 instead of 231.
> >
> > Unfortunately changing the BIOS and the Windows driver is not possible for
> > Cannon Lake anymore so we need to handle it in Linux instead. This should
> > be done properly in future platforms.
> >
> > The patch series updates the Intel pinctrl driver to allow passing custom
> > GPIO number space, taking advantage of pin ranges supported by the pinctrl
> > core. However, before we can add these pin ranges we need to drop the
> > custom Cherryview GPIO/ACPI translation first and make the driver to use
> > direct mapping instead (which turns out to be much simpler).
> >
> > Once that is done we update the Cannon Lake pinctrl driver to align with
> > the Windows GPIO driver numbering scheme.
> >
> > Mika Westerberg (3):
> >   gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
> >   pinctrl: intel: Allow custom GPIO base for pad groups
> >   pinctrl: cannonlake: Align GPIO number space with Windows
> 
> I applied these with Andy's ACKs.

Thanks!

> I guess I vageuly understand what happened.
> 
> So the ACPI GPIO numberspace was misaligned with the
> actual hardware GPIO numberspace. That's unfortunate.

That's right.

> I hope these is nothing in here trying to align the *LINUX*
> global GPIO numberspace with this weirdness and that
> lsgpio still gives something reasonable per-gpiochip?

The resulting GPIO ranges for the chip look like following on the
problematic system:

# cat /sys/kernel/debug/pinctrl/INT34BB\:00/gpio-ranges 
GPIO ranges handled:
0: INT34BB:00 GPIOS [200 - 224] PINS [0 - 24]
32: INT34BB:00 GPIOS [232 - 257] PINS [25 - 50]
64: INT34BB:00 GPIOS [264 - 271] PINS [51 - 58]
96: INT34BB:00 GPIOS [296 - 320] PINS [68 - 92]
128: INT34BB:00 GPIOS [328 - 351] PINS [93 - 116]
160: INT34BB:00 GPIOS [360 - 383] PINS [117 - 140]
192: INT34BB:00 GPIOS [392 - 423] PINS [141 - 172]
224: INT34BB:00 GPIOS [424 - 431] PINS [173 - 180]
256: INT34BB:00 GPIOS [456 - 479] PINS [181 - 204]
288: INT34BB:00 GPIOS [488 - 511] PINS [205 - 228]

So we will have GPIO ranges for each pad group starting at 32 pin
"boundary" to align it with what the BIOS expects. Pinctrl pin numbers
still follow the hardware numbering and is continuous.
