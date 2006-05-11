From: Paul Wagner <paul_spam@gmx.at>
Subject: DSDT on Averatec 1050
Date: Thu, 11 May 2006 17:55:54 +0200
Message-ID: <44635E8A.406@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:28634 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030292AbWEKPz6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 11:55:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Folks,

tried to get Linux (Slackware 10.1 with Kernel 2.6.13) to run on my 
Averatec 1050. Unfortunately, ACPI doesn't work as supposed: No thermal 
zones, no fan, no CPU temperature, kernel error messages (see below).

I disassembled the DSDT, and recompiled it using Intels iasl, and got a 
bunch of error and warnings (see below). Unfortunately, I do not 
understand a single bit of this ASL code, and the manual doesn't really 
help me much. I figured out how to get rid of one error (the field 
thing), but I do not have the slightest idea how to handle the others.

Can anybody please help or point me to some source of help with this 
damn DSDT thing? I googled a lot last night, but weren't too successful.

Thanks a lot,

Paul

--------------------------- 8< ------------------------

iasl -tc complains about:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060421 [May 10 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl    20:     Name (_T04, 0x00)
Warning  1097 -              ^ Unknown reserved name (_T04)

dsdt.dsl    21:     Name (_T03, 0x00)
Warning  1097 -              ^ Unknown reserved name (_T03)

dsdt.dsl    22:     Name (_T02, 0x00)
Warning  1097 -              ^ Unknown reserved name (_T02)

dsdt.dsl    23:     Name (_T01, 0x00)
Warning  1097 -              ^ Unknown reserved name (_T01)

dsdt.dsl    24:     Name (_T00, 0x00)
Warning  1097 -              ^ Unknown reserved name (_T00)

dsdt.dsl   513:                         C0E0,   8,
Error    4027 -                            ^ Access width of Field Unit 
extends beyond region limit

dsdt.dsl   514:                         C0E1,   8
Error    4027 -                            ^ Access width of Field Unit 
extends beyond region limit

dsdt.dsl  1545:                             Acquire (\ECMX, 0xA000)
Warning  1103 -             Possible operator timeout is ignored ^

dsdt.dsl  1559:                             Acquire (\MUEC, 0x8000)
Warning  1103 -             Possible operator timeout is ignored ^

dsdt.dsl  1649:                         OperationRegion (IO, SystemIO, 
DPRT, 0x05)
Error    4094 -                                           ^ parse error, 
unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
PARSEOP_NAMESTRING

dsdt.dsl  1650:                         Field (IO, ByteAcc, Lock, Preserve)
Error    4094 -                                 ^ parse error, 
unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
PARSEOP_NAMESTRING

dsdt.dsl  1657:                         Field (IO, ByteAcc, Lock, Preserve)
Error    4094 -                                 ^ parse error, 
unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
PARSEOP_NAMESTRING

dsdt.dsl  1666:                             Return (LNot (INPS))
Error    4062 -                        Object does not exist ^  (INPS)

dsdt.dsl  1671:                             Return (OUTS)
Error    4062 -                  Object does not exist ^  (OUTS)

dsdt.dsl  1917:                                 Store (DAT0, Local0)
Error    4062 -                     Object does not exist ^  (DAT0)

dsdt.dsl  1926:                                 Store (0x80, CMD0)
Error    4062 -                           Object does not exist ^  (CMD0)

dsdt.dsl  1929:                                     Store (Arg0, DAT0)
Error    4062 -                               Object does not exist ^ 
(DAT0)

dsdt.dsl  1932:                                         Store (DAT0, Local0)
Error    4062 -                             Object does not exist ^  (DAT0)

dsdt.dsl  1947:                                 Store (0x81, CMD0)
Error    4062 -                           Object does not exist ^  (CMD0)

dsdt.dsl  1950:                                     Store (Arg0, DAT0)
Error    4062 -                               Object does not exist ^ 
(DAT0)

dsdt.dsl  1953:                                         Store (Arg1, DAT0)
Error    4062 -                                   Object does not exist 
^  (DAT0)

ASL Input:  dsdt.dsl - 4588 lines, 159794 bytes, 2285 keywords
Compilation complete. 14 Errors, 7 Warnings, 0 Remarks, 791 Optimizations

--------------------------- 8< ------------------------

The kernel sometimes (at boot and during operation) says:

     ACPI-0142: *** Error: Store into Alias - should never happen
     ACPI-1172: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_._Q0C] (Node c14b4c20), AE_AML_INTERNAL

--------------------------- 8< ------------------------

