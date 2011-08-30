From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPICA: Fix wrongly mapped acpi table header when overriding via initrd
Date: Tue, 30 Aug 2011 13:30:40 +0200
Message-ID: <201108301330.40955.trenn@suse.de>
References: <1314179290-31526-1-git-send-email-trenn@suse.de> <1314179290-31526-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42008 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab1H3Lan (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Aug 2011 07:30:43 -0400
In-Reply-To: <1314179290-31526-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: eric.piel@tremplin-utc.net, jnelson-suse@jamponi.net, devel@acpica.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, mchang@suse.com

From: Michael Chang <mchang@suse.com>

Fix the overriding ACPI table header do not override the existing ACPI
header thus the existing one is still in use. This caused a discrepency
of header and body, which would introdce a serios side effect that when
overriding DSDT, system might have error with "Unable to load the System
Description Tables" due to DSDT table verified failed.

Most field in ACPI table is static, but the length field is dyamically
changed and corresponds the new assembled *.aml size. We reserve the
ACPI data region using the overridden table size but attemps to map it
with existing ACPI table size introduced by above discrepency. It
would lead to remap fail during verifying DSDT able if length difference
cross a page boundary.

Signed-off-by: Michael Chang <mchang@suse.com>
---
 drivers/acpi/acpica/tbutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index df85afe..2e797d9 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -511,9 +511,9 @@ acpi_tb_install_table(acpi_physical_address address,
 				   ACPI_CAST_PTR(void, address)));
 			acpi_os_unmap_memory(mapped_table,
 					     sizeof(struct acpi_table_header));
+			address = tmp_addr;
 			mapped_table = acpi_os_map_memory(address,
 					  sizeof(struct acpi_table_header));
-			address = tmp_addr;
 		}
 		flags = ACPI_TABLE_ORIGIN_MAPPED;
 		table_to_install = mapped_table;
-- 
1.7.3.4

