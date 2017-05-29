From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 05/12] gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
Date: Mon, 29 May 2017 11:19:09 +0200
Message-ID: <CACRpkdbZj4ktsSY2XcVnPb=O=UJMQWunHRj2BuCr9zEXtNVPyw@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-6-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> If we pass connection ID to the both functions and at the same time
> acpi_can_fallback_to_crs() returns false we will get different results,
> i.e. the number of GPIO resources returned by acpi_gpio_count() might be
> not correct.
>
> Fix this by calling acpi_can_fallback_to_crs() in acpi_gpio_count()
> before trying to fallback.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
