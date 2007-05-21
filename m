From: Chris Wright <chrisw@sous-sol.org>
Subject: [patch 04/69] ACPI: Fix 2.6.21 boot regression on P4/HT
Date: Mon, 21 May 2007 12:16:16 -0700
Message-ID: <20070521191659.548011000@sous-sol.org>
References: <20070521191612.800400000@sous-sol.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46263 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764933AbXEUTVK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 15:21:10 -0400
Content-Disposition: inline; filename=acpi-fix-2.6.21-boot-regression-on-p4-ht.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

-stable review patch.  If anyone has any objections, please let us know.
---------------------

From: Len Brown <lenb@kernel.org>

Up through 2.6.20 we cleared the FADT.CSTATE_CONTROL field
for FADT versions before r3, because it made no sense
for that reserved field to be set for pre-ACPI 2.0 systems.

It turns out that not clearing this field exposes
Linux to SMM BIOS failures, so do the same in 2.6.21.

http://bugzilla.kernel.org/show_bug.cgi?id=8346

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/acpi/tables/tbfadt.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-2.6.21.1.orig/drivers/acpi/tables/tbfadt.c
+++ linux-2.6.21.1/drivers/acpi/tables/tbfadt.c
@@ -347,6 +347,20 @@ static void acpi_tb_convert_fadt(void)
 		acpi_gbl_xpm1b_enable.space_id = acpi_gbl_FADT.xpm1a_event_block.space_id;
 
 	}
+	/*
+	 * _CST object and C States change notification start with
+	 * ACPI 2.0 (FADT r3).  Although the field should be Reserved
+	 * and 0 before then, some pre-r3 FADT set this field and
+	 * it results in SMM-related boot failures.  For them, clear it.
+	 */
+	if ((acpi_gbl_FADT.header.revision < 3) &&
+		(acpi_gbl_FADT.cst_control != 0)) {
+			ACPI_WARNING((AE_INFO,
+				"Ignoring BIOS FADT r%u C-state control",
+				acpi_gbl_FADT.header.revision));
+		 	acpi_gbl_FADT.cst_control = 0;
+	}
+
 }
 
 /******************************************************************************

-- 
