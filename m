From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] ACPICA: Clean up whitespace of indentation
Date: Sat, 28 Oct 2017 09:34:21 +0800
Message-ID: <1509154461-23909-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdJ1Be2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Oct 2017 21:34:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, Baoquan He <bhe@redhat.com>

Use tabs (not spaces) for indentation.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/acpi/actbl1.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 6b8714a428b6..d8a4fc066abe 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1438,9 +1438,9 @@ struct acpi_srat_mem_affinity {
 	u16 reserved;		/* Reserved, must be zero */
 	u64 base_address;
 	u64 length;
-       u32 reserved1;
+	u32 reserved1;
 	u32 flags;
-       u64 reserved2;	       /* Reserved, must be zero */
+	u64 reserved2;	       /* Reserved, must be zero */
 };
 
 /* Flags */
-- 
2.5.5

