From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/3] gpio: designware: add acpi binding
Date: Thu, 10 Mar 2016 22:30:10 +0200
Message-ID: <CAHp75VeySD-dLAZ+r-4+R2tUWGL98WL6mi=oJt5rDmFUqamVzA@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
	<1457077474-124064-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457077474-124064-3-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 4, 2016 at 9:44 AM, qiujiang <qiujiang@huawei.com> wrote:
> This patch adds acpi binding for designware gpio driver,
> because it is used to support power button on hisilicon
> d02 board.
>
> These two bindings, DT and acpi, are compatible in this
> driver.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

>  static struct dwapb_platform_data *
> -dwapb_gpio_get_pdata_of(struct device *dev)
> +dwapb_gpio_get_pdata(struct device *dev)

Rename is a part of patch 1

-- 
With Best Regards,
Andy Shevchenko
