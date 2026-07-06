Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833741F7C2;
	Mon,  6 Jul 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330909; cv=none; b=Nyian1hXz2/cUhK2OVkmHgNoWL5yqPpvGRcWGvFmx2To3oH6IpNzfO0opn+H4/Bqe/aTFpbwbR1KjgQaYJ9QZrXxtJUhqwZM3P7FRyZBkI8gJieAs76GSsr1xH0IDNApN9OXyGDOKxbc/6lxNPgmdhKBLaofT0HPfip+TB9TF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330909; c=relaxed/simple;
	bh=zDcwSarAM00bxYX7dtipkxZ0tPvZRttqJkR3MnGrZyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDlrF3X8bkEaWlAIZSUxO2v6o91b2tsaiO5iKyjSBHTmbMAlp6CgGhzLaL04M4nMMQwy1/ca/GtnPWblDAq9r1gBq3tirfUoOCKunNDVUSkb/Byf9ReS77gVARLRjuqEEq5dhCUX+yxfIYB/wSwybl2/VI/+bOvWo6P49SsIW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowADngcpWeEtqgr7xBA--.35296S2;
	Mon, 06 Jul 2026 17:41:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: FPDT: validate table and record lengths
Date: Mon,  6 Jul 2026 17:41:41 +0800
Message-ID: <20260706094141.82438-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADngcpWeEtqgr7xBA--.35296S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyDAr4fXFy5uFy3Ar4xWFg_yoWruFyxpF
	y8ta48tr45tF12yrs3trs0va45J3yxKa43WFZ8G3s0gr13WFy8ZF1rKFy29ayDGF18A3WF
	v3sFqFW5CFWxAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-
	B_UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

FPDT records are supplied by firmware and are walked through
length fields stored in the table itself.

Check the main-table entry length before reading an entry, check
the mapped subtable length before remapping it, and check each
record length before saving a typed record pointer for sysfs.

This keeps malformed firmware records from being interpreted as
complete resume, suspend, or boot records when the current item
is shorter than the structure consumed by the driver.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/acpi_fpdt.c | 53 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index e75dd28d31a9..79191ed20f76 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -168,7 +168,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 	struct fpdt_subtable_header *subtable_header;
 	struct fpdt_record_header *record_header;
 	char *signature = (subtable_type == SUBTABLE_FBPT ? "FBPT" : "S3PT");
-	u32 length, offset;
+	u32 length, offset, remaining;
 	int result;
 
 	if (!fpdt_address_valid(address)) {
@@ -182,10 +182,17 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 
 	if (strncmp((char *)&subtable_header->signature, signature, 4)) {
 		pr_info(FW_BUG "subtable signature and type mismatch!\n");
+		acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
 		return -EINVAL;
 	}
 
 	length = subtable_header->length;
+	if (length < sizeof(*subtable_header)) {
+		pr_err(FW_BUG "Invalid FPDT subtable length %u.\n", length);
+		acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
+		return -EINVAL;
+	}
+
 	acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
 
 	subtable_header = acpi_os_map_memory(address, length);
@@ -194,17 +201,29 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 
 	offset = sizeof(*subtable_header);
 	while (offset < length) {
-		record_header = (void *)subtable_header + offset;
-		offset += record_header->length;
+		remaining = length - offset;
+		if (remaining < sizeof(*record_header)) {
+			pr_err(FW_BUG "Truncated FPDT record header.\n");
+			result = -EINVAL;
+			goto err;
+		}
 
-		if (!record_header->length) {
-			pr_err(FW_BUG "Zero-length record found in FPTD.\n");
+		record_header = (void *)subtable_header + offset;
+		if (record_header->length < sizeof(*record_header) ||
+		    record_header->length > remaining) {
+			pr_err(FW_BUG "Invalid FPDT record length %u.\n",
+			       record_header->length);
 			result = -EINVAL;
 			goto err;
 		}
+		offset += record_header->length;
 
 		switch (record_header->type) {
 		case RECORD_S3_RESUME:
+			if (record_header->length < sizeof(*record_resume)) {
+				result = -EINVAL;
+				goto err;
+			}
 			if (subtable_type != SUBTABLE_S3PT) {
 				pr_err(FW_BUG "Invalid record %d for subtable %s\n",
 				     record_header->type, signature);
@@ -221,6 +240,10 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 				goto err;
 			break;
 		case RECORD_S3_SUSPEND:
+			if (record_header->length < sizeof(*record_suspend)) {
+				result = -EINVAL;
+				goto err;
+			}
 			if (subtable_type != SUBTABLE_S3PT) {
 				pr_err(FW_BUG "Invalid %d for subtable %s\n",
 				     record_header->type, signature);
@@ -236,6 +259,10 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 				goto err;
 			break;
 		case RECORD_BOOT:
+			if (record_header->length < sizeof(*record_boot)) {
+				result = -EINVAL;
+				goto err;
+			}
 			if (subtable_type != SUBTABLE_FBPT) {
 				pr_err(FW_BUG "Invalid %d for subtable %s\n",
 				     record_header->type, signature);
@@ -317,7 +344,21 @@ static int __init acpi_init_fpdt(void)
 	}
 
 	while (offset < header->length) {
+		if (header->length - offset < sizeof(*subtable)) {
+			pr_err(FW_BUG "Truncated FPDT subtable entry.\n");
+			result = -EINVAL;
+			goto err_subtable;
+		}
+
 		subtable = (void *)header + offset;
+		if (subtable->length < sizeof(*subtable) ||
+		    subtable->length > header->length - offset) {
+			pr_err(FW_BUG "Invalid FPDT subtable entry length %u.\n",
+			       subtable->length);
+			result = -EINVAL;
+			goto err_subtable;
+		}
+
 		switch (subtable->type) {
 		case SUBTABLE_FBPT:
 		case SUBTABLE_S3PT:
@@ -330,7 +371,7 @@ static int __init acpi_init_fpdt(void)
 			/* Other types are reserved in ACPI 6.4 spec. */
 			break;
 		}
-		offset += sizeof(*subtable);
+		offset += subtable->length;
 	}
 	return 0;
 err_subtable:
-- 
2.43.0

