From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Mon, 13 Oct 2008 16:10:04 +0800
Message-ID: <1223885404.2735.183.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3472 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912AbYJMIN4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:13:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>

=EF=BB=BFhi all,

this is the patch set I made recently for ACPI table management
enhancement.

Patch 01 introduces a new mechanism for ACPI inactive table management.
with this patch applied, Linux gets the address of the unused root
table, and parses this root table to get the inactive tables when
needed.
e.g. if Linux is using XSDT on a laptop, tables from RSDT will be
maintain by this mechanism.

Patch 02 introduces a new interface to get certain inactive table,
which is needed by Patch 03.

Patch 03 gets the inactive tables and creates sysfs I/F for these
tables.

Patch 04 creates the sysfs I/F for dynamic loaded tables.
so that users can get all the ACPI tables
under /sys/firmware/acpi/tables,
which was done by the acpidump tool manually before.

Patch 05 fixes a suspend/hibernation bug.
I have a platform which suspends well, but always reboots instead of
resuming when pressing the power button.
I found that there are two FACS tables on this platform,
XSDT-->FADT1-->Xfacs-->FACS1
	|----->facs-|
		    |->FACS2
RSDT-->FADT2-->facs-|
Linux uses XSDT on this platform and sets the waking vector in FACS1
when suspending.
But it seems that the BIOS only cares for the waking vector in FACS2,
thus it reboots when resuming because the waking vector is not set at
all.
I set the waking vector in inactive FACS table to fix it in this patch.

Patch 06 is a refreshed version of =EF=BB=BFPeter Gruber's patch which =
stops
using empty file names for acpi tables in sysfs I/F.

Note:
In this patch set, all the tables in the inactive root table are
recognized as inactive tables even if it's also in the active root
table.
i.e. some tables are shown twice in /sys/firmware/acpi/tables,
both as active and inactive tables.
Take my laptop for example,
#ls /sys/firmware/acpi/tables/
APIC  APIC_inactive  ASF!  ASF!_inactive  DSDT  DSDT_inactive  FACP
=46ACP_inactive
=46ACS  FACS_inactive  MCFG  MCFG_inactive  SSDT_dynamic

In my case, FACP and FACP_inactive are different tables exported by XSD=
T
and RSDT.
but MCFG and MCFG_inactive are the same table because they point to the
same physical address.

I don't think the duplicate tables should be ignored because:
If only the unduplicated inactive tables is shown, we are not able to
get a full list of the tables exported by the inactive root table,
which is important for debugging in some cases.

any comments are welcome. :)


thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
