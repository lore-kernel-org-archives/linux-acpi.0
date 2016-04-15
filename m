From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Fri, 15 Apr 2016 15:58:37 +0800
Message-ID: <57109F2D.6020807@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
 <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
 <20160408083830.GT1727@lahna.fi.intel.com> <570B9BEA.8060608@huawei.com>
 <20160412064657.GF1714@lahna.fi.intel.com>
 <CACRpkdY=i9BVYEpu0svmKOQJURH2nQ5iwCM0895fODmkVuPBew@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4663 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbcDOH7n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 03:59:43 -0400
In-Reply-To: <CACRpkdY=i9BVYEpu0svmKOQJURH2nQ5iwCM0895fODmkVuPBew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>

=E5=9C=A8 2016/4/15 15:40, Linus Walleij =E5=86=99=E9=81=93:
> On Tue, Apr 12, 2016 at 8:46 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Mon, Apr 11, 2016 at 08:43:22PM +0800, Jiang Qiu wrote:
>>>> Currently it just complains if something goes wrong. The GPIO driv=
er
>>>> itself can still work just fine (including interrupts).
>>>>
>>>> I'm fine to change it to return an error code.
>>> Agree, if add a error code for acpi_gpiochip_request_interrupts(), =
it looks more pretty.
>>>
>>> However, this function is common for other part, maybe cause any ot=
her effects if I
>>> do this change, did you think so?
>> I'm thinking what the callers are going to do with the error code.
>> Basically it means that we were not able to attach and configure ACP=
I
>> event GPIOs. It does not prevent GPIO drivers from functioning so th=
ey
>> probably just print out some warning message and continue probing, a=
nd
>> we already warn in acpi_gpiochip_request_interrupts() if something f=
ails.
>>
>> Unless Linus W insists, let's just keep it as is for now :)
> I'm fine with it, don' worry.
>
> I'm just waiting for this patch set to mature so I can apply
> it.
Many thanks, I will fix these minor mentioned by Andy and get ready for=
 the new version
ASAP.

Regards,
Jiang
>
> Yours,
> Linus Walleij
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
