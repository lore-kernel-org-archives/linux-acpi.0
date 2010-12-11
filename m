From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/15] ACPI, APEI, use raw spinlock in ERST
Date: Sat, 11 Dec 2010 02:06:35 -0500
Message-ID: <3b38bb5f7f06356a89bb2cbf92ad346025e95192.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33724 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab0LKHwu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:52:50 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900699780NVJ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:52:50 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

ERST writing may be used in NMI or Machine Check Exception handler. So
it need to use raw spinlock instead of normal spinlock.  This patch
fixes it.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/erst.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 1211c03..5850d32 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -86,7 +86,7 @@ static struct erst_erange {
  * It is used to provide exclusive accessing for ERST Error Log
  * Address Range too.
  */
-static DEFINE_SPINLOCK(erst_lock);
+static DEFINE_RAW_SPINLOCK(erst_lock);
 
 static inline int erst_errno(int command_status)
 {
@@ -421,9 +421,9 @@ ssize_t erst_get_record_count(void)
 	if (erst_disable)
 		return -ENODEV;
 
-	spin_lock_irqsave(&erst_lock, flags);
+	raw_spin_lock_irqsave(&erst_lock, flags);
 	count = __erst_get_record_count();
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 
 	return count;
 }
@@ -456,9 +456,9 @@ int erst_get_next_record_id(u64 *record_id)
 	if (erst_disable)
 		return -ENODEV;
 
-	spin_lock_irqsave(&erst_lock, flags);
+	raw_spin_lock_irqsave(&erst_lock, flags);
 	rc = __erst_get_next_record_id(record_id);
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 
 	return rc;
 }
@@ -624,17 +624,17 @@ int erst_write(const struct cper_record_header *record)
 		return -EINVAL;
 
 	if (erst_erange.attr & ERST_RANGE_NVRAM) {
-		if (!spin_trylock_irqsave(&erst_lock, flags))
+		if (!raw_spin_trylock_irqsave(&erst_lock, flags))
 			return -EBUSY;
 		rc = __erst_write_to_nvram(record);
-		spin_unlock_irqrestore(&erst_lock, flags);
+		raw_spin_unlock_irqrestore(&erst_lock, flags);
 		return rc;
 	}
 
 	if (record->record_length > erst_erange.size)
 		return -EINVAL;
 
-	if (!spin_trylock_irqsave(&erst_lock, flags))
+	if (!raw_spin_trylock_irqsave(&erst_lock, flags))
 		return -EBUSY;
 	memcpy(erst_erange.vaddr, record, record->record_length);
 	rcd_erange = erst_erange.vaddr;
@@ -642,7 +642,7 @@ int erst_write(const struct cper_record_header *record)
 	memcpy(&rcd_erange->persistence_information, "ER", 2);
 
 	rc = __erst_write_to_storage(0);
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 
 	return rc;
 }
@@ -696,9 +696,9 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 	if (erst_disable)
 		return -ENODEV;
 
-	spin_lock_irqsave(&erst_lock, flags);
+	raw_spin_lock_irqsave(&erst_lock, flags);
 	len = __erst_read(record_id, record, buflen);
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 	return len;
 }
 EXPORT_SYMBOL_GPL(erst_read);
@@ -719,20 +719,20 @@ ssize_t erst_read_next(struct cper_record_header *record, size_t buflen)
 	if (erst_disable)
 		return -ENODEV;
 
-	spin_lock_irqsave(&erst_lock, flags);
+	raw_spin_lock_irqsave(&erst_lock, flags);
 	rc = __erst_get_next_record_id(&record_id);
 	if (rc) {
-		spin_unlock_irqrestore(&erst_lock, flags);
+		raw_spin_unlock_irqrestore(&erst_lock, flags);
 		return rc;
 	}
 	/* no more record */
 	if (record_id == APEI_ERST_INVALID_RECORD_ID) {
-		spin_unlock_irqrestore(&erst_lock, flags);
+		raw_spin_unlock_irqrestore(&erst_lock, flags);
 		return 0;
 	}
 
 	len = __erst_read(record_id, record, buflen);
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 
 	return len;
 }
@@ -746,12 +746,12 @@ int erst_clear(u64 record_id)
 	if (erst_disable)
 		return -ENODEV;
 
-	spin_lock_irqsave(&erst_lock, flags);
+	raw_spin_lock_irqsave(&erst_lock, flags);
 	if (erst_erange.attr & ERST_RANGE_NVRAM)
 		rc = __erst_clear_from_nvram(record_id);
 	else
 		rc = __erst_clear_from_storage(record_id);
-	spin_unlock_irqrestore(&erst_lock, flags);
+	raw_spin_unlock_irqrestore(&erst_lock, flags);
 
 	return rc;
 }
-- 
1.7.3.3.480.g2f76a

