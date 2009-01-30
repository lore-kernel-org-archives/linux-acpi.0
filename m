From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 1/2] ACPICA: Fix table entry truncation calculation
Date: Fri, 30 Jan 2009 15:44:53 -0700
Message-ID: <20090130224453.24329.32589.stgit@bob.kio>
References: <20090130223832.24329.5434.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:2268 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbZA3Woy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jan 2009 17:44:54 -0500
In-Reply-To: <20090130223832.24329.5434.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, myron.stowe@hp.comMyron Stowe <myron.stowe@hp.com>

During early boot, ACPI RSDT/XSDT table entries are gathered into the
'initial_tables[]' array.  This array is currently statically defined (see
./drivers/acpi/tables.c).  When there are more table entries than can be
held in the 'initial_tables[]' array, the message "Truncating N table
entries!" is output.  As currently implemented, this message will always
erroneously calculate N as 0.

This patch fixes the calculation that determines how many table entries
will be missing (truncated).


This modification may be used under either the GPL or the BSD-style
license used for Intel ACPI CA code.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/acpi/acpica/tbutils.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9684cc8..22ce489 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -538,10 +538,9 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 			if (ACPI_FAILURE(status)) {
 				ACPI_WARNING((AE_INFO,
 					      "Truncating %u table entries!",
-					      (unsigned)
-					      (acpi_gbl_root_table_list.size -
-					       acpi_gbl_root_table_list.
-					       count)));
+					      (unsigned) (table_count -
+					       (acpi_gbl_root_table_list.
+					       count - 2))));
 				break;
 			}
 		}

