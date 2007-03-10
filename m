From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/20] ACPI: fix Thinkpad 600/600E/600X interrupts
Date: Fri,  9 Mar 2007 22:49:29 -0500
Message-ID: <1173498587849-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965832AbXCJDts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:48 -0500
In-Reply-To: <11734985863491-git-send-email-len.brown@intel.com>
Message-Id: <74586fca38109d2fc75daf678635928f64b4ccec.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

The root cause of this bug shows that this machine
could not possibly run an ACPI-aware OS without a
model specific workaround.

http://bugzilla.kernel.org/show_bug.cgi?id=5966

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index e5eb97a..9ea5b8e 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -1072,7 +1072,28 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 			       "ASUS A7V ACPI BIOS Revision 1007"),
 		     },
 	 },
-
+	{
+		/*
+		 * Latest BIOS for IBM 600E (1.16) has bad pcinum
+		 * for LPC bridge, which is needed for the PCI
+		 * interrupt links to work. DSDT fix is in bug 5966.
+		 * 2645, 2646 model numbers are shared with 600/600E/600X
+		 */
+	 .callback = disable_acpi_irq,
+	 .ident = "IBM Thinkpad 600 Series 2645",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+		     DMI_MATCH(DMI_BOARD_NAME, "2645"),
+		     },
+	 },
+	{
+	 .callback = disable_acpi_irq,
+	 .ident = "IBM Thinkpad 600 Series 2646",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+		     DMI_MATCH(DMI_BOARD_NAME, "2646"),
+		     },
+	 },
 	/*
 	 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
 	 */
-- 
1.5.0.3.310.g05ef5
