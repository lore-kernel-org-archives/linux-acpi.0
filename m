From: Antonio Ospite <ao2@ao2.it>
Subject: Overriding DSDT and ignored resources
Date: Thu, 22 Jan 2015 14:57:29 +0100
Message-ID: <20150122145729.281f038e8326019a50612e37@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:58121 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbAVN5d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jan 2015 08:57:33 -0500
Received: from jcn (79.2.147.43) by smtp207.alice.it (8.6.060.28)
        id 547D8BAA086F9AC1 for linux-acpi@vger.kernel.org; Thu, 22 Jan 2015 14:57:31 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

it looks like linux can't use the correct PCI host resources when using
an overridden DSDT table, even with an _unmodified_ one.

I am using 3.19-rc5 rather vanilla (no acpi changes anyways) on a Bay
Trail tablet.

When I override the DSDT table I get these messages, and most of the
devices don't work anymore:

[    0.000000] DSDT ACPI table found in initrd [kernel/firmware/acpi/dsdt.aml][0x103c3]
[...]
[    0.000000] ACPI: Override [DSDT-  A M I ], this is unsafe: tainting kernel
[...]
[    0.000000] ACPI: DSDT 0x000000007BCF1000 Physical table override, new table: 0x00000000792E9000
[    0.000000] ACPI: DSDT 0x00000000792E9000 0103C3 (v02 ALASKA A M I    00000003 AMI  0100000D)
[...]
[    0.370871] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000a0000-0x000bffff] ignored 
[    0.370880] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000c0000-0x000dffff] ignored 
[    0.370887] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000e0000-0x000fffff] ignored 
[    0.370893] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x7d000001-0x7f000000] ignored 
[    0.370900] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x00000000-0xffffffff] ignored
[...]

Which I don't get without overriding the DSDT.

Full dmesg here:
http://ao2.it/tmp/ACPI_DSDT_override/dmesg_DSDT_override.log

The dmesg with the original DSDT here:
http://ao2.it/tmp/ACPI_DSDT_override/dmesg_original_DSDT.log

These are the steps to reproduce the issue:
  1. Extract the DSDT with acpidump;
  2. Build an initrd with the intent to override the DSDT with the very
     same extracted at 1., no modifications whatsoever.
     The initrd is built just like explained in
     Documentation/acpi/initrd_table_override.txt;
  3. Boot with the modified initrd.

I did the test with the _unmodified_ DSDT to exclude errors on my side
when decompiling, editing and recompiling the DSDT table.

Can anyone else reproduce that?

Thanks,
   Antonio

P.S. Please CC me on reply, I am not subscribed to linux-acpi.

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
