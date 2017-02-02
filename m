From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 16:26:18 +0200
Message-ID: <20170202142618.GX2053@lahna.fi.intel.com>
References: <20170127133058.pxuovuuqpnffx3py@sig21.net>
 <20170130205745.wwavipta5hbz5zfz@sig21.net>
 <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
 <20170131143740.lgn2svjskjulsucf@sig21.net>
 <20170202095200.d5clhprl7rpgrf72@sig21.net>
 <20170202103122.GH2053@lahna.fi.intel.com>
 <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 02, 2017 at 02:52:57PM +0100, Johannes Stezenbach wrote:
> Nope, as I've written earlier:
> > In ProductionKernelQuilts I found
> > DC-TI-PMIC-disable-power-button-support.patch so I guess it
> > might not be needed because it's probably handled by ACPI.
> 
> [  +0.000338] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [  +0.000127] ACPI: Power Button [PWRB]
> ...
> [  +0.000248] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [  +0.000116] ACPI: Power Button [PWRF]

Yeah, but shouldn't hurt to try it out :)

> And I also have:
> 
> [  +0.000004] soc_button_array INTCFD9:00: GPIO lookup for consumer soc_button_array
> [  +0.000002] soc_button_array INTCFD9:00: using ACPI for GPIO lookup
> [  +0.000003] acpi INTCFD9:00: GPIO: looking up soc_button_array-gpios
> [  +0.000004] acpi INTCFD9:00: GPIO: looking up soc_button_array-gpio
> [  +0.000003] acpi INTCFD9:00: GPIO: looking up 0 in _CRS
> [  +0.000610] soc_button_array INTCFD9:00: lookup for GPIO soc_button_array failed
> (repeats for 5 buttons, one of them should succeed)

It fails because of the missing GPIO driver.

> > Let's include the original author (Ramakrishna) as well if we could get
> > some information from him.
> 
> Looking at 0002-GPIO-Adding-AXP288-PMIC-GPIO-driver.patch from ProductionKernelQuilts,
> it doesn't seem hard to do the same for the TI PMIC, but it needs information
> from the PMIC datasheet for irq and gpio control registers.
> Hopefully you have a patch or at least could provide the information.

That patch looks like a GPIO driver for DCOVE. Did you try it already?
