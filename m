From: Chuck Ebbert <cebbert@redhat.com>
Subject: 2.6.23-rc5 hangs on boot, apparently when initializing the EC
Date: Tue, 11 Sep 2007 15:57:00 -0400
Message-ID: <46E6F30C.5040500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbXIKT5E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Sep 2007 15:57:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kernel ACPI Mailing List <linux-acpi@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>

2.6.23-rc5-git1 hangs here, just before EC initialization.
Pressing the power button briefly makes it continue, then the
EC gets detected twice:


ACPI: bus type pci registered
PCI: Using configuration type 1

------------------ hangs here, press power button --------------------

ACPI: EC: Look up EC in DSDT
ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: If "acpi_osi=Linux" works better,
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:10.0
...


System is an HP TX1000 notebook with AMD Turion X2 processor,
running the x86_64 kernel. (And acpi_osi="Linux" doesn't seem to
make any difference.)
