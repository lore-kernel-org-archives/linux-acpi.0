Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3AF313532;
	Wed, 15 Apr 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218215; cv=none; b=EszF5ianPgNyjh92iOPciEkQ5ep63xiXGLnzMSECLRjNCXb4Jj4cs08WZvrFIKDWXqrnzk3Qjfc1jvxy6r4JaiuNwJ+271+JYu/im4IEwMiqMSfj3O7qBA8VWQKuva0mgPLlBm8dltZL+TVzVey2FC+wGpLOai4gQjyzBd1B7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218215; c=relaxed/simple;
	bh=W4I3+X1ieckjmz3X1WF1vjk4ckKSk0GxVxGUjTVFtBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaXFLhjtEc436m1xI5K5PoGmkSko5F/o2A+VQe1T5QAh9nXRHc6uNKyFbR0R/QbexSoFi+RnztCaB2zgDzijX/FDeEZSyt1/BqzkXlbrBAju6Pol7b9GUrhJ3tBUk7nHYdsVgud65pVlPJVgKkPzvQqtDNwJ4WPWwsxYK5LU/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKNLvZhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKNLvZhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AECC2BCB6;
	Wed, 15 Apr 2026 01:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218215;
	bh=W4I3+X1ieckjmz3X1WF1vjk4ckKSk0GxVxGUjTVFtBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PKNLvZhTQaDAmBSK4tQoU9B+bMl9EY02u1JSVYPhfddifDz8GrEYMsV71Q7Hjr5w+
	 Eh9lMcZKasjWHip5fB1paqmQ2TOMc9gMEKp+cukRJS0jJuzoop0gPPu/o1ZzfNmWA6
	 DnF832vSkwyE54hdvVOew3lkC2YUJ+rcEVszV+PxaU5+TRbJURNzFJyQRlpNRKN+H4
	 PONJ5NGUjlleHHsKrgsjkhEUSOY8P2Ks3xayi4sIiCClx+j1TTxtNoi5zNSy+qWtAi
	 Es6wj+U7t/rikFYU+qxqplGcZghBQ6Uc6Bcnng9WxnmoJ+vnFNOPouwh2QPO4xnIzP
	 lAQW/cOkf6uMw==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:53:59 -0700
Subject: [PATCH RFC v3 05/11] RISC-V: QoS: add resctrl arch callbacks for
 CBQRI controllers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-5-b3b2e7e9847a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13493; i=fustini@kernel.org;
 h=from:subject:message-id; bh=W4I3+X1ieckjmz3X1WF1vjk4ckKSk0GxVxGUjTVFtBA=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5Dk8dpNau/jTN8LcgeLGd6Z6WttyVqy6IRzjObU+
 9Xyc2ZM6ShlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMJPIDI8OmWa83nXOU1ltU
 wyf8mHF9plmk7vv0/imlJ/or4nOKgtYxMjwQ9924bNec8H9Twr6oeS0vLtmxkDnleN3a+F1nrT7
 EpfACAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Implement the resctrl architecture callbacks required by the resctrl
filesystem and expose them via arch/riscv/include/asm/resctrl.h.

These include capability reporting, CDP enable/disable, CLOSID/RMID
encoding, scheduler integration (sched_in, set_closid_rmid,
sync_cpu_closid_rmid), domain config read/write (update_one,
update_domains, get_config), and stub implementations for monitoring
operations not yet supported on RISC-V.

The function prototypes and inline stubs are declared in
include/linux/riscv_qos.h alongside the implementations in
arch/riscv/kernel/qos/qos_resctrl.c.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                         |   1 +
 arch/riscv/include/asm/resctrl.h    |   7 +
 arch/riscv/kernel/qos/qos_resctrl.c | 367 ++++++++++++++++++++++++++++++++++++
 include/linux/riscv_qos.h           |  33 ++++
 4 files changed, 408 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a66d7047c51..af9698a16439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22784,6 +22784,7 @@ R:	yunhui cui <cuiyunhui@bytedance.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos/
 F:	include/linux/riscv_qos.h
 
diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
new file mode 100644
index 000000000000..48ad45cbe25c
--- /dev/null
+++ b/arch/riscv/include/asm/resctrl.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_RESCTRL_H
+#define _ASM_RISCV_RESCTRL_H
+
+#include <linux/riscv_qos.h>
+
+#endif /* _ASM_RISCV_RESCTRL_H */
diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
index 6d294f2f2504..a4a120f89840 100644
--- a/arch/riscv/kernel/qos/qos_resctrl.c
+++ b/arch/riscv/kernel/qos/qos_resctrl.c
@@ -2,6 +2,7 @@
 
 #define pr_fmt(fmt) "qos: resctrl: " fmt
 
+#include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -430,3 +431,369 @@ static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 	release_mem_region(ctrl->addr, ctrl->size);
 	return err;
 }
