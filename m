From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 17:58:26 +0200
Message-ID: <20170202155826.GF2053@lahna.fi.intel.com>
References: <20170202095200.d5clhprl7rpgrf72@sig21.net>
 <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
 <20170202142618.GX2053@lahna.fi.intel.com>
 <20170202143145.xnjnicrxf5uapuwl@sig21.net>
 <20170202150212.GA2053@lahna.fi.intel.com>
 <20170202154243.wxrdcy6yqohcwvw3@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdBBP6a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 10:58:30 -0500
Content-Disposition: inline
In-Reply-To: <20170202154243.wxrdcy6yqohcwvw3@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com

On Thu, Feb 02, 2017 at 04:42:43PM +0100, Johannes Stezenbach wrote:
> On Thu, Feb 02, 2017 at 05:02:12PM +0200, Mika Westerberg wrote:
> > OK, I guess it is easier if I just order one of those machines here and
> > figure out how to get the PMIC driver working.
> 
> Oh, I assumed the bottleneck is developer time, not lack of hardware...

Well, both actually ;)

> > Is the model Asus E200HA? Something like this (sorry the information is
> > in Finnish but the machine should look the same):
> > 
> > https://www.karkkainen.com/verkkokauppa/asus-e200ha-fd0005ts-11-6--hd-kannettava-tietokone
> 
> Looks right, mine is E200HA-FD0004TS but I think that just means dark blue color.

OK, we have one other Cherrytrail machine here which may have the same
PMIC. We'll check that first and if it does not have the same, I'll
order the above machine.

> > Also can you remind me what exactly is not working so we can prioritize?
> 
> There are reports hibernate isn't working, presumably because
> the storage is 32MB eMMC.  I've never tried.  It doesn't
> support ACPI S3 (suspend-to-RAM).  So currently one has
> to boot+shutdown everytime (or keep it running).
> 
> 1. There seems to be no way to wake it up after "echo freeze >/sys/power/state".
>    That is the reason for wanting the power button to wake it up.
>    Whether the PB creates an input event is secondary.
>    (the LID also doesn't wake it up, but it creates an input event)
> 2. I've no idea what would be the power consumption in freeze state,
>    so I guess support for the S0ix states is needed
> 3. It randomly hangs at boot, often with a message related to i2c timeout.
>    I tried Hans de Goede's patches but it didn't work for me
>    (question is if the semphore address is the same for
>    AXP288 and TI DCove; the DSDT has the _SEM method so the
>    semphore is needed).
> 
> Everything else is secondary.  E.g. there is an ADC driver used for thermal
> used by the opregion driver, I didn't port it and just implemented
> like for AXP288 by simple register reads (which might not work for TI).
> We could fix this later.

OK, thanks.
