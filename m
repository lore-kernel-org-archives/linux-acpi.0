From: Paul Hartman <paul.hartman@gmail.com>
Subject: ACPI Error: Method parse/execution failed
Date: Thu, 17 May 2012 23:27:59 -0500
Message-ID: <CAEH5T2Pd6qP8xnE6d4Qu4VHdL9Snw5istAZDs55eF660eCds8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57669 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753725Ab2ERE2V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 May 2012 00:28:21 -0400
Received: by lahd3 with SMTP id d3so1807041lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 17 May 2012 21:28:19 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope this is an appropriate place to post this. I have a laptop,
circa 2004, which apparently has a buggy DSDT that causes the battery
monitoring to stop working. I'm presently using kernel 3.3.5 but this
has happened for years, as long as I've had the laptop.

My battery/power readings will work normally until suddenly, randomly
it shows something like this in dmesg:

[ 6286.707038] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.PIB_.EC0_.SMWR] (Node ffff88007d028348),
AE_AML_INFINITE_LOOP (20120111/psparse-536)
[ 6286.707074] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.PIB_.EC0_.SMSL] (Node ffff88007d028398),
AE_AML_INFINITE_LOOP (20120111/psparse-536)
[ 6286.707096] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.PIB_.EC0_._Q09] (Node ffff88007d028438),
AE_AML_INFINITE_LOOP (20120111/psparse-536)

After that, the battery state is no longer updated and eventually my
laptop powers off without any warning or proper shutdown.  Sometimes
the messages are repeated. Because it is unpredictable, it is
difficult to test. Sometimes it fails within a minute of booting,
other times it could go hours or even days before failing. It's
usually within an hour or two of booting the computer.

I've tried decompiling/recompiling the DSDT and "fixing" things in it,
but I have only managed to make things behave even worse. Probably due
to my complete lack of understanding of ACPI, DSDT or ASL. :)

I'm sure there's some logical flaw causing the infinite loop but I
can't find it. If anyone is familiar with this and can guide me in the
right direction to figure out where the problem lies and how (or if)
it can be fixed, worked around, or what the error message is telling
me, I would be very grafeful. Thanks in advance.

Recompilation output is below. Please let me know if I should provide
any other data, or post/make available the DSDT file itself.

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20111123-64 [May 16 2012]
Copyright (c) 2000 - 2011 Intel Corporation

dsdt.dsl    381:     Method (\_WAK, 1, NotSerialized)
Warning  1105 -                  ^ Reserved method must return a value
(Integer/Package required for _WAK)

dsdt.dsl   2109:                         CreateWordField (BUFA,
\_SB.PCI0.PIB.ALKA._CRS._Y0B._INT, IRAI)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 32 bits, Field: 16 bits)

dsdt.dsl   2164:                         CreateWordField (BUFB,
\_SB.PCI0.PIB.ALKB._CRS._Y0C._INT, IRBI)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 32 bits, Field: 16 bits)

dsdt.dsl   2212:                         CreateWordField (BUFC,
\_SB.PCI0.PIB.ALKC._CRS._Y0D._INT, IRCI)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 32 bits, Field: 16 bits)

dsdt.dsl   2260:                         CreateWordField (BUFD,
\_SB.PCI0.PIB.ALKD._CRS._Y0E._INT, IRDI)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 32 bits, Field: 16 bits)

dsdt.dsl   2303:                         CreateByteField (BUFA,
\_SB.PCI0.PIB.LNKA._CRS._Y0F._INT, IRA1)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 16 bits, Field: 8 bits)

dsdt.dsl   2377:                         CreateByteField (BUFB,
\_SB.PCI0.PIB.LNKB._CRS._Y10._INT, IRB1)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 16 bits, Field: 8 bits)

dsdt.dsl   2451:                         CreateByteField (BUFC,
\_SB.PCI0.PIB.LNKC._CRS._Y11._INT, IRC1)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 16 bits, Field: 8 bits)

dsdt.dsl   2525:                         CreateByteField (BUFD,
\_SB.PCI0.PIB.LNKD._CRS._Y12._INT, IRD1)
Warning  1125 -
ResourceTag larger than Field ^  (Tag: 16 bits, Field: 8 bits)

dsdt.dsl   5095:                     Method (SMSL, 0, NotSerialized)
Warning  1113 -                                 ^ Not all control
paths return a value (SMSL)

ASL Input:     dsdt.dsl - 5911 lines, 229987 bytes, 2466 keywords
AML Output:    dsdt.aml - 20957 bytes, 572 named objects, 1894
executable opcodes
Hex Dump:      dsdt.hex - 196818 bytes

Compilation complete. 0 Errors, 10 Warnings, 0 Remarks, 799 Optimizations
