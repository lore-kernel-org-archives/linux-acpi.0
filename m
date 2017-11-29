From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] pinctrl: Align Cannon Lake GPIO number space with Windows
Date: Wed, 29 Nov 2017 13:49:01 +0100
Message-ID: <CACRpkdbPk-78bTnL36a3i0xUxep-RYVXLifCVQW+ymw0Nuvy=w@mail.gmail.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2017 at 2:54 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> It turns out that the Cannon Lake GPIO driver in Windows uses different
> GPIO numbering scheme than what Linux uses. Instead of hardware numbers it
> has "banks" of 32 pins even if the hardware group actually does not have
> that many pins. This is problematic for Linux because BIOS uses the same
> Windows numbering scheme in ACPI GpioIo/GpioInt resources, making Linux to
> pick a wrong pin.
>
> For example the SD card detection GPIO resource in BIOS ACPI tables looks
> like:
>
>   GpioInt (...) {231} // vSD3_CD_B
>
> Where the real hardware number would be 180 instead of 231.
>
> Unfortunately changing the BIOS and the Windows driver is not possible for
> Cannon Lake anymore so we need to handle it in Linux instead. This should
> be done properly in future platforms.
>
> The patch series updates the Intel pinctrl driver to allow passing custom
> GPIO number space, taking advantage of pin ranges supported by the pinctrl
> core. However, before we can add these pin ranges we need to drop the
> custom Cherryview GPIO/ACPI translation first and make the driver to use
> direct mapping instead (which turns out to be much simpler).
>
> Once that is done we update the Cannon Lake pinctrl driver to align with
> the Windows GPIO driver numbering scheme.
>
> Mika Westerberg (3):
>   gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
>   pinctrl: intel: Allow custom GPIO base for pad groups
>   pinctrl: cannonlake: Align GPIO number space with Windows

I applied these with Andy's ACKs.

I guess I vageuly understand what happened.

So the ACPI GPIO numberspace was misaligned with the
actual hardware GPIO numberspace. That's unfortunate.

I hope these is nothing in here trying to align the *LINUX*
global GPIO numberspace with this weirdness and that
lsgpio still gives something reasonable per-gpiochip?

Yours,
Linus Walleij
