From: Thomas Renninger <trenn@suse.de>
Subject: [RESEND] [PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
Date: Sun, 19 Oct 2008 23:49:49 +0200
Message-ID: <200810192349.51020.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:40054 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbYJSVtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 17:49:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

ACPICA: Add acpi_gbl_force_rsdt variable

References: http://bugzilla.kernel.org/show_bug.cgi?id=8246

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>


---
 drivers/acpi/tables/tbutils.c     |    3 ++-
 drivers/acpi/utilities/utglobal.c |    1 +
 include/acpi/acglobal.h           |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -420,7 +420,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 	/* Differentiate between RSDT and XSDT root tables */
 
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
+	    && !acpi_gbl_force_rsdt) {
 		/*
 		 * Root table is an XSDT (64-bit physical addresses). We must use the
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -76,6 +76,7 @@ u8 acpi_gbl_method_executing = FALSE;
 /* System flags */
 
 u32 acpi_gbl_startup_flags = 0;
+int acpi_gbl_force_rsdt = 0;
 
 /* System starts uninitialized */
 
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -246,6 +246,7 @@ ACPI_EXTERN u8 acpi_gbl_system_awake_and
 
 extern u8 acpi_gbl_shutdown;
 extern u32 acpi_gbl_startup_flags;
+extern int acpi_gbl_force_rsdt;
 extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
 extern const char *acpi_gbl_highest_dstate_names[4];
 extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
