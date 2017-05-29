From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 09/12] gpio: acpi: Split out acpi_gpio_get_irq_resource()
 helper
Date: Mon, 29 May 2017 11:23:32 +0200
Message-ID: <CACRpkdbpmD1xM-qC2AcUGkorKMSbAhxu6ERhG6oZZWz+w=5ejw@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-10-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-10-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The helper does retrieve pointer to struct acpi_resource_gpio from
> struct acpi_resource if it represents GpioInt() resource.
>
> It will be used by PNP code later on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's review tag.

Yours,
Linus Walleij
