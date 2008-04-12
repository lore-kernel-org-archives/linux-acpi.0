From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/73] ACPICA: Fix for Increment/Decrement operator, incorrect type change
Date: Sat, 12 Apr 2008 00:25:13 -0400
Message-ID: <bc85205e6125097848e5c5490ddeae824516e168.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753138AbYDLE2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:08 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the Increment and Decrement operators where
the type of the target object could be unexpectedly and incorrectly
changed. (BZ 353) Lin Ming.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acopcode.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acopcode.h b/include/acpi/acopcode.h
index e6f76a2..ab54349 100644
--- a/include/acpi/acopcode.h
+++ b/include/acpi/acopcode.h
@@ -233,7 +233,7 @@
 #define ARGI_CREATE_WORD_FIELD_OP       ARGI_LIST3 (ARGI_BUFFER,     ARGI_INTEGER,       ARGI_REFERENCE)
 #define ARGI_DATA_REGION_OP             ARGI_LIST3 (ARGI_STRING,     ARGI_STRING,        ARGI_STRING)
 #define ARGI_DEBUG_OP                   ARG_NONE
-#define ARGI_DECREMENT_OP               ARGI_LIST1 (ARGI_INTEGER_REF)
+#define ARGI_DECREMENT_OP               ARGI_LIST1 (ARGI_TARGETREF)
 #define ARGI_DEREF_OF_OP                ARGI_LIST1 (ARGI_REF_OR_STRING)
 #define ARGI_DEVICE_OP                  ARGI_INVALID_OPCODE
 #define ARGI_DIVIDE_OP                  ARGI_LIST4 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF,    ARGI_TARGETREF)
@@ -246,7 +246,7 @@
 #define ARGI_FIND_SET_RIGHT_BIT_OP      ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
 #define ARGI_FROM_BCD_OP                ARGI_LIST2 (ARGI_INTEGER,    ARGI_FIXED_TARGET)
 #define ARGI_IF_OP                      ARGI_INVALID_OPCODE
-#define ARGI_INCREMENT_OP               ARGI_LIST1 (ARGI_INTEGER_REF)
+#define ARGI_INCREMENT_OP               ARGI_LIST1 (ARGI_TARGETREF)
 #define ARGI_INDEX_FIELD_OP             ARGI_INVALID_OPCODE
 #define ARGI_INDEX_OP                   ARGI_LIST3 (ARGI_COMPLEXOBJ, ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_LAND_OP                    ARGI_LIST2 (ARGI_INTEGER,    ARGI_INTEGER)
-- 
1.5.5.29.g7134

