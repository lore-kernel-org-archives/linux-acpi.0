Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEC34752D;
	Tue,  2 Jun 2026 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384577; cv=none; b=N/ObduDIAi3FM+SmPaXu7OsHkIVbwG4PpntsgdMWK+4RBAGwi1T2c5wVlKRjFLNRLbUJnLgoVHp6C/xwmdGtMq5UrEPS2MPWTWmi09NIDZqaBgYHA/2H/0cO33LsXPgEND5NW1SFBTBCLPMZUYQ/lbz68KShHR47cgVCHvi6Z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384577; c=relaxed/simple;
	bh=LutnBlhqyOIvbFqTOmDw9r6dqJ1LBQLMQACDal4qZTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2hkmUMit6/ztyBLbjRjGTJEYV4epNNxD6kjbIq6m54o5Cg9pvmz2jrUJdB6bCy2H0ZSLcp6yViUtxtRMaV2fdp0xyfRFwBpGSo93sFYEecUHT4CZmmUOxfNwoHkQ0ATYAECpDVI88SlA5aNqeeEAKQ3yeioEpiOE2y+sP8IHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AStWR9MM; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AStWR9MM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384561; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Wkg7zePrkjLP7+kbmK0jAUbfScXCvDraNXIRyL6x9wI=;
	b=AStWR9MMAK5o0oXahF0LjPCdIJyRQqOyckZ6gI1Muc9Xm5xTWxrkNBJxgj5HYc3MieSvdB2PDqCCkwOTG2WQfrgsj8oIhuMuAaFXh9Re3mkiRxFNss1vaLYDB9wW21612YZgb4+oJsut96TCJKRHMPG02CPcv0xvVMvy2JtzLYI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2aa_1780384553;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2aa_1780384553 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:15:58 +0800
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
Subject: [PATCH v7 03/16] arm64: ras: Unify the read/write interface for system and MMIO registers
Date: Tue,  2 Jun 2026 15:15:26 +0800
Message-ID: <20260602071540.3711528-4-tianruidong@linux.alibaba.com>
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

ARM RAS error records are reachable either through system registers
(PE-affine sources) or through memory-mapped windows (off-core
sources), depending on the AEST interface type. Hard-coding the
choice at every call site would scatter that knowledge across the
driver and double every future change.

Introduce a ras_access ops table that hides the transport behind a
single read/write contract, so all later error handling, masking and
injection code is access-method-agnostic and can be reasoned about as
plain register operations.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/arm64/aest.c    |  3 +-
 drivers/ras/arm64/ras-core.c |  5 +-
 drivers/ras/arm64/ras.h      | 94 ++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index 8cf24467d0c2..3a813fe7047c 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -93,6 +93,7 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 	}
 
 	props[(*p)++] = PROPERTY_ENTRY_U8("arm,node-type", hdr->type);
