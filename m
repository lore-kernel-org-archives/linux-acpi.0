From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
Date: Thu, 8 May 2008 09:32:53 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B34C305A@orsmsx415.amr.corp.intel.com>
References: <1210259402.6710.10.camel@hammer1.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5683 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbYEHQd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 12:33:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1210259402.6710.10.camel@hammer1.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, me@markdoughty.co.uk, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>

Has there any investigation into how windows handles this?


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Thursday, May 08, 2008 8:10 AM
>To: linux-acpi; Len Brown
>Cc: Zhao, Yakui; me@markdoughty.co.uk; Moore, Robert; Starikovskiy,
Alexey
>Y
>Subject: [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
>
>I expect separate patches should now be patched against
>acpica when possible?
>
>Does this also make sense with patches which have dependencies
>to other patches for the Linux kernel? In this case there is not a
>"does not compile" dependency, but at least they belong together.
>
>I wonder what works out for acpica and Linux kernel maintainers best,
>please advise.
>
>
>----
>
>ACPICA: Add acpi_gbl_force_rsdt variable
>
>Signed-off-by: Thomas Renninger <trenn@suse.de>
>Tested-by: Mark Doughty <me@markdoughty.co.uk>
>
>
>---
> drivers/acpi/tables/tbutils.c     |    3 ++-
> drivers/acpi/utilities/utglobal.c |    1 +
> include/acpi/acglobal.h           |    1 +
> 3 files changed, 4 insertions(+), 1 deletion(-)
>
>Index: linux-acpi-
>2.6_video_native_vs_vendor/drivers/acpi/utilities/utglobal.c
>===================================================================
>--- linux-acpi-
>2.6_video_native_vs_vendor.orig/drivers/acpi/utilities/utglobal.c
>+++
linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/utilities/utglobal.c
>@@ -76,6 +76,7 @@ u8 acpi_gbl_method_executing = FALSE;
> /* System flags */
>
> u32 acpi_gbl_startup_flags = 0;
>+int acpi_gbl_force_rsdt = 0;
>
> /* System starts uninitialized */
>
>Index: linux-acpi-2.6_video_native_vs_vendor/include/acpi/acglobal.h
>===================================================================
>--- linux-acpi-2.6_video_native_vs_vendor.orig/include/acpi/acglobal.h
>+++ linux-acpi-2.6_video_native_vs_vendor/include/acpi/acglobal.h
>@@ -246,6 +246,7 @@ ACPI_EXTERN u8 acpi_gbl_system_awake_and
>
> extern u8 acpi_gbl_shutdown;
> extern u32 acpi_gbl_startup_flags;
>+extern int acpi_gbl_force_rsdt;
> extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
> extern const char *acpi_gbl_highest_dstate_names[4];
> extern const struct acpi_opcode_info
>acpi_gbl_aml_op_info[AML_NUM_OPCODES];
>Index:
linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables/tbutils.c
>===================================================================
>--- linux-acpi-
>2.6_video_native_vs_vendor.orig/drivers/acpi/tables/tbutils.c
>+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables/tbutils.c
>@@ -421,7 +421,8 @@ acpi_tb_parse_root_table(acpi_physical_a
>
> 	/* Differentiate between RSDT and XSDT root tables */
>
>-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
>+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
>+	    && !acpi_gbl_force_rsdt) {
> 		/*
> 		 * Root table is an XSDT (64-bit physical addresses). We
must
>use the
> 		 * XSDT if the revision is > 1 and the XSDT pointer is
present,
>as per
>

