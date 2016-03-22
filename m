From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Tue, 22 Mar 2016 11:38:26 +0100
Message-ID: <CACRpkdYb8HYXta3yHB4-n-KtSAhyrREUGJJMOUbt3ZXvSUbn6Q@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
	<1457077474-124064-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 4, 2016 at 8:44 AM, qiujiang <qiujiang@huawei.com> wrote:

> This patch converts device node to fwnode in
> dwapb_port_property for designware gpio driver,
> so as to provide a unified data structure for DT
> and ACPI bindings.
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

I need Mika's and maybe also Rafael's ACKs on this before
I merge any of the series.

> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -227,7 +227,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>                 return -ENOMEM;
>
>         /* Set the properties for portA */
> -       pdata->properties->node         = NULL;
> +       pdata->properties->fwnode       = NULL;

And apparently also the MFD maintainer needs to be involved to ACK this,
so add Lee Jones on subsequent postings.

Yours,
Linus Walleij
