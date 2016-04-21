From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v9 0/3] gpio: dwapb: add gpio-signaled acpi event support
 for power button
Date: Thu, 21 Apr 2016 19:42:11 +0800
Message-ID: <5718BC93.2000407@huawei.com>
References: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
 <CAHp75VfW=07SQdR3rH1gh0Q-CEBkBDrdNgoeYKc7QGbVB6THfw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfW=07SQdR3rH1gh0Q-CEBkBDrdNgoeYKc7QGbVB6THfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/4/20 21:06, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Apr 20, 2016 at 10:13 AM, Jiang Qiu <qiujiang@huawei.com> wro=
te:
>> This patchset adds gpio-signaled acpi events support for power butto=
n on hisilicon
>> D02 board.
>>
>> The three patches respectively:
>>         - remove name from dwapb_port_property
>>         - convert device node to fwnode
>>         - add gpio-signaled acpi event support
>>
>>    This patchset is based on
>>    https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio=
=2Egit
>>    branch "devel"
>>
>> Changes v8 -> v9:
>>    - fixed a low-level compile warning
>=20
> Please, don't send updates to often. You see, now I noticed one more
> thing you have to address.
> Usually the time between fixup series is something like 24h. Thus,
> waiting for v10 at least tomorrow or even next week.
>=20
Thanks for the reminder. I made a mistake when I finished my test and m=
erge
the last code because my careless. I'm too anxious to correct it :)

> Linus, for my point of view next version should be fine and final. Th=
e
> current code is in a good shape already.
>=20
>>
>> Changes v7 -> v8:
>>    - fixed few minors
>>
>> Changes v6 -> v7:
>>    - add patch1 by Alan's suggestion
>>
>> Changes v5 -> v6:
>>    - merge patch 2~3 to one patch
>>    - small fixed from Alan's suggestion
>>    - fixed subject title reference commit history
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
>> Jiang Qiu (3):
>>   gpio: dwapb: remove name from dwapb_port_property
>>   gpio: dwapb: convert device node to fwnode
>>   gpio: dwapb: add gpio-signaled acpi event support
>>
>>  drivers/gpio/gpio-dwapb.c                | 78 +++++++++++++++++++--=
-----------
>>  drivers/mfd/intel_quark_i2c_gpio.c       |  3 +-
>>  include/linux/platform_data/gpio-dwapb.h |  3 +-
>>  3 files changed, 48 insertions(+), 36 deletions(-)
>>
>> --
>> 1.9.1
>>
>=20
>=20
>=20
