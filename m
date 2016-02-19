From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Fri, 19 Feb 2016 09:35:37 +0100
Message-ID: <CACRpkda1JJOg9ZdSL5ccE9oohekNvaDtxiOOTqvOWGhcxVPGjA@mail.gmail.com>
References: <1455694090-41713-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33536 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946116AbcBSIfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2016 03:35:37 -0500
Received: by mail-ob0-f181.google.com with SMTP id jq7so101287955obb.0
        for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2016 00:35:37 -0800 (PST)
In-Reply-To: <1455694090-41713-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Wed, Feb 17, 2016 at 8:28 AM, qiujiang <qiujiang@huawei.com> wrote:

> This patch modifies the DesignWare GPIO controller driver to
> support the GPIO-signaled ACPI Events. This is used for power
> button function on ARM server.
>
> To make it work, the _AEI and _EVT object must be defined in
> the corresponding GPIO driver's dsdt table in UEFI as follow:
>
> Device(GPI0) {
>         Name(_HID, "HISI0181")
>         Name(_ADR, 0) // _ADR: Address
>         Name(_UID, 0)
>
>         Name (_CRS, ResourceTemplate ()  {
>                 Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
>                 Interrupt (ResourceConsumer, Level, ActiveHigh,
>                 Exclusive,,,) {344}
>         })
>
>         Device(PRTa) {
>                 Name (_DSD, Package () {
>                         Package () {
>                                 Package () {"reg",0},
>                                 Package () {"snps,nr-gpios",32},
>                 }
>                 })
>         }
>
>         Name (_AEI, ResourceTemplate () {
>                 GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp, ,
>                 " \\_SB.GPI0") {8}
>         })
>
>         Method (_E08, 0x0, NotSerialized) {
>                 Notify (\_SB.PWRB, 0x80)
>         }
> }
>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

This patch doesn't apply to my tree. Please do the following:

- Rebase on the "devel" branch in the linux-gpio tree:
  https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

- Split in two parts as suggested by Andy S.

- Add Mika's ACKs.

Yours,
Linus Walleij
