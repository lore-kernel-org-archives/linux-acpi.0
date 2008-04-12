From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/73] ACPICA: Increase maximum buffer size dumped to screen in buffer object dump
Date: Sat, 12 Apr 2008 00:24:54 -0400
Message-ID: <8a4deb6a52dbd1f65826465ccc735a9b9a6f67a6.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752703AbYDLE2A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:00 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exstore.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 97cb188..f88b181 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -147,7 +147,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 				      (u32) source_desc->buffer.length));
 		ACPI_DUMP_BUFFER(source_desc->buffer.pointer,
 				 (source_desc->buffer.length <
-				  32) ? source_desc->buffer.length : 32);
+				  256) ? source_desc->buffer.length : 256);
 		break;
 
 	case ACPI_TYPE_STRING:
-- 
1.5.5.29.g7134

