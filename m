From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/4] ACPI / gpio: Updates to properties
Date: Fri, 7 Oct 2016 20:10:26 +0300
Message-ID: <CAHp75Vf3nO6r+D1Fo9Di1UbsRya=08MeKkgKQEsS3KgXgyxcig@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33932 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbcJGRK2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 13:10:28 -0400
In-Reply-To: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 29, 2016 at 4:39 PM, Mika Westerberg
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

Awesome!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> The previous version can be found here:
>
>   http://www.spinics.net/lists/linux-acpi/msg69385.html
>
> Changes from v1:
>   - Drop patch [1/5] as it has been applied already.
>   - Move patch [4/5] to be the first.
>   - Rename acpi_data_get_property_reference() to __acpi_node_get_property_reference().
>   - Drop acpi_node_get_property_reference() as it is not necessary anymore.
>   - Add static inline wrapper acpi_node_get_property_reference() that
>     calls the previous passing MAX_ACPI_REFERENCE_ARGS to support existing
>     drivers.
>
> Mika Westerberg (4):
>   ACPI / property: Allow holes in reference properties
>   ACPI / gpio: Add support for naming GPIOs
>   ACPI / gpio: Add hogging support
>   ACPI / gpio: Allow holes in list of GPIOs for a device
>
>  Documentation/acpi/gpio-properties.txt |  62 ++++++++++++++
>  drivers/acpi/property.c                | 117 +++++++++++++++-----------
>  drivers/gpio/gpiolib-acpi.c            | 147 ++++++++++++++++++++++++++++++---
>  include/linux/acpi.h                   |  22 ++++-
>  4 files changed, 285 insertions(+), 63 deletions(-)
>
> --
> 2.9.3
>



-- 
With Best Regards,
Andy Shevchenko
