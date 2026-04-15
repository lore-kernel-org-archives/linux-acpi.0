Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F93101BF;
	Wed, 15 Apr 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218214; cv=none; b=QZNT1bDFFq7XP7EtW7BgZ4APEmxLUKRa+EEJuHZGb8qwQE2XqTtcGrBlSkdH1Ci9cbpZVO8qPkE4eK9CQJwC2Ft3j36nrMGmjlkoj8RSqacc7iyUBTyjQVgxkFXMWPOSw/oZ5Rthe3J5Ii0aV+kv6V57YLf0fo2Qwi3oGBABJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218214; c=relaxed/simple;
	bh=H1ztQgd+2H1GKQQqEH15jClagTdCx1WzvmrE8NCuARs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Egxtla2HExOu/Zsdn2l85lHfY98mybi013I2Rk/giuqb5skHVyokSNA23LTj5EEuoC3Hk3/oKyu1csB9/XfDOrlCq8L1izRv/Wvb7Mq1lz0AabW3sK7+1BLDqo6rAAF1dCWgKujU7LQsXZt05S6s+tyVEdc0c2uNAOEx44WyYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW8dABxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW8dABxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B1C2BCC4;
	Wed, 15 Apr 2026 01:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218214;
	bh=H1ztQgd+2H1GKQQqEH15jClagTdCx1WzvmrE8NCuARs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aW8dABxFiClvpDtdFboVo5klhedNQrj+B6xsvX4HjE9oBtkOH9xkcmNOqRuG0RTEy
	 tbqr7dd3sk/7qJ4TK2ciLQR+YYuL+ePx8JUw/pmG5IbZ7ppk1BwV7ZRoUgdYiWU++x
	 7jUl8xKoEywiMFn5SIIujvwTwqSNmPZbBGEpi4I211gT9OWWmAudUjKUcdsA5e8uYB
	 HsCxQd5Y3MlvQOJwNsWPism5bf6bTAOjAJdAtUG0w9ujvfmoVTmEM8n7JmclmzQShj
	 LSt6ps40cOWAsQll4k2fW4gcC/hyr9sRt0AB0H+0yD91KZYsrG/jUAvABoKTlqEgax
	 qBBrx35g1qSRQ==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:53:58 -0700
Subject: [PATCH RFC v3 04/11] RISC-V: QoS: add CBQRI hardware interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19984; i=fustini@kernel.org;
 h=from:subject:message-id; bh=H1ztQgd+2H1GKQQqEH15jClagTdCx1WzvmrE8NCuARs=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5CU1bHojVCP3lTekPro1cU99m2JPrfFWKx4pt0pS
 v07KWttRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAib80YGY6m/Tiy/f0ZJ3uh
 mnuF/+/sPiTCJHg0k+9Bb1R8QaEVNwPDf8e/X7m//35mE6fAYn3+qt2OAzfUW/2Sb0b5yx2Lirk
 ayQMA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add the CBQRI controller hardware interface layer.

Define data structures representing CBQRI controller properties
(cbqri_controller) and hardware capabilities for capacity and bandwidth
controllers (riscv_cbqri_capacity_caps, riscv_cbqri_bandwidth_caps) in
include/linux/riscv_qos.h.

Define MMIO register offsets, field masks, and internal wrapper structs
(cbqri_resctrl_res, cbqri_resctrl_dom, cbqri_config) in internal.h.

Implement MMIO helpers for capacity block mask and bandwidth reservation,
alloc control operations for capacity and bandwidth controllers, and
probe functions to discover controller capabilities. A per-controller
spinlock serializes multi-step MMIO sequences.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                         |   1 +
 arch/riscv/kernel/qos/internal.h    |  81 +++++++
 arch/riscv/kernel/qos/qos_resctrl.c | 432 ++++++++++++++++++++++++++++++++++++
 include/linux/riscv_qos.h           |  76 +++++++
 4 files changed, 590 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b17f885411ba..6a66d7047c51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22785,6 +22785,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/kernel/qos/
