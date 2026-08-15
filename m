Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BD30B53F;
	Sat, 15 Aug 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801419; cv=none; b=lNWb1/LnpLtBQ2mH8bPG2Ac3+g7nmrcJEN12qPuDK8+610k9ZYdcDMFGU1dT5rupoeoX/E4UfCLwtlomBURGRgopoQrxdX059hQhrjzk8o4GPNeTHr/8PKRSaNzltExJd6As+HwllOIIS88BXhD15aUGwwIU+8FOgt4bYsSqR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801419; c=relaxed/simple;
	bh=VccHjzo70kJs/g+yi3EenvdlombykYNLBtnsCvK+IPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVh5R6aQ+Tdqt50mNnyi/AipDTkYaJflvrMQd/zyS33Pt+SzxrXvojZ2EGtNsp/+vCS1O2cannnigEpxRcAOagVkRXOEU0a3qIxHxnEP8ycTxY4RxbT3r4y9HhreOo2Y5SbcTeKJrYm1SDWogmlaG7IDstX1bDn2o69ECEbSo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAC35kABbYBqpkTRBQ--.31847S2;
	Sat, 15 Aug 2026 21:43:30 +0800 (CST)
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
Subject: [PATCH v2 2/2] efi/cper: bound IA32/X64 processor record walks
Date: Sat, 15 Aug 2026 21:43:29 +0800
Message-ID: <20260815134329.46057-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC35kABbYBqpkTRBQ--.31847S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFykKrW5Zw1rGF1Utw4fXwb_yoW7WFWrpa
	1akF17Jw4DKw1rJwnayr4UZas8K395ZFWUK3srZw1xuwnxAa4kJFs8KrWI9343GryxXr1a
	qa1Dta98GFykAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

IA32/X64 processor CPER sections encode fixed error-info and variable
context record counts in validation_bits.  cper_print_proc_ia() receives
only a pointer, so a truncated section can make either loop dereference a
missing header or dump a register array beyond the section.

Pass the section length to the printer and track the unconsumed bytes after
the fixed processor header.  Require every fixed record, variable payload
and aligned context extent to fit before reading it.

Fixes: f9e1bdb9f35f ("efi: Decode IA32/X64 Processor Error Section")

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/firmware/efi/cper-x86.c | 51 +++++++++++++++++++++++++++++++++++++--
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 3949d7b5e808..fd0e84cf836f 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
 #include <linux/cper.h>
+#include <linux/limits.h>
 #include <linux/acpi.h>
 
 /*
@@ -254,14 +254,24 @@ static void print_err_info(const char *pfx, u8 err_type, u64 check)
 	}
 }
 
-void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
+void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc,
+			u32 length)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
 	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
+	size_t len;
 	u8 err_type;
 
+	if (length < sizeof(*proc)) {
+		printk("%ssection length is too small\n", pfx);
+		printk("%sfirmware-generated error record is incorrect\n", pfx);
+		return;
+	}
+
+	len = length - sizeof(*proc);
+
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
 
@@ -275,6 +285,12 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
 	err_info = (struct cper_ia_err_info *)(proc + 1);
 	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		if (len < sizeof(*err_info)) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
 		printk("%sError Information Structure %d:\n", pfx, i);
 
 		err_type = cper_get_err_type(&err_info->err_type);
@@ -321,13 +337,40 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		}
 
 		err_info++;
+		len -= sizeof(*err_info);
 	}
 
 	ctx_info = (struct cper_ia_proc_ctx *)err_info;
 	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
-		int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
+		size_t size;
 		int groupsize = 4;
 
+		if (len < sizeof(*ctx_info)) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
+		if (ctx_info->reg_arr_size > len - sizeof(*ctx_info)) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
+		size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
+		if (size > SIZE_MAX - 15) {
+			printk("%ssection length is too large\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
+		size = ALIGN(size, 16);
+		if (size > len) {
+			printk("%ssection length is too small\n", newpfx);
+			printk("%sfirmware-generated error record is incorrect\n", pfx);
+			return;
+		}
+
 		printk("%sContext Information Structure %d:\n", pfx, i);
 
 		printk("%sRegister Context Type: %s\n", newpfx,
@@ -356,6 +399,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 				       ctx_info->reg_arr_size, 0);
 		}
 
-		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
+		ctx_info = (struct cper_ia_proc_ctx *)((u8 *)ctx_info + size);
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
2.50.1 (Apple Git-155)