+
+bool resctrl_arch_alloc_capable(void)
+{
+	return exposed_alloc_capable;
+}
+
+bool resctrl_arch_mon_capable(void)
+{
+	/* Monitoring not yet implemented */
+	return false;
+}
+
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
+{
+	switch (rid) {
+	case RDT_RESOURCE_L2:
+		return is_cdp_l2_enabled;
+
+	case RDT_RESOURCE_L3:
+		return is_cdp_l3_enabled;
+
+	default:
+		return false;
+	}
+}
+
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level rid, bool enable)
+{
+	switch (rid) {
+	case RDT_RESOURCE_L2:
+		if (!exposed_cdp_l2_capable)
+			return -ENODEV;
+		is_cdp_l2_enabled = enable;
+		break;
+
+	case RDT_RESOURCE_L3:
+		if (!exposed_cdp_l3_capable)
+			return -ENODEV;
+		is_cdp_l3_enabled = enable;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
+{
+	if (l >= RDT_NUM_RESOURCES)
+		return NULL;
+
+	return &cbqri_resctrl_resources[l].resctrl_res;
+}
+
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+{
+	return false;
+}
+
+void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
+				 enum resctrl_event_id evtid)
+{
+	/* RISC-V can always read an rmid, nothing needs allocating */
+	return NULL;
+}
+
+void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
+			       enum resctrl_event_id evtid, void *arch_mon_ctx)
+{
+	/* No arch-private monitoring context to free */
+}
+
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign)
+{
+	/* MBM counter assignment not supported */
+}
+
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			   u32 unused, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val)
+{
+	/* MBM counter assignment not supported */
+	return -EOPNOTSUPP;
+}
+
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
+{
+	/* MBM counter assignment not supported */
+	return false;
+}
+
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
+{
+	/* MBM counter assignment not supported */
+	return 0;
+}
+
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 unused, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid)
+{
+	/* MBM counter assignment not supported */
+}
+
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
+{
+	/* CBQRI does not have I/O-specific allocation */
+	return false;
+}
+
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
+{
+	/* CBQRI does not have I/O-specific allocation */
+	return 0;
+}
+
+/*
+ * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
+ *   CLOSID on x86 is RCID on RISC-V
+ *     RMID on x86 is MCID on RISC-V
+ */
+u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
+{
+	struct cbqri_resctrl_res *hw_res;
+
+	hw_res = container_of(res, struct cbqri_resctrl_res, resctrl_res);
+
+	return hw_res->max_rcid;
+}
+
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	return max_rmid;
+}
+
+u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
+{
+	return rmid;
+}
+
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*closid = RISCV_RESCTRL_EMPTY_CLOSID;
+	*rmid = idx;
+}
+
+void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
+{
+	u32 srmcfg;
+
+	WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) != closid);
+	WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) != rmid);
+
+	srmcfg = rmid << SRMCFG_MCID_SHIFT;
+	srmcfg |= closid;
+	WRITE_ONCE(per_cpu(cpu_srmcfg_default, cpu), srmcfg);
+}
+
+void resctrl_arch_sched_in(struct task_struct *tsk)
+{
+	__switch_to_srmcfg(tsk);
+}
+
+void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
+{
+	u32 srmcfg;
+
+	WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) != closid);
+	WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) != rmid);
+
+	srmcfg = rmid << SRMCFG_MCID_SHIFT;
+	srmcfg |= closid;
+	WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
+}
+
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
+{
+	struct resctrl_cpu_defaults *r = info;
+
+	lockdep_assert_preemption_disabled();
+
+	if (r) {
+		resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id(),
+							 r->closid, r->rmid);
+	}
+
+	resctrl_arch_sched_in(current);
+}
+
+bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
+{
+	return (READ_ONCE(tsk->thread.srmcfg) & SRMCFG_RCID_MASK) == closid;
+}
+
+bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
+{
+	u32 tsk_rmid;
+
+	tsk_rmid = READ_ONCE(tsk->thread.srmcfg);
+	tsk_rmid >>= SRMCFG_MCID_SHIFT;
+	tsk_rmid &= SRMCFG_MCID_MASK;
+
+	return tsk_rmid == rmid;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
+			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
+			   void *arch_priv, u64 *val, void *arch_mon_ctx)
+{
+	/*
+	 * Cache occupancy and bandwidth monitoring are not yet implemented
+	 * for RISC-V CBQRI. This will be added in a future series once the
+	 * resctrl framework supports monitoring domains at non-L3 scopes.
+	 */
+	return -EOPNOTSUPP;
+}
+
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 closid, u32 rmid, enum resctrl_event_id eventid)
+{
+	/* Monitoring not yet supported; nothing to reset */
+}
+
+void resctrl_arch_mon_event_config_read(void *info)
+{
+	/* Monitoring not yet supported; no event config */
+}
+
+void resctrl_arch_mon_event_config_write(void *info)
+{
+	/* Monitoring not yet supported; no event config */
+}
+
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
+{
+	/* Monitoring not yet supported; nothing to reset */
+}
+
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
+{
+	/* not implemented for the RISC-V resctrl implementation */
+}
+
+void resctrl_arch_pre_mount(void)
+{
+	/* All controllers discovered at boot via late_initcall; nothing to do */
+}
+
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+{
+	struct cbqri_controller *ctrl;
+	struct cbqri_resctrl_dom *dom;
+	struct cbqri_config cfg;
+	int err = 0;
+
+	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+	ctrl = dom->hw_ctrl;
+
+	if (!r->alloc_capable)
+		return -EINVAL;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L2:
+	case RDT_RESOURCE_L3:
+		cfg.cbm = cfg_val;
+		err = cbqri_apply_cache_config(dom, closid, t, &cfg);
+		break;
+	case RDT_RESOURCE_MBA:
+		/* convert from percentage to bandwidth blocks */
+		cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;
+		cfg.rbwb = min_t(u64, cfg.rbwb, ctrl->bc.mrbwb);
+		err = cbqri_apply_bw_config(dom, closid, t, &cfg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
+{
+	struct resctrl_staged_config *cfg;
+	enum resctrl_conf_type t;
+	struct rdt_ctrl_domain *d;
+	int err = 0;
+
+	/* Walking r->ctrl_domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		for (t = 0; t < CDP_NUM_TYPES; t++) {
+			cfg = &d->staged_config[t];
+			if (!cfg->have_new_ctrl)
+				continue;
+			err = resctrl_arch_update_one(r, d, closid, t, cfg->new_ctrl);
+			if (err) {
+				pr_err("%s(): update failed (err=%d)\n", __func__, err);
+				return err;
+			}
+		}
+	}
+	return err;
+}
+
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
+			    u32 closid, enum resctrl_conf_type type)
+{
+	struct cbqri_resctrl_dom *hw_dom;
+	struct cbqri_controller *ctrl;
+	u32 val;
+	u32 rbwb;
+	int err;
+
+	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+
+	ctrl = hw_dom->hw_ctrl;
+
+	val = resctrl_get_default_ctrl(r);
+
+	if (!r->alloc_capable)
+		return val;
+
+	spin_lock(&ctrl->lock);
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L2:
+	case RDT_RESOURCE_L3:
+		/* Clear cc_block_mask before read limit operation */
+		cbqri_set_cbm(ctrl, 0);
+
+		/* Capacity read limit operation for RCID (closid) */
+		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);
+		if (err < 0) {
+			pr_err("%s(): operation failed: err = %d\n", __func__, err);
+			break;
+		}
+
+		/* Read capacity block mask for RCID (closid) */
+		val = ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+		break;
+
+	case RDT_RESOURCE_MBA:
+		/* Bandwidth read limit operation for RCID (closid) */
+		err = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+		if (err < 0) {
+			pr_err("%s(): operation failed: err = %d\n", __func__, err);
+			break;
+		}
+
+		rbwb = cbqri_get_rbwb(ctrl);
+		val = DIV_ROUND_UP(rbwb * 100, ctrl->bc.nbwblks);
+		break;
+
+	default:
+		break;
+	}
+
+	spin_unlock(&ctrl->lock);
+	return val;
+}
diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
index 0f3daae2e84f..1712fb12f6bc 100644
--- a/include/linux/riscv_qos.h
+++ b/include/linux/riscv_qos.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_RISCV_QOS_H
 #define __LINUX_RISCV_QOS_H
 
+#include <linux/resctrl_types.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -73,4 +74,36 @@ struct cbqri_controller {
 
 extern struct list_head cbqri_controllers;
 
+bool resctrl_arch_alloc_capable(void);
+bool resctrl_arch_mon_capable(void);
+
+struct rdt_resource;
+/*
+ * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
+ *   CLOSID on x86 is RCID on RISC-V
+ *     RMID on x86 is MCID on RISC-V
+ *      CDP on x86 is AT (access type) on RISC-V
+ */
+u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
+void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid);
+void resctrl_arch_sched_in(struct task_struct *tsk);
+void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
+bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_event_id evtid);
+void resctrl_arch_mon_ctx_free(struct rdt_resource *r, enum resctrl_event_id evtid,
+			       void *arch_mon_ctx);
+
+static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
+{
+	return val;
+}
+
+/* Not needed for RISC-V */
+static inline void resctrl_arch_enable_mon(void) { }
+static inline void resctrl_arch_disable_mon(void) { }
+static inline void resctrl_arch_enable_alloc(void) { }
+static inline void resctrl_arch_disable_alloc(void) { }
+
 #endif /* __LINUX_RISCV_QOS_H */

-- 
2.43.0

