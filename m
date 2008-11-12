From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND] [PATCH 0/6] ACPI: ACPI table management enhancement
Date: Wed, 12 Nov 2008 16:28:58 +0800
Message-ID: <1226478538.15014.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35341 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYKLIb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 03:31:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>

=EF=BB=BFhi all,

this is the patch set I made recently for ACPI table management
enhancement.

Patch 01 creates the sysfs I/F for ACPI dynamic tables.

Patch 02 introduces a new mechanism for ACPI inactive table management.

Patch 03 initializes the inactive tables at boot time and builds sysfs
I/F for these tables.

Patch 04 introduces ACPI_INACTIVE_TABLE_MANAGEMENT to make the inactive
table management configurable.

here is the ACPI table sysfs I/F on my laptop after applying these
patches.
#tree /sys/firmware/acpi/tables/
=EF=BB=BF/sys/firmware/acpi/tables/
|-- APIC
|-- ASF!
|-- DMAR
|-- DSDT
|-- FACP
|-- FACS
|-- HPET
|-- MCFG
|-- SLIC
|-- SSDT1
|-- SSDT2
|-- SSDT3
|-- SSDT4
|-- dynamic
|   |-- SSDT5
|   |-- SSDT6
|   |-- SSDT7
|   `-- SSDT8
`-- inactive
    |-- APIC
    |-- ASF!
    |-- DMAR
    |-- DSDT
    |-- FACP
    |-- FACS
    |-- HPET
    |-- MCFG
    |-- RSDT
    |-- SLIC
    |-- SSDT1
    |-- SSDT2
    |-- SSDT3
    `-- SSDT4

2 directories, 31 files

Patch 05 and Patch 06 fix a suspend/hibernation bug for me.
I have a test box which suspends well, but always reboots instead of
resuming when pressing the power button.
I found that there are two FACS tables on this platform,
XSDT-->FADT1-->Xfacs------>FACS1
	|----->facs-----|
			|->FACS2
RSDT-->FADT2-->facs-----|
Linux uses XSDT on this platform and sets the waking vector in FACS1
when suspending. But it seems that the BIOS only cares for the waking
vector in FACS2, thus it reboots when resuming because the waking vecto=
r
is not set at all.

=46ADT1.facs is installed to the acpi_gbl_root_table_list in Patch 05.
And the waking vector of FADT1.facs is set during suspend in Patch 06.

any comments are welcome. :)

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
