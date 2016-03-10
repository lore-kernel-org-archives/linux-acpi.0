From: Alan Tull <delicious.quinoa@gmail.com>
Subject: Re: [PATCH v5 0/3] "gpio: designware: add gpio-signaled acpi event
 support for power button"
Date: Thu, 10 Mar 2016 14:10:28 -0600
Message-ID: <CANk1AXT-2BLUzkwWw_UXGf3U2zt=NaoF2p7r5dZtGBZ99-O+BA@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
	<CACRpkdZ6Uodt-WTrXjCmaGNQLMChRVXOzKLeGf4JoNtuTvNCGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34754 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbcCJUKa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 15:10:30 -0500
In-Reply-To: <CACRpkdZ6Uodt-WTrXjCmaGNQLMChRVXOzKLeGf4JoNtuTvNCGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: qiujiang <qiujiang@huawei.com>, Jamie Iles <jamie@jamieiles.com>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>, Alan Tull <delicious.quinoa@gmail.com>

On Tue, Mar 8, 2016 at 8:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Mar 4, 2016 at 2:44 PM, qiujiang <qiujiang@huawei.com> wrote:
>
>> This patchset adds gpio-signaled acpi events support for power button on hisilicon
>> D02 board.
>>
>> The three patches respectively:
>>         - convert device node to fwnode
>>                 - add acpi binding
>>         - add gpio-signaled acpi event support
>>
>>    This patchset is based on
>>    https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
>>    branch "devel"
>>
>> Changes v4 -> v5:
>>    - split into three patchs
>>    - add Andy's ACKs
>>
>> Changes v3 -> v4:
>>    - re-organize this two patchs by Andy's suggestion
>>
>> Changes v2 -> v3:
>>    - fixed the build error reported by Kbuild test robot
>>
>> Changes v1 -> v2:
>>    - rebase to branch "devel" of Linus Walleij's repository
>>    - split in two patch as suggested by Andy S
>>    - add Mika's ACKs
>>
>> qiujiang (3):
>>   gpio: designware: convert device node to fwnode
>>   gpio: designware: add acpi binding
>>   gpio: designware: add gpio-signaled acpi event support
>
> I noticed that the original driver authors Jamie and Alan have not been
> properly CC:ed on this patch. Jamie, Alan: can you look at this and
> ACK it if you like what you see?
>
> Yours,
> Linus Walleij

Hi Linus,

I briefly tested the patches on a ARM CycloneV board and didn't see
any issues.  I looked over the patches (not super familiar with ACPI)
and just had one question (on another thread).

Thanks,
Alan
