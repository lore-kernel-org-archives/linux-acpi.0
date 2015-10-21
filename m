From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Wed, 21 Oct 2015 11:50:56 +0300
Message-ID: <20151021085056.GV1526@lahna.fi.intel.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10311 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238AbbJUIxH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Oct 2015 04:53:07 -0400
Content-Disposition: inline
In-Reply-To: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Oct 20, 2015 at 02:47:43PM -0500, Ben Gardner wrote:
> Hi everyone,
> 
> I am building a custom board based on the Bayley Bay reference design, using
> the Intel E3845 CPU.
> I have a few I2C devices on the board that are connected to I2C buses 1-3.
> The I2C controllers use the i2c-designware-pci driver.
> 
> I am currently using i2c_register_board_info() in a driver to describe what
> is on the I2C buses. That seems to work just fine.
> 
> However, I would like to use the ACPI I2cSerialBus() macro to specify the
> devices on those buses and have Linux automatically create the devices.
> 
> I am defining the device as shown below (in scope \_SB).
> That creates an ACPI device under /sys/bus/acpi/devices/.
> 
> // M24C02 EEPROM on I2C-3 addr 0x57
> Device (EEP0) {
>   Name (_ADR, 1)
>   Name (_CID, Package() { "24c02" })
>   Method (_CRS, 0, NotSerialized) {
>     Name (RBUF, ResourceTemplate () {
>       I2cSerialBus (0x0057, ControllerInitiated,
>         400000, AddressingMode7Bit, "\\_SB.I2C3",
>         0x00, ResourceConsumer,,)
>     })
>     Return (RBUF)
>   }
> }
> 
> The problem is that the I2C controller is a PCI device. The logic that scans
> for attached devices in acpi_i2c_register_devices() in i2c-core.c gives up
> because the adapter is not an ACPI device.
> 
>   handle = ACPI_HANDLE(adap->dev.parent);
>   if (!handle)
>     return;
> 
> I am using coreboot/SeaBIOS as the BIOS, so I have full control over
> the ACPI tables.
> 
> I tried enabling the I2C ACPI devices and using the i2c-designware-platform
> driver, but that didn't work because Linux changes the resource allocation
> for the PCI I2C devices if I specify the resources for the I2C device in ACPI.
> 
> The relevent kernel logs are:
> [    0.105628] pci 0000:00:18.3: [8086:0f43] type 00 class 0x0c8000
> [    0.105656] pci 0000:00:18.3: reg 0x10: [mem 0xd0723000-0xd0723fff]
> [    0.105670] pci 0000:00:18.3: reg 0x14: [mem 0xd0724000-0xd0724fff]
> ...
> [    0.122970] pci 0000:00:18.3: can't claim BAR 0 [mem
> 0xd0723000-0xd0723fff]: address conflict with 80860F43:00 [mem
> 0xd0723000-0xd0723fff]
> ...
> [    0.136530] pci 0000:00:18.3: BAR 0: assigned [mem 0x80602000-0x80602fff]
> 
> The i2c-designware-platform driver tries to use the old BAR0 address
> (0xd0723000), which obviously doesn't work.
> 
> So my questions are:
>   Can I use I2cSerialBus with a PCI I2C controller?

Yes you can.

That's what we do all the time for Intel hardware.

>   If so, what am I doing incorrectly?

Let me see..

> For reference, here are the interesting parts of the ACPI device definition.
> The variable \S3B0 holds the BAR0 value that coreboot sets up.
> 8086:0f43 is the PCI device ID. 0:18.3 is the PCI bus, device, and function.
> 
> Device (I2C3)
> {
>   Name (_HID, "80860F43")
>   Name (_UID, 3)

Drop the _HID and _UID.

>   Name (_DDN, "I2C Controller #3")
>   Name (_ADR, 0x00180003)

This will bind the PCI device to this ACPI device if the address is
correct.

>   /* Standard Mode: HCNT, LCNT, SDA Hold Time */
>   Name (SSCN, Package () { 0x200, 0x200, 0x6 })
> 
>   /* Fast Mode: HCNT, LCNT, SDA Hold Time */
>   Name (FMCN, Package () { 0x55, 0x99, 0x6 })
> 
>   Name (RBUF, ResourceTemplate()
>   {
>     /* BAR0._BAS is replaced in _CRS */
>     Memory32Fixed (ReadWrite, 0, 0x1000, BAR0)
>     Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive,,,)
>     {
>       LPSS_I2C3_IRQ
>     }

You should not populate BAR and IRQ.

>     FixedDMA (0x10, 0x0, Width32Bit, )
>     FixedDMA (0x11, 0x1, Width32Bit, )

These you don't need as the designware I2C does not currently support
DMA.

So you can just drop the whole _CRS and make your I2C host controller
device to look like:

Device (I2C3)
{
	Name (_ADR, 0x00180003)

	/* Standard Mode: HCNT, LCNT, SDA Hold Time */
	Name (SSCN, Package () { 0x200, 0x200, 0x6 })

	/* Fast Mode: HCNT, LCNT, SDA Hold Time */
	Name (FMCN, Package () { 0x55, 0x99, 0x6 })

	Device (EEP0)
	{
		Name (_CID, Package() { "24c02" })
		Name (_CRS, ResourceTemplate () {
			I2cSerialBus (0x0057, ControllerInitiated, 400000,
				      AddressingMode7Bit, "\\_SB.I2C3", 0x00,
				      ResourceConsumer,,)
		})
	}
}
