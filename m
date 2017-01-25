From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Wed, 25 Jan 2017 11:29:26 +0200
Message-ID: <20170125092926.GO17297@lahna.fi.intel.com>
References: <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net>
 <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net>
 <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
 <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net>
 <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124192314.gw6njffcgwyfm2gp@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2017 at 08:23:14PM +0100, Johannes Stezenbach wrote:
> On Tue, Jan 24, 2017 at 04:28:29PM +0200, Andy Shevchenko wrote:
> > They probably release just almost all One Big Ugly patch from official
> > BSP, which by some reason, includes all Intel MID SoCs, Baytrail.
> > I think I know how Dollar Cove related code ended up there. But that
> > all stuff is a total mess.
> 
> I agree.  Probably it was a mistake to bring up this code here.
> Let me try to go back two steps:  Could you please let me
> know if there is any progress in mainlining the TI Dollar Cove PMIC
> and related drivers?  Is there a schedule?

David, can you please answer this!

> After waiting for four months I'm actually getting impatient
> because by now the Cherryview based hardware seems to go out
> of production and I fear the mainlining might never happen.

If we hear nothing from David soon, I think I'll just take it to my
growing todo list. Unless someone else wants to take it.
