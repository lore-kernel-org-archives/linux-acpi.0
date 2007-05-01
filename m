From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Tue, 01 May 2007 11:40:54 +0200
Message-ID: <46370B26.2080704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031631AbXEAJkl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 May 2007 05:40:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

i bought a Laptop Asus A7Tc and got the first Problem with ACPI and
suspend-to-ram.

My System is Debian Etch with Kernel 2.6.21.
Cpu is AMD Turion(tm) 64 X2 Mobile Technology TL-52


i did the folowing to fix my dsdt Table,
 > cat /proc/acpi/dsdt > dsdt.dat
 > iasl -d dsdt.dat
 > feld-bertlap:/tmp/acpi# iasl -tc dsdt.dsl

 > Intel ACPI Component Architecture
 > ASL Optimizing Compiler version 20060912 [Dec 20 2006]
 > Copyright (C) 2000 - 2006 Intel Corporation
 > Supports ACPI Specification Revision 3.0a

 > dsdt.dsl     1: ACPI Package (0x04)
 > Error    4094 -    ^ syntax error, unexpected PARSEOP_NAMESEG, 
expecting PARSEOP_DEFINITIONBLOCK

Can anybody explain what i have to do to correct my table?

bye Markus

