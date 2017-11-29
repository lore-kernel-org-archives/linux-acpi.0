From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 4/6] gpiolib: acpi: Consolidate debug output in acpi_gpio_update_gpiod_flags()
Date: Wed, 29 Nov 2017 13:31:19 +0100
Message-ID: <CACRpkdZhSptvurr_=Gt8BS1Jb8CsGy3RBtrdbFR4jKG7z+CRaA@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com> <20171110134033.85461-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171110134033.85461-4-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have the duplicated debug strings printed whenever
> acpi_gpio_update_gpiod_flags() fails. Instead of doing this by callers,
> move the debug output inside function.
>
> In one case convert almost useless pr_debug() to dev_dbg() where
> actual consumer of GPIO resource is disclosed.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
