From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/8] gpio: acpi: Make it working
Date: Fri, 24 Mar 2017 18:01:57 +0200
Message-ID: <20170324160157.GF2957@lahna.fi.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 23, 2017 at 09:46:10PM +0200, Andy Shevchenko wrote:
> Currently GPIO ACPI library provides an API to get a GPIO resources
> (IO or interrupt) from ACPI tables for the individual drivers.
> 
> This library has few flaws which makes some devices not working:
>  - the library allows to abuse ACPI by using a _CRS fallback mechanism
>  - the library neglects flags of the resource
> 
> In this series:
>  - the _CRS fallback is forbidden
>  - the pin configuration follows what firmware wants to
>  - the documentation is updated in order to clarify corner cases
> 
> After this series it's possible to use GPIO pins for input (interrupt)
> which were configured as output by BIOS by some reason. It's a crucial
> functionality for IoT open connected boards where user may choose any of
> available pin for almost any of available function, including GPIO input
> (interrupt).
> 
> Current bad behaviour was first reported by Jarkko Nikula few months ago.
> 
> Andy Shevchenko (8):
>   gpiolib: Export gpiod_configure_flags() to internal users
>   gpio: acpi: Align acpi_find_gpio() with DT version
>   gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
>   gpio: acpi: Even more tighten up ACPI GPIO lookups
>   gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
>   gpio: acpi: Explain how to get GPIO descriptors in ACPI case
>   gpio: acpi: Factor out acpi_gpio_to_gpiod_flags() helper
>   gpio: acpi: Override GPIO initialization flags
> 
>  Documentation/acpi/gpio-properties.txt |  60 ++++++++++++
>  drivers/gpio/gpiolib-acpi.c            | 162 +++++++++++++++++++--------------
>  drivers/gpio/gpiolib.c                 |  10 +-
>  drivers/gpio/gpiolib.h                 |  17 +++-
>  4 files changed, 176 insertions(+), 73 deletions(-)

Really nice work!

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
