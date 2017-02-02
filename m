From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 18:32:33 +0100
Message-ID: <20170202173233.3gk6ko2tnjbhj73y@sig21.net>
References: <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
 <20170202142618.GX2053@lahna.fi.intel.com>
 <20170202143145.xnjnicrxf5uapuwl@sig21.net>
 <20170202150212.GA2053@lahna.fi.intel.com>
 <20170202154243.wxrdcy6yqohcwvw3@sig21.net>
 <20170202155826.GF2053@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:51498 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdBBRco (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 12:32:44 -0500
Content-Disposition: inline
In-Reply-To: <20170202155826.GF2053@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com

On Thu, Feb 02, 2017 at 05:58:26PM +0200, Mika Westerberg wrote:
> On Thu, Feb 02, 2017 at 04:42:43PM +0100, Johannes Stezenbach wrote:
> > On Thu, Feb 02, 2017 at 05:02:12PM +0200, Mika Westerberg wrote:
> > > Is the model Asus E200HA? Something like this (sorry the information is
> > > in Finnish but the machine should look the same):
> > > 
> > > https://www.karkkainen.com/verkkokauppa/asus-e200ha-fd0005ts-11-6--hd-kannettava-tietokone
> > 
> > Looks right, mine is E200HA-FD0004TS but I think that just means dark blue color.
> 
> OK, we have one other Cherrytrail machine here which may have the same
> PMIC. We'll check that first and if it does not have the same, I'll
> order the above machine.

In case it is useful to know, I installed Debian stretch following this:
https://wiki.debian.org/InstallingDebianOn/Asus/E200HA

I built my kernel using a relatively minimal kernel config,
let me know if you want it.  I could also post the
two patches which port the mfd and opregion drivers, but
they are straight forward copies of intel_soc_pmic_crc.c
and intel_pmic_crc.c from 4.10.0-rc6+ with code copy&pasted
from the ProductionKernelQuilts patches and s/crc/dc_ti/ etc.,
except I scamped the thermal handler to skip the ADC driver port for now.


Maybe I should've used intel_pmic_xpower.c instead of
intel_pmic_crc.c, since as I write this I see there
is a no-op intel_xpower_pmic_gpio_handler() registered.
This is the trick that fixes this:
        \_SB.PCI0.I2C7.PMI2.AVBG Integer      ffff8be7b74d9be0 01 = 0000000000000001

But now it generates ACPI errors about thermal zone
and "acpi -V" usually hangs it up.

[    5.500927] ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion] (20160930/evregion-300)
[    5.503842] No Local Variables are initialized for method [TMPR]
[    5.506703] No Arguments are initialized for method [TMPR]
[    5.509557] ACPI Error: Method parse/execution failed [\_SB.ATKD.TMPR] (Node ffff8a7d374e87f8), AE_ERROR (20160930/ps
parse-543)
[    5.512481] ACPI Error: Method parse/execution failed [\_SB.ATKD.WMNB] (Node ffff8a7d374e7ed8), AE_ERROR (20160930/ps
parse-543)
[    6.545403] i2c_designware 808622C1:06: controller timed out
[    6.550763] ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion] (20160930/evregion-300)
[    6.555783] No Local Variables are initialized for method [TMPR]
[    6.558769] No Arguments are initialized for method [TMPR]
[    6.561571] ACPI Error: Method parse/execution failed [\_SB.ATKD.TMPR] (Node ffff8a7d374e87f8), AE_ERROR (20160930/ps
parse-543)
[    6.564487] ACPI Error: Method parse/execution failed [\_SB.ATKD.WMNB] (Node ffff8a7d374e7ed8), AE_ERROR (20160930/ps
parse-543)

(I knew my thermal opregion code was preliminary but I didn't expect it to error.)


Thanks,
Johannes
