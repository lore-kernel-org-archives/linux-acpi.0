From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/3] pinctrl: Align Cannon Lake GPIO number space with
 Windows
Date: Tue, 28 Nov 2017 23:52:24 +0200
Message-ID: <1511905944.25007.471.camel@linux.intel.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53889 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752468AbdK1Vz2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Nov 2017 16:55:28 -0500
In-Reply-To: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-11-27 at 16:54 +0300, Mika Westerberg wrote:
> Hi,
> 
> It turns out that the Cannon Lake GPIO driver in Windows uses
> different
> GPIO numbering scheme than what Linux uses. Instead of hardware
> numbers it
> has "banks" of 32 pins even if the hardware group actually does not
> have
> that many pins. This is problematic for Linux because BIOS uses the
> same
> Windows numbering scheme in ACPI GpioIo/GpioInt resources, making
> Linux to
> pick a wrong pin.
> 
> For example the SD card detection GPIO resource in BIOS ACPI tables
> looks
> like:
> 
>   GpioInt (...) {231} // vSD3_CD_B
> 
> Where the real hardware number would be 180 instead of 231.
> 
> Unfortunately changing the BIOS and the Windows driver is not possible
> for
> Cannon Lake anymore so we need to handle it in Linux instead. This
> should
> be done properly in future platforms.
> 
> The patch series updates the Intel pinctrl driver to allow passing
> custom
> GPIO number space, taking advantage of pin ranges supported by the
> pinctrl
> core. However, before we can add these pin ranges we need to drop the
> custom Cherryview GPIO/ACPI translation first and make the driver to
> use
> direct mapping instead (which turns out to be much simpler).
> 
> Once that is done we update the Cannon Lake pinctrl driver to align
> with
> the Windows GPIO driver numbering scheme.

For all three:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Mika Westerberg (3):
>   gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
>   pinctrl: intel: Allow custom GPIO base for pad groups
>   pinctrl: cannonlake: Align GPIO number space with Windows
> 
>  drivers/gpio/gpiolib-acpi.c                |  75 +-------------
>  drivers/pinctrl/intel/pinctrl-cannonlake.c |  65 ++++++------
>  drivers/pinctrl/intel/pinctrl-cherryview.c |  59 ++++-------
>  drivers/pinctrl/intel/pinctrl-intel.c      | 156
> +++++++++++++++++++++--------
>  drivers/pinctrl/intel/pinctrl-intel.h      |   3 +
>  5 files changed, 176 insertions(+), 182 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
