From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 07/12] gpio: acpi: Factor out acpi_gpio_to_gpiod_flags()
 helper
Date: Mon, 29 May 2017 11:21:18 +0200
Message-ID: <CACRpkdYmxPBse5zDiys6t9xFZ4-Mg9cTo5MSOm6EFpkMMhMt0w@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-8-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38227 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdE2JVZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2017 05:21:25 -0400
Received: by mail-it0-f45.google.com with SMTP id r63so24030041itc.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 May 2017 02:21:20 -0700 (PDT)
In-Reply-To: <20170523170327.18055-8-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The helper function acpi_gpio_to_gpiod_flags() will be used later to configure
> pin properly whenever it's requested.
>
> While here, introduce a checking error code returned by gpiod_configure_flags()
> and bail out if it's not okay.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
