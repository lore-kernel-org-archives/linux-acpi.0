Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E21F4C8C;
	Sat, 18 Apr 2026 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472149; cv=none; b=QD2RyYLkixV8pBDAYzJp/WV9i7oZLO1MORrjaEH5Djvp/520D4DA5TMRUiJ0qOilQdfMnL3qtu0Z/2RiHvKU2CYBZeCky5BLwnOobCkiw+cpwcT+JToviEqeviyANwkx8zeEaN5EkQUv09wCRoBSWvhaFjiwBFUtqYTQbSgk0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472149; c=relaxed/simple;
	bh=5XfkxBgRZw1G4iOWjC/UNxOQcOsxLiT6whw9IzG3hBo=;
	h=Message-Id:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=bv+t3SXJsMFp074guZjA48sjcN6tuxBj04VIfqHvksqICgWgqD3iDiL4K3NJoT7dB1UCOeu25MSGDMAxggFpSKmnB55Utj/yD/rJwmBrRJJH6J0Z/mnISEdEvp14GP5kGkwQtOpyY45vCp/EIl3uVjG7qAsSXT726eDzQR5fJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fyCKk72ghz8Xs6Q;
	Sat, 18 Apr 2026 08:28:58 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 63I0Svo8029922;
	Sat, 18 Apr 2026 08:28:57 +0800 (+08)
	(envelope-from guo.wenjia23@zte.com.cn)
Message-Id: <202604180028.63I0Svo8029922@mse-fl1.zte.com.cn>
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl1.zte.com.cn with SMTP id 63HAqPVX032987;
	Fri, 17 Apr 2026 18:52:25 +0800 (+08)
	(envelope-from guo.wenjia23@zte.com.cn)
Received: from mapi (njy2app02[null])
	by mapi (Zmail) with MAPI id mid202;
	Fri, 17 Apr 2026 18:52:27 +0800 (CST)
X-Zmail-TransId: 2afa69e210ebfc0-fc690
X-Mailer: Zmail v1.0
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org>
References: 20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org,20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org
Date: Fri, 17 Apr 2026 18:52:27 +0800 (CST)
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
        <conor.dooley@microchip.com>, <cuiyunhui@bytedance.com>,
        <cp0613@linux.alibaba.com>, <zhiwei_liu@linux.alibaba.com>,
        <liwei1518@gmail.com>, <gong.shuai@sanechips.com.cn>,
        <gsh517@gmail.com>, <liu.qingtao2@zte.com.cn>,
        <reinette.chatre@intel.com>, <tony.luck@intel.com>,
        <babu.moger@amd.com>, <peternewman@google.com>, <fenghua.yu@intel.com>,
        <james.morse@arm.com>, <ben.horgan@arm.com>, <Dave.Martin@arm.com>,
        <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <sunilvl@ventanamicro.com>, <fustini@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <paul.walmsley@sifive.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRkMgdjMgMDYvMTFdIFJJU0MtVjogUW9TOiBhZGQgcmVzY3RybCBzZXR1cCBhbmQgZG9tYWluIG1hbmFnZW1lbnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 63I0Svo8029922
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: guo.wenjia23@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 18 Apr 2026 08:28:59 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69E2D04A.002/4fyCKk72ghz8Xs6Q

Hi Drew,

On Wed, Apr 15, 2026 at 9:57 AM Drew Fustini <fustini@kernel.org> wrote:

> Add the setup and domain management layer: domain allocation
> (qos_new_domain), controller value initialization
> (qos_init_domain_ctrlval), resource struct initialization for cache and
> bandwidth resources, domain registration with the resctrl filesystem
> (qos_resctrl_add_controller_domain), and the top-level setup function
> (qos_resctrl_setup) that probes all controllers and calls resctrl_init().
>
> Also add qos_resctrl_online_cpu() and qos_resctrl_offline_cpu() for CPU
> hotplug integration.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  arch/riscv/kernel/qos/qos_resctrl.c | 295 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> index a4a120f89840..8d7e3b0abb75 100644
> --- a/arch/riscv/kernel/qos/qos_resctrl.c
> +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> @@ -675,7 +675,23 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domai
>  
>  void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
>  {
> -    /* not implemented for the RISC-V resctrl implementation */
> +    struct cbqri_resctrl_res *hw_res;
> +    struct rdt_ctrl_domain *d;
> +    enum resctrl_conf_type t;
> +    u32 default_ctrl;
> +    int i;
> +
> +    lockdep_assert_cpus_held();
> +
> +    hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
> +    default_ctrl = resctrl_get_default_ctrl(r);
> +
> +    list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +        for (i = 0; i < hw_res->max_rcid; i++) {
> +            for (t = 0; t < CDP_NUM_TYPES; t++)
> +                resctrl_arch_update_one(r, d, i, t, default_ctrl);

For the bw controller, default_ctrl = max_bw, and resctrl_arch_update_one will set the rbwb of all RCIDs to max_bw. 
According to the spec: The sum of Rbwb allocated across all rcids must not exceed MRBWB value. 

Does this conflict with the spec?

> +        }
> +    }
>  }
>  
>  void resctrl_arch_pre_mount(void)
> @@ -797,3 +813,280 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>      spin_unlock(&ctrl->lock);
>      return val;
>  }
> +
> +static struct rdt_ctrl_domain *qos_new_domain(struct cbqri_controller *ctrl)
> +{
> +    struct cbqri_resctrl_dom *hw_dom;
> +    struct rdt_ctrl_domain *domain;
> +
> +    hw_dom = kzalloc_obj(*hw_dom, GFP_KERNEL);
> +    if (!hw_dom)
> +        return NULL;
> +
> +    /* associate this cbqri_controller with the domain */
> +    hw_dom->hw_ctrl = ctrl;
> +
> +    /* the rdt_domain struct from inside the cbqri_resctrl_dom struct */
> +    domain = &hw_dom->resctrl_ctrl_dom;
> +
> +    INIT_LIST_HEAD(&domain->hdr.list);
> +
> +    return domain;
> +}
> +
> +static int qos_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
> +{
> +    struct cbqri_resctrl_res *hw_res;
> +    int err = 0;
> +    int i;
> +
> +    hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
> +
> +    for (i = 0; i < hw_res->max_rcid; i++) {
> +        err = resctrl_arch_update_one(r, d, i, 0, resctrl_get_default_ctrl(r));

Also set rbwb of all RCIDs to max_bw. Does this also conflict with the spec?

> +        if (err)
> +            return err;
> +    }
> +    return 0;
> +}
> +


Thanks,
Wenjia
