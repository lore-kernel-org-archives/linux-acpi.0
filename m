From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v9 1/3] gpio: dwapb: remove name from dwapb_port_property
Date: Fri, 29 Apr 2016 11:21:09 +0200
Message-ID: <CACRpkdb4sOeDJaaU8ZMVB7fL7DtnsoGUnraatgkMbtSAaBLD5g@mail.gmail.com>
References: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
	<1461136429-85114-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461136429-85114-2-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Qiu <qiujiang@huawei.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 20, 2016 at 9:13 AM, Jiang Qiu <qiujiang@huawei.com> wrote:

> This patch removed the name property from dwapb_port_property.
> The name property is redundant, since we can get this info
> from dwapb_gpio dev node.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jiang Qiu <qiujiang@huawei.com>

The people patching this driver in the past didn't say anything so
OK patch applied.

Yours,
Linus Walleij
