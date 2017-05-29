From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 02/12] gpio: acpi: Align acpi_find_gpio() with DT version
Date: Mon, 29 May 2017 11:16:38 +0200
Message-ID: <CACRpkdazvNSVCGCXL4G0QBZvFo7-G+Ch_fqEa-5H7q5xrzLGzw@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37145 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdE2JQk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2017 05:16:40 -0400
Received: by mail-it0-f50.google.com with SMTP id g126so23986777ith.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 May 2017 02:16:39 -0700 (PDT)
In-Reply-To: <20170523170327.18055-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> By some reason acpi_find_gpio() and acpi_gpio_count() have compared
> connection ID to "gpios" when tries to check if suffix is needed or not.
>
> Don't do any assumptions about what connection ID can be and, when defined,
> use it only with suffix as it's done in the device tree version.
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
