From: Len Brown <len.brown@intel.com>
Subject: [PATCH 40/65] ACPICA: Add full table name to disassembler output
Date: Fri, 24 Nov 2006 02:18:50 -0500
Message-ID: <11643528013509-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934485AbWKXHQF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:05 -0500
In-Reply-To: <11643528001078-git-send-email-len.brown@intel.com>
Message-Id: <f2eec4942e2547d5dc3c45e0c6811ab941b4708b.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index b29d77a..ea35f1f 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -101,6 +101,7 @@ typedef const struct acpi_dmtable_info {
 #define ACPI_DMT_MADT                   24
 #define ACPI_DMT_SRAT                   25
 #define ACPI_DMT_EXIT                   26
+#define ACPI_DMT_SIG                    27
 
 typedef
 void (*ACPI_TABLE_HANDLER) (struct acpi_table_header * table);
@@ -109,6 +110,7 @@ struct acpi_dmtable_data {
 	char *signature;
 	struct acpi_dmtable_info *table_info;
 	ACPI_TABLE_HANDLER table_handler;
+	char *name;
 };
 
 struct acpi_op_walk_info {
-- 
1.4.4.1
