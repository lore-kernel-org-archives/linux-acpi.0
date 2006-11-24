From: Len Brown <len.brown@intel.com>
Subject: [PATCH 23/65] ACPICA: Update version to 20060831
Date: Fri, 24 Nov 2006 02:18:33 -0500
Message-ID: <11643527853403-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5567 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934468AbWKXHPr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:47 -0500
In-Reply-To: <11643527843465-git-send-email-len.brown@intel.com>
Message-Id: <d09157670d9e199175b04cc5fc12fc6fb57a0ad2.1164352294.git.len.brown@intel.com>
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
 include/acpi/acconfig.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index ed181bc..82316e5 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -63,7 +63,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20060828
+#define ACPI_CA_VERSION                 0x20060831
 
 /*
  * OS name, used for the _OS object.  The _OS object is essentially obsolete,
@@ -158,8 +158,8 @@
 
 /* Sizes for ACPI table headers */
 
-#define ACPI_OEM_ID_SIZE        6
-#define ACPI_OEM_TABLE_ID_SIZE  8
+#define ACPI_OEM_ID_SIZE                6
+#define ACPI_OEM_TABLE_ID_SIZE          8
 
 /* Constants used in searching for the RSDP in low memory */
 
-- 
1.4.4.1
