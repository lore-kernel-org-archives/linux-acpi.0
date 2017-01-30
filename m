From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Mon, 30 Jan 2017 21:57:45 +0100
Message-ID: <20170130205745.wwavipta5hbz5zfz@sig21.net>
References: <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
 <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net>
 <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
 <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net>
 <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:51376 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbdA3U6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Jan 2017 15:58:01 -0500
Content-Disposition: inline
In-Reply-To: <20170127133058.pxuovuuqpnffx3py@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>

On Fri, Jan 27, 2017 at 02:30:58PM +0100, Johannes Stezenbach wrote:
> On Fri, Jan 27, 2017 at 03:21:22PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 27, 2017 at 1:38 PM, Johannes Stezenbach <js@sig21.net> wrote:
> > > On Fri, Jan 27, 2017 at 12:56:53AM +0200, Andy Shevchenko wrote:
> > 
> > >> Had you tried to add ID to axp20x-i2c.c ?
> > >
> > > Nope, since I have no idea if the axp and TI hardware is similar.
> > 
> > I think you would give a try.
> 
> I'll check it.

I checked the reference source code, my impression is the
TI Dollar Cove and and AXP288 are completely different hardware.

> > > [    5.331709] i2c_designware 808622C1:06: controller timed out
> > >
> > This is known: http://www.spinics.net/lists/intel-gfx/msg117738.html

Interestingly via this link I found Intel also published
the TI DCove source in a patch series against an unspecified kernel:
https://github.com/01org/ProductionKernelQuilts
specifically
https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/mfd-intel_soc_pmic-add-TI-variant-of-dollar-cove.patch
https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/PWRBTN-add-driver-for-TI-PMIC.patch
and some more (the series is quite messy).

For the Asus E200HA I'm not sure if the charger and coulomb
counter drivers are needed since charging just works and
the battery status is reported via ACPI.  It seems these
drivers are only for tablets without ACPI support, right?


Thanks,
Johannes
