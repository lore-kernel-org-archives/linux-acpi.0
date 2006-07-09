From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.18-rc1-mm1
Date: Sun, 9 Jul 2006 13:47:25 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9C0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47958 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030231AbWGIRra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 13:47:30 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Reuben Farrelly <reuben-lkml@reub.net>, mingo@redhat.com, "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, greg@kroah.com

>> 2. Onto some more minor warnings:
>> 
>> ACPI: bus type pci registered
>> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
>> PCI: Not using MMCONFIG.
>> PCI: Using configuration type 1
>> ACPI: Interpreter enabled
>> 
>> Is there any way to verify that there really is a BIOS bug 
>there?  If it is, is there anyone within Intel or are there any
>known contacts 
>who can push and poke > to get this looked at/fixed?
>(It's a new Intel board, I'd hope they could get it right..).

Arjan should probably comment on that one.

>> 3. Power Management warnings, been there ages, but I've had 
>bigger things to 
>> worry about (like fatal oopses) so haven't bothered asking:
>> 
>> Device `[PEX0]' is not power manageable
>> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
>> PCI: Setting latency timer of device 0000:00:1c.0 to 64
>> Device `[PEX2]' is not power manageable

I'll revert this message to CONFIG_ACPI_DEBUG=y like it used to be.

>I guess that's from here:
>
>/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDES
>
>which contains 2 directories:  PRID and SECD.
>Apparently ATA/IDE primary and secondary controllers,
>but I'm not sure.  Those empty directory structures
>don't tell me much.

/sys/firmware/acpi/namespace should not exist at all
and is waiting to die.  You can ignore it.

cheers,
-Len
