From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/3] pinctrl: Align Cannon Lake GPIO number space with Windows
Date: Mon, 27 Nov 2017 16:54:41 +0300
Message-ID: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbdK0NzS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Nov 2017 08:55:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

It turns out that the Cannon Lake GPIO driver in Windows uses different
GPIO numbering scheme than what Linux uses. Instead of hardware numbers it
has "banks" of 32 pins even if the hardware group actually does not have
that many pins. This is problematic for Linux because BIOS uses the same
Windows numbering scheme in ACPI GpioIo/GpioInt resources, making Linux to
pick a wrong pin.

For example the SD card detection GPIO resource in BIOS ACPI tables looks
like:

  GpioInt (...) {231} // vSD3_CD_B

Where the real hardware number would be 180 instead of 231.

Unfortunately changing the BIOS and the Windows driver is not possible for
Cannon Lake anymore so we need to handle it in Linux instead. This should
be done properly in future platforms.

The patch series updates the Intel pinctrl driver to allow passing custom
GPIO number space, taking advantage of pin ranges supported by the pinctrl
core. However, before we can add these pin ranges we need to drop the
custom Cherryview GPIO/ACPI translation first and make the driver to use
direct mapping instead (which turns out to be much simpler).

Once that is done we update the Cannon Lake pinctrl driver to align with
the Windows GPIO driver numbering scheme.

Mika Westerberg (3):
  gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
  pinctrl: intel: Allow custom GPIO base for pad groups
  pinctrl: cannonlake: Align GPIO number space with Windows

 drivers/gpio/gpiolib-acpi.c                |  75 +-------------
 drivers/pinctrl/intel/pinctrl-cannonlake.c |  65 ++++++------
 drivers/pinctrl/intel/pinctrl-cherryview.c |  59 ++++-------
 drivers/pinctrl/intel/pinctrl-intel.c      | 156 +++++++++++++++++++++--------
 drivers/pinctrl/intel/pinctrl-intel.h      |   3 +
 5 files changed, 176 insertions(+), 182 deletions(-)

-- 
2.15.0

