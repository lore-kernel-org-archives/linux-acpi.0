From: Martian67 <Martian67@gmail.com>
Subject: DSDT compilation issues
Date: Fri, 18 May 2007 02:17:39 +0000 (UTC)
Message-ID: <loom.20070518T040303-255@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34140 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999AbXERCUI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 22:20:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hos4Y-0006UW-Nz
	for linux-acpi@vger.kernel.org; Fri, 18 May 2007 04:20:03 +0200
Received: from S0106001839504413.ed.shawcable.net ([68.149.13.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 18 May 2007 04:20:02 +0200
Received: from Martian67 by S0106001839504413.ed.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 18 May 2007 04:20:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, when i attempt to recompile a buggy DSDT table for my Toshiba P100
PSPA3C-MA502C, I get some compiletime errors, and i am not sure how to adress
them properly.

I am running through this procedure as outlined @
http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems

**************************************************************************

cat /proc/acpi/dsdt > dsdt.dat

iasl -d dsdt.dat

iasl -tc dsdt.dsl

**************************************************************************

When I attempt to  do this it results in these errors

***************************************************************************

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20061109 [May 15 2007]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl  1773:                                 Name (_T_0, 0x00)
Error    4081 -                     Use of reserved word ^  (_T_0)

dsdt.dsl  1851:                                 Name (_T_0, 0x00)
Error    4081 -                     Use of reserved word ^  (_T_0)

dsdt.dsl  2145:                             Name (_T_0, 0x00)
Error    4081 -                 Use of reserved word ^  (_T_0)

dsdt.dsl  2223:                             Name (_T_0, 0x00)
Error    4081 -                 Use of reserved word ^  (_T_0)

dsdt.dsl  6516:             Method (BTST, 0, NotSerialized)
Warning  1086 -                        ^ Not all control paths return a 
value (BTST)

dsdt.dsl  6543:             Name (_HID, "*PNP0C14")
Error    4001 -                                  ^ String must be entirely
alphanumeric (*PNP0C14)

***************************************************************************

here is a link to the dsl file

http://www.pastebin.ca/494055

any help that could be rendered would be greatly appreciated

