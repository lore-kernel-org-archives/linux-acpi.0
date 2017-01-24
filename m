From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Tue, 24 Jan 2017 14:52:50 +0100
Message-ID: <20170124135250.d72silj6jlxh7zqk@sig21.net>
References: <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
 <20160921090614.GY1811@lahna.fi.intel.com>
 <20160921091635.tjnc2gvj75jixycv@sig21.net>
 <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net>
 <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net>
 <20161205110608.GF1459@lahna.fi.intel.com>
 <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
 <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2017 at 01:14:16PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 24, 2017 at 11:41 AM, Johannes Stezenbach <js@sig21.net> wrote:
> > Meanwhile I found out the TI PMIC and power button drivers
> > has been published as part of the Asus ZenFone Zoom (ZX551ML)
> > Android kernel code drop (based on linux-3.10.x):
> >
> > https://www.asus.com/support/Download/39/1/0/26/BXbNqJplzZiLmk6G/32/
> >
> > Please let me know if there is anything I could do
> > to help get it mainlined soon.
> 
> AFAIK ASuS Zenfone 2 (Intel based) series uses Intel Moorefield. It
> has ShadyCove PMIC.

So Asus released more than they needed.  I confirmed their
source drop contains the TI Dollar Cove driver (dollar_cove_ti.c).
iPreviously I searched for Android devices using CherryView but the
only one I could find is Xioami MiPad 2 and it's released
kernel source doesn't contain the driver.

Anyway, let me know if I can help to get it into mainline soon.


Johannes
