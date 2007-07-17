From: Lukas <lcpak@wsbnlu.edu.pl>
Subject: BIOS bug: multiple APIC/MADT found
Date: Tue, 17 Jul 2007 10:36:55 +0200
Message-ID: <20070717103655.82ea4430.lcpak@wsbnlu.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:43844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524AbXGQIhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 04:37:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so109241ugf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 01:37:02 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

MODEL: TOSHIBA TECRA A7
kernel: 2.6.22-r1 (gentoo)
dmesg output
--CODE:
ACPI: RSDP 000F6960, 0024 (r2 TOSINV)
ACPI: XSDT 5FE78451, 008C (r1 TOSINV TOSINV00  6040000  INV        0)
ACPI: FACP 5FE81BF8, 00F4 (r3 TOSINV TOSINV00  6040000 ALAN        1)
ACPI: DSDT 5FE7A1EA, 799A (r2 TOSINV CALISTGA  6040000 INTL 20050624)
ACPI: FACS 5FE82FC0, 0040
ACPI: APIC 5FE81CEC, 0068 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: HPET 5FE81D54, 0038 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: MCFG 5FE81D8C, 003C (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: TCPA 5FE81DC8, 0032 (r1 PTLTD  CALISTGA  6040000  PTL        1)
ACPI: APIC 5FE81DFA, 0068 (r1 TOSINV   APIC    6040000  INV        0)
ACPI: SLIC 5FE81E62, 0176 (r1 TOSINV TOSINV00  6040000  INV        0)
ACPI: BOOT 5FE81FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SSDT 5FE79B9B, 064F (r1 SataRe  SataPri     1000 INTL 20050624)
ACPI: SSDT 5FE79509, 0692 (r1 SataRe  SataSec     1000 INTL 20050624)
ACPI: SSDT 5FE78A69, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
ACPI: SSDT 5FE789C3, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
ACPI: SSDT 5FE784DD, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
--
