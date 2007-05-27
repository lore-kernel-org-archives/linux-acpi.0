From: giggz <giggzounet@gmail.com>
Subject: Bugs in my DSDT (aopen 1556/1557 ou keynux impact)
Date: Sun, 27 May 2007 19:25:09 +0200
Message-ID: <4659BEF5.5020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40061 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbXE0R0L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 May 2007 13:26:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1470876ugf
        for <linux-acpi@vger.kernel.org>; Sun, 27 May 2007 10:26:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have done that :

cat /proc/acpi/dsdt > dsdt.dat
iasl -d dsdt.dat
iasl -tc dsdt.dsl

The output :

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20061109 [May 18 2007]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl   207:     Method (_WAK, 1, NotSerialized)
Warning  1079 -                ^ Reserved method must return a value (_WAK)

dsdt.dsl  2600:                     Field (RAM, AnyAcc, Lock, Preserve)
Error    4074 -                              ^ Host Operation Region
requires ByteAcc access

dsdt.dsl  2714:                             Store (Arg2, DAT3)
Error    4005 -    Method argument is not initialized ^  (Arg2)

dsdt.dsl  2714:                             Store (Arg2, DAT3)
Remark   5065 -   Not a parameter, used as local only ^  (Arg2)

dsdt.dsl  3121:                     Release (MTIO)
Warning  1098 -        Statement is unreachable ^

ASL Input:  dsdt.dsl - 4852 lines, 179994 bytes, 2068 keywords
Compilation complete. 2 Errors, 2 Warnings, 1 Remarks, 493 Optimizations

Do anyone can and want to help me, please ?
I can post the dsdt.dsl too but it's quite long...

Thx
Guillaume
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGWb71RvQAQ6Awr6YRAidyAJ9qiAZmu908ZepZDgZNR2zeuf8mdgCfaiJk
p2gI9zWA8pY2qO7px72XQuU=
=RCLO
-----END PGP SIGNATURE-----
