From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 14:52:57 +0100
Message-ID: <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
References: <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net>
 <20170130205745.wwavipta5hbz5zfz@sig21.net>
 <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
 <20170131143740.lgn2svjskjulsucf@sig21.net>
 <20170202095200.d5clhprl7rpgrf72@sig21.net>
 <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:56656 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbdBBNxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 08:53:06 -0500
Content-Disposition: inline
In-Reply-To: <20170202121639.GO2053@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com

On Thu, Feb 02, 2017 at 02:16:39PM +0200, Mika Westerberg wrote:
> On Thu, Feb 02, 2017 at 01:35:08PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 12:12:22PM +0100, Johannes Stezenbach wrote:
> > > On Thu, Feb 02, 2017 at 12:31:22PM +0200, Mika Westerberg wrote:
> > > > On Thu, Feb 02, 2017 at 10:52:00AM +0100, Johannes Stezenbach wrote:
> > > > >                 OperationRegion (GPOP, GeneralPurposeIo, Zero, 0x0100)
> > > > >                 Field (GPOP, ByteAcc, NoLock, Preserve)
> > > > >                 {
> > > > >                     Connection (
> > > > >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> > > > >                             "\\_SB.PCI0.I2C7.PMI2", 0x00, ResourceConsumer, ,
> > > > >                             )
> > > > >                             {   // Pin list
> > > > >                                 0x0020
> > > > >                             }
> > > > >                     ), 
> > > > >                     GMP0,   1, 
> > > > >                     ...
> > > > >                     (repeat for many more pins)
> > > > > 
> > > > > I guess it means it uses chv_gpio pins and can't work
> > > > > if the GPIO opregion is not registered?
> > > > 
> > > > That is using GPIO pins of the PMI2 device - the PMIC GPIO driver, I
> > > > suppose.
> > > > 
> > > > So in addition to the PMIC MFD driver, you need to have a GPIO driver
> > > > for Dollar Cove (I guess the quilt patch series included that as well?).
> > > 
> > > Nope, I see it for AX288 but didn't find it for TI DCove.  And in
> > > current Linus' tree axp288_cells[] doesn't include gpio so
> > > I concluded it's not needed... what am I missing?
> > 
> > So reading your DSDT there is that GPIO button array device \_SB.TBAD
> > which has one GpioInt() referencing \_SB.PCI0.I2C7.PMI2. I suppose that
> > is the power button GPIO.
> > 
> > In order to use that there needs to be a GPIO driver exposing those
> > GPIOs to other drivers. So it is definitely needed.
> 
> Actually, looking again the patches you found:
> 
> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/mfd-intel_soc_pmic-add-TI-variant-of-dollar-cove.patch
> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/PWRBTN-add-driver-for-TI-PMIC.patch
> 
> Did you try to them both? The latter seems to handle the power button
> by talking directly with the PMIC (instead of using a GPIO).

Nope, as I've written earlier:
> In ProductionKernelQuilts I found
> DC-TI-PMIC-disable-power-button-support.patch so I guess it
> might not be needed because it's probably handled by ACPI.

[  +0.000338] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[  +0.000127] ACPI: Power Button [PWRB]
...
[  +0.000248] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[  +0.000116] ACPI: Power Button [PWRF]

And I also have:

[  +0.000004] soc_button_array INTCFD9:00: GPIO lookup for consumer soc_button_array
[  +0.000002] soc_button_array INTCFD9:00: using ACPI for GPIO lookup
[  +0.000003] acpi INTCFD9:00: GPIO: looking up soc_button_array-gpios
[  +0.000004] acpi INTCFD9:00: GPIO: looking up soc_button_array-gpio
[  +0.000003] acpi INTCFD9:00: GPIO: looking up 0 in _CRS
[  +0.000610] soc_button_array INTCFD9:00: lookup for GPIO soc_button_array failed
(repeats for 5 buttons, one of them should succeed)

> Let's include the original author (Ramakrishna) as well if we could get
> some information from him.

Looking at 0002-GPIO-Adding-AXP288-PMIC-GPIO-driver.patch from ProductionKernelQuilts,
it doesn't seem hard to do the same for the TI PMIC, but it needs information
from the PMIC datasheet for irq and gpio control registers.
Hopefully you have a patch or at least could provide the information.


Thanks,
Johannes
