From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: acpi: work around false-positive -Wstring-overflow warning
Date: Tue, 12 Sep 2017 11:26:08 +0200
Message-ID: <CACRpkdYnA=gwo0B5zTMQQOtdVgWB3w4pha2wASCGMEnT9BihJg@mail.gmail.com>
References: <20170906154756.2133726-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906154756.2133726-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 6, 2017 at 5:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> gcc-7 notices that the pin_table is an array of 16-bit numbers,
> but fails to take the following range check into account:
>
> drivers/gpio/gpiolib-acpi.c: In function 'acpi_gpiochip_request_interrupt':
> drivers/gpio/gpiolib-acpi.c:206:24: warning: '%02X' directive writing between 2 and 4 bytes into a region of size 3 [-Wformat-overflow=]
>    sprintf(ev_name, "_%c%02X",
>                         ^~~~
> drivers/gpio/gpiolib-acpi.c:206:20: note: directive argument in the range [0, 65535]
>    sprintf(ev_name, "_%c%02X",
>                     ^~~~~~~~~
> drivers/gpio/gpiolib-acpi.c:206:3: note: 'sprintf' output between 5 and 7 bytes into a destination of size 5
>    sprintf(ev_name, "_%c%02X",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     pin);
>     ~~~~
>
> As suggested by Andy, this changes the format string to have a fixed length.
> Since modifying the range check did not help, I also opened a bug against
> gcc, see link below.
>
> Fixes: 0d1c28a449c6 ("gpiolib-acpi: Add ACPI5 event model support to gpio.")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://patchwork.kernel.org/patch/9840801/
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82123
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
