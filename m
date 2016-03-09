From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 0/3] "gpio: designware: add gpio-signaled acpi event
 support for power button"
Date: Wed, 9 Mar 2016 09:26:10 +0700
Message-ID: <CACRpkdZ6Uodt-WTrXjCmaGNQLMChRVXOzKLeGf4JoNtuTvNCGw@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>, Jamie Iles <jamie@jamieiles.com>, Alan Tull <atull@altera.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 4, 2016 at 2:44 PM, qiujiang <qiujiang@huawei.com> wrote:

> This patchset adds gpio-signaled acpi events support for power button on hisilicon
> D02 board.
>
> The three patches respectively:
>         - convert device node to fwnode
>                 - add acpi binding
>         - add gpio-signaled acpi event support
>
>    This patchset is based on
>    https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
>    branch "devel"
>
> Changes v4 -> v5:
>    - split into three patchs
>    - add Andy's ACKs
>
> Changes v3 -> v4:
>    - re-organize this two patchs by Andy's suggestion
>
> Changes v2 -> v3:
>    - fixed the build error reported by Kbuild test robot
>
> Changes v1 -> v2:
>    - rebase to branch "devel" of Linus Walleij's repository
>    - split in two patch as suggested by Andy S
>    - add Mika's ACKs
>
> qiujiang (3):
>   gpio: designware: convert device node to fwnode
>   gpio: designware: add acpi binding
>   gpio: designware: add gpio-signaled acpi event support

I noticed that the original driver authors Jamie and Alan have not been
properly CC:ed on this patch. Jamie, Alan: can you look at this and
ACK it if you like what you see?

Yours,
Linus Walleij
