From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 04/12] gpio: acpi: Even more tighten up ACPI GPIO lookups
Date: Mon, 29 May 2017 11:18:17 +0200
Message-ID: <CACRpkdZ+U+8zBpuWkVcN42Cjtk+csCM0pF1HDn3ssJ45CnQgbg@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-5-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>, Bastien Nocera <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The commit 10cf4899f8af ("gpiolib: tighten up ACPI legacy gpio lookups")
> prevents to getting same resource twice if the driver asks twice using
> different connection ID.
>
> But the whole idea of fallback might bring some problems. Imagine the case when
> we have two versions of BIOS/hardware where in one _DSD is introduced along
> with GPIO resources, but the other one uses just plain GPIO resource for
> another purpose
>
> Case 1:
>
>     Device (DEVX)
>     {
>         ...
>         Name (_CRS, ResourceTemplate ()
>         {
>             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                     "\\_SB.GPO0", 0, ResourceConsumer) {15}
>         })
>         Name (_DSD, Package ()
>         {
>             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>             Package ()
>             {
>                 Package () {"some-gpios", Package() {^DEVX, 0, 0, 0 }},
>             }
>         })
>     }
>
> Case 2:
>
>     Device (DEVX)
>     {
>         ...
>         Name (_CRS, ResourceTemplate ()
>         {
>             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                     "\\_SB.GPO0", 0, ResourceConsumer) {27}
>         })
>     }
>
> To prevent the possible misconfiguration tighten up even more GPIO ACPI lookups
> for case without connection ID provided.
>
> In the past the issue had been triggered by "use mctrl_gpio helpers" series
> [1,2].
>
> [1] commit 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers")
> [2] https://patchwork.kernel.org/patch/9283745/
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
