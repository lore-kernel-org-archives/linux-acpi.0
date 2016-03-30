From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 2/2] gpio: dwapb: add gpio-signaled acpi event support
Date: Wed, 30 Mar 2016 14:41:29 +0300
Message-ID: <CAHp75VcRkwDm60b7PTJmYmPVX7iNoLFL_pcx5qUK8=E7zMyKtw@mail.gmail.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
	<1458959496-57455-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1458959496-57455-3-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 26, 2016 at 4:31 AM, qiujiang <qiujiang@huawei.com> wrote:
> This patch adds gpio-signaled acpi event support. It is used for
> power button on hisilicon D02 board, an arm64 platform.

Yes, looks good, my tag stays.

> @@ -502,10 +509,17 @@ dwapb_gpio_get_pdata(struct device *dev)
>                         }
>                 }
>
> +               if (has_acpi_companion(dev) && pp->idx == 0)
> +                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +

>                 pp->irq_shared  = false;
>                 pp->gpio_base   = -1;


> +
>                 if (dev->of_node)
>                         pp->name = to_of_node(fwnode)->full_name;

This change doesn't belong the patch, though it should gone with the
two lines of pp->name assignment as per Alan's suggestion to get rid
of pp->name completely.

> +
> +               if (has_acpi_companion(dev))
> +                       pp->name = acpi_dev_name(to_acpi_device_node(fwnode));

-- 
With Best Regards,
Andy Shevchenko
