From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] ACPI / gpio: Updates to properties
Date: Wed, 28 Sep 2016 23:32:46 +0200
Message-ID: <CAJZ5v0gkdZDnRjy_=tDys8LoKD2g5OZzOfNW6t+q8N3bw2ufUA@mail.gmail.com>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34165 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbcI1Vcs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2016 17:32:48 -0400
In-Reply-To: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

On Fri, Sep 23, 2016 at 4:57 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Hi,
>
> This series brings couple of useful GPIO related properties from Device
> Tree to ACPI _DSD device properties:
>
>   - Names for GPIO lines
>   - GPIO hogging
>   - Holes in GPIO property lists
>
> We are using these to get Intel Galileo better supported in the mainline
> kernel (but these may be useful for other boards as well). For example SPI
> chip select on Galileo is connected to a GPIO line so we need to be able to
> describe it in ACPI, and at the same time allow native chip selects.
>
> GPIO hogging can be used to set initial state of certain GPIOs available on
> the headers regardless of the BIOS settings (which may be wrong as it knows
> nothing about which devices have been connected).
>
> Mika Westerberg (5):
>   ACPI / documentation: Use recommended name in GPIO property names
>   ACPI / gpio: Add support for naming GPIOs
>   ACPI / gpio: Add hogging support
>   ACPI / property: Allow holes in reference properties
>   ACPI / gpio: Allow holes in list of GPIOs for a device
>
>  Documentation/acpi/gpio-properties.txt |  72 ++++++++++++++--
>  drivers/acpi/property.c                | 116 +++++++++++++++++++-------
>  drivers/gpio/gpiolib-acpi.c            | 147 ++++++++++++++++++++++++++++++---
>  include/linux/acpi.h                   |   3 +
>  4 files changed, 292 insertions(+), 46 deletions(-)

I would like to tackle patches [1/5] and [4/5] first, as they are core
patches and the rest is against gpiolib-acpi.

Moreover, the documentation patch [1/5] looks like immediately applicable to me.

Thanks,
Rafael
