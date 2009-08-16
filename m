From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: [2.6.31-rc6] ACPI region conflict regression...
Date: Sun, 16 Aug 2009 10:59:38 +0100
Message-ID: <6278d2220908160259v38c34c4ck6db2853ae886492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:54155 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZHPJ7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Aug 2009 05:59:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

When booting 2.6.31-rc6 on some x86-64 hardware with fan control and
monitoring via the Winbond 83627 chip, 2.6.31-rc6 prevents the module
using an I/O region [1] described in the ACPI DSDT table [2] - which
didn't occur in -rc5.

Is there a way to relax this, or does it require adding
acpi_bus_register_driver(struct acpi_driver) and the needed code this
late in the game?

Thanks,
  Daniel

--- [1]

w83627ehf: Found W83627EHG chip at 0x290
ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region
SEN1 [0x295-0x296]
ACPI: Device needs an ACPI driver

--- [2]

    OperationRegion (SEN1, SystemIO, 0x0295, 0x02)
    Field (SEN1, ByteAcc, NoLock, Preserve)
    {
        SEI0,   8,
        SED0,   8
    }
-- 
Daniel J Blueman
