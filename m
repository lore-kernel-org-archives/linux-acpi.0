From: "Brian Schau" <brian.schau@gmail.com>
Subject: Unexpected shutdown - perhaps ACPI related? (May be solved ...)
Date: Sat, 11 Oct 2008 22:33:06 +0200
Message-ID: <4b97db550810111333x3df0237cif105ccdcd2aa6ce4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:58717 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbYJKUdI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 16:33:08 -0400
Received: by ug-out-1314.google.com with SMTP id k3so203164ugf.37
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 13:33:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

Ok, so I did some changes to my system which _may_ have resolved my
issue.   I haven't seen any unexpected shutdowns
in the last couple of days while running with ACPI enabled.

1) I've changed the harddisk - not that the old one were failing (at
least not according to smart :-) but I needed the extra
capacity.   I went from a Samsung to a Western Digital disk (120GB -> 250 GB :-)

2) I looked through the dmesg output and found the following two acpi notes:

[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify
linux-acpi@vger.kernel.org

So, I set acpi_apic_instance=2 and the signature is:

[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F77B0 checksum 0
[    0.000000] ACPI: RSDP 000F77B0, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 5F696B3B, 004C (r1 STD    STANDARD  6040000
LTP        0)
[    0.000000] ACPI: FACP 5F69CCAA, 0074 (r1 INTEL  CALISTGA  6040000
LOHR       5A)
[    0.000000] ACPI: DSDT 5F69821C, 4A8E (r1 UW____ FUW_____  6040000
INTL 20050624)
[    0.000000] ACPI: FACS 5F69DFC0, 0040
[    0.000000] ACPI: APIC 5F69CD1E, 0068 (r1 INTEL  CALISTGA  6040000
LOHR       5A)
[    0.000000] ACPI: HPET 5F69CD86, 0038 (r1 INTEL  CALISTGA  6040000
LOHR       5A)
[    0.000000] ACPI: MCFG 5F69CDBE, 003C (r1 INTEL  CALISTGA  6040000
LOHR       5A)
[    0.000000] ACPI: APIC 5F69CDFA, 0068 (r1 PTLTD       APIC
6040000  LTP        0)
[    0.000000] ACPI: SLIC 5F69CE62, 0176 (r1 SRD    STANDARD  6040000
LTP        0)
[    0.000000] ACPI: BOOT 5F69CFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000
LTP        1)
[    0.000000] ACPI: SSDT 5F697BCD, 064F (r1 SataRe  SataPri     1000
INTL 20050624)
[    0.000000] ACPI: SSDT 5F69753B, 0692 (r1 SataRe  SataSec     1000
INTL 20050624)
[    0.000000] ACPI: SSDT 5F696B87, 04F6 (r1  PmRef    CpuPm     3000
INTL 20050624)

3) Further down the dmesg log I had:

[   17.300227] ACPI: BIOS _OSI(Linux) query ignored
[   17.300229] ACPI: DMI System Vendor: Standard
[   17.300231] ACPI: DMI Product Name: L51IIX
[   17.300232] ACPI: DMI Product Version:
[   17.300233] ACPI: DMI Board Name: L51IIX
[   17.300235] ACPI: DMI BIOS Vendor: Standard
[   17.300236] ACPI: DMI BIOS Date: 01/12/2007
[   17.300237] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[   17.300239] ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org

... so I added acpi_osi=Linux and now get:

[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] ACPI: Added _OSI(Linux)

Don't know aout the "This may significantly impact system performance"
thing - the system seems
stable.  Which is what I care about!


Best regards,
Brian
