From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: ACPICA branch (0 Objects with 0 Devices 0 Methods 0 Regions)
Date: Tue, 06 May 2008 14:20:33 +0800
Message-ID: <1210054833.7447.3.camel@minggr>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
	 <200804290504.54789.lenb@kernel.org>
	 <9D39833986E69849A2A8E74C1078B6B33BCDFA@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbYEFGYZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 02:24:25 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B33BCDFA@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi, all

The root cause found, it's caused by a patch 
which introduced in ACPICA version 20071019

commit 7f4ac9f91383a0707de559dc8fbca986fc2d302f
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Apr 10 19:06:39 2008 +0400

    ACPICA: Fix for Load/LoadTable to specify load location
    
    Fixed a problem with the Load and LoadTable operators where
    the table location within the namespace was ignored. Instead,
    the table was always loaded into the root or current scope.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>


For example, 
SSDT:
Name(\tmp0, 0)

DSDT:
Method(m000)
{
	<Load the SSDT above>
}

Namespace walking will start at node m000, so \tmp0 will never appear at
the namespace walking.

It seems that we should again force the table always loaded into the
root.
Load statement is always inside a method.
It makes no sense to install some nodes inside a method since the nodes
in method should all be temporary nodes that will be deleted when method
exit.

Lin Ming
---
diff --git a/drivers/acpi/executer/exconfig.c
b/drivers/acpi/executer/exconfig.c
index 24da921..508bb0e 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -376,7 +376,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
        }
 
        status =
-           acpi_ex_add_table(table_index,
walk_state->scope_info->scope.node,
+           acpi_ex_add_table(table_index, acpi_gbl_root_node,
                              &ddb_handle);
        if (ACPI_FAILURE(status)) {

On Wed, 2008-04-30 at 00:09 +0800, Moore, Robert wrote:
> It looks like the tables in question are dynamically loaded:
> 
> >ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
> >Table [SSDT](id 0044) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
> >Table [SSDT](id 0045) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
> >Table [SSDT](id 0050) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
> >Table [SSDT](id 0051) - 0 Objects with 0 Devices 0 Methods 0 Regions
> 
> What the zeroes mean is that a WalkNamespace after the table load did
> not find any such objects created by the table.
> 
> Something does look wrong, it may not affect your machine, but has the
> potential to cause problems on other machines.
> 
> The difference in owner IDs between the two traces might mean that there
> is some mismatch somewhere. I would debug and determine 1) The actual
> owner id created for the newly loaded table, and 2) what owner id is
> passed to AcpiDsInitializeObjects after the table is loaded.
> 
> Bob
> 
> 
> 
> >-----Original Message-----
> >From: Len Brown [mailto:lenb@kernel.org]
> >Sent: Tuesday, April 29, 2008 2:05 AM
> >To: linux-acpi@vger.kernel.org; Moore, Robert; Lin, Ming M
> >Subject: Re: ACPICA branch (0 Objects with 0 Devices 0 Methods 0
> Regions)
> >
> >Hmm, i just noticed something strange on the T61
> >
> >Linus' tree prints these messages:
> >
> >[lenb@t61 sut]$ grep -i ssdt 2.6.25-06058-ga01e035/dmesg
> >ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
> >ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
> >Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
> >Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
> >Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
> >Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
> >ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
> >Table [SSDT](id 003A) - 6 Objects with 0 Devices 4 Methods 0 Regions
> >ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
> >Table [SSDT](id 003B) - 16 Objects with 0 Devices 1 Methods 0 Regions
> >ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
> >Table [SSDT](id 0046) - 4 Objects with 0 Devices 4 Methods 0 Regions
> >ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
> >Table [SSDT](id 0047) - 1 Objects with 0 Devices 1 Methods 0 Regions
> >
> >
> >The acpi test tree prints these messages:
> >
> >[lenb@t61 sut]$ grep -i ssdt 2.6.25-06238-gf4e0ea3/dmesg
> >ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
> >ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
> >Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
> >Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
> >Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
> >Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
> >Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
> >ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
> >Table [SSDT](id 0044) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
> >Table [SSDT](id 0045) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
> >Table [SSDT](id 0050) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
> >Table [SSDT](id 0051) - 0 Objects with 0 Devices 0 Methods 0 Regions
> >
> >ie.  "0 Objects with 0 Devices 0 Methods 0 Regions"
> >
> >dunno if this is just cosmetic -- the p-states that are advertised in
> >the SSDT's seem to be working normally, and C-states do too.
> >
> >-Len

