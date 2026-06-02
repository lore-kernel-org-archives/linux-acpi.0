Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0513AD52B;
	Tue,  2 Jun 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384588; cv=none; b=R9+loJ33BECbzj0hA+wane6fOZOjkRF9sfp4dFJUMQxzkprtmXEGpe5DkkFDgnKsMbvLuHpuDdLEsgIMXQMNBu7uixGYVmQb7+Ozhiu6e7KRdLKZ1z0+A1Vc5xhHneOOkHx8mEc+r/TFX1It/uVx49RXatYnNH6sxmwB53e3Su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384588; c=relaxed/simple;
	bh=CGngURJ8uhwlmCur94zG6M+OhpqHYIyJHxZWQrOAxFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jI+vW6vlg5M5uiROgqgUdc4bgV1NtxHLgHVzBcM8wfVvMzv4I2YPBcqodGbrezmwHd0w9QSRSag5sycGITv6eYes8RA7Gk7DaDzu88aiNmR2zNXFir9BfRFGcKXA3V9/Iskfkk9tBAH9TnRO3n1IFQN0o68deTW2JszjAvtOnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pz5w3hVB; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pz5w3hVB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384574; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mzmNojoq2hu2ZwgjtjdxdvvwEj7R5BiH7fs14gYyDQo=;
	b=pz5w3hVBtmkAI1acYXYyUysZSELWVvp57uYqJ9b3IHNf7aYfnGPjusHpdgpcrJTk+trK3FB9PyyarZug2jWXWn7+HercLDGc3KM1yP45o+e1aJLgASSI+Pw0mtaY3KMfnHhmW7kEF3qRTK+d4jm+x8lEemmpddebQM81sEkabYE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2gL_1780384573;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2gL_1780384573 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:14 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 13/16] arm64: ras: Introduce ras inject interface
Date: Tue,  2 Jun 2026 15:15:36 +0800
Message-ID: <20260602071540.3711528-14-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

End-to-end validation of the RAS driver requires the ability to
generate errors on demand. Driver gives two complementary paths,
which the inject interface deliberately keeps separate:

  - Soft injection writes directly into the record's status registers
    and is unconstrained by the spec. It is the tool of choice for
    state-machine coverage: notifier delivery, ABI shape.

  - Hard injection drives the architected inject registers and obeys
    the hardware contract, exercising the real interrupt and decode
    paths.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-arm64-ras |  39 +++++-
 drivers/ras/arm64/Makefile                  |   1 +
 drivers/ras/arm64/ras-core.c                |  26 ++--
 drivers/ras/arm64/ras-inject.c              | 127 ++++++++++++++++++++
 drivers/ras/arm64/ras-sysfs.c               |   1 +
 drivers/ras/arm64/ras.h                     |   2 +
 6 files changed, 183 insertions(+), 13 deletions(-)
 create mode 100644 drivers/ras/arm64/ras-inject.c

diff --git a/Documentation/ABI/testing/debugfs-arm64-ras b/Documentation/ABI/testing/debugfs-arm64-ras
index d86bde83d0b9..a14f481c0c04 100644
--- a/Documentation/ABI/testing/debugfs-arm64-ras
+++ b/Documentation/ABI/testing/debugfs-arm64-ras
@@ -47,4 +47,41 @@ KernelVersion:	6.19
 Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RW) Read and write the CE threshold to this record.
-		Returns error if input exceeded the maximum threshold.
\ No newline at end of file
+		Returns error if input exceeded the maximum threshold.
+
+What:		/sys/kernel/debug/ras/arm64/<node_name>/record<index>/inject/err_*
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RW) These registers are used to simulate soft injection errors
+		by holding error register values. You can write any values
+		to them. To trigger the injection, you need to write soft_inject
+		at last. The validity of the injected error depends on the
+		value written to err_status.
+
+		Accepts values -  any.
+
+What:		/sys/kernel/debug/ras/arm64/<node_name>/record<index>/inject/soft_inject
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) Write any value to this file to trigger the error
+		injection. Make sure you have specified all necessary error
+		parameters, i.e. this write should be the last step when
+		injecting errors.
+
+		Accepts values -  any.
+
+What:		/sys/kernel/debug/ras/arm64/<node_name>/record<index>/inject/hard_inject
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) If the AEST table provides error injection registers,
+		you can write to them via this interface. For instance,
+		values can be written to the ERXPFGCTL register. The post-injection
+		behavior is then determined by the hardware specification.
+
+		Accepts values - any.
\ No newline at end of file
diff --git a/drivers/ras/arm64/Makefile b/drivers/ras/arm64/Makefile
index e13e223107dd..2f3119ac3ec5 100644
--- a/drivers/ras/arm64/Makefile
+++ b/drivers/ras/arm64/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ARM64_RAS_DRIVER) 	+= arm64_ras.o
 
 arm64_ras-y		:= ras-core.o
 arm64_ras-y		+= ras-sysfs.o
