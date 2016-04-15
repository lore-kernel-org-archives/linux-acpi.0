From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Fri, 15 Apr 2016 09:40:05 +0200
Message-ID: <CACRpkdY=i9BVYEpu0svmKOQJURH2nQ5iwCM0895fODmkVuPBew@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
	<1459926480-32966-4-git-send-email-qiujiang@huawei.com>
	<CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
	<20160408083830.GT1727@lahna.fi.intel.com>
	<570B9BEA.8060608@huawei.com>
	<20160412064657.GF1714@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160412064657.GF1714@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiang Qiu <qiujiang@huawei.com>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 12, 2016 at 8:46 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Apr 11, 2016 at 08:43:22PM +0800, Jiang Qiu wrote:
>> > Currently it just complains if something goes wrong. The GPIO driver
>> > itself can still work just fine (including interrupts).
>> >
>> > I'm fine to change it to return an error code.
>> Agree, if add a error code for acpi_gpiochip_request_interrupts(), it looks more pretty.
>>
>> However, this function is common for other part, maybe cause any other effects if I
>> do this change, did you think so?
>
> I'm thinking what the callers are going to do with the error code.
> Basically it means that we were not able to attach and configure ACPI
> event GPIOs. It does not prevent GPIO drivers from functioning so they
> probably just print out some warning message and continue probing, and
> we already warn in acpi_gpiochip_request_interrupts() if something fails.
>
> Unless Linus W insists, let's just keep it as is for now :)

I'm fine with it, don' worry.

I'm just waiting for this patch set to mature so I can apply
it.

Yours,
Linus Walleij
