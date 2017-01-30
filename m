From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Cherryview wake up events
Date: Tue, 31 Jan 2017 00:05:07 +0200
Message-ID: <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
References: <20161205110608.GF1459@lahna.fi.intel.com> <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
 <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net> <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net> <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net> <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net> <20170130205745.wwavipta5hbz5zfz@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170130205745.wwavipta5hbz5zfz@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2017 at 10:57 PM, Johannes Stezenbach <js@sig21.net> wrote:
> On Fri, Jan 27, 2017 at 02:30:58PM +0100, Johannes Stezenbach wrote:
>> On Fri, Jan 27, 2017 at 03:21:22PM +0200, Andy Shevchenko wrote:
>> > On Fri, Jan 27, 2017 at 1:38 PM, Johannes Stezenbach <js@sig21.net> wrote:
>> > > On Fri, Jan 27, 2017 at 12:56:53AM +0200, Andy Shevchenko wrote:
>> >
>> > >> Had you tried to add ID to axp20x-i2c.c ?
>> > >
>> > > Nope, since I have no idea if the axp and TI hardware is similar.
>> >
>> > I think you would give a try.
>>
>> I'll check it.
>
> I checked the reference source code, my impression is the
> TI Dollar Cove and and AXP288 are completely different hardware.

Thanks for checking.

Yes, due to not obvious communication to PMIC. I suppose that the IP
core is quite similar in all of them, the difference is just how OS
and other MCUs in SoC communicate with it.

So, basically what it means that I2C direct communication is prohibited here.

>
>> > > [    5.331709] i2c_designware 808622C1:06: controller timed out
>> > >
>> > This is known: http://www.spinics.net/lists/intel-gfx/msg117738.html
>
> Interestingly via this link I found Intel also published
> the TI DCove source in a patch series against an unspecified kernel:
> https://github.com/01org/ProductionKernelQuilts
> specifically
> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/mfd-intel_soc_pmic-add-TI-variant-of-dollar-cove.patch
> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/PWRBTN-add-driver-for-TI-PMIC.patch
> and some more (the series is quite messy).
>
> For the Asus E200HA I'm not sure if the charger and coulomb
> counter drivers are needed since charging just works and
> the battery status is reported via ACPI.  It seems these
> drivers are only for tablets without ACPI support, right?

Have no idea.

What that code reminds me is MID family of devices. So, power button
is (reasonable) easy to get support of in that case.
Look into drivers/platform/x86/intel_mid_powerbtn.c. I recently
updated it to support Basin Cove on Intel Edison.

-- 
With Best Regards,
Andy Shevchenko
