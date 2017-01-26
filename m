From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Cherryview wake up events
Date: Fri, 27 Jan 2017 00:56:53 +0200
Message-ID: <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
References: <20160921091635.tjnc2gvj75jixycv@sig21.net> <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net> <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net> <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net> <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net> <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124192314.gw6njffcgwyfm2gp@sig21.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2017 at 9:23 PM, Johannes Stezenbach <js@sig21.net> wrote:
> On Tue, Jan 24, 2017 at 04:28:29PM +0200, Andy Shevchenko wrote:
>> They probably release just almost all One Big Ugly patch from official
>> BSP, which by some reason, includes all Intel MID SoCs, Baytrail.
>> I think I know how Dollar Cove related code ended up there. But that
>> all stuff is a total mess.

I'm reading your long thread about the issue.

> but excluded CONFIG_MFD_AXP20X based on \_SB.PIC0.I2C7.PMI1._STA returning 0 in acpidbg,
> but \_SB.PIC0.I2C7.PMI1._STA returns 0xf

Did you mean PMI2 in the second sentence?
Had you tried to add ID to axp20x-i2c.c ?

> Repeating essential info to avoid any confusion, the PMIC is

In code you found there are two DCove drivers :-) One with "ti" suffix.


-- 
With Best Regards,
Andy Shevchenko
