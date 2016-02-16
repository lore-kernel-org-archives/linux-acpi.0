From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Tue, 16 Feb 2016 16:38:43 +0100
Message-ID: <CACRpkdbpysZVN3SGKbX+3rMaua8QBG1Qc0ABa3uVz2Rbfb8v7w@mail.gmail.com>
References: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
	<CACRpkdZNCt_TtA6SR86dVCR7vq5cpVmbzxeTguc7go6vVRkuTg@mail.gmail.com>
	<56C316E8.4090002@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35715 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933024AbcBPPjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 10:39:06 -0500
Received: by mail-ob0-f172.google.com with SMTP id xk3so262916915obc.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2016 07:39:06 -0800 (PST)
In-Reply-To: <56C316E8.4090002@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Tue, Feb 16, 2016 at 1:32 PM, Jiang Qiu <qiujiang@huawei.com> wrote:
> =E5=9C=A8 2016/2/16 2:25, Linus Walleij =E5=86=99=E9=81=93:
>> Mika can you help out looking at this patch. Tell me if you need a c=
opy
>> of the whole patch, I'm not smart with ACPI.
>>
>> On Fri, Feb 5, 2016 at 7:25 AM, qiujiang <qiujiang@huawei.com> wrote=
:
>>
>>> This patch modifies the DesignWare GPIO controller driver to
>>> support the GPIO-signaled ACPI Events. This is used for power
>>> button function on ARM server.
>>>
>>> To make it work, the _AEI and _EVT object must be defined in
>>> the corresponding GPIO driver's dsdt table in UEFI. At the same
>>> time, ACPI daemon component is also necessary.
>>>
>>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>>
>> (...)
>>> --- a/drivers/gpio/gpio-dwapb.c
>>> +++ b/drivers/gpio/gpio-dwapb.c
>>> @@ -23,6 +23,11 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/platform_data/gpio-dwapb.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/gpio.h>
>>
>> You should only need <linux/driver.h>
> Here, I don't understand well. I used driver.h instead acpi.h and
> gpio.h, but it came to compile failed.

Argh sorry.
<linux/gpio/driver.h>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