+F:	include/linux/riscv_qos.h
 
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
new file mode 100644
index 000000000000..edbcbd9471b1
--- /dev/null
+++ b/arch/riscv/kernel/qos/internal.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_QOS_INTERNAL_H
+#define _ASM_RISCV_QOS_INTERNAL_H
+
+#include <linux/bitfield.h>
+#include <linux/resctrl.h>
+#include <linux/riscv_qos.h>
+
+#define RISCV_RESCTRL_EMPTY_CLOSID	((u32)~0)
+
+#define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_MON_CTL_OFF      8
+#define CBQRI_CC_MON_CTL_VAL_OFF 16
+#define CBQRI_CC_ALLOC_CTL_OFF   24
+#define CBQRI_CC_BLOCK_MASK_OFF  32
+
+#define CBQRI_BC_CAPABILITIES_OFF 0
+#define CBQRI_BC_MON_CTL_OFF      8
+#define CBQRI_BC_MON_CTR_VAL_OFF 16
+#define CBQRI_BC_ALLOC_CTL_OFF   24
+#define CBQRI_BC_BW_ALLOC_OFF    32
+
+#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK  GENMASK(23, 8)
+#define CBQRI_CC_CAPABILITIES_FRCID_MASK   GENMASK(24, 24)
+
+#define CBQRI_BC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_MASK  GENMASK(23, 8)
+#define CBQRI_BC_CAPABILITIES_MRBWB_MASK    GENMASK_ULL(47, 32)
+
+#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK(4, 0)
+#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK(7, 5)
+#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
+#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
+#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK(19, 8)
+#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
+#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
+#define CBQRI_CONTROL_REGISTERS_RBWB_MASK    GENMASK(15, 0)
+
+#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_CC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_CC_ALLOC_CTL_OP_FLUSH_RCID   3
+#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_BC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
+
+int qos_resctrl_setup(void);
+int qos_resctrl_online_cpu(unsigned int cpu);
+int qos_resctrl_offline_cpu(unsigned int cpu);
+
+struct cbqri_resctrl_res {
+	struct rdt_resource     resctrl_res;
+	u32 max_rcid;
+	u32 max_mcid;
+};
+
+struct cbqri_resctrl_dom {
+	struct rdt_ctrl_domain  resctrl_ctrl_dom;
+	struct cbqri_controller *hw_ctrl;
+};
+
+struct cbqri_config {
+	u64 cbm; /* capacity block mask */
+	u64 rbwb; /* reserved bandwidth blocks */
+};
+
+#endif /* _ASM_RISCV_QOS_INTERNAL_H */
diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
new file mode 100644
index 000000000000..6d294f2f2504
--- /dev/null
+++ b/arch/riscv/kernel/qos/qos_resctrl.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "qos: resctrl: " fmt
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/resctrl.h>
+#include <linux/riscv_qos.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/csr.h>
+#include <asm/qos.h>
+#include "internal.h"
+
+static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
+
+static bool exposed_alloc_capable;
+/* CDP (code data prioritization) on x86 is AT (access type) on RISC-V */
+static bool exposed_cdp_l2_capable;
+static bool exposed_cdp_l3_capable;
+static bool is_cdp_l2_enabled;
+static bool is_cdp_l3_enabled;
+
+/* used by resctrl_arch_system_num_rmid_idx() */
+static u32 max_rmid;
+
+LIST_HEAD(cbqri_controllers);
+
+static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_offset,
+				u64 *regp);
+
+/* Set capacity block mask (cc_block_mask) */
+static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
+{
+	iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+}
+
+/* Set the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
+static void cbqri_set_rbwb(struct cbqri_controller *ctrl, u64 rbwb)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	reg &= ~CBQRI_CONTROL_REGISTERS_RBWB_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_RBWB_MASK, rbwb);
+	iowrite64(reg, ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+}
+
+/* Get the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
+static u64 cbqri_get_rbwb(struct cbqri_controller *ctrl)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	return FIELD_GET(CBQRI_CONTROL_REGISTERS_RBWB_MASK, reg);
+}
+
+static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_offset,
+				u64 *regp)
+{
+	u64 reg;
+	int ret;
+
+	ret = readq_poll_timeout_atomic(ctrl->base + reg_offset, reg,
+					!FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_MASK, reg),
+					0, 1000);
+	if (!ret && regp)
+		*regp = reg;
+
+	return ret;
+}
+
+/* Perform capacity allocation control operation on capacity controller */
+static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation, int rcid,
+			     enum resctrl_conf_type type)
+{
+	int reg_offset = CBQRI_CC_ALLOC_CTL_OFF;
+	int status;
+	u64 reg;
+
+	reg = ioread64(ctrl->base + reg_offset);
+	reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
+	reg &= ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
+
+	/* CBQRI capacity AT is only supported on L2 and L3 caches for now */
+	if (ctrl->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&
+	    ((ctrl->cache.cache_level == 2 && is_cdp_l2_enabled) ||
+	    (ctrl->cache.cache_level == 3 && is_cdp_l3_enabled))) {
+		reg &= ~CBQRI_CONTROL_REGISTERS_AT_MASK;
+		switch (type) {
+		case CDP_CODE:
+			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
+					  CBQRI_CONTROL_REGISTERS_AT_CODE);
+			break;
+		case CDP_DATA:
+		default:
+			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
+					  CBQRI_CONTROL_REGISTERS_AT_DATA);
+			break;
+		}
+	}
+
+	iowrite64(reg, ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err("%s(): BUSY timeout when executing the operation\n", __func__);
+		return -EIO;
+	}
+
+	status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+	if (status != CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
+		pr_err("%s(): operation %d failed: status=%d\n", __func__, operation, status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Write a capacity block mask and verify the hardware accepted it by
+ * reading back the value after a CONFIG_LIMIT + READ_LIMIT sequence.
+ */
+static int cbqri_apply_cache_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
+				    enum resctrl_conf_type type, struct cbqri_config *cfg)
+{
+	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
+	int err = 0;
+	u64 reg;
+
+	spin_lock(&ctrl->lock);
+
+	/* Set capacity block mask (cc_block_mask) */
+	cbqri_set_cbm(ctrl, cfg->cbm);
+
+	/* Capacity config limit operation */
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT, closid, type);
+	if (err < 0) {
+		pr_err("%s(): operation failed: err = %d\n", __func__, err);
+		goto out;
+	}
+
+	/* Clear cc_block_mask before read limit to verify op works */
+	cbqri_set_cbm(ctrl, 0);
+
+	/* Perform a capacity read limit operation to verify blockmask */
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);
+	if (err < 0) {
+		pr_err("%s(): operation failed: err = %d\n", __func__, err);
+		goto out;
+	}
+
+	/* Read capacity blockmask to verify it matches the requested config */
+	reg = ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+	if (reg != cfg->cbm) {
+		pr_err("%s(): failed to verify allocation (reg:%llx != cbm:%llx)\n",
+		       __func__, reg, cfg->cbm);
+		err = -EIO;
+	}
+
+out:
+	spin_unlock(&ctrl->lock);
+	return err;
+}
+
+/* Perform bandwidth allocation control operation on bandwidth controller */
+static int cbqri_bc_alloc_op(struct cbqri_controller *ctrl, int operation, int rcid)
+{
+	int reg_offset = CBQRI_BC_ALLOC_CTL_OFF;
+	int status;
+	u64 reg;
+
+	reg = ioread64(ctrl->base + reg_offset);
+	reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
+	reg &= ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
+	iowrite64(reg, ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err("%s(): BUSY timeout when executing the operation\n", __func__);
+		return -EIO;
+	}
+
+	status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+	if (status != CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
+		pr_err("%s(): operation %d failed with status = %d\n",
+		       __func__, operation, status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Write a bandwidth reservation and verify the hardware accepted it by
+ * reading back the value after a CONFIG_LIMIT + READ_LIMIT sequence.
+ */
+static int cbqri_apply_bw_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
+				 enum resctrl_conf_type type, struct cbqri_config *cfg)
+{
+	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
+	int ret = 0;
+	u64 reg;
+
+	spin_lock(&ctrl->lock);
+
+	/* Set reserved bandwidth blocks */
+	cbqri_set_rbwb(ctrl, cfg->rbwb);
+
+	/* Bandwidth config limit operation */
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT, closid);
+	if (ret < 0) {
+		pr_err("%s(): operation failed: ret = %d\n", __func__, ret);
+		goto out;
+	}
+
+	/* Clear rbwb before read limit to verify op works */
+	cbqri_set_rbwb(ctrl, 0);
+
+	/* Bandwidth allocation read limit operation to verify */
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (ret < 0)
+		goto out;
+
+	/* Read bandwidth allocation to verify it matches the requested config */
+	reg = cbqri_get_rbwb(ctrl);
+	if (reg != cfg->rbwb) {
+		pr_err("%s(): failed to verify allocation (reg:%llx != rbwb:%llu)\n",
+		       __func__, reg, cfg->rbwb);
+		ret = -EIO;
+	}
+
+out:
+	spin_unlock(&ctrl->lock);
+	return ret;
+}
+
+static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
+			       int operation, int *status, bool *access_type_supported)
+{
+	u64 reg, saved_reg;
+	int at;
+
+	/* Keep the initial register value to preserve the WPRI fields */
+	reg = ioread64(ctrl->base + reg_offset);
+	saved_reg = reg;
+
+	/* Execute the requested operation to find if the register is implemented */
+	reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
+	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
+	iowrite64(reg, ctrl->base + reg_offset);
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err("%s(): BUSY timeout when executing the operation\n", __func__);
+		return -EIO;
+	}
+
+	/* Get the operation status */
+	*status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+
+	/*
+	 * Check for the AT support if the register is implemented
+	 * (if not, the status value will remain 0)
+	 */
+	if (*status != 0) {
+		/* Set the AT field to a valid value */
+		reg = saved_reg;
+		reg &= ~CBQRI_CONTROL_REGISTERS_AT_MASK;
+		reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
+				  CBQRI_CONTROL_REGISTERS_AT_CODE);
+		iowrite64(reg, ctrl->base + reg_offset);
+		if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+			pr_err("%s(): BUSY timeout when setting AT field\n", __func__);
+			return -EIO;
+		}
+
+		/*
+		 * If the AT field value has been reset to zero,
+		 * then the AT support is not present
+		 */
+		at = FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
+		if (at == CBQRI_CONTROL_REGISTERS_AT_CODE)
+			*access_type_supported = true;
+		else
+			*access_type_supported = false;
+	}
+
+	/* Restore the original register value */
+	iowrite64(saved_reg, ctrl->base + reg_offset);
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, NULL) < 0) {
+		pr_err("%s(): BUSY timeout when restoring the original register value\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cbqri_probe_cc(struct cbqri_controller *ctrl)
+{
+	int err, status;
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
+	if (reg == 0)
+		return -ENODEV;
+
+	ctrl->ver_minor = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg);
+	ctrl->ver_major = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg);
+	ctrl->cc.supports_alloc_op_flush_rcid =
+		FIELD_GET(CBQRI_CC_CAPABILITIES_FRCID_MASK, reg);
+	ctrl->cc.ncblks = FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, reg);
+
+	pr_debug("version=%d.%d ncblks=%d cache_level=%d\n",
+		 ctrl->ver_major, ctrl->ver_minor,
+		 ctrl->cc.ncblks, ctrl->cache.cache_level);
+
+	/* Probe allocation features (monitoring not yet implemented) */
+	err = cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
+				  CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+				  &status, &ctrl->cc.supports_alloc_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
+		ctrl->alloc_capable = true;
+		exposed_alloc_capable = true;
+	}
+
+	return 0;
+}
+
+static int cbqri_probe_bc(struct cbqri_controller *ctrl)
+{
+	int err, status;
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_CAPABILITIES_OFF);
+	if (reg == 0)
+		return -ENODEV;
+
+	ctrl->ver_minor = FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MINOR_MASK, reg);
+	ctrl->ver_major = FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK, reg);
+	ctrl->bc.nbwblks = FIELD_GET(CBQRI_BC_CAPABILITIES_NBWBLKS_MASK, reg);
+	ctrl->bc.mrbwb = FIELD_GET(CBQRI_BC_CAPABILITIES_MRBWB_MASK, reg);
+
+	if (!ctrl->bc.nbwblks) {
+		pr_err("bandwidth controller has nbwblks=0\n");
+		return -EINVAL;
+	}
+
+	pr_debug("version=%d.%d nbwblks=%d mrbwb=%d\n",
+		 ctrl->ver_major, ctrl->ver_minor,
+		 ctrl->bc.nbwblks, ctrl->bc.mrbwb);
+
+	/* Probe allocation features (monitoring not yet implemented) */
+	err = cbqri_probe_feature(ctrl, CBQRI_BC_ALLOC_CTL_OFF,
+				  CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT,
+				  &status, &ctrl->bc.supports_alloc_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
+		ctrl->alloc_capable = true;
+		exposed_alloc_capable = true;
+	}
+
+	return 0;
+}
+
+static int cbqri_probe_controller(struct cbqri_controller *ctrl)
+{
+	int err;
+
+	pr_debug("controller info: type=%d addr=%pa size=%pa max-rcid=%u max-mcid=%u\n",
+		 ctrl->type, &ctrl->addr, &ctrl->size,
+		 ctrl->rcid_count, ctrl->mcid_count);
+
+	if (!ctrl->addr) {
+		pr_warn("%s(): controller has invalid addr=0x0, skipping\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller")) {
+		pr_err("%s(): request_mem_region failed for %pa\n",
+		       __func__, &ctrl->addr);
+		return -EBUSY;
+	}
+
+	ctrl->base = ioremap(ctrl->addr, ctrl->size);
+	if (!ctrl->base) {
+		pr_err("%s(): ioremap failed for %pa\n", __func__, &ctrl->addr);
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	spin_lock_init(&ctrl->lock);
+
+	switch (ctrl->type) {
+	case CBQRI_CONTROLLER_TYPE_CAPACITY:
+		err = cbqri_probe_cc(ctrl);
+		break;
+	case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+		err = cbqri_probe_bc(ctrl);
+		break;
+	default:
+		pr_err("unknown controller type %d\n", ctrl->type);
+		err = -ENODEV;
+		break;
+	}
+
+	if (err)
+		goto err_iounmap;
+
+	/*
+	 * max_rmid is used by resctrl_arch_system_num_rmid_idx()
+	 * Find the smallest mcid_count amongst all controllers.
+	 */
+	max_rmid = min(max_rmid, ctrl->mcid_count);
+
+	return 0;
+
+err_iounmap:
+	iounmap(ctrl->base);
+	ctrl->base = NULL;
+err_release:
+	release_mem_region(ctrl->addr, ctrl->size);
+	return err;
+}
diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
new file mode 100644
index 000000000000..0f3daae2e84f
--- /dev/null
+++ b/include/linux/riscv_qos.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_RISCV_QOS_H
+#define __LINUX_RISCV_QOS_H
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/qos.h>
+
+enum cbqri_controller_type {
+	CBQRI_CONTROLLER_TYPE_CAPACITY,
+	CBQRI_CONTROLLER_TYPE_BANDWIDTH,
+	CBQRI_CONTROLLER_TYPE_UNKNOWN
+};
+
+/* Capacity Controller hardware capabilities */
+struct riscv_cbqri_capacity_caps {
+	u16 ncblks; /* number of capacity blocks */
+
+	bool supports_alloc_at_code;
+	bool supports_alloc_op_flush_rcid;
+};
+
+/* Bandwidth Controller hardware capabilities */
+struct riscv_cbqri_bandwidth_caps {
+	u16 nbwblks; /* number of bandwidth blocks */
+	u16 mrbwb;   /* max reserved bw blocks */
+
+	bool supports_alloc_at_code;
+};
+
+struct cbqri_controller {
+	void __iomem *base;
+	/*
+	 * Protects multi-step MMIO register sequences on this controller.
+	 * CBQRI operations (e.g. CONFIG_LIMIT, READ_LIMIT) require writing
+	 * an operation register, waiting for the busy flag to clear, then
+	 * reading back the result. These sequences must be atomic per
+	 * controller to prevent interleaving.
+	 */
+	spinlock_t lock;
+
+	int ver_major;
+	int ver_minor;
+
+	struct riscv_cbqri_bandwidth_caps bc;
+	struct riscv_cbqri_capacity_caps cc;
+
+	bool alloc_capable;
+
+	phys_addr_t addr;
+	phys_addr_t size;
+	enum cbqri_controller_type type;
+	u32 rcid_count;
+	u32 mcid_count;
+	struct list_head list;
+
+	struct cache_controller {
+		u32 cache_level;
+		u32 cache_size; /* in bytes */
+		struct cpumask cpu_mask;
+		/* Unique Cache ID from the PPTT table's Cache Type Structure */
+		u32 cache_id;
+	} cache;
+
+	struct mem_controller {
+		/* Proximity Domain from SRAT table Memory Affinity Controller */
+		u32 prox_dom;
+		struct cpumask cpu_mask;
+	} mem;
+};
+
+extern struct list_head cbqri_controllers;
+
+#endif /* __LINUX_RISCV_QOS_H */

-- 
2.43.0