+arm64_ras-y		+= ras-inject.o
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index c427c131a862..8cde26ab95de 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -200,7 +200,7 @@ static void ras_panic(struct ras_record *record, struct ras_ext_regs *regs,
 	panic(msg);
 }
 
-static void ras_proc_record(struct ras_record *record, void *data)
+void ras_proc_record(struct ras_record *record, void *data, bool fake)
 {
 	struct ras_ext_regs regs = { 0 };
 	int *count = data;
@@ -240,13 +240,15 @@ static void ras_proc_record(struct ras_record *record, void *data)
 	ue = FIELD_GET(ERR_STATUS_UET, regs.err_status);
 	if ((regs.err_status & ERR_STATUS_UE) &&
 	    (ue == ERR_STATUS_UET_UC || ue == ERR_STATUS_UET_UEU)) {
-		if (!panic_on_ue)
-			ras_record_err(record, "UE detected, panic suppressed\n");
-		else
+		if (fake)
+			ras_record_info(record,
+					"Simulated error! Skip panic due to fault injection\n");
+		else if (panic_on_ue)
 			ras_panic(record, &regs,
-				  "AEST: unrecoverable error encountered");
+				   "AEST: unrecoverable error encountered");
+		else
+			ras_record_err(record, "UE detected, panic suppressed\n");
 	}
-
 	ras_do_proc(record, &regs);
 
 	/* Write-one-to-clear the bits we've seen */
@@ -263,7 +265,7 @@ static void ras_proc_record(struct ras_record *record, void *data)
 	record_write(record, ERXSTATUS, regs.err_status);
 }
 
