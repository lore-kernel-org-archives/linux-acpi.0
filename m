Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659A37998A;
	Mon,  6 Jul 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330333; cv=none; b=XjNc8Pa2I03NAiiEe94roZO0tdQMY5blwXsT12Ri1QkuGERFNV86QSccB2AfB/3FTPTEkwr/CEwC2ThpQEUc8c55SfIzbIab0MqjHozYrk12CimgYoNA22jEFGEc0YwBxirp6DSY2Fc3j1J44Yc19BMuD/sjh5/ILpOkUsCMvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330333; c=relaxed/simple;
	bh=+L4ORZ4Zpp8HV0T4gb1K9aNQOb6ke3VqBkqmVRRpUcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIVIJBMNr5oHblVbAmB4Tm0xgyUoY1gHtVndwOeFMOdPGpYqTmzyeODdZ2Q1tBWex7NAaDkUb6L1+BzTsZ5zX12e8I75ysjy6uUBIGqGR+PM627WTWElUkT8QLP0vcqOK3klOPbbNW65GgGHGu5qgRO7c/tbIUmyV/FSCMR/vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAHqtIPdktqJ37xBA--.35586S2;
	Mon, 06 Jul 2026 17:32:00 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: [PATCH] efi: cper: validate processor section item bounds
Date: Mon,  6 Jul 2026 17:31:58 +0800
Message-ID: <20260706093158.80364-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHqtIPdktqJ37xBA--.35586S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4UXryUKr4fuF1kuw1DGFg_yoWxJry7pa
	13Kr1UJw48Kw1rJwn3ArWjva43K395XFWUK3srua4fCwnxAa4kGFZ8KFW09r13Gry8Xrya
	qa9rtayDGFykAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

CPER processor error sections contain counted arrays after the fixed
section header. The ARM path receives the section length, but it read
each context header size before proving that a full context header
remains. The IA32/X64 path received only the payload pointer, so it
could not bound its error information and context walks against the
section payload.

Pass the IA32/X64 payload length into the printer and track the
remaining bytes while walking variable records. Also make the ARM path
prove that a context header remains before reading its variable size
field.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/firmware/efi/cper-arm.c | 10 ++++++++--
 drivers/firmware/efi/cper-x86.c | 32 ++++++++++++++++++++++++++++++--
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index b21cb1232d82..75a32f3a31a0 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -313,10 +313,16 @@ void cper_print_proc_arm(const char *pfx,
 	ctx_info = (struct cper_arm_ctx_info *)err_info;
 	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
 	for (i = 0; i < proc->context_info_num; i++) {
-		int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
+		int size;
 
 		printk("%sContext info structure %d:\n", pfx, i);
-		if (len < size) {
+		if (len < sizeof(*ctx_info)) {
+			pr_warn("%ssection length is too small\n", newpfx);
+			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+		size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
+		if (size > len) {
 			printk("%ssection length is too small\n", newpfx);
 			printk("%sfirmware-generated error record is incorrect\n", pfx);
 			return;
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 3949d7b5e808..77621a5677da 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -3,6 +3,7 @@
 
 #include <linux/cper.h>
 #include <linux/acpi.h>
+#include <linux/printk.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -254,17 +255,26 @@ static void print_err_info(const char *pfx, u8 err_type, u64 check)
 	}
 }
 
-void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
+void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc,
+			u32 length)
 {
 	int i;
+	u32 len;
 	struct cper_ia_err_info *err_info;
 	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
 	u8 err_type;
 
+	if (length < sizeof(*proc)) {
+		pr_warn("%ssection length is too small\n", pfx);
+		pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
+		return;
+	}
+
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
 
+	len = length - sizeof(*proc);
 	if (proc->validation_bits & VALID_CPUID_INFO) {
 		printk("%sCPUID Info:\n", pfx);
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
@@ -276,6 +286,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 	err_info = (struct cper_ia_err_info *)(proc + 1);
 	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
 		printk("%sError Information Structure %d:\n", pfx, i);
+		if (len < sizeof(*err_info)) {
+			pr_warn("%ssection length is too small\n", newpfx);
+			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
 
 		err_type = cper_get_err_type(&err_info->err_type);
 		printk("%sError Structure Type: %s\n", newpfx,
@@ -321,14 +336,26 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		}
 
 		err_info++;
+		len -= sizeof(*err_info);
 	}
 
 	ctx_info = (struct cper_ia_proc_ctx *)err_info;
 	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
-		int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
+		int size;
 		int groupsize = 4;
 
 		printk("%sContext Information Structure %d:\n", pfx, i);
+		if (len < sizeof(*ctx_info)) {
+			pr_warn("%ssection length is too small\n", newpfx);
+			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+		size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
+		if (size > len) {
+			pr_warn("%ssection length is too small\n", newpfx);
+			pr_warn("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
 
 		printk("%sRegister Context Type: %s\n", newpfx,
 		       ctx_info->reg_ctx_type < ARRAY_SIZE(ia_reg_ctx_strs) ?
@@ -357,5 +384,6 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
+		len -= size;
 	}
 }
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..87e65377a15d 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -675,7 +675,8 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 
 		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*ia_err))
-			cper_print_proc_ia(newpfx, ia_err);
+			cper_print_proc_ia(newpfx, ia_err,
+					   gdata->error_data_length);
 		else
 			goto err_section_too_small;
 #endif
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e5..a2fa9376f6c0 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -598,7 +598,8 @@ void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc,
 			 u32 length);
 void cper_print_proc_ia(const char *pfx,
-			const struct cper_sec_proc_ia *proc);
+			const struct cper_sec_proc_ia *proc,
+			u32 length);
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
 
-- 
2.43.0

