From: Ben Gardner <gardner.ben@gmail.com>
Subject: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Tue, 20 Oct 2015 14:47:43 -0500
Message-ID: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34682 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbJTTrn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2015 15:47:43 -0400
Received: by iow1 with SMTP id 1so34453958iow.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2015 12:47:43 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone,

I am building a custom board based on the Bayley Bay reference design, using
the Intel E3845 CPU.
I have a few I2C devices on the board that are connected to I2C buses 1-3.
The I2C controllers use the i2c-designware-pci driver.

I am currently using i2c_register_board_info() in a driver to describe what
is on the I2C buses. That seems to work just fine.

However, I would like to use the ACPI I2cSerialBus() macro to specify the
devices on those buses and have Linux automatically create the devices.

I am defining the device as shown below (in scope \_SB).
That creates an ACPI device under /sys/bus/acpi/devices/.

// M24C02 EEPROM on I2C-3 addr 0x57
Device (EEP0) {
  Name (_ADR, 1)
  Name (_CID, Package() { "24c02" })
  Method (_CRS, 0, NotSerialized) {
    Name (RBUF, ResourceTemplate () {
      I2cSerialBus (0x0057, ControllerInitiated,
        400000, AddressingMode7Bit, "\\_SB.I2C3",
        0x00, ResourceConsumer,,)
    })
    Return (RBUF)
  }
}

The problem is that the I2C controller is a PCI device. The logic that scans
for attached devices in acpi_i2c_register_devices() in i2c-core.c gives up
because the adapter is not an ACPI device.

  handle = ACPI_HANDLE(adap->dev.parent);
  if (!handle)
    return;

I am using coreboot/SeaBIOS as the BIOS, so I have full control over
the ACPI tables.

I tried enabling the I2C ACPI devices and using the i2c-designware-platform
driver, but that didn't work because Linux changes the resource allocation
for the PCI I2C devices if I specify the resources for the I2C device in ACPI.

The relevent kernel logs are:
[    0.105628] pci 0000:00:18.3: [8086:0f43] type 00 class 0x0c8000
[    0.105656] pci 0000:00:18.3: reg 0x10: [mem 0xd0723000-0xd0723fff]
[    0.105670] pci 0000:00:18.3: reg 0x14: [mem 0xd0724000-0xd0724fff]
...
[    0.122970] pci 0000:00:18.3: can't claim BAR 0 [mem
0xd0723000-0xd0723fff]: address conflict with 80860F43:00 [mem
0xd0723000-0xd0723fff]
...
[    0.136530] pci 0000:00:18.3: BAR 0: assigned [mem 0x80602000-0x80602fff]

The i2c-designware-platform driver tries to use the old BAR0 address
(0xd0723000), which obviously doesn't work.

So my questions are:
  Can I use I2cSerialBus with a PCI I2C controller?
  If so, what am I doing incorrectly?


For reference, here are the interesting parts of the ACPI device definition.
The variable \S3B0 holds the BAR0 value that coreboot sets up.
8086:0f43 is the PCI device ID. 0:18.3 is the PCI bus, device, and function.

Device (I2C3)
{
  Name (_HID, "80860F43")
  Name (_UID, 3)
  Name (_DDN, "I2C Controller #3")
  Name (_ADR, 0x00180003)

  /* Standard Mode: HCNT, LCNT, SDA Hold Time */
  Name (SSCN, Package () { 0x200, 0x200, 0x6 })

  /* Fast Mode: HCNT, LCNT, SDA Hold Time */
  Name (FMCN, Package () { 0x55, 0x99, 0x6 })

  Name (RBUF, ResourceTemplate()
  {
    /* BAR0._BAS is replaced in _CRS */
    Memory32Fixed (ReadWrite, 0, 0x1000, BAR0)
    Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive,,,)
    {
      LPSS_I2C3_IRQ
    }
    FixedDMA (0x10, 0x0, Width32Bit, )
    FixedDMA (0x11, 0x1, Width32Bit, )
  })

  Method (_CRS)
  {
    CreateDwordField (^RBUF, ^BAR0._BAS, RBAS)
    Store (\S3B0, RBAS)
    Return (^RBUF)
  }
  ...
}

Thanks,
Ben Gardner
