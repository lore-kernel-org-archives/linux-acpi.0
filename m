From: Len Brown <lenb@kernel.org>
Subject: Re:  ACPI: If an ACPI driver is available for this device,
 you should use it instead of the native drive
Date: Thu, 23 Sep 2010 13:47:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009231341190.30002@localhost.localdomain>
References: <Pine.LNX.4.64.1008162059410.10248@marshadder.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:33457 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab0IWRsB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2010 13:48:01 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L97009YUO3QFF5V@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Sep 2010 12:47:55 -0500 (CDT)
In-reply-to: <Pine.LNX.4.64.1008162059410.10248@marshadder.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Denison <lkml@marshadder.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 16 Aug 2010, Peter Denison wrote:

> Following the change to strict ACPI resource checking, I'm getting error
> messages about the i2c_i801 driver conflicting:
> 
> [    5.892659] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) ->
> IRQ 18
> [    5.892711] ACPI: I/O resource 0000:00:1f.3 [0x400-0x41f] conflicts with
> ACPI region SMRG [0x400-0x40f]
> [    5.892755] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver
> 
> Clearly the resource checking is the right way to go, so I started to
> investigate an ACPI-capable driver for the i801 I2C bus. The i2c-scmi driver
> looks plausible, but doesn't work immediately. (Note that the asus_atk0110
> driver works fine for the sensors via ACPI, but there are other devices on the
> I2C bus e.g. DIMM SPDs)
> 
> The ACPI tables on this box (ASUS P5K-E) don't have a defined EC, or any
> device with PNP0C09, ACPI0001 or ACPI0005 HIDs. They do however, define the
> SMRG region and a series of methods to access the I2C bus.
> 
> I'd like some recommendation for the best approach:
> 
> a) Tweak the DSDT for myself to provide a device which will conform to a
> standard, then use a standard driver. Obviously not a very palatable solution
> for others.

Avoid hacking a DSDT except for debugging,
because it is a 'solution' that can neither
scale, nor be properly supported.

> b) Some form of automatic fixup when the ACPI tables are parsed, although the
> method names appear a little arbitrary - it's not simply a case of a missing
> _HID.

Conceivable in a platform driver to recognize vendor specific AML,
but in the generic ACPI code, no way.

> c) Forget about it, use acpi_enforce_resources=lax, and just hope I never get
> an unlocked race (not preferred!)

Quite possibly it is safe on this box.
Unfortunately, it is not only un-safe in general, but when it is unsafe
the consequences can be severe.

> d) Something else I clearly haven't thought of (most likely)
> 
> Clearly the ACPI tables lacking the bus device is a problem fairly particular
> to this hardware, and the fix is likely to be targetted, but I'd like to make
> it as universal as possible. If I can get an ACPI driver working, and fix this
> for more than just myself, then brilliant.

cheers,
Len Brown, Intel Open Source Technology Center
