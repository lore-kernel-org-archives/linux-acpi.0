From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 0/3] gpio: dwapb: add gpio-signaled acpi event support
 for power button
Date: Wed, 20 Apr 2016 16:06:44 +0300
Message-ID: <CAHp75VfW=07SQdR3rH1gh0Q-CEBkBDrdNgoeYKc7QGbVB6THfw@mail.gmail.com>
References: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jiang Qiu <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 20, 2016 at 10:13 AM, Jiang Qiu <qiujiang@huawei.com> wrote:
> This patchset adds gpio-signaled acpi events support for power button on hisilicon
> D02 board.
>
> The three patches respectively:
>         - remove name from dwapb_port_property
>         - convert device node to fwnode
>         - add gpio-signaled acpi event support
>
>    This patchset is based on
>    https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
>    branch "devel"
>
> Changes v8 -> v9:
>    - fixed a low-level compile warning

Please, don't send updates to often. You see, now I noticed one more
thing you have to address.
Usually the time between fixup series is something like 24h. Thus,
waiting for v10 at least tomorrow or even next week.

Linus, for my point of view next version should be fine and final. The
current code is in a good shape already.

>
> Changes v7 -> v8:
>    - fixed few minors
>
> Changes v6 -> v7:
>    - add patch1 by Alan's suggestion
>
> Changes v5 -> v6:
>    - merge patch 2~3 to one patch
>    - small fixed from Alan's suggestion
>    - fixed subject title reference commit history
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
> Jiang Qiu (3):
>   gpio: dwapb: remove name from dwapb_port_property
>   gpio: dwapb: convert device node to fwnode
>   gpio: dwapb: add gpio-signaled acpi event support
>
>  drivers/gpio/gpio-dwapb.c                | 78 +++++++++++++++++++-------------
>  drivers/mfd/intel_quark_i2c_gpio.c       |  3 +-
>  include/linux/platform_data/gpio-dwapb.h |  3 +-
>  3 files changed, 48 insertions(+), 36 deletions(-)
>
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
