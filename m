From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
Date: Wed, 29 Nov 2017 13:43:53 +0100
Message-ID: <CACRpkdbXdbXWxJyrCQgAoSTyxF8UPn3ZCOTpMDwq=T5ew2-L-Q@mail.gmail.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com> <20171127135444.66735-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127135444.66735-2-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2017 at 2:54 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> We added acpi_gpiochip_pin_to_gpio_offset() because there was a need to
> translate from ACPI GpioIo/GpioInt number to Linux GPIO number in the
> Cherryview pinctrl driver. This translation is necessary because
> Cherryview has gaps in the pin list and the driver used continuous GPIO
> number space in Linux side as follows:
>
>   created GPIO range 0->7 ==> INT33FF:03 PIN 0->7
>   created GPIO range 8->19 ==> INT33FF:03 PIN 15->26
>   created GPIO range 20->25 ==> INT33FF:03 PIN 30->35
>   created GPIO range 26->33 ==> INT33FF:03 PIN 45->52
>   created GPIO range 34->43 ==> INT33FF:03 PIN 60->69
>   created GPIO range 44->54 ==> INT33FF:03 PIN 75->85
>
> For example when ACPI GpioInt resource refers to GPIO 81 (SDMMC3_CD_B)
> we translate from pin 81 to the corresponding Linux GPIO number, which
> is 50. This number is then used when the GPIO is accessed through gpiolib.
>
> It turns out, this is not necessary at all. We can just pass 1:1 mapping
> between Linux GPIO numbers and pin numbers (including gaps) and the
> pinctrl core handles all the details automatically:
>
>   created GPIO range 0->7 ==> INT33FF:03 PIN 0->7
>   created GPIO range 15->26 ==> INT33FF:03 PIN 15->26
>   created GPIO range 30->35 ==> INT33FF:03 PIN 30->35
>   created GPIO range 45->52 ==> INT33FF:03 PIN 45->52
>   created GPIO range 60->69 ==> INT33FF:03 PIN 60->69
>   created GPIO range 75->85 ==> INT33FF:03 PIN 75->85
>
> Here GPIO 81 is exactly same than the hardware pin 81 (SDMMC3_CD_B).
>
> As an added bonus this simplifies both the ACPI GPIO core code and the
> Cherryview pinctrl driver.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I optimistically applied this with the ACKs to the pinctrl tree hoping
it does not
clash with Andy's refactorings that I applied to the GPIO tree.

Let's see what happens.

Yours,
Linus Walleij
