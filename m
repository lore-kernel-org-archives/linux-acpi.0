From: daniel friedrich <f-bert@gmx.net>
Subject: asus a7n8x-xe S3 problems
Date: Tue, 18 Apr 2006 13:03:50 +0200
Message-ID: <1145358230.5786.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:19395 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750773AbWDRLDw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 07:03:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hi,

the resume from suspend to disk works fine, but when i resume von
suspend to ram i have to switch by hand into x and than the system
freezes after a short time.

i think there is a problem with my hd access.

i take a look at dsdt but there is only one error:
~$iasl -sa dsdt.dsl
Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060331 [Apr 18 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a
dsdt.dsl  3950:                 Name (_HID, "_NVRAIDBUS")
Error    1001 -   String must be entirely alphanumeric ^  (_NVRAIDBUS)

ASL Input:  dsdt.dsl - 4364 lines, 141169 bytes, 1852 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 415 Optimizations

some files maybe help to see whats wrong by s3:
http://www.f-bert.net/blog/fileadmin/dmsg_acpi_support.txt
http://www.f-bert.net/blog/fileadmin/dmsg_acpi_support_reset_drive.txt
http://f-bert.net/blog/fileadmin/dmsg_normal_boot.txt
http://f-bert.net/blog/fileadmin/asus_a7n8x-xe_dsdt.dat

my hardware:
-geforce2 mx 400
-asus a7n8x-xe
-werstern digital wd2500jb

if you need more infos please say it :)

thanks daniel

