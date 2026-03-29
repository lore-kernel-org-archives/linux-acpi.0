Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642551922FD;
	Sun, 29 Mar 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781110; cv=none; b=fi2+kZxIka21/Kw+XtOeSStENV0MzrtOss8X0zPKf2ZRjMMoGb6KS9rvH+hoMBtZnQrBPsP4lDIYnzzsdi1AhzMMbAyqN7WRIHao0so+YB4QdA3P517lvFeGyFEiaLxKQPDP71J1405k/8So/UCrHZVFt4Wwa5SBhItqIw/cByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781110; c=relaxed/simple;
	bh=5UYg7ALgX1M21HjBAk1fFUnAqf7oVErtnGioVT0EgM4=;
	h=Message-Id:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=q5lalYqHhSWZe0c+zpUY3s3s9htPWQxVel6pbxqa8O42/8+c0oGlBmzfAozKNLSfWoqN13PfPdg2dQi117whzCP049P2luBPq/k/3t+5N7Lzs6/ui2oRtdyKD4P6Qi4APnZ1jmKOqijopL56nM3Ok9njpBr/ZVQ2Z7eWvt7a9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fk9xm0pPYz5BNS0;
	Sun, 29 Mar 2026 18:45:00 +0800 (CST)
Received: (from root@localhost)
	by mse-fl2.zte.com.cn id 62TAiv5H081340;
	Sun, 29 Mar 2026 18:44:57 +0800 (+08)
	(envelope-from guo.wenjia23@zte.com.cn)
Message-Id: <202603291044.62TAiv5H081340@mse-fl2.zte.com.cn>
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl2.zte.com.cn with SMTP id 62TARphR075539;
	Sun, 29 Mar 2026 18:27:51 +0800 (+08)
	(envelope-from guo.wenjia23@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid202;
	Sun, 29 Mar 2026 18:27:53 +0800 (CST)
X-Zmail-TransId: 2aff69c8fea9ced-ace99
X-Mailer: Zmail v1.0
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
References: 20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org,20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org
Date: Sun, 29 Mar 2026 18:27:53 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <guo.wenjia23@zte.com.cn>
To: <fustini@kernel.org>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <rkrcmar@ventanamicro.com>,
        <samuel.holland@sifive.com>, <aricciardi@baylibre.com>,
        <npitre@baylibre.com>, <mindal@semihalf.com>, <atish.patra@linux.dev>,
        <atishp@rivosinc.com>, <vasu@rivosinc.com>, <ved@rivosinc.com>,
        <cuiyunhui@bytedance.com>, <cp0613@linux.alibaba.com>,
        <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>,
        <liu.qingtao2@zte.com.cn>, <reinette.chatre@intel.com>,
        <tony.luck@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
        <fenghua.yu@intel.com>, <james.morse@arm.com>, <ben.horgan@arm.com>,
        <Dave.Martin@arm.com>, <fustini@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <x86@kernel.org>, <robh@kernel.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <sunilvl@ventanamicro.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <devicetree@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRkMgdjIgMDgvMTddIFJJU0MtVjogUW9TOiBhZGQgcmVzY3RybCBpbnRlcmZhY2UgZm9yIENCUVJJIGNvbnRyb2xsZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 62TAiv5H081340
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: guo.wenjia23@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 29 Mar 2026 18:45:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69C902AC.000/4fk9xm0pPYz5BNS0

Hi Drew,

On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:>
> Add interface for CBQRI controller drivers to make use of the resctrl
> filesystem.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> arch/riscv/kernel/qos/qos_resctrl.c | 1192 +++++++++++++++++++++++++++++++++++
> 1 file changed, 1192 insertions(+)
>
> ...
>
> +
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> + u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> +{
> + struct cbqri_controller *ctrl;
> + struct cbqri_resctrl_dom *dom;
> + struct cbqri_config cfg;
> + int err = 0;
> +
> + dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> + ctrl = dom->hw_ctrl;
> +
> + if (!r->alloc_capable)
> + return -EINVAL;
> +
> + switch (r->rid) {
> + case RDT_RESOURCE_L2:
> + case RDT_RESOURCE_L3:
> + cfg.cbm = cfg_val;
> + err = cbqri_apply_cache_config(dom, closid, t, &cfg);
> + break;
> + case RDT_RESOURCE_MBA:
> + /* covert from percentage to bandwidth blocks */
> + cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;

Should use bc.mrbwb to calculate rbwb?
I think bc.nbwblks represent the available bw blks in the controller. It should should decrease as they are allocated.

> + err = cbqri_apply_bw_config(dom, closid, t, &cfg);
> + break;
> + default:
> + return -EINVAL;
> + }
> +
> + return err;
> +}
>
> ...
>
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> + u32 closid, enum resctrl_conf_type type)
> +{
> + struct cbqri_resctrl_dom *hw_dom;
> + struct cbqri_controller *ctrl;
> + int reg_offset;
> + u32 percent;
> + u32 rbwb;
> + u64 reg;
> + int err;
> +
> + hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> +
> + ctrl = hw_dom->hw_ctrl;
> +
> + if (!r->alloc_capable)
> + return resctrl_get_default_ctrl(r);
> +
> + switch (r->rid) {
> + case RDT_RESOURCE_L2:
> + case RDT_RESOURCE_L3:
> + /* Clear cc_block_mask before read limit operation */
> + cbqri_set_cbm(ctrl, 0);
> +
> + /* Capacity read limit operation for RCID (closid) */
> + err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, type, closid);
> + if (err < 0) {
> + pr_err("%s(): operation failed: err = %d", __func__, err);
> + return resctrl_get_default_ctrl(r);
> + }
> +
> + /* Read capacity block mask for RCID (closid) */
> + reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> + reg = ioread64(ctrl->base + reg_offset);
> +
> + /* Update the config value for the closid in this domain */
> + hw_dom->ctrl_val[closid] = reg;
> + return hw_dom->ctrl_val[closid];
> +
> + case RDT_RESOURCE_MBA:
> + /* Capacity read limit operation for RCID (closid) */
> + err = cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid);
> + if (err < 0) {
> + pr_err("%s(): operation failed: err = %d", __func__, err);
> + return resctrl_get_default_ctrl(r);
> + }
> +
> + hw_dom->ctrl_val[closid] = cbqri_get_rbwb(ctrl);
> +
> + /* Convert from bandwidth blocks to percent */
> + rbwb = hw_dom->ctrl_val[closid];
> + rbwb *= 100;
> + percent = rbwb / ctrl->bc.nbwblks;
> + if (rbwb % ctrl->bc.nbwblks)

Same Question.

> + percent++;
> + return percent;
> +
> + default:
> + return resctrl_get_default_ctrl(r);
> + }
> +}

Sorry for my previous reply on old patch. Please ignore it. I’m re-sending this comment on v2.

Thank,
Wenjia





郭文佳10158971
