From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Cherryview wake up events
Date: Tue, 24 Jan 2017 16:28:29 +0200
Message-ID: <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
References: <20160920211153.y7ntwwik2l6ppoqz@sig21.net> <20160921090614.GY1811@lahna.fi.intel.com>
 <20160921091635.tjnc2gvj75jixycv@sig21.net> <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net> <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net> <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net> <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35160 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdAXO2a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 09:28:30 -0500
In-Reply-To: <20170124135250.d72silj6jlxh7zqk@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>

On Tue, Jan 24, 2017 at 3:52 PM, Johannes Stezenbach <js@sig21.net> wrote:
> On Tue, Jan 24, 2017 at 01:14:16PM +0200, Andy Shevchenko wrote:
>> On Tue, Jan 24, 2017 at 11:41 AM, Johannes Stezenbach <js@sig21.net> wrote:
>> > Meanwhile I found out the TI PMIC and power button drivers
>> > has been published as part of the Asus ZenFone Zoom (ZX551ML)
>> > Android kernel code drop (based on linux-3.10.x):
>> >
>> > https://www.asus.com/support/Download/39/1/0/26/BXbNqJplzZiLmk6G/32/
>> >
>> > Please let me know if there is anything I could do
>> > to help get it mainlined soon.
>>
>> AFAIK ASuS Zenfone 2 (Intel based) series uses Intel Moorefield. It
>> has ShadyCove PMIC.
>
> So Asus released more than they needed.  I confirmed their
> source drop contains the TI Dollar Cove driver (dollar_cove_ti.c).

They probably release just almost all One Big Ugly patch from official
BSP, which by some reason, includes all Intel MID SoCs, Baytrail.
I think I know how Dollar Cove related code ended up there. But that
all stuff is a total mess.

> Anyway, let me know if I can help to get it into mainline soon.

-- 
With Best Regards,
Andy Shevchenko
