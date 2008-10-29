From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.28 - new warning evaluating _BIF - found Buffer, expected
 String
Date: Wed, 29 Oct 2008 12:35:13 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580AE5B9C1@orsmsx503.amr.corp.intel.com>
References: <200810292038.53075.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbYJ2Tft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 15:35:49 -0400
In-Reply-To: <200810292038.53075.arvidjaar@mail.ru>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>From examining the acpidump, here is what is what is happening:

The battery strings are extracted from an EC operation region. When reading an operation region field, the result is either an integer or a buffer (if too large for an integer).

Prior to ACPI 2.0, there was no easy way to extract the EC field read as a string object, so most battery implementations returned the data as buffer objects. The ToString operator was introduced in ACPI 2.0 to perform this type of conversion.

However, we don't know when ToString was actually implemented in a Windows release -- and it appears that many _BIF implementations continue to simply return the data as a buffer.

This does have the possibility of causing some problems in the host OS, since the buffer is not guaranteed to be null-terminated. If the host treats the buffer and string objects the same (as strings), garbage output can be produced.

This kind of issue can be easily fixed in the ACPICA code that examines the return values from the predefined methods (like _BIF) by performing a proper buffer to string conversion before the host even sees the return value.

This is the plan, and the change will be released in a few days.

Bob


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Andrey Borzenkov
>Sent: Wednesday, October 29, 2008 10:39 AM
>To: linux-acpi@vger.kernel.org
>Subject: 2.6.28 - new warning evaluating _BIF - found Buffer, expected
>String
>
>[   36.156325] ACPI: AC Adapter [ADP1] (off-line)
>[   36.177259] ACPI Warning (nspredef-0858): \_SB_.BAT1._BIF: Return
>Package type mismatch at index 9 - found Buffer, expected String [20080926]
>[   36.183721] ACPI: Battery Slot [BAT1] (battery present)
>[   36.184307] ACPI: Battery Slot [BAT2] (battery absent)
>
>well, battery.c extrac_package deals with both string and buffer just fine.
>I am not sure if this warning is really needed in normal kernel - after
>all,
>Buffer to String conversion has well defined sematic in ACPI.
>
>There is nothing user can do about it anyway.
>
>For reference, here is _BIF method; it is Toshiba Portege 4000:
>
>            Method (_BIF, 0, NotSerialized)
>            {
>                Name (BUFF, Package (0x0D) {})
>                Store (0x00, Index (BUFF, 0x00))
>                Store (\_SB.MEM.BDV1, Local2)
>                Multiply (\_SB.MEM.BDC1, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x01))
>                Multiply (\_SB.MEM.BLF1, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x02))
>                Store (\_SB.MEM.BTC1, Index (BUFF, 0x03))
>                Store (\_SB.MEM.BDV1, Index (BUFF, 0x04))
>                Multiply (\_SB.MEM.BCW1, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x05))
>                Multiply (\_SB.MEM.BCL1, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x06))
>                Multiply (\_SB.MEM.BG11, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x07))
>                Multiply (\_SB.MEM.BG21, Local2, Local0)
>                Divide (Local0, 0x03E8, Local1, Local0)
>                Store (Local0, Index (BUFF, 0x08))
>                Store (\_SB.MEM.BMN1, Index (BUFF, 0x09))
>                Store (\_SB.MEM.BSN1, Index (BUFF, 0x0A))
>                Store (\_SB.MEM.BTP1, Index (BUFF, 0x0B))
>                Store (\_SB.MEM.BOI1, Index (BUFF, 0x0C))
>                Return (BUFF)
>            }
