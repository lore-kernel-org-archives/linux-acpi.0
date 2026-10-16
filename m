Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB48385503;
	Fri, 16 Oct 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161747; cv=none; b=j+Tiz3mqmQGHD1Z6Ku/nhWaTckGtTsf0Z+9zwc0obJWxgds2u16gk3Mvd8stOBPIp+xKWLe4d3ci5ttY3LXWFXsxZ6nQfNETGW9XZLWO2488Onos8tVwEsyL6YxpCwGvzeZGYgpGM0NPvNIzB+hfzgwgpon6XMvSMNwtCvpQdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161747; c=relaxed/simple;
	bh=tlIYM5uJGY7nQekQ3EYN/zYQy/+2JzukYCdxBCOPJsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIr7FlSy7pBi1DMM3YXB7V3Y83ke54pIZcdpE8SJh9vdU6UrwBBEp7tHO55whjQ7ja9zhzojFtaymB8uiMSZ7dguTu8MfBAJ/LkVzZtQXYO+SP+itv7BkMsTyG66tyKaDEIlIUMJmLhjFUmTrOSUQGR9pIZHAk8YXSwmkemhrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bMNfZHfd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bMNfZHfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sn
	JtUXom9jVegv+bY+lEkwOmMVys6GneunonYhdmkBE=; b=bMNfZHfdJ9exMmzItt
	pFrQdu7JVM8rfx4doQztkYJ7xzHvCzvs/0J6DekPXLyO0ovVWqGqyJiKFXF8dXXN
	xsVEeNL/MCyzkVlub7rcIBnD9Opo/czwmxmj6TQNgUM4R8zUvQdRNofsKGSDbkmA
	UQFfSBDFIoBaS83MdMBUjbhLA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P2m4N9JqigIWAg--.64930S2;
	Fri, 16 Oct 2026 22:42:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] lib/firmware_table: validate subtable bounds
Date: Fri, 16 Oct 2026 22:41:54 +0800
Message-Id: <20261016144154.2818962-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P2m4N9JqigIWAg--.64930S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1Dur1UGF4kuFykWF43trb_yoW8ur48pF
	1Sgas8tr4FqFy2qr97X3WrtF1YvrWkW3ZFyFy7Gr18twnrZF1rXFy3G342qrZ3ZrW7Wa15
	WayYqry8CrWkZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU0fOrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRlLhWrSN7kzlQAA3K

The generic firmware table walker dispatches matching entries after only
checking that a generic subtable header is present. A record whose
declared length is shorter than its header or extends past the table can
therefore reach a handler before its bounds have been established.

Validate the complete generic header and the declared record range
before looking up or invoking a handler. This also rejects zero-length
records and prevents malformed lengths from advancing the cursor outside
the table.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 lib/fw_table.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/fw_table.c b/lib/fw_table.c
index 16291814450e..84c2515edde7 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -172,7 +172,20 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	    ((unsigned long)table_header + table_size);
 	subtable_len = acpi_get_subtable_header_length(&entry);
 
-	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
+	while ((unsigned long)entry.hdr < table_end) {
+		if (table_end - (unsigned long)entry.hdr < subtable_len) {
+			pr_err("[%4.4s] Invalid subtable header\n", id);
+			return -EINVAL;
+		}
+
+		entry_len = acpi_get_entry_length(&entry);
+		if (entry_len < subtable_len ||
+		    entry_len > table_end - (unsigned long)entry.hdr) {
+			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
+			       acpi_get_entry_type(&entry), entry_len);
+			return -EINVAL;
+		}
+
 		for (i = 0; i < proc_num; i++) {
 			if (acpi_get_entry_type(&entry) != proc[i].id)
 				continue;
@@ -186,16 +199,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			break;
 		}
 
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		entry_len = acpi_get_entry_length(&entry);
-		if (entry_len == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
-			return -EINVAL;
-		}
-
 		entry.hdr = (union acpi_subtable_headers *)
 		    ((unsigned long)entry.hdr + entry_len);
 	}
-- 
2.34.1

