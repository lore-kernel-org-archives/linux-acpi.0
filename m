From: Peter Denison <lkml@marshadder.org>
Subject: (unknown)
Date: Mon, 16 Aug 2010 23:16:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.1008162059410.10248@marshadder.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail3.uklinux.net ([80.84.72.33]:57406 "EHLO mail3.uklinux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457Ab0HPWtV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Aug 2010 18:49:21 -0400
Received: from marshadder.org (cpc1-oxfd5-0-0-cust228.oxfd.cable.virginmedia.com [86.2.116.229])
	by mail3.uklinux.net (Postfix) with ESMTP id DF58E1F66C5
	for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2010 23:16:17 +0100 (BST)
Received: by marshadder.org (Exim) with esmtp id 1Ol7yZ-0002g1-IN
	for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2010 23:16:16 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Following the change to strict ACPI resource checking, I'm getting error 
messages about the i2c_i801 driver conflicting:

[    5.892659] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    5.892711] ACPI: I/O resource 0000:00:1f.3 [0x400-0x41f] conflicts with ACPI region SMRG [0x400-0x40f]
[    5.892755] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

Clearly the resource checking is the right way to go, so I started to 
investigate an ACPI-capable driver for the i801 I2C bus. The i2c-scmi 
driver looks plausible, but doesn't work immediately. (Note that the 
asus_atk0110 driver works fine for the sensors via ACPI, but there are 
other devices on the I2C bus e.g. DIMM SPDs)

The ACPI tables on this box (ASUS P5K-E) don't have a defined EC, or any 
device with PNP0C09, ACPI0001 or ACPI0005 HIDs. They do however, define 
the SMRG region and a series of methods to access the I2C bus.

I'd like some recommendation for the best approach:

a) Tweak the DSDT for myself to provide a device which will conform to a 
standard, then use a standard driver. Obviously not a very palatable 
solution for others.

b) Some form of automatic fixup when the ACPI tables are parsed, although 
the method names appear a little arbitrary - it's not simply a case of a 
missing _HID.

c) Forget about it, use acpi_enforce_resources=lax, and just hope I never 
get an unlocked race (not preferred!)

d) Something else I clearly haven't thought of (most likely)

Clearly the ACPI tables lacking the bus device is a problem fairly 
particular to this hardware, and the fix is likely to be targetted, but 
I'd like to make it as universal as possible. If I can get an ACPI driver 
working, and fix this for more than just myself, then brilliant.

-- 
Peter Denison <peterd at marshadder dot org>
