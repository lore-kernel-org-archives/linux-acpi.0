From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 13:35:08 +0200
Message-ID: <20170202113508.GM2053@lahna.fi.intel.com>
References: <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net>
 <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net>
 <20170130205745.wwavipta5hbz5zfz@sig21.net>
 <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
 <20170131143740.lgn2svjskjulsucf@sig21.net>
 <20170202095200.d5clhprl7rpgrf72@sig21.net>
 <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52593 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdBBLfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 06:35:13 -0500
Content-Disposition: inline
In-Reply-To: <20170202111222.aoiwinw37jrquhbh@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>

On Thu, Feb 02, 2017 at 12:12:22PM +0100, Johannes Stezenbach wrote:
> On Thu, Feb 02, 2017 at 12:31:22PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 10:52:00AM +0100, Johannes Stezenbach wrote:
> > >                 OperationRegion (GPOP, GeneralPurposeIo, Zero, 0x0100)
> > >                 Field (GPOP, ByteAcc, NoLock, Preserve)
> > >                 {
> > >                     Connection (
> > >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> > >                             "\\_SB.PCI0.I2C7.PMI2", 0x00, ResourceConsumer, ,
> > >                             )
> > >                             {   // Pin list
> > >                                 0x0020
> > >                             }
> > >                     ), 
> > >                     GMP0,   1, 
> > >                     ...
> > >                     (repeat for many more pins)
> > > 
> > > I guess it means it uses chv_gpio pins and can't work
> > > if the GPIO opregion is not registered?
> > 
> > That is using GPIO pins of the PMI2 device - the PMIC GPIO driver, I
> > suppose.
> > 
> > So in addition to the PMIC MFD driver, you need to have a GPIO driver
> > for Dollar Cove (I guess the quilt patch series included that as well?).
> 
> Nope, I see it for AX288 but didn't find it for TI DCove.  And in
> current Linus' tree axp288_cells[] doesn't include gpio so
> I concluded it's not needed... what am I missing?

So reading your DSDT there is that GPIO button array device \_SB.TBAD
which has one GpioInt() referencing \_SB.PCI0.I2C7.PMI2. I suppose that
is the power button GPIO.

In order to use that there needs to be a GPIO driver exposing those
GPIOs to other drivers. So it is definitely needed.
