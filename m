From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Tue, 12 Apr 2016 14:55:52 +0800
Message-ID: <570C9BF8.7070400@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
 <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
 <20160408083830.GT1727@lahna.fi.intel.com> <570B9BEA.8060608@huawei.com>
 <20160412064657.GF1714@lahna.fi.intel.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160412064657.GF1714@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/4/12 14:46, Mika Westerberg =E5=86=99=E9=81=93:
> On Mon, Apr 11, 2016 at 08:43:22PM +0800, Jiang Qiu wrote:
>>> Currently it just complains if something goes wrong. The GPIO drive=
r
>>> itself can still work just fine (including interrupts).
>>>
>>> I'm fine to change it to return an error code.
>> Agree, if add a error code for acpi_gpiochip_request_interrupts(), i=
t looks more pretty.
>>
>> However, this function is common for other part, maybe cause any oth=
er effects if I
>> do this change, did you think so?
> I'm thinking what the callers are going to do with the error code.
> Basically it means that we were not able to attach and configure ACPI
> event GPIOs. It does not prevent GPIO drivers from functioning so the=
y
> probably just print out some warning message and continue probing, an=
d
> we already warn in acpi_gpiochip_request_interrupts() if something fa=
ils.
>
> Unless Linus W insists, let's just keep it as is for now :)
=46ine to me, thanks:).
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
