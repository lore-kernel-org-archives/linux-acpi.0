From: Ben B <kernel@bb.cactii.net>
Subject: DSDT/ASL compiler error
Date: Thu, 17 Aug 2006 19:03:03 +0200
Message-ID: <20060817170303.GA3592@cactii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from us.cactii.net ([66.160.141.151]:62986 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S964784AbWHQRD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Aug 2006 13:03:28 -0400
Received: from cactii.net ([IPv6:2001:bd8:face:0:211:2fff:fe49:c0d8])
	by us.cactii.net (8.13.4/8.13.4/Debian-4) with ESMTP id k7HH3OGi011918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2006 17:03:27 GMT
Received: from erebus.cactii.net (localhost.localdomain [127.0.0.1])
	by cactii.net (8.13.4/8.11.6) with ESMTP id k7HH34kQ003953
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256 bits) verified NO)
	for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2006 19:03:04 +0200
Received: (from bb@localhost)
	by erebus.cactii.net (8.13.4/8.12.8/Submit) id k7HH33V7003952
	for linux-acpi@vger.kernel.org; Thu, 17 Aug 2006 19:03:03 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Wondering if any ASL experts can help me here. I'm trying to recompile
the DSDT on my HP NC6400 laptop, to hopefully get some better acpi
functionality, and I'm seeing the following error:

$ iasl -tc dsdt.dsl            

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 29 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
Warning  1104 -        Result is not used, operator has no effect ^ 

dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
Warning  1086 -                                ^ Not all control paths return a value (_DSM)

dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
Warning  1079 -                                ^ Reserved method must return a value (_DSM)

dsdt.dsl 12767:                 CreateByteField (C1D3, \_SB.C002.C003._X0F._LEN, C08F)
Error    4062 -                                         Object does not exist ^  (\_SB.C002.C003._X0F._LEN)

ASL Input:  dsdt.dsl - 13280 lines, 478523 bytes, 6207 keywords
Compilation complete. 1 Errors, 3 Warnings, 0 Remarks, 2052 Optimizations

The relevent section around line 12767 is this:

    Device (\_SB.C002.C003.C334)
    {
        Name (_HID, EisaId ("PNP0C02"))
        Name (_UID, 0x02)
        Name (\_SB.C002.C003.C1D3, ResourceTemplate ()
        {
            IO (Decode16,
                0x0010,             // Range Minimum
                0x0010,             // Range Maximum
                0x01,               // Alignment
                0x10,               // Length
                )
[... skipping some defs ..]
            IO (Decode16,
                0x00A4,             // Range Minimum
                0x00A4,             // Range Maximum
                0x01,               // Alignment
                0x1A,               // Length
                )
            IO (Decode16,
                0x0500,             // Range Minimum
                0x0500,             // Range Maximum
                0x01,               // Alignment
                0x80,               // Length
                _X0F)
            IO (Decode16,
                0x0800,             // Range Minimum
                0x0800,             // Range Maximum
                0x01,               // Alignment
                0x10,               // Length
                )
            Memory32Fixed (ReadOnly,
                0xFFB00000,         // Address Base
                0x00100000,         // Address Length
                )
            Memory32Fixed (ReadOnly,
                0xFFF00000,         // Address Base
                0x00100000,         // Address Length
                )
        })
        Method (_CRS, 0, NotSerialized)
        {
            If (LEqual (\_SB.C002.C003.C1FC._STA (), 0x0F))
            {
                CreateByteField (C1D3, \_SB.C002.C003.C1D3._X0F._LEN,
C08F)
                Store (0x60, C08F)
            }

            Return (^^C1AD.C1D2 ())
        }
    }


What suggestions does anyone have on fixing this?

Thanks,
BB


