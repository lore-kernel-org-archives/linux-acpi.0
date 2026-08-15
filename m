Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322B2AEF5;
	Sat, 15 Aug 2026 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801315; cv=none; b=bS5NIWbPTqp6FKbc+vUZ6p4wgwTSQoCf1hfiarS7qEQHSfn2CF/69XfqdmVF85+Muo6nIUpvXD415RlxqvW4FodncV+imH2yv28I9ee9GA13zJJcxE1vqXov0IJvX0kSCy1h+Csl5Ar6FpbbROJBlLzqQtRcfOvPhIEgXgx+ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801315; c=relaxed/simple;
	bh=Spb0yFbCsRs1KFeQlzLfscL2M91Gzn6RIxmeoa04nVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHfAqNKnxlFZz8va/MlyhpQhrLeXhEQsBa4EwGGs35hix1yNWwETV8sMB2olP6n4e5bsfm95kdFyAiTZKXXTdt7osGuooJIVhuT15RWI6f3778x+IlTPR2KkyTxU/RB4aJydNIyqgTV4vu+RdPBXTDx4OqCsy5RYk8ujSQRNulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAB3qEKZbIBq9TnRBQ--.19027S2;
	Sat, 15 Aug 2026 21:41:45 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rafael@kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] efi/cper: validate ARM context headers before reading their size
Date: Sat, 15 Aug 2026 21:41:45 +0800
Message-ID: <20260815134145.44465-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815133837.42466-1-pengpeng@iscas.ac.cn>
References: <20260815133837.42466-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3qEKZbIBq9TnRBQ--.19027S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UCw13KFW8Kw1rCr4rZrb_yoWrZw1fp3
	W3Kw17Jr4UKw1fGwn7ArWUZr9xK393AF4UJ3srAryxCwn3A3WkWFZ8KFWq9rnxGr18GrWa
	qF4DtFy5GFykAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ARM processor CPER sections contain a fixed header, a fixed-size
error-information array and variable-size context records.  The parser
derives the remaining byte count in int after subtracting
firmware-controlled unsigned values, then reads ctx_info->size before
proving that a complete context header remains.

Keep the remaining extent in size_t.  Validate the section header and
error-information count before advancing, then require each context
header, payload and 16-byte-aligned record to fit before it is read or
consumed.

Fixes: c6d8c8ef1d0d ("efi: Move ARM CPER code to new file")

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/firmware/efi/cper-arm.c | 53 ++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index b21cb1232d82..e2f973d7a4a4 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -229,26 +229,39 @@ void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc,
 			 u32 length)
 {
-	int i, len, max_ctx_type;
+	int i, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
 	char error_type[120];
+	size_t len;
 
-	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
+	if (length < sizeof(*proc)) {
+		printk("%ssection length is too small\n", pfx);
+		printk("%sfirmware-generated error record is incorrect\n", pfx);
+		return;
+	}
 
-	len = proc->section_length - (sizeof(*proc) +
-		proc->err_info_num * (sizeof(*err_info)));
+	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
-	if (len < 0 || proc->section_length > length) {
-		printk("%ssection length: %d, CPER size: %d\n",
+	if (proc->section_length < sizeof(*proc) ||
+	    proc->section_length > length) {
+		printk("%ssection length: %u, CPER size: %u\n",
 		       pfx, proc->section_length, length);
 		printk("%ssection length is too %s\n", pfx,
-		       (len < 0) ? "small" : "big");
+		       proc->section_length < sizeof(*proc) ? "small" : "big");
+		printk("%sfirmware-generated error record is incorrect\n", pfx);
+		return;
+	}
+
+	len = proc->section_length - sizeof(*proc);
+	if (proc->err_info_num > len / sizeof(*err_info)) {
+		printk("%ssection length is too small\n", pfx);
 		printk("%sfirmware-generated error record is incorrect\n", pfx);
 		printk("%sERR_INFO_NUM is %d\n", pfx, proc->err_info_num);
 		return;
 	}
+	len -= proc->err_info_num * sizeof(*err_info);
 
 	if (proc->validation_bits & CPER_ARM_VALID_MPIDR)
 		printk("%sMultiprocessor Affinity Register (MPIDR): 0x%016llx\n",
@@ -313,10 +326,28 @@ void cper_print_proc_arm(const char *pfx,
 	ctx_info = (struct cper_arm_ctx_info *)err_info;
 	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
 	for (i = 0; i < proc->context_info_num; i++) {
-		int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
+		size_t size;
 
 		printk("%sContext info structure %d:\n", pfx, i);
-		if (len < size) {
+		if (len < sizeof(*ctx_info)) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+		if (ctx_info->size > len - sizeof(*ctx_info)) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
+		size = sizeof(*ctx_info) + ctx_info->size;
+		if (size > SIZE_MAX - 15) {
+			printk("%scontext record size is too big\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+		size = ALIGN(size, 16);
+		if (size > len) {
 			printk("%ssection length is too small\n", newpfx);
 			printk("%sfirmware-generated error record is incorrect\n", pfx);
 			return;
@@ -331,11 +362,11 @@ void cper_print_proc_arm(const char *pfx,
 		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4,
 				(ctx_info + 1), ctx_info->size, 0);
 		len -= size;
-		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + size);
+		ctx_info = (struct cper_arm_ctx_info *)((u8 *)ctx_info + size);
 	}
 
 	if (len > 0) {
-		printk("%sVendor specific error info has %u bytes:\n", pfx,
+		printk("%sVendor specific error info has %zu bytes:\n", pfx,
 		       len);
 		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4, ctx_info,
 				len, true);
-- 
2.50.1 (Apple Git-155)

