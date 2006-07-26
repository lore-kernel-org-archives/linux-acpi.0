From: "John Altobelli" <acocaracha@gmail.com>
Subject: ACPI Errors for Dimension 8250
Date: Tue, 25 Jul 2006 20:54:57 -0400
Message-ID: <4be0d0b30607251754t1bd64bbs65b344023b34997f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:23384 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030301AbWGZAy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 20:54:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2948549ugc
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2006 17:54:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a dell dimension 8250 and after compiling the dsdt.dsl file I
get the following errors:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060512 [Jul 15 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl   356:         Notify (\_SB.PCI0.ISA.KBD, 0x02)
Error    4062 -           Object does not exist ^  (\_SB.PCI0.ISA.KBD)

dsdt.dsl   666:                 Method (_S5D, 0, NotSerialized)
Warning  1097 -      Unknown reserved name ^  (_S5D)

dsdt.dsl  1331:                 Device (DMA)
Error    4094 -                           ^ syntax error, unexpected
PARSEOP_DMA, expecting PARSEOP_NAMESEG or PARSEOP_NAMESTRING

dsdt.dsl  1504:                 Field (\_SB.PCI0.ISA.COM, ByteAcc,
NoLock, Preserve)
Error    4062 -                  Object does not exist ^  (\_SB.PCI0.ISA.COM)

dsdt.dsl  1513:                 Field (\_SB.PCI0.ISA.FDPA, ByteAcc,
NoLock, Preserve)
Error    4062 -                   Object does not exist ^  (\_SB.PCI0.ISA.FDPA)

dsdt.dsl  1598:                         CreateByteField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X03._MIN, IOL0)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X03._MIN)

dsdt.dsl  1600:                         CreateByteField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X03._MAX, IOL1)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X03._MAX)

dsdt.dsl  1602:                         CreateByteField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X04._MIN, I2L0)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X04._MIN)

dsdt.dsl  1604:                         CreateByteField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X04._MAX, I2L1)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X04._MAX)

dsdt.dsl  1606:                         CreateWordField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X05._INT, IQR)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X05._INT)

dsdt.dsl  1607:                         CreateByteField (FDB0,
\_SB.PCI0.ISA.FDC._CRS._X06._DMA, DAM)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.FDC._CRS._X06._DMA)

dsdt.dsl  1873:                         CreateByteField (CMA0,
\_SB.PCI0.ISA.COMA._CRS._X07._MIN, IOL0)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.COMA._CRS._X07._MIN)

dsdt.dsl  1875:                         CreateByteField (CMA0,
\_SB.PCI0.ISA.COMA._CRS._X07._MAX, IOL1)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.COMA._CRS._X07._MAX)

dsdt.dsl  1877:                         CreateWordField (CMA0,
\_SB.PCI0.ISA.COMA._CRS._X08._INT, IQR)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.COMA._CRS._X08._INT)

dsdt.dsl  2037:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X09._MIN, IOL0)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X09._MIN)

dsdt.dsl  2039:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X09._MAX, IOL1)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X09._MAX)

dsdt.dsl  2041:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X09._ALN, LALN)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X09._ALN)

dsdt.dsl  2042:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X09._LEN, LLEN)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X09._LEN)

dsdt.dsl  2043:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0A._MIN, I2L0)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0A._MIN)

dsdt.dsl  2045:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0A._MAX, I2L1)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0A._MAX)

dsdt.dsl  2047:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0A._ALN, HALN)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0A._ALN)

dsdt.dsl  2048:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0A._LEN, HLEN)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0A._LEN)

dsdt.dsl  2049:                         CreateWordField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0B._INT, IQR)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0B._INT)

dsdt.dsl  2050:                         CreateByteField (PTB0,
\_SB.PCI0.ISA.PRT._CRS._X0C._DMA, DAM)
Error    4062 -
 Object does not exist ^  (\_SB.PCI0.ISA.PRT._CRS._X0C._DMA)

dsdt.dsl  2450:         Field (\_SB.PCI0.ISA.P40C, ByteAcc, NoLock, Preserve)
Error    4062 -           Object does not exist ^  (\_SB.PCI0.ISA.P40C)

dsdt.dsl  2458:         Field (\_SB.PCI0.ISA.P41C, ByteAcc, NoLock, Preserve)
Error    4062 -           Object does not exist ^  (\_SB.PCI0.ISA.P41C)

dsdt.dsl  2498:                 CreateWordField (PRR0,
\_SB.LNKA._CRS._X0D._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKA._CRS._X0D._INT)

dsdt.dsl  2553:                 CreateWordField (PRR1,
\_SB.LNKB._CRS._X0E._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKB._CRS._X0E._INT)

dsdt.dsl  2608:                 CreateWordField (PRR2,
\_SB.LNKC._CRS._X0F._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKC._CRS._X0F._INT)

dsdt.dsl  2663:                 CreateWordField (PRR3,
\_SB.LNKD._CRS._X10._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKD._CRS._X10._INT)

dsdt.dsl  2718:                 CreateWordField (PRR4,
\_SB.LNKE._CRS._X11._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKE._CRS._X11._INT)

dsdt.dsl  2773:                 CreateWordField (PRR5,
\_SB.LNKF._CRS._X12._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKF._CRS._X12._INT)

dsdt.dsl  2828:                 CreateWordField (PRR6,
\_SB.LNKG._CRS._X13._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKG._CRS._X13._INT)

dsdt.dsl  2883:                 CreateWordField (PRR7,
\_SB.LNKH._CRS._X14._INT, IQR)
Error    4062 -                                         Object does
not exist ^  (\_SB.LNKH._CRS._X14._INT)

dsdt.dsl  2906: }
Error    4094 - ^ syntax error, unexpected '}', expecting $end

ASL Input:  dsdt.dsl - 2907 lines, 98364 bytes, 902 keywords
Compilation complete. 34 Errors, 1 Warnings, 0 Remarks, 188 Optimizations


I do have a very modularized kernel so I have the following loaded on startup:

processor
thermal
fan

Any help would be greatly appriciated,
John
