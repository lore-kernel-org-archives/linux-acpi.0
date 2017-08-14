From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 2/3] gpio: Add support for TPS68470 GPIOs
Date: Mon, 14 Aug 2017 15:39:16 +0200
Message-ID: <CACRpkdbu0nhXjdvA7X6DPZwKnTEU896EPe3MZsXgi=rgz_w5Kg@mail.gmail.com>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com> <1501288226-27469-3-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501288226-27469-3-git-send-email-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, sakari.ailus@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 29, 2017 at 2:30 AM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:

> This patch adds support for TPS68470 GPIOs.
> There are 7 GPIOs and a few sensor related GPIOs.
> These GPIOs can be requested and configured as
> appropriate.
>
> The GPIOs are also provided with descriptive names.
> However, the typical use case is that the OS GPIO
> driver will interact with TPS68470 GPIO driver
> to configure these GPIOs, as requested by the
> platform firmware.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(...)

> +config GPIO_TPS68470
> +       bool "TPS68470 GPIO"
> +       depends on MFD_TPS68470

Guarded by this symbol, so:
patch applied to the GPIO tree, thanks!

Yours,
Linus Walleij
