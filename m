From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Thu, 2 Feb 2017 10:52:00 +0100
Message-ID: <20170202095200.d5clhprl7rpgrf72@sig21.net>
References: <20170124135250.d72silj6jlxh7zqk@sig21.net>
 <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
 <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net>
 <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net>
 <20170130205745.wwavipta5hbz5zfz@sig21.net>
 <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
 <20170131143740.lgn2svjskjulsucf@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170131143740.lgn2svjskjulsucf@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Mika,

On Tue, Jan 31, 2017 at 03:37:40PM +0100, Johannes Stezenbach wrote:
> - Powerbutton driver seems simple enough, the only specialty
>   of the TI dcove PB driver is the workarond for lost button
>   press event after resume.  However, I still don't see how
>   the PB would cause thermal event irqs on E200HA and how the
>   PMIC driver would change it?

In ProductionKernelQuilts I found
DC-TI-PMIC-disable-power-button-support.patch so I guess it
might not be needed because it's probably handled by ACPI.

> I think the mfd driver would be similar to intel_soc_pmic_crc.c,
> the dollar_cove_ti_powerbtn.c I would keep instead of merging
> it into intel_mid_powerbtn.c.  I guess what we need is in
> drivers/acpi/pmic/ something similar to intel_pmic_crc.c,
> the ProductionKernelQuilts has 0001-ACPI-Adding-support-for-TI-pmic-opregion.patch.

I have preliminary versions of the mfd and opregion driver,
while testing I found the GPIO opregion is not registered:

Excerpt from DSDT:
https://linuxtv.org/~js/e200ha/dsdt.dsl

            Device (PMI2)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INT33F5" /* TI PMIC Controller */)  // _HID: Hardware ID
                Name (_CID, "INT33F5" /* TI PMIC Controller */)  // _CID: Compatible ID
                Name (_DDN, "TI PMIC Controller")  // _DDN: DOS Device Name
                Name (_HRV, 0x03)  // _HRV: Hardware Revision
                Name (_UID, One)  // _UID: Unique ID
                Name (_DEP, Package (0x02)  // _DEP: Dependencies
                {
                    I2C7, 
                    GPO1
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (SBUF, ResourceTemplate ()
                    {
                        I2cSerialBusV2 (0x005E, ControllerInitiated, 0x000F4240,
                            AddressingMode7Bit, "\\_SB.PCI0.I2C7",
                            0x00, ResourceConsumer, , Exclusive,
                            )
                        GpioInt (Level, ActiveHigh, Shared, PullDefault, 0x0000,
                            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x000F
                            }
                    })
                    Return (SBUF) /* \_SB_.PCI0.I2C7.PMI2._CRS.SBUF */
                }
...
                Name (AVBL, Zero)
                Name (AVBD, Zero)
                Name (AVBG, Zero)
                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (Arg0 == 0x08)
                    {
                        AVBG = Arg1
                    }

                    If (Arg0 == 0x8D)
                    {
                        AVBL = Arg1
                    }

                    If (Arg0 == 0x8C)
                    {
                        AVBD = Arg1
                    }
                }


acpidbg:
        \_SB.PCI0.I2C7.PMI2.AVBL Integer      ffff8be7b74d97a8 01 = 0000000000000001
        \_SB.PCI0.I2C7.PMI2.AVBD Integer      ffff8be7b74d94d8 01 = 0000000000000001
        \_SB.PCI0.I2C7.PMI2.AVBG Integer      ffff8be7b74d9be0 01 = 0000000000000000

Any idea about it?
devm_gpiochip_add_data() in chv_gpio_probe() indirectly calls acpi_gpiochip_add()
which should use _DEP to figure out to call _REG, right?

Also PMI2 has

                OperationRegion (GPOP, GeneralPurposeIo, Zero, 0x0100)
                Field (GPOP, ByteAcc, NoLock, Preserve)
                {
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                            "\\_SB.PCI0.I2C7.PMI2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0020
                            }
                    ), 
                    GMP0,   1, 
                    ...
                    (repeat for many more pins)

I guess it means it uses chv_gpio pins and can't work
if the GPIO opregion is not registered?


FWIW, with the mfd driver, /proc/interrupts has

 180:          0          0          0          0  chv-gpio    9  TI Dollar Cove

I guess the 9 refers to the 10th pin in north_pins[] which is pin 0x000F, right?
I boot with "dyndbg=file gpiolib* +p" and get

[  +0.012798] acpi INT33F5:00: GPIO: looking up 0 in _CRS
[  +0.000214] intel_soc_pmic_i2c i2c-INT33F5:00: GPIO lookup for consumer intel_soc_pmic
[  +0.000003] intel_soc_pmic_i2c i2c-INT33F5:00: using ACPI for GPIO lookup
[  +0.000005] acpi INT33F5:00: GPIO: looking up intel_soc_pmic-gpios
[  +0.000005] acpi INT33F5:00: GPIO: looking up intel_soc_pmic-gpio
[  +0.000005] acpi INT33F5:00: GPIO: looking up 0 in _CRS
[  +0.000091] cherryview-pinctrl INT33FF:01: request pin 15 (GPIO_SUS0) for INT33FF:01:406

but so far the irq never triggers.


Thanks
Johannes
