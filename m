From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Tue, 23 Apr 2019 11:17:32 +0200
Message-ID: <CACRpkda_xw2rdzSLcreHnfdwsmUMTR=+BRHJWjrE31COaZhtZw@mail.gmail.com>
References: <20190405142112.26592-1-yuehaibing@huawei.com> <20190412151911.12084-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412151911.12084-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 12, 2019 at 5:20 PM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_ACPI is not set
> gcc warn this:
>
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This doesn't apply cleanly to any GPIO branch (devel or fixes)
so I assume it is supposed to be applied to the ACPI tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
