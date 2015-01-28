From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Overriding DSDT and ignored resources
Date: Wed, 28 Jan 2015 12:21:57 +0200
Message-ID: <20150128102157.GC1451@lahna.fi.intel.com>
References: <20150122145729.281f038e8326019a50612e37@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42123 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934250AbbA1UrY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jan 2015 15:47:24 -0500
Content-Disposition: inline
In-Reply-To: <20150122145729.281f038e8326019a50612e37@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-acpi@vger.kernel.org

On Thu, Jan 22, 2015 at 02:57:29PM +0100, Antonio Ospite wrote:
> Hi,
> 
> it looks like linux can't use the correct PCI host resources when using
> an overridden DSDT table, even with an _unmodified_ one.
> 
> I am using 3.19-rc5 rather vanilla (no acpi changes anyways) on a Bay
> Trail tablet.
> 
> When I override the DSDT table I get these messages, and most of the
> devices don't work anymore:
> 
> [    0.000000] DSDT ACPI table found in initrd [kernel/firmware/acpi/dsdt.aml][0x103c3]
> [...]
> [    0.000000] ACPI: Override [DSDT-  A M I ], this is unsafe: tainting kernel
> [...]
> [    0.000000] ACPI: DSDT 0x000000007BCF1000 Physical table override, new table: 0x00000000792E9000
> [    0.000000] ACPI: DSDT 0x00000000792E9000 0103C3 (v02 ALASKA A M I    00000003 AMI  0100000D)
> [...]
> [    0.370871] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000a0000-0x000bffff] ignored 
> [    0.370880] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000c0000-0x000dffff] ignored 
> [    0.370887] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x000e0000-0x000fffff] ignored 
> [    0.370893] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x7d000001-0x7f000000] ignored 
> [    0.370900] acpi PNP0A08:00: host bridge window expanded to [mem 0x00000000-0xffffffff]; [mem 0x00000000-0xffffffff] ignored
> [...]
> 
> Which I don't get without overriding the DSDT.
> 
> Full dmesg here:
> http://ao2.it/tmp/ACPI_DSDT_override/dmesg_DSDT_override.log
> 
> The dmesg with the original DSDT here:
> http://ao2.it/tmp/ACPI_DSDT_override/dmesg_original_DSDT.log
> 
> These are the steps to reproduce the issue:
>   1. Extract the DSDT with acpidump;
>   2. Build an initrd with the intent to override the DSDT with the very
>      same extracted at 1., no modifications whatsoever.
>      The initrd is built just like explained in
>      Documentation/acpi/initrd_table_override.txt;
>   3. Boot with the modified initrd.
> 
> I did the test with the _unmodified_ DSDT to exclude errors on my side
> when decompiling, editing and recompiling the DSDT table.

Are you using the latest ACPICA?

> Can anyone else reproduce that?

Nope, but I have done several times following:

 1) Take the DSDT dump
 2) iasl -d DSDT
 3) iasl -tc DSDT.dsl

 (the above will make .hex file)

 4) Edit your .config and add:

 CONFIG_STANDALONE=n
 CONFIG_ACPI_CUSTOM_DSDT_FILE="/path/to/your/DSDT.hex"

 5) Rebuild and reboot

That typically works for me.
