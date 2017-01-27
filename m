From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Fri, 27 Jan 2017 14:30:58 +0100
Message-ID: <20170127133058.pxuovuuqpnffx3py@sig21.net>
References: <20161204185219.j45aabkpvptadmcx@sig21.net>
 <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
 <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net>
 <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
 <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net>
 <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:33978 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbdA0NcP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Jan 2017 08:32:15 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>

On Fri, Jan 27, 2017 at 03:21:22PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 27, 2017 at 1:38 PM, Johannes Stezenbach <js@sig21.net> wrote:
> > On Fri, Jan 27, 2017 at 12:56:53AM +0200, Andy Shevchenko wrote:
> 
> > And the same info is also in sysfs:
> >
> > # cat /sys/devices/LNXSYSTM\:00/LNXSYBUS\:00/PNP0A08\:00/808622C1\:06/INT33F4\:00/status
> > 0
> > # cat /sys/devices/LNXSYSTM\:00/LNXSYBUS\:00/PNP0A08\:00/808622C1\:06/INT33F5\:00/status
> > 15
> >
> > The DSDT is still at https://linuxtv.org/~js/e200ha/
> >
> >> Had you tried to add ID to axp20x-i2c.c ?
> >
> > Nope, since I have no idea if the axp and TI hardware is similar.
> 
> I think you would give a try.

I'll check it.

> > There might be more issues, currently the machine hangs often
> > during bootup at random points.  I built i915 as a module and
> > blacklisted it for autoloading so I can read the last message
> > on the console.  All I can say is that it is more likely to
> > hang when the loglevel is high, i.e. it almost never succeeds
> > with "debug" on kernel command line.  Sometimes there are
> > timeout errors from I2C:
> > [    4.307189] i2c_designware 808622C1:06: controller timed out
> > [    5.331709] i2c_designware 808622C1:06: controller timed out
> >
> > Once it has booted it is running stable.
> 
> This is known: http://www.spinics.net/lists/intel-gfx/msg117738.html

Not sure because it happens with i915 module not loaded
(currently I load it manually after boot completed).
But thanks for the link.

Johannes
