From: Dennis Buehler <dennisbuehler@gmx.de>
Subject: Problems with the Intel IASL Compiler
Date: Tue, 03 Oct 2006 22:14:24 +0200
Message-ID: <4522C4A0.9040800@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:18320 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030236AbWJCUO3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Oct 2006 16:14:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello members of the ACPI-devel-mailing-list,

in hope to connect to the right point of contact i send this message.

When i try to compile my dsdt.dsl i get the error message 1061.


$ sudo iasl -sa dsdt.dsl
$
$ Intel ACPI Component Architecture
$ ASL Optimizing Compiler version 20051216 [Jan  9 2006]
$ Copyright (C) 2000 - 2005 Intel Corporation
$ Supports ACPI Specification Revision 3.0
$
$ dsdt.dsl  1742:                                     Store
$ (\_SB.PCI0.SBRG.EC0.ACIN, Local0)
$ Error    1061 - Object does not exist ^  (\_SB.PCI0.SBRG.EC0.ACIN)
$
$ ASL Input:  dsdt.dsl - 3456 lines, 120805 bytes, 1551 keywords
$ Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 473
$ Optimizations

After many hours of searching i could not find a solution for this problem.
Is there anybody who knows this error and can tell me what to do to fix it?

I used:

kernel
linux 2.6.17-5-386

compiler
Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051216 [Jan  9 2006]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

bison is installed and there was a test with flex even then flex-old
which should be recommended/needed (says the ubuntu wiki)

hopefully

dennis from berlin
