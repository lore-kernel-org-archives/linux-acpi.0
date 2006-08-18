From: Holger Schurig <h.schurig@mn-solutions.de>
Subject: Help needed to create a valid DSDT
Date: Fri, 18 Aug 2006 16:11:38 +0200
Message-ID: <200608181611.38580.h.schurig@mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from s131.mittwaldmedien.de ([62.216.178.31]:3901 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S1030419AbWHROVM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 10:21:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id D2D405E4179
	for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2006 16:21:09 +0200 (CEST)
Received: from lin01.mn-solutions.de (pD95F84A5.dip0.t-ipconnect.de [217.95.132.165])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id F024B5E4199
	for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2006 16:21:05 +0200 (CEST)
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 201DB1E00D1
	for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2006 16:11:39 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have a DT Research DT368 board where the DSDT is invalid. I've 
uploaded the original DSDT, anyone can fetch it here.

http://acpi.sourceforge.net/dsdt/view.php?id=662

The errors that I get are:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 27 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

  dsdt.dsl.orig    63:             Name (_HID, "_ASIM0000")
  Error    4001 -   String must be entirely alphanumeric ^
  (_ASIM0000)

Is it here ok to just change that into Name (_HID, "ASIM0000") ?


  dsdt.dsl.orig  1968:                 Field (PIUC, DWordAcc,
                                       Lock, Preserve)
  Error    4026 -                                ^ Access width
                                    is greater than region size

When I change this into ByteAcc, then it compiles. The resulting 
function is below, does that make sense?

                OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
                Field (PIUC, ByteAcc, Lock, Preserve)
                {
                            AccessAs (ByteAcc, 0x00),
                    PIRU,   4
                }




  dsdt.dsl.orig  3521:     Method (_WAK, 1, NotSerialized)
  Warning  1079 -                     ^ Reserved method must
                                       return a value (_WAK)

That was actually in some FAQ, I added a Return(Package) so that 
it now is like below. Does this make sense, too?

    Name (PB02, 0x00)
    Name (PB03, 0x00)
    Name (PB21, 0x00)
    Name (PB26, 0x00)
    Method (_WAK, 1, NotSerialized)
    {
        Store ("===== WAK =====", Debug)
        If (LEqual (Arg0, 0x01))
        {
            Store ("===== WAK from S1 =====", Debug)
            Notify (\_SB.SLPB, 0x02)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store ("===== WAK from S3 =====", Debug)
            Notify (\_SB.SLPB, 0x02)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store ("===== WAK from S4 =====", Debug)
            Notify (\_SB.SLPB, 0x02)
        }
        Return(Package(0x02){0x00, 0x00})
    }


  dsdt.dsl.orig  3751:             Name (_HID, "*pnp0c14")
  Error    4001 -  String must be entirely alphanumeric ^
  (*pnp0c14)

Here I'd got rid of the star and make it Name (_HID, "pnp0c14")


  dsdt.dsl.orig  4035:                     Store (Debug, FOO1)
  Error    4094 -                                     ^ syntax
                               error, unexpected PARSEOP_DEBUG

Here I don't really understand the problem and don't know a
solution. For now, I just uncommented it:

            Method (WQAA, 1, NotSerialized)
            {
                If (LEqual (CCAA, Zero))
                {
                    Name (FOO, "WMIACPI: ASL: WQAA called, but 
CCAA is 0\n")
                    Store (FOO, Debug)
                    Name (FOO1, "aa")
                    /* Store (Debug, FOO1) */
                    Fatal (0xA0, 0x00000001, 0x00)
                }

                Return (GETA (Arg0))
            }



The rest are warnings:

  dsdt.dsl.orig  3923:           Method (GETA, 1, NotSerialized)
  Warning  1086 -                              ^ Not all control
                                     paths return a value (GETA)

This basically either returns something or terminates with 
Fatal(). Is the warning therefore bogus?

  dsdt.dsl.orig  4039:                 Return (GETA (Arg0))
  Warning  1091 -                               ^ Called method
                                  may not always return a value

And that's a followup to the warning above. The same happens for 
other methods. Does this need fixing?



dsdt.dsl.orig  3951:             Method (GETB, 1, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (GETB)

dsdt.dsl.orig  3979:             Method (GETC, 1, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (GETC)

dsdt.dsl.orig  4051:                 Return (GETB (Arg0))
Warning  1091 -                                 ^ Called method 
may not always return a value

dsdt.dsl.orig  4063:                 Return (GETC (Arg0))
Warning  1091 -                                 ^ Called method 
may not always return a value

dsdt.dsl.orig  4066:             Method (SETA, 2, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (SETA)

dsdt.dsl.orig  4098:             Method (SETB, 2, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (SETB)

dsdt.dsl.orig  4130:             Method (SETC, 2, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (SETC)

dsdt.dsl.orig  4184:                 Return (SETA (Arg0, Arg1))
Warning  1091 -                                 ^ Called method 
may not always return a value

dsdt.dsl.orig  4196:                 Return (SETB (Arg0, Arg1))
Warning  1091 -                                 ^ Called method 
may not always return a value

dsdt.dsl.orig  4208:                 Return (SETC (Arg0, Arg1))
Warning  1091 -                                 ^ Called method 
may not always return a value

dsdt.dsl.orig  4230:             Method (WMBA, 3, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (WMBA)

dsdt.dsl.orig  4234:                     Return (GETA (Arg0))
Warning  1091 -                                     ^ Called 
method may not always return a value

dsdt.dsl.orig  4263:             Method (WMBB, 3, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (WMBB)

dsdt.dsl.orig  4267:                     Return (GETB (Arg0))
Warning  1091 -                                     ^ Called 
method may not always return a value

dsdt.dsl.orig  4296:             Method (WMBC, 3, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (WMBC)

dsdt.dsl.orig  4300:                     Return (GETC (Arg0))
Warning  1091 -                                     ^ Called 
method may not always return a value

dsdt.dsl.orig  4329:             Method (_WED, 1, NotSerialized)
Warning  1086 -                             ^ Not all control 
paths return a value (_WED)

dsdt.dsl.orig  4329:             Method (_WED, 1, NotSerialized)
Warning  1079 -                             ^ Reserved method 
must return a value (_WED)

dsdt.dsl.orig  4333:                     Return (GETA (0x00))
Warning  1091 -                                     ^ Called 
method may not always return a value

dsdt.dsl.orig  4338:                     Return (GETB (0x00))
Warning  1091 -                                     ^ Called 
method may not always return a value

dsdt.dsl.orig  4343:                     Return (GETC (0x00))
Warning  1091 -                                     ^ Called 
method may not always return a value

ASL Input:  dsdt.dsl.orig - 4499 lines, 156755 bytes, 2496 
keywords
Compilation complete. 4 Errors, 24 Warnings, 0 Remarks, 602 
Optimizations

-- 
M&N Solutions GmbH
Holger Schurig
Dieselstr. 18
61191 Rosbach
06003/9141-15
