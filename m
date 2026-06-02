Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920B345CAA;
	Tue,  2 Jun 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384579; cv=none; b=LLHat2tWBbQ33IXZ+wHWgTGP7ok3E3GqwDGVvrA1OUtM5Kba8CJZHbBWo5jhAHKvTQUYWQF05Oiaex5Sh898QoUcQMqmkl1O5RP2mxfvdd2v3euq/DKPy7eInGtyn+x9/sqBVP8oIOEbIzFi2P0chcbt2rTmWVvzds0RIrk6o38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384579; c=relaxed/simple;
	bh=1FLUAjqkojQoRY09Mk+KMmwl/m0J9QDmG803FDSKLhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjfbwe/gMGKUuKHo3xXOqJXVYHzwbYWQWW3XrVZzHtUBOO6hUooyJlVRPknXZWqsAI98xSobhYQTKVHwWvP97PFI42jw5AG+vHQq22UcQqcnQ6GnqKWVBeV23s/ced/PfiD0IACFwHzhqC62FjSlcRytQozNgqw/WHnxxEmertU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ny7VHHEV; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ny7VHHEV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384568; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZozZHcNNhfj5S1VhtyeRB12PjLLzujmaREsy9720OSQ=;
	b=ny7VHHEVsALIT4DhdBqYklIKfaE1BssdRSwZ9WmYZfMUA9L7l6t5xPxx+ho5hW0O9XADD/PKXH+zxgQBYfgY066ogH+z0Hg1NQpZH5aEn0tHZkEQvcH6ZM6VTpr2Dtox7Y1NtGLVmIS8JRkfZR+FuknVDJnSrOsjoR3BBaDH7tY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2e1_1780384566;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2e1_1780384566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:07 +0800
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
Subject: [PATCH v7 09/16] arm64: ras: Probe RAS architecture version
Date: Tue,  2 Jun 2026 15:15:32 +0800
Message-ID: <20260602071540.3711528-10-tianruidong@linux.alibaba.com>
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

The RAS version of a component can be probed via its ERRDEVARCH register.

In cases where a component (e.g., SMMU) does not implement an ERRDEVARCH
register, the driver falls back to using the RAS version of the Processing
Element (PE).

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/ras.h |  3 +++
 drivers/ras/arm64/ras-core.c | 25 +++++++++++++++++++++++++
 drivers/ras/arm64/ras.h      |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
index 7bef631a395c..5b938ff03e74 100644
--- a/arch/arm64/include/asm/ras.h
+++ b/arch/arm64/include/asm/ras.h
@@ -44,6 +44,9 @@
 #define ERRFHICR0_OFFSET		0x0
 #define ERRERICR0_OFFSET		0x10
 
+/* ERRDEVARCH */
+#define ERRDEVARCH_REV			GENMASK(19, 16)
+
 struct ras_ext_regs {
 	u64 err_fr;
 	u64 err_ctlr;
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index babb390b795f..9fbc98e89f15 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -169,9 +169,18 @@ static void ras_proc_record(struct ras_record *record, void *data)
 	if (regs.err_status & ERR_STATUS_MV) {
 		regs.err_misc[0] = record_read(record, ERXMISC0);
 		regs.err_misc[1] = record_read(record, ERXMISC1);
+		if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
+			regs.err_misc[2] = record_read(record, ERXMISC2);
+			regs.err_misc[3] = record_read(record, ERXMISC3);
+		}
+
 		if (record->node->flags & AEST_XFACE_FLAG_CLEAR_MISC) {
 			record_write(record, ERXMISC0, 0);
 			record_write(record, ERXMISC1, 0);
+			if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
+				record_write(record, ERXMISC2, 0);
+				record_write(record, ERXMISC3, 0);
+			}
 		}
 	}
 
@@ -358,6 +367,21 @@ static void ras_enable_irq(struct ras_record *record)
 	record_write(record, ERXCTLR, err_ctlr);
 }
 
+static int get_ras_node_ver(struct ras_node *node)
+{
+	u32 reg;
+
+	if (node->type == ACPI_AEST_GIC_ERROR_NODE) {
+		if (!node->base)
+			return 0;
+
+		reg = readl_relaxed(node->base + GIC_ERRDEVARCH);
+		return FIELD_GET(ERRDEVARCH_REV, reg);
+	}
+
+	return FIELD_GET(ID_AA64PFR0_EL1_RAS_MASK, read_cpuid(ID_AA64PFR0_EL1));
+}
+
 static int ras_init_record(struct ras_record *record, int i, struct ras_node *node)
 {
 	record->name = devm_kasprintf(node->dev, GFP_KERNEL, "record%d", i);
@@ -665,6 +689,7 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 	if (!node->name)
 		return ERR_PTR(-ENOMEM);
 
+	node->version = get_ras_node_ver(node);
 	node->records = devm_kcalloc(node->dev, node->record_count,
 				     sizeof(struct ras_record), GFP_KERNEL);
 	if (!node->records)
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index 11c6def1e4bf..03d1b498acc4 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -58,6 +58,8 @@
 #define ERXPFGCTL		0x808
 #define ERXPFGCDN		0x810
 
+#define GIC_ERRDEVARCH		0xFFBC
+
 struct ras_access {
 	u64 (*read)(void __iomem *base, u32 offset);
 	void (*write)(void __iomem *base, u32 offset, u64 val);
@@ -148,6 +150,7 @@ struct ras_node {
 	u32 record_count;
 	u32 record_index;
 	u32 flags;
+	int version;
 
 	u8 type;
 	u8 access_type;
-- 
2.51.2.612.gdc70283dfc

