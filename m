From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] ACPICA: remove duplicate u8 typedef
Date: Tue, 28 Apr 2015 16:54:04 +0200
Message-ID: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:20979 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbbD1OyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 10:54:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Olaf Hering <olaf@aepfle.de>

During commit e252652fb2664d42de19f933aa3688bbc470de3f ("ACPICA:
acpidump: Remove integer types translation protection.") two 'unsigned
char' types got converted to 'u8'.

The result does not compile with gcc-4.5, it can not cope with duplicate
typedefs.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 include/acpi/actypes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f5ca0e9..1c3002e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -124,7 +124,6 @@
 #ifndef ACPI_USE_SYSTEM_INTTYPES
 
 typedef unsigned char u8;
-typedef unsigned char u8;
 typedef unsigned short u16;
 typedef short s16;
 typedef COMPILER_DEPENDENT_UINT64 u64;
