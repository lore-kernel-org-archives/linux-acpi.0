From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Faulty DSDT
Date: Mon, 24 Apr 2006 17:33:22 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6420CA9@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60960 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751307AbWDXVdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2006 17:33:31 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Iv=E1n=22_Gracia?= <izanmail@yahoo.com>
Cc: linux-acpi@vger.kernel.org

[adding linux-acpi@vger.kernel.org] to cc:

>I have a Toshiba S3 laptop that comes with a falulty DSDT. 
>These are the
>errors I get when trying to compile with iasl on both windows and linux
>machines

What issue motivates you to compile the DSDT in the first place?

>Intel ACPI Component Architecture
>ASL Optimizing Compiler version 20060317 [Mar 17 2006]

probably good to get the very latest dis-assembler
and compiler from here:

http://www.intel.com/technology/iapc/acpi/downloads.htm

20060331 is the latest on the web site at the moment.

>Copyright (C) 2000 - 2006 Intel Corporation
>Supports ACPI Specification Revision 3.0a
>
>dsdt.dsl  3735:                     }
>Error    1094 -                     ^ parse error, expecting `'(''
>
>dsdt.dsl  3747:                             }
>Error    1094 -                             ^ parse error, expecting `'
>
>dsdt.dsl  3866:                 0x03
>Error    1094 -                    ^ parse error, expecting `'(''
>
>dsdt.dsl  4233: [*** iASL: Read error on source code temp file ***]
>Error    1094 -^ parse error
>
>ASL Input:  dsdt.dsl - 4234 lines, 139958 bytes, 1745 keywords
>Compilation complete. 4 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
>
>
>*******
>If (LEqual (Local0, 0x02))
>{
>   PDVN  <<line: 3735 here is a parse error
>}

looks like PDVN is missing the parameters.
eg. PVDN(a, b, c)
similar issues below.

if the latest disassembler/compiler do not work, please open a bug
and attach the output from acpidump or the DSDT w/ no modifications.

thanks,
-Len

>Else
>{
>   If (LEqual (Local0, 0x08))
>   {
>      If (LAnd (LNot (LEqual (\_SB.MEM.VALF, 0x00)), LNot (LEqual
>(\_SB.MEM.HKRD, 0x00))))
>      {
>         Notify (\_SB.VALZ, 0x87)
>      }
>      Else
>      {
>          SDVN <<line: 3747 here is a parse error
>      }
>
>*******
>If (LEqual (SBTB, 0x01))
>{
>   SH1X
>   0x03 <<line: 3866 Here is the parse error
>}
>*******
>
>
>I was able to fix another error, but I have found no info about this
>errors on forums or pages, and www.acpi.info is down (or at 
>least I can't
>access) so I can't download the specs. Could you please give 
>me a hand, if
>it's not too many trouble? Otherwise, please let me know were I can get
>some help. I've been fighting with these 4 errors for a couple of days,
>and after comparing my dsdt with other dsdt's, I can't find any
>workarounds for these errors, and I get an "ACPI- Can't load 
>DSDT" message
>with dmesg.
>
>Sorry for the trouble, and thank you in advance for any help 
>you can give
>on this matter.
>
>Kind regards,
>Ivan Gracia
>
>
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>
