From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] CPER: Add UEFI spec reference for CPER UUIDs
Date: Fri, 01 Sep 2017 18:50:29 -0500
Message-ID: <20170901235029.10575.53949.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752084AbdIAXuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Sep 2017 19:50:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Add a reference to the definition of CPER UUIDs.  The UEFI specs are
available at http://www.uefi.org/specifications .

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/cper.h |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4c671fc2081e..9c79075597dc 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -69,10 +69,11 @@ enum {
 
 /*
  * Notification type used to generate error record, used in
- * notification_type in struct cper_record_header
- *
- * Corrected Machine Check
+ * notification_type in struct cper_record_header.  These UUIDs are defined
+ * in the UEFI spec v2.7, sec N.2.1.
  */
+
+/* Corrected Machine Check */
 #define CPER_NOTIFY_CMC							\
 	UUID_LE(0x2DCE8BB1, 0xBDD7, 0x450e, 0xB9, 0xAD, 0x9C, 0xF4,	\
 		0xEB, 0xD4, 0xF8, 0x90)
@@ -165,10 +166,11 @@ enum {
 
 /*
  * Section type definitions, used in section_type field in struct
- * cper_section_descriptor
- *
- * Processor Generic
+ * cper_section_descriptor.  These UUIDs are defined in the UEFI spec
+ * v2.7, sec N.2.2.
  */
+
+/* Processor Generic */
 #define CPER_SEC_PROC_GENERIC						\
 	UUID_LE(0x9876CCAD, 0x47B4, 0x4bdb, 0xB6, 0x5E, 0x16, 0xF1,	\
 		0x93, 0xC4, 0xF3, 0xDB)

