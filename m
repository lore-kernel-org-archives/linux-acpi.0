From: Len Brown <len.brown@intel.com>
Subject: [PATCH 32/65] ACPICA: IsResourceTemplate now returns ACPI_STATUS
Date: Fri, 24 Nov 2006 02:18:42 -0500
Message-ID: <11643527943385-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757616AbWKXHP4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:56 -0500
In-Reply-To: <11643527931850-git-send-email-len.brown@intel.com>
Message-Id: <595830000ed536d250568af7fec2a54136a65f36.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

to differentiate the failure modes.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 722583a..b29d77a 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -140,7 +140,9 @@ extern const char *acpi_gbl_match_ops[];
 
 extern struct acpi_dmtable_info acpi_dm_table_info_asf0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf1[];
+extern struct acpi_dmtable_info acpi_dm_table_info_asf1a[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf2[];
+extern struct acpi_dmtable_info acpi_dm_table_info_asf2a[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf3[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf4[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf_hdr[];
@@ -322,7 +324,7 @@ acpi_dm_resource_template(struct acpi_op
 			  union acpi_parse_object *op,
 			  u8 * byte_data, u32 byte_count);
 
-u8 acpi_dm_is_resource_template(union acpi_parse_object *op);
+acpi_status acpi_dm_is_resource_template(union acpi_parse_object *op);
 
 void acpi_dm_indent(u32 level);
 
-- 
1.4.4.1
