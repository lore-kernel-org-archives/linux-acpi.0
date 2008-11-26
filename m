From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 8/8] acpi: move acpi_gbl_permanent_mmap to acpixf.h
Date: Wed, 26 Nov 2008 10:56:45 +0800
Message-ID: <1227668205.7702.101.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50622 "EHLO mga02.intel.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752362AbYKZDCT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 22:02:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

acglobal.h now is acpica internal use only.
Move acpi_gbl_permanent_mmap to acpixf.h for external use.

=EF=BB=BFSigned-off-by: Lin Ming <ming.m.lin@intel.com>
---
include/acpi/acglobal.h |    1 -
include/acpi/acpixf.h   |    2 ++
2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index fddd865..78f3c14 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -141,7 +141,6 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
-extern u8 acpi_gbl_permanent_mmap;

/* These addresses are calculated from FADT address values */

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ee5cbbb..8a60343 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -58,6 +58,8 @@
extern u32 acpi_current_gpe_count;
extern struct acpi_table_fadt acpi_gbl_FADT;

+extern u8 acpi_gbl_permanent_mmap;
+
/* Run-time configuration */

extern u32 acpi_dbg_level;


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
