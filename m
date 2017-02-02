From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 17:02:12 +0200
Message-ID: <20170202150212.GA2053@lahna.fi.intel.com>
References: <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
 <20170131143740.lgn2svjskjulsucf@sig21.net>
 <20170202095200.d5clhprl7rpgrf72@sig21.net>
 <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
 <20170202142618.GX2053@lahna.fi.intel.com>
 <20170202143145.xnjnicrxf5uapuwl@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbdBBPEv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 10:04:51 -0500
Content-Disposition: inline
In-Reply-To: <20170202143145.xnjnicrxf5uapuwl@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com

On Thu, Feb 02, 2017 at 03:31:45PM +0100, Johannes Stezenbach wrote:
> On Thu, Feb 02, 2017 at 04:26:18PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 02:52:57PM +0100, Johannes Stezenbach wrote:
> > > Looking at 0002-GPIO-Adding-AXP288-PMIC-GPIO-driver.patch from ProductionKernelQuilts,
> > > it doesn't seem hard to do the same for the TI PMIC, but it needs information
> > > from the PMIC datasheet for irq and gpio control registers.
> > > Hopefully you have a patch or at least could provide the information.
> > 
> > That patch looks like a GPIO driver for DCOVE. Did you try it already?
> 
> Hell, no.  Without datasheets I can't compare if registers
> are compatible between AXP288 and TI DDOVE (SND9039).
> Couldn't it damager the hardware if I mess up charger
> and voltage regulator related registers?

It might yes :)

> And current Linus' tree doesn't have the AXP288 GPIO,
> and ProductionKernelQuilts doesn't use AXP288 GPIO
> for TI DCOVE.

OK, I guess it is easier if I just order one of those machines here and
figure out how to get the PMIC driver working.

Is the model Asus E200HA? Something like this (sorry the information is
in Finnish but the machine should look the same):

https://www.karkkainen.com/verkkokauppa/asus-e200ha-fd0005ts-11-6--hd-kannettava-tietokone

Also can you remind me what exactly is not working so we can prioritize?

Thanks.
