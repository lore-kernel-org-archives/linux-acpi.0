From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 0/3] gpio: dwapb: add gpio-signaled acpi event support
 for power button
Date: Wed, 6 Apr 2016 16:03:10 +0300
Message-ID: <CAHp75Vdw_xj6Cc+zsM_ba0BPkeV+18dZzGoyyVGOgTKbxZwzdA@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34131 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcDFNDL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2016 09:03:11 -0400
In-Reply-To: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com

On Wed, Apr 6, 2016 at 10:07 AM, qiujiang <qiujiang@huawei.com> wrote:
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

Thanks for new version. Still few minors, but looks pretty match good!

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
> qiujiang (3):
>   gpio: dwapb: remove name from dwapb_port_property
>   gpio: dwapb: convert device node to fwnode
>   gpio: dwapb: add gpio-signaled acpi event support
>
>  drivers/gpio/gpio-dwapb.c                | 76 ++++++++++++++++++--------------
>  drivers/mfd/intel_quark_i2c_gpio.c       |  3 +-
>  include/linux/platform_data/gpio-dwapb.h |  3 +-
>  3 files changed, 46 insertions(+), 36 deletions(-)
>
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
