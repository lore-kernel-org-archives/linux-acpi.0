From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 08/12] gpio: acpi: Override GPIO initialization flags
Date: Mon, 29 May 2017 11:22:14 +0200
Message-ID: <CACRpkdYTCT5Z3h3eJMVenx5vbndEecMYB4gh1LmrJvPMU+R1Xw@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-9-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-9-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This allows ACPI GPIO code to modify flags based on
> ACPI GpioIo() / GpioInt() resources.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