+	props[(*p)++] = PROPERTY_ENTRY_U8("arm,interface-type", interface->type);
 	props[(*p)++] = PROPERTY_ENTRY_U8("arm,group-format",
 					  interface->group_format);
 	props[(*p)++] = PROPERTY_ENTRY_U32("arm,error-records-count",
@@ -121,7 +122,7 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 static int __init
 aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
 {
-	struct property_entry props[10] = { };
+	struct property_entry props[11] = { };
 	int p = 0;
 	int ret;
 
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index b5448f4a841f..47ab78cc88d7 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -51,6 +51,7 @@ static int ras_init_record(struct ras_record *record, int i, struct ras_node *no
 	if (node->base)
 		record->regs_base = node->base + sizeof(struct ras_ext_regs) * i;
 
+	record->access = &ras_access[node->access_type];
 	record->index = i;
 	record->node = node;
 
@@ -152,6 +153,7 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 	node->dev = &pdev->dev;
 
 	ret = ret ?: device_property_read_u8(dev, "arm,node-type", &node->type);
+	ret = ret ?: device_property_read_u8(dev, "arm,interface-type", &node->access_type);
 	ret = ret ?: device_property_read_u8(dev, "arm,group-format", &node->group_format);
 	ret = ret ?: device_property_read_u32(dev, "arm,interface-flags", &node->flags);
 	ret = ret ?: device_property_read_u32(dev, "arm,error-records-count", &node->record_count);
@@ -219,7 +221,8 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 		if (ret)
 			return ERR_PTR(ret);
 	}
-	ras_node_dbg(node, "base: %llx\n", node->addr);
+	ras_node_dbg(node, "base: %llx, access_type: %s\n",
+		     node->addr, node->access_type ? "MMIO" : "Register");
 	return node;
 }
 
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index 3d83f8b26da7..94ffeb83b251 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -11,6 +11,11 @@
 #include <linux/acpi_aest.h>
 #include <asm/ras.h>
 
+#define record_read(record, offset) \
+	((record)->access->read((record)->regs_base, (offset)))
+#define record_write(record, offset, val) \
+	((record)->access->write((record)->regs_base, (offset), (val)))
+
 #define ras_node_err(__node, format, ...)                          \
 	dev_err((__node)->dev, "%s: " format, (__node)->name, \
 		##__VA_ARGS__)
@@ -41,10 +46,25 @@
 #define ERXGROUP_16K_ERRGSR_NUM		4
 #define ERXGROUP_64K_ERRGSR_NUM		14
 
+#define ERXFR			0x0
+#define ERXCTLR			0x8
+#define ERXSTATUS		0x10
+#define ERXADDR			0x18
+#define ERXMISC0		0x20
+#define ERXMISC1		0x28
+#define ERXMISC2		0x30
+#define ERXMISC3		0x38
+
+struct ras_access {
+	u64 (*read)(void __iomem *base, u32 offset);
+	void (*write)(void __iomem *base, u32 offset, u64 val);
+};
+
 struct ras_record {
 	char *name;
 	void __iomem *regs_base;
 	struct ras_node *node;
+	const struct ras_access *access;
 
 	int index;
 };
@@ -98,7 +118,81 @@ struct ras_node {
 	u32 flags;
 
 	u8 type;
+	u8 access_type;
 	u8 group_format;
 };
 
+#define CASE_READ(res, x)                           \
+	case (x): {                                 \
+		res = read_sysreg_s(SYS_##x##_EL1); \
+		break;                              \
+	}
+
+#define CASE_WRITE(val, x)                            \
+	case (x): {                                   \
+		write_sysreg_s((val), SYS_##x##_EL1); \
+		break;                                \
+	}
+
+static inline u64 ras_sysreg_read(void __iomem *base __always_unused, u32 offset)
+{
+	u64 res;
+
+	switch (offset) {
+	CASE_READ(res, ERXFR)
+	CASE_READ(res, ERXCTLR)
+	CASE_READ(res, ERXSTATUS)
+	CASE_READ(res, ERXADDR)
+	CASE_READ(res, ERXMISC0)
+	CASE_READ(res, ERXMISC1)
+	CASE_READ(res, ERXMISC2)
+	CASE_READ(res, ERXMISC3)
+	default:
+		res = 0;
+	}
+	return res;
+}
+
+static inline void ras_sysreg_write(void __iomem *base __always_unused, u32 offset, u64 val)
+{
+	switch (offset) {
+	CASE_WRITE(val, ERXFR)
+	CASE_WRITE(val, ERXCTLR)
+	CASE_WRITE(val, ERXSTATUS)
+	CASE_WRITE(val, ERXADDR)
+	CASE_WRITE(val, ERXMISC0)
+	CASE_WRITE(val, ERXMISC1)
+	CASE_WRITE(val, ERXMISC2)
+	CASE_WRITE(val, ERXMISC3)
+	default:
+		return;
+	}
+}
+
+static inline u64 ras_iomem_read(void __iomem *base, u32 offset)
+{
+	return readq_relaxed(base + offset);
+}
+
+static inline void ras_iomem_write(void __iomem *base, u32 offset, u64 val)
+{
+	writeq_relaxed(val, base + offset);
+}
+
+/* access type is decided by AEST interface type. */
+static const struct ras_access ras_access[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = ras_sysreg_read,
+		.write = ras_sysreg_write,
+	},
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = ras_iomem_read,
+		.write = ras_iomem_write,
+	},
+	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
+		.read = ras_iomem_read,
+		.write = ras_iomem_write,
+	},
+};
+
 #endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
-- 
2.51.2.612.gdc70283dfc

