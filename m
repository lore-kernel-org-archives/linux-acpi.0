From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Date: Mon,  1 Sep 2014 23:05:59 +0800
Message-ID: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33748 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaIAPGm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2014 11:06:42 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so12581486pab.31
        for <linux-acpi@vger.kernel.org>; Mon, 01 Sep 2014 08:06:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set is example of the sort of driver changes needed to boot
Juno using ACPI tables, which using the ACPI tables devloped for MS
Windows and published by ARM [1].

For the smsc911x driver, it is based on the following ASL fragment
which is part of DSDT for Juno:

    // LAN9118 Ethernet
    //
    Device(ETH0) {
      Name(_HID, "ARMH9118")
      Name(_UID, Zero)
      Name(_CRS, ResourceTemplate() {
              Memory32Fixed(ReadWrite, 0x1A000000, 0x1000)
              Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) { 192 }
      })
    }

UART driver is just for review purpose, ARM is working on a more
functional UART driver that does not poll to transmit. But it shows
how to initialise SBSA compatible UART without clock definitions in
DSDT.

You also can refer to the boot log from [2].

[1]: https://github.com/ARM-software/edk2/tree/juno-acpi/ArmPlatformPkg/ArmJunoPkg/AcpiTables
[2]: http://www.xora.org.uk/2014/08/29/juno-booting-from-acpi-tables/


Graeme Gregory (2):
  net: smsc911x add support for probing from ACPI
  tty: SBSA compatible UART

 drivers/net/ethernet/smsc/smsc911x.c |   38 ++++
 drivers/tty/Kconfig                  |    6 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/sbsauart.c               |  328 ++++++++++++++++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 drivers/tty/sbsauart.c

-- 
1.7.9.5