-static void ras_node_foreach_record(void (*func)(struct ras_record *, void *),
+static void ras_node_foreach_record(void (*func)(struct ras_record *, void *, bool),
 				    struct ras_node *node, void *data,
 				    unsigned long *bitmap)
 {
@@ -272,13 +274,13 @@ static void ras_node_foreach_record(void (*func)(struct ras_record *, void *),
 	for_each_clear_bit(i, bitmap, node->record_count) {
 		ras_select_record(node, i);
 
-		func(&node->records[i], data);
+		func(&node->records[i], data, false);
 
 		ras_sync(node);
 	}
 }
 
-static void ras_node_foreach_poll_record(void (*func)(struct ras_record *, void *),
+static void ras_node_foreach_poll_record(void (*func)(struct ras_record *, void *, bool),
 					 struct ras_node *node, void *data)
 {
 	int i;
@@ -300,7 +302,7 @@ static void ras_node_foreach_poll_record(void (*func)(struct ras_record *, void
 
 		ras_select_record(node, i);
 
-		func(&node->records[i], data);
+		func(&node->records[i], data, false);
 
 		ras_sync(node);
 	}
@@ -329,7 +331,7 @@ static int ras_proc(struct ras_node *node)
 			 */
 			if (test_bit(i * BITS_PER_LONG + j, node->status_reporting))
 				continue;
-			ras_proc_record(&node->records[j], &count);
+			ras_proc_record(&node->records[j], &count, false);
 		}
 	}
 
@@ -521,7 +523,7 @@ static int ras_init_record(struct ras_record *record, int i, struct ras_node *no
 	return 0;
 }
 
-static void ras_online_record(struct ras_record *record, void *data)
+static void ras_online_record(struct ras_record *record, void *data, bool __unused)
 {
 	ras_set_ce_threshold(record);
 	ras_enable_irq(record);
diff --git a/drivers/ras/arm64/ras-inject.c b/drivers/ras/arm64/ras-inject.c
new file mode 100644
index 000000000000..7fb522a845e7
--- /dev/null
+++ b/drivers/ras/arm64/ras-inject.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2024, Alibaba Group.
+ */
+
+#include "ras.h"
+
+static struct ras_ext_regs regs_inj;
+
+struct inj_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct ras_node *n, struct inj_attr *a, char *b);
+	ssize_t (*store)(struct ras_node *n, struct inj_attr *a, const char *b,
+				size_t c);
+};
+
+struct ras_inject {
+	struct ras_node *node;
+	struct kobject kobj;
+};
+
+#define to_inj(k)	container_of(k, struct ras_inject, kobj)
+#define to_inj_attr(a)	container_of(a, struct inj_attr, attr)
+
+static u64 ras_sysreg_read_inject(void *__unused, u32 offset)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	return p[offset/8];
+}
+
+static void ras_sysreg_write_inject(void *base, u32 offset, u64 val)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	p[offset/8] = val;
+}
+
+static u64 ras_iomem_read_inject(void *base, u32 offset)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	return p[offset/8];
+}
+
+static void ras_iomem_write_inject(void *base, u32 offset, u64 val)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	p[offset/8] = val;
+}
+
+static struct ras_access ras_access_inject[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = ras_sysreg_read_inject,
+		.write = ras_sysreg_write_inject,
+	},
+
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = ras_iomem_read_inject,
+		.write = ras_iomem_write_inject,
+	},
+	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
+		.read = ras_iomem_read_inject,
+		.write = ras_iomem_write_inject,
+	},
+	{ }
+};
+
+static int soft_inject_store(void *data, u64 val)
+{
+	int count = 0;
+	struct ras_record record_inj, *record = data;
+	struct ras_node *node = record->node;
+
+	memcpy(&record_inj, record, sizeof(*record));
+	record_inj.access = &ras_access_inject[node->access_type];
+
+	regs_inj.err_status |= ERR_STATUS_V;
+
+	ras_proc_record(&record_inj, &count, true);
+
+	if (count != 1)
+		return -EIO;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(soft_inject_ops, NULL, soft_inject_store, "%llu\n");
+
+static int hard_inject_store(void *data, u64 val)
+{
+	struct ras_record *record = data;
+	struct ras_node *node = record->node;
+
+	if (node->type != ACPI_AEST_PROCESSOR_ERROR_NODE && !node->inj)
+		return -EPERM;
+
+	ras_select_record(node, record->index);
+	record_write(record, ERXPFGCTL, val);
+	record_write(record, ERXPFGCDN, 0x100);
+	ras_sync(node);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(hard_inject_ops, NULL, hard_inject_store, "%llu\n");
+
+void ras_inject_init_debugfs(struct ras_record *record)
+{
+	struct dentry *inj;
+
+	inj = debugfs_create_dir("inject", record->debugfs);
+
+	debugfs_create_u64("err_fr", 0600, inj, &regs_inj.err_fr);
+	debugfs_create_u64("err_ctrl", 0600, inj, &regs_inj.err_ctlr);
+	debugfs_create_u64("err_status", 0600, inj, &regs_inj.err_status);
+	debugfs_create_u64("err_addr", 0600, inj, &regs_inj.err_addr);
+	debugfs_create_u64("err_misc0", 0600, inj, &regs_inj.err_misc[0]);
+	debugfs_create_u64("err_misc1", 0600, inj, &regs_inj.err_misc[1]);
+	debugfs_create_u64("err_misc2", 0600, inj, &regs_inj.err_misc[2]);
+	debugfs_create_u64("err_misc3", 0600, inj, &regs_inj.err_misc[3]);
+	debugfs_create_file("soft_inject", 0200, inj, record, &soft_inject_ops);
+
+	if (record->node->type == ACPI_AEST_PROCESSOR_ERROR_NODE || record->node->inj)
+		debugfs_create_file("hard_inject", 0200, inj, record, &hard_inject_ops);
+}
diff --git a/drivers/ras/arm64/ras-sysfs.c b/drivers/ras/arm64/ras-sysfs.c
index 03cc00b820e2..d8b351ee9aef 100644
--- a/drivers/ras/arm64/ras-sysfs.c
+++ b/drivers/ras/arm64/ras-sysfs.c
@@ -151,6 +151,7 @@ static void ras_record_init_debugfs(struct ras_record *record)
 			    record, &ras_record_err_count_fops);
 	debugfs_create_file("ce_threshold", 0600, record->debugfs,
 			    record, &record_ce_threshold_ops);
+	ras_inject_init_debugfs(record);
 }
 
 static void ras_init_records_debugfs(struct ras_node *node)
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index 92cbb975b4df..8a0d2909fe4b 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -302,5 +302,7 @@ static inline void ras_sync(struct ras_node *node)
 }
 
 void ras_node_init_debugfs(struct ras_node *node);
+void ras_inject_init_debugfs(struct ras_record *record);
+void ras_proc_record(struct ras_record *record, void *data, bool fake);
 
 #endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
-- 
2.51.2.612.gdc70283dfc

