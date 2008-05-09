From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
Date: Fri, 9 May 2008 10:28:31 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B34FACBB@orsmsx415.amr.corp.intel.com>
References: <1210259402.6710.10.camel@hammer1.suse.de> <9D39833986E69849A2A8E74C1078B6B34C305A@orsmsx415.amr.corp.intel.com> <1210323010.29724.7.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35416 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683AbYEIR27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2008 13:28:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1210323010.29724.7.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, me@markdoughty.co.uk, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>

Sounds like there are still a lot of "unknowns", namely

1) what does XP do?
2) what does Vista do?
3) is there actually a bug in ACPICA?

I'm not comfortable just slapping in another global when so many
questions remain unanswered.

Bob


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Friday, May 09, 2008 1:50 AM
>To: Moore, Robert
>Cc: linux-acpi; Len Brown; Zhao, Yakui; me@markdoughty.co.uk;
Starikovskiy,
>Alexey Y
>Subject: RE: [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
>
>On Thu, 2008-05-08 at 09:32 -0700, Moore, Robert wrote:
>> Has there any investigation into how windows handles this?
>It's too late now, anyway.
>This is about 3 years old machines, we do not want to change the
>behavior XSDT vs RSDT in general and produce some regressions as a
>side-effect, but just fix up some known broken machines.
>
>I expect that XP did violate a bit the spec and tended to prefer the
>RSDT. I don't know how to check all this, but I expect that Vista is
>preferring the XSDT again.
>Or there always were bugs in acpica setting up the FADT via XSDT
causing
>this.
>
>Providing OS a knob at this place shouldn't be a big deal?
>
>   Thomas
>
>> >-----Original Message-----
>> >From: Thomas Renninger [mailto:trenn@suse.de]
>> >Sent: Thursday, May 08, 2008 8:10 AM
>> >To: linux-acpi; Len Brown
>> >Cc: Zhao, Yakui; me@markdoughty.co.uk; Moore, Robert; Starikovskiy,
>> Alexey
>> >Y
>> >Subject: [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
>> >
>> >I expect separate patches should now be patched against
>> >acpica when possible?
>> >
>> >Does this also make sense with patches which have dependencies
>> >to other patches for the Linux kernel? In this case there is not a
>> >"does not compile" dependency, but at least they belong together.
>> >
>> >I wonder what works out for acpica and Linux kernel maintainers
best,
>> >please advise.
>> >
>> >
>> >----
>> >
>> >ACPICA: Add acpi_gbl_force_rsdt variable
>> >
>> >Signed-off-by: Thomas Renninger <trenn@suse.de>
>> >Tested-by: Mark Doughty <me@markdoughty.co.uk>
>> >
>> >
>> >---
>> > drivers/acpi/tables/tbutils.c     |    3 ++-
>> > drivers/acpi/utilities/utglobal.c |    1 +
>> > include/acpi/acglobal.h           |    1 +
>> > 3 files changed, 4 insertions(+), 1 deletion(-)
>> >
>> >Index: linux-acpi-
>> >2.6_video_native_vs_vendor/drivers/acpi/utilities/utglobal.c
>> >===================================================================
>> >--- linux-acpi-
>> >2.6_video_native_vs_vendor.orig/drivers/acpi/utilities/utglobal.c
>> >+++
>>
linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/utilities/utglobal.c
>> >@@ -76,6 +76,7 @@ u8 acpi_gbl_method_executing = FALSE;
>> > /* System flags */
>> >
>> > u32 acpi_gbl_startup_flags = 0;
>> >+int acpi_gbl_force_rsdt = 0;
>> >
>> > /* System starts uninitialized */
>> >
>> >Index: linux-acpi-2.6_video_native_vs_vendor/include/acpi/acglobal.h
>> >===================================================================
>> >---
linux-acpi-2.6_video_native_vs_vendor.orig/include/acpi/acglobal.h
>> >+++ linux-acpi-2.6_video_native_vs_vendor/include/acpi/acglobal.h
>> >@@ -246,6 +246,7 @@ ACPI_EXTERN u8 acpi_gbl_system_awake_and
>> >
>> > extern u8 acpi_gbl_shutdown;
>> > extern u32 acpi_gbl_startup_flags;
>> >+extern int acpi_gbl_force_rsdt;
>> > extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
>> > extern const char *acpi_gbl_highest_dstate_names[4];
>> > extern const struct acpi_opcode_info
>> >acpi_gbl_aml_op_info[AML_NUM_OPCODES];
>> >Index:
>> linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables/tbutils.c
>> >===================================================================
>> >--- linux-acpi-
>> >2.6_video_native_vs_vendor.orig/drivers/acpi/tables/tbutils.c
>> >+++
linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables/tbutils.c
>> >@@ -421,7 +421,8 @@ acpi_tb_parse_root_table(acpi_physical_a
>> >
>> > 	/* Differentiate between RSDT and XSDT root tables */
>> >
>> >-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
>> >+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
>> >+	    && !acpi_gbl_force_rsdt) {
>> > 		/*
>> > 		 * Root table is an XSDT (64-bit physical addresses). We
>> must
>> >use the
>> > 		 * XSDT if the revision is > 1 and the XSDT pointer is
>> present,
>> >as per
>> >
>>

