From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] actbl1.h: use tab instead of seven spaces as the indentation
Date: Tue, 22 Aug 2017 18:18:45 +0800
Message-ID: <20170822101845.18468-1-fanc.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44199 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932330AbdHVKSu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2017 06:18:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>

The indentation of these two lines is seven spaces, but not tab.
So fix it.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 include/acpi/actbl1.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b4ce55c008b0..d13e5b416a7e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1223,9 +1223,9 @@ struct acpi_srat_mem_affinity {
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
2.13.5



