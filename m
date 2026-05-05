Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9B346E46
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956245; cv=pass; b=KKg2G7kNDY+BY2XaLndkmFDDlNhquOg1MmZHONVDca9n8bgmKpMUnRLcwZn4eRdWKquG5uDbw5S9m5AoL1YX5wsPK+RDQpxIPBhikHc08Ogg9VUv/e+Vw4OcJkEOg0XhFcXbJ+LMhgIcwYj/0YgoACrVLbOla9iH3Ru2rU+qHII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956245; c=relaxed/simple;
	bh=kL1aVLYS3I0g52inbTT0LTuylr5L6m0FkhAXhpc6gYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teEfyDzAXkOd/ZGDPTkmcnGAb90LGo9XUmDWQw82kLfVbijcD/7u9RsMccWfnLlZGKW9JUeVGSgrt0MIFFF3xku2lMtEg8yd+991equzRDSBDjEI7d8kXWdBWbG2lf/WaKA78+O6sCHPrZGLo6/PEWLB1BzD4SxMVackIVOxPZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VHKttfgU; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VHKttfgU"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47cbd444fd0so762320b6e.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 21:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777956242; cv=none;
        d=google.com; s=arc-20240605;
        b=EYjD1yjUgm1gqVCDRZ90/Qz/nSI+2PwWJ/XuFFoPmMY6ulW2mejoFxnJqqYJXDnLzX
         wLAuq0dMPW6HaEat2f/5rPZouuRy0nogcpzHwvvT9mmdLriWVad6H8hwCbeeNoHeaBcy
         vZjh+Ttxu0x2C42ZnwU7LLc8SRNpr83yWkKrEumhAP5cKt2XU+AhOLxlO7NYqc2UKhVK
         g88HKCXgiXCtzgMFK9cotGdUTE0TauQM71JPln0A080p6L7PAd1qIrOSH0REMw57dWW+
         D/zGmiRbHotI2xglZFzZQve5CDF4qjUgk2Mu3XbXe66wrhGlYJMWskCm1GETyZaRV8q3
         aZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0dr/GoCls3mdoSP87F22ugMi/si1hLktDUJmNHHS5k=;
        fh=+tHBvmQURY6GvDEtanI7sxcMk9PFKSPbLSsqOJoRJEA=;
        b=ZQajtTM4qk2e8eVJMabIr3rxRHEUB0oeFKptysN4AxNBPAA6obxCszrceE8gEiRxPm
         Ht4Aiw8UxICq5K5AFQy2hKTRR5hCu84O1i23loULH6dVTJwB0q7fWHPd9jsr4B+vtfJS
         kigoaM7nuLolrO6sZIDIHHpwMPgsVAtJNLOBU07IMI+aT53E0/MXPdqqqZUqDVPF07Kv
         kfd4P0A1tj02ceoeaO2M6A6fel9zpB/E60MUV0IgDpJO9mSzdS58t12WGshhXl8bHv2T
         JDihyGN1Tv3wUNiRfcIsccgmYqUAI/jjexZREFFejHqXOjhf7j5VvrONOeQHiEzoJJSw
         zxGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777956242; x=1778561042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0dr/GoCls3mdoSP87F22ugMi/si1hLktDUJmNHHS5k=;
        b=VHKttfgUL23M5njjvJjGXLO7kBvgg/92b/1zhyR2KoyGpOZhysKR6IOntyXV6cdvKm
         KpmRy7hYj8Bbv7iNgdQ4cneLHr1nyKInAh9pnUlyenfBdSJUR0Eklre+ZYJQIOSve0vF
         pHY1EYJ2xOayP8kmjX8wbnN29LHQKIOgB3ZeFaIdYhv6BNUCUC3tItJMWBEyplouqH9J
         zGkOgdZkKwNkhqmNRcnVrUIZQIdoSYOfJAnA9LfRgAXxNYZL1NheV4s7/Ip+VD3Erslh
         iAx+nRpaABgJEysUUACjQCoPUaxOBSUjW4LzsXr8QwpbIHEeFLECmir4W2O5rugkgxWo
         23xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956242; x=1778561042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0dr/GoCls3mdoSP87F22ugMi/si1hLktDUJmNHHS5k=;
        b=MDJiIQdzfZ+IC6HmzENnzx/oWqDWAHbPBgKAt4D9JdqgjRfjZcvJCAfU7GLOuTQl93
         Sxj77QVK9Woba8HjIQpQYfC+9AYREdn3nBJDQQmemM7mtVNspty/4tfmpcdaxzb3y1Gy
         USuosdnRo4OHMn1l8jKnoXaomjiWxXXY1Q10PylrIAp1+Fc9gr/sBj+JFwl0+X71DLI5
         9JCO0KTGoTUR8mWAI9vHTU2hHe4GfW8KJMO6t1ukSdXrzqeLWMqu8dNvAHEt1TXeQuwT
         nSe/wiEbJwpqpjbTKjYH2Nmy2gMDpB7ao2RQCoRXOEfItDFCLu7LHefdGPluX9aUHEDU
         szyw==
X-Forwarded-Encrypted: i=1; AFNElJ/PydSKdjf2/uFLPu1ndn+toZ3f9ryMU1R0hxNBCR0dEUqmFMuugGZuRSn677SZywpW2iKoNo/zVgjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOZjxKUrok2xzyc3C6De97FXSxZ5Duh4icdM2HYSkk7eCdH/z
	0LrEj54Cc00Vyfmhf4ZZHz58nl3B8vxuQqABXNg5FQdR/t/AKhJf9E6KLlO8Jw2nQHCt6S78uuD
	gLHgXz9n3wpxZzggeCsConIEvYaiZ9y4AG5vs2fX3JA==
X-Gm-Gg: AeBDietXulmagj+RYPsMm+eYyK+qpOLnKH/lK+c9GgPxFlw+XuFMiPrm8BzwiQ4ehxT
	Sa7dF2Lfb9se8kr+gtaF0kTpkt33mUu6sx7REPdCH59AP+8I3NaASsyNiniyp0vMUlWV1YNWx6z
	QMhgZgSmY0welCtlj3qcmxbbJb8BpmdTWgSH+Y2sPqzb8LdoqFvyvwHSoeX2Fuq4Bv0YtJaWs/p
	XG1EqehFUJi9hee0Pl40meN3nIu6I8AJ8BlvVREdnX/iomJpKu8f7/OJo5QtQkAxJwnIx+WcWnz
	hPQFrkh1XBuEXAe2TA==
X-Received: by 2002:a05:6808:1787:b0:463:c56f:a45b with SMTP id
 5614622812f47-47c89278598mr6149400b6e.28.1777956241520; Mon, 04 May 2026
 21:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org> <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 5 May 2026 12:43:46 +0800
X-Gm-Features: AVHnY4JDo5TOygkhxu1cNu9895DnVgYp2hsOMIszIrebr2MLdn7QcIxT2PPZiEM
Message-ID: <CAEEQ3wmkSyThakHy=fe-uNAZbzGaSM=avsqdgcZ2ZTkPNvCkMA@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v3 04/11] RISC-V: QoS: add CBQRI hardware interface
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Chen Pei <cp0613@linux.alibaba.com>, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
	guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Apr 15, 2026 at 9:57=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add the CBQRI controller hardware interface layer.
>
> Define data structures representing CBQRI controller properties
> (cbqri_controller) and hardware capabilities for capacity and bandwidth
> controllers (riscv_cbqri_capacity_caps, riscv_cbqri_bandwidth_caps) in
> include/linux/riscv_qos.h.
>
> Define MMIO register offsets, field masks, and internal wrapper structs
> (cbqri_resctrl_res, cbqri_resctrl_dom, cbqri_config) in internal.h.
>
> Implement MMIO helpers for capacity block mask and bandwidth reservation,
> alloc control operations for capacity and bandwidth controllers, and
> probe functions to discover controller capabilities. A per-controller
> spinlock serializes multi-step MMIO sequences.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                         |   1 +
>  arch/riscv/kernel/qos/internal.h    |  81 +++++++
>  arch/riscv/kernel/qos/qos_resctrl.c | 432 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/riscv_qos.h           |  76 +++++++
>  4 files changed, 590 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b17f885411ba..6a66d7047c51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22785,6 +22785,7 @@ L:      linux-riscv@lists.infradead.org
>  S:     Supported
>  F:     arch/riscv/include/asm/qos.h
>  F:     arch/riscv/kernel/qos/
> +F:     include/linux/riscv_qos.h
>
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/int=
ernal.h
> new file mode 100644
> index 000000000000..edbcbd9471b1
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/internal.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_QOS_INTERNAL_H
> +#define _ASM_RISCV_QOS_INTERNAL_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/resctrl.h>
> +#include <linux/riscv_qos.h>
> +
> +#define RISCV_RESCTRL_EMPTY_CLOSID     ((u32)~0)
> +
> +#define CBQRI_CC_CAPABILITIES_OFF 0
> +#define CBQRI_CC_MON_CTL_OFF      8
> +#define CBQRI_CC_MON_CTL_VAL_OFF 16
> +#define CBQRI_CC_ALLOC_CTL_OFF   24
> +#define CBQRI_CC_BLOCK_MASK_OFF  32
> +
> +#define CBQRI_BC_CAPABILITIES_OFF 0
> +#define CBQRI_BC_MON_CTL_OFF      8
> +#define CBQRI_BC_MON_CTR_VAL_OFF 16
> +#define CBQRI_BC_ALLOC_CTL_OFF   24
> +#define CBQRI_BC_BW_ALLOC_OFF    32
> +
> +#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
> +#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
> +
> +#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK  GENMASK(23, 8)
> +#define CBQRI_CC_CAPABILITIES_FRCID_MASK   GENMASK(24, 24)
> +
> +#define CBQRI_BC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
> +#define CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
> +
> +#define CBQRI_BC_CAPABILITIES_NBWBLKS_MASK  GENMASK(23, 8)
> +#define CBQRI_BC_CAPABILITIES_MRBWB_MASK    GENMASK_ULL(47, 32)
> +
> +#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK(4, 0)
> +#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK(7, 5)
> +#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
> +#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
> +#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK(19, 8)
> +#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
> +#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
> +#define CBQRI_CONTROL_REGISTERS_RBWB_MASK    GENMASK(15, 0)
> +
> +#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
> +#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
> +#define CBQRI_CC_MON_CTL_STATUS_SUCCESS  1
> +
> +#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
> +#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
> +#define CBQRI_CC_ALLOC_CTL_OP_FLUSH_RCID   3
> +#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
> +
> +#define CBQRI_BC_MON_CTL_OP_CONFIG_EVENT 1
> +#define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
> +#define CBQRI_BC_MON_CTL_STATUS_SUCCESS  1
> +
> +#define CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT 1
> +#define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
> +#define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
> +
> +int qos_resctrl_setup(void);
> +int qos_resctrl_online_cpu(unsigned int cpu);
> +int qos_resctrl_offline_cpu(unsigned int cpu);
> +
> +struct cbqri_resctrl_res {
> +       struct rdt_resource     resctrl_res;
> +       u32 max_rcid;
> +       u32 max_mcid;
> +};
> +
> +struct cbqri_resctrl_dom {
> +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +       struct cbqri_controller *hw_ctrl;
> +};
> +
> +struct cbqri_config {
> +       u64 cbm; /* capacity block mask */
> +       u64 rbwb; /* reserved bandwidth blocks */
> +};
> +
> +#endif /* _ASM_RISCV_QOS_INTERNAL_H */
> diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/=
qos_resctrl.c
> new file mode 100644
> index 000000000000..6d294f2f2504
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "qos: resctrl: " fmt
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/resctrl.h>
> +#include <linux/riscv_qos.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +#include "internal.h"
> +
> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCE=
S];
> +
> +static bool exposed_alloc_capable;
> +/* CDP (code data prioritization) on x86 is AT (access type) on RISC-V *=
/
> +static bool exposed_cdp_l2_capable;
> +static bool exposed_cdp_l3_capable;
> +static bool is_cdp_l2_enabled;
> +static bool is_cdp_l3_enabled;
> +
> +/* used by resctrl_arch_system_num_rmid_idx() */
> +static u32 max_rmid;
> +
> +LIST_HEAD(cbqri_controllers);
> +
> +static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_o=
ffset,
> +                               u64 *regp);
> +
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +       iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +}

 CBQRI capacity limits appear to include both cc_block_mask and
cc_cunits, but only cc_block_mask seems to be modeled here. How is
cc_cunits expected to be handled?

> +
> +/* Set the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
> +static void cbqri_set_rbwb(struct cbqri_controller *ctrl, u64 rbwb)
> +{
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_RBWB_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_RBWB_MASK, rbwb);
> +       iowrite64(reg, ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
> +}
> +
> +/* Get the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
> +static u64 cbqri_get_rbwb(struct cbqri_controller *ctrl)
> +{
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
> +       return FIELD_GET(CBQRI_CONTROL_REGISTERS_RBWB_MASK, reg);
> +}
> +
> +static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_o=
ffset,
> +                               u64 *regp)
> +{
> +       u64 reg;
> +       int ret;
> +
> +       ret =3D readq_poll_timeout_atomic(ctrl->base + reg_offset, reg,
> +                                       !FIELD_GET(CBQRI_CONTROL_REGISTER=
S_BUSY_MASK, reg),
> +                                       0, 1000);
> +       if (!ret && regp)
> +               *regp =3D reg;
> +
> +       return ret;
> +}
> +
> +/* Perform capacity allocation control operation on capacity controller =
*/
> +static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operatio=
n, int rcid,
> +                            enum resctrl_conf_type type)
> +{
> +       int reg_offset =3D CBQRI_CC_ALLOC_CTL_OFF;
> +       int status;
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
> +
> +       /* CBQRI capacity AT is only supported on L2 and L3 caches for no=
w */
> +       if (ctrl->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY &&
> +           ((ctrl->cache.cache_level =3D=3D 2 && is_cdp_l2_enabled) ||
> +           (ctrl->cache.cache_level =3D=3D 3 && is_cdp_l3_enabled))) {
> +               reg &=3D ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> +               switch (type) {
> +               case CDP_CODE:
> +                       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MA=
SK,
> +                                         CBQRI_CONTROL_REGISTERS_AT_CODE=
);
> +                       break;
> +               case CDP_DATA:
> +               default:
> +                       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MA=
SK,
> +                                         CBQRI_CONTROL_REGISTERS_AT_DATA=
);
> +                       break;
> +               }
> +       }
> +
> +       iowrite64(reg, ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation\n=
", __func__);
> +               return -EIO;
> +       }
> +
> +       status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +       if (status !=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
> +               pr_err("%s(): operation %d failed: status=3D%d\n", __func=
__, operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Write a capacity block mask and verify the hardware accepted it by
> + * reading back the value after a CONFIG_LIMIT + READ_LIMIT sequence.
> + */
> +static int cbqri_apply_cache_config(struct cbqri_resctrl_dom *hw_dom, u3=
2 closid,
> +                                   enum resctrl_conf_type type, struct c=
bqri_config *cfg)
> +{
> +       struct cbqri_controller *ctrl =3D hw_dom->hw_ctrl;
> +       int err =3D 0;
> +       u64 reg;
> +
> +       spin_lock(&ctrl->lock);
> +
> +       /* Set capacity block mask (cc_block_mask) */
> +       cbqri_set_cbm(ctrl, cfg->cbm);
> +
> +       /* Capacity config limit operation */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMI=
T, closid, type);
> +       if (err < 0) {
> +               pr_err("%s(): operation failed: err =3D %d\n", __func__, =
err);
> +               goto out;
> +       }
> +
> +       /* Clear cc_block_mask before read limit to verify op works */
> +       cbqri_set_cbm(ctrl, 0);
> +
> +       /* Perform a capacity read limit operation to verify blockmask */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,=
 closid, type);
> +       if (err < 0) {
> +               pr_err("%s(): operation failed: err =3D %d\n", __func__, =
err);
> +               goto out;
> +       }
> +
> +       /* Read capacity blockmask to verify it matches the requested con=
fig */
> +       reg =3D ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +       if (reg !=3D cfg->cbm) {
> +               pr_err("%s(): failed to verify allocation (reg:%llx !=3D =
cbm:%llx)\n",
> +                      __func__, reg, cfg->cbm);
> +               err =3D -EIO;
> +       }
> +
> +out:
> +       spin_unlock(&ctrl->lock);
> +       return err;
> +}
> +
> +/* Perform bandwidth allocation control operation on bandwidth controlle=
r */
> +static int cbqri_bc_alloc_op(struct cbqri_controller *ctrl, int operatio=
n, int rcid)
> +{
> +       int reg_offset =3D CBQRI_BC_ALLOC_CTL_OFF;
> +       int status;
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
> +       iowrite64(reg, ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation\n=
", __func__);
> +               return -EIO;
> +       }
> +
> +       status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +       if (status !=3D CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
> +               pr_err("%s(): operation %d failed with status =3D %d\n",
> +                      __func__, operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Write a bandwidth reservation and verify the hardware accepted it by
> + * reading back the value after a CONFIG_LIMIT + READ_LIMIT sequence.
> + */
> +static int cbqri_apply_bw_config(struct cbqri_resctrl_dom *hw_dom, u32 c=
losid,
> +                                enum resctrl_conf_type type, struct cbqr=
i_config *cfg)
> +{
> +       struct cbqri_controller *ctrl =3D hw_dom->hw_ctrl;
> +       int ret =3D 0;
> +       u64 reg;
> +
> +       spin_lock(&ctrl->lock);
> +
> +       /* Set reserved bandwidth blocks */
> +       cbqri_set_rbwb(ctrl, cfg->rbwb);
> +
> +       /* Bandwidth config limit operation */
> +       ret =3D cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMI=
T, closid);
> +       if (ret < 0) {
> +               pr_err("%s(): operation failed: ret =3D %d\n", __func__, =
ret);
> +               goto out;
> +       }
> +
> +       /* Clear rbwb before read limit to verify op works */
> +       cbqri_set_rbwb(ctrl, 0);
> +
> +       /* Bandwidth allocation read limit operation to verify */
> +       ret =3D cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT,=
 closid);
> +       if (ret < 0)
> +               goto out;
> +
> +       /* Read bandwidth allocation to verify it matches the requested c=
onfig */
> +       reg =3D cbqri_get_rbwb(ctrl);
> +       if (reg !=3D cfg->rbwb) {
> +               pr_err("%s(): failed to verify allocation (reg:%llx !=3D =
rbwb:%llu)\n",
> +                      __func__, reg, cfg->rbwb);
> +               ret =3D -EIO;
> +       }
> +
> +out:
> +       spin_unlock(&ctrl->lock);
> +       return ret;
> +}
> +
> +static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_of=
fset,
> +                              int operation, int *status, bool *access_t=
ype_supported)
> +{
> +       u64 reg, saved_reg;
> +       int at;
> +
> +       /* Keep the initial register value to preserve the WPRI fields */
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       saved_reg =3D reg;
> +
> +       /* Execute the requested operation to find if the register is imp=
lemented */
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +       reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +       iowrite64(reg, ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation\n=
", __func__);
> +               return -EIO;
> +       }
> +
> +       /* Get the operation status */
> +       *status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +
> +       /*
> +        * Check for the AT support if the register is implemented
> +        * (if not, the status value will remain 0)
> +        */
> +       if (*status !=3D 0) {
> +               /* Set the AT field to a valid value */
> +               reg =3D saved_reg;
> +               reg &=3D ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> +               reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> +                                 CBQRI_CONTROL_REGISTERS_AT_CODE);
> +               iowrite64(reg, ctrl->base + reg_offset);
> +               if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +                       pr_err("%s(): BUSY timeout when setting AT field\=
n", __func__);
> +                       return -EIO;
> +               }
> +
> +               /*
> +                * If the AT field value has been reset to zero,
> +                * then the AT support is not present
> +                */
> +               at =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
> +               if (at =3D=3D CBQRI_CONTROL_REGISTERS_AT_CODE)
> +                       *access_type_supported =3D true;
> +               else
> +                       *access_type_supported =3D false;
> +       }
> +
> +       /* Restore the original register value */
> +       iowrite64(saved_reg, ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, NULL) < 0) {
> +               pr_err("%s(): BUSY timeout when restoring the original re=
gister value\n", __func__);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_cc(struct cbqri_controller *ctrl)
> +{
> +       int err, status;
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
> +       if (reg =3D=3D 0)
> +               return -ENODEV;
> +
> +       ctrl->ver_minor =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MAS=
K, reg);
> +       ctrl->ver_major =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MAS=
K, reg);
> +       ctrl->cc.supports_alloc_op_flush_rcid =3D
> +               FIELD_GET(CBQRI_CC_CAPABILITIES_FRCID_MASK, reg);
> +       ctrl->cc.ncblks =3D FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, =
reg);
> +
> +       pr_debug("version=3D%d.%d ncblks=3D%d cache_level=3D%d\n",
> +                ctrl->ver_major, ctrl->ver_minor,
> +                ctrl->cc.ncblks, ctrl->cache.cache_level);
> +
> +       /* Probe allocation features (monitoring not yet implemented) */
> +       err =3D cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
> +                                 CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +                                 &status, &ctrl->cc.supports_alloc_at_co=
de);
> +       if (err)
> +               return err;
> +
> +       if (status =3D=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
> +               ctrl->alloc_capable =3D true;
> +               exposed_alloc_capable =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_bc(struct cbqri_controller *ctrl)
> +{
> +       int err, status;
> +       u64 reg;
> +
> +       reg =3D ioread64(ctrl->base + CBQRI_BC_CAPABILITIES_OFF);
> +       if (reg =3D=3D 0)
> +               return -ENODEV;
> +
> +       ctrl->ver_minor =3D FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MINOR_MAS=
K, reg);
> +       ctrl->ver_major =3D FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MAJOR_MAS=
K, reg);
> +       ctrl->bc.nbwblks =3D FIELD_GET(CBQRI_BC_CAPABILITIES_NBWBLKS_MASK=
, reg);
> +       ctrl->bc.mrbwb =3D FIELD_GET(CBQRI_BC_CAPABILITIES_MRBWB_MASK, re=
g);
> +
> +       if (!ctrl->bc.nbwblks) {
> +               pr_err("bandwidth controller has nbwblks=3D0\n");
> +               return -EINVAL;
> +       }
> +
> +       pr_debug("version=3D%d.%d nbwblks=3D%d mrbwb=3D%d\n",
> +                ctrl->ver_major, ctrl->ver_minor,
> +                ctrl->bc.nbwblks, ctrl->bc.mrbwb);
> +
> +       /* Probe allocation features (monitoring not yet implemented) */
> +       err =3D cbqri_probe_feature(ctrl, CBQRI_BC_ALLOC_CTL_OFF,
> +                                 CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT,
> +                                 &status, &ctrl->bc.supports_alloc_at_co=
de);
> +       if (err)
> +               return err;
> +
> +       if (status =3D=3D CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
> +               ctrl->alloc_capable =3D true;
> +               exposed_alloc_capable =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_controller(struct cbqri_controller *ctrl)
> +{
> +       int err;
> +
> +       pr_debug("controller info: type=3D%d addr=3D%pa size=3D%pa max-rc=
id=3D%u max-mcid=3D%u\n",
> +                ctrl->type, &ctrl->addr, &ctrl->size,
> +                ctrl->rcid_count, ctrl->mcid_count);
> +
> +       if (!ctrl->addr) {
> +               pr_warn("%s(): controller has invalid addr=3D0x0, skippin=
g\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller=
")) {
> +               pr_err("%s(): request_mem_region failed for %pa\n",
> +                      __func__, &ctrl->addr);
> +               return -EBUSY;
> +       }
> +
> +       ctrl->base =3D ioremap(ctrl->addr, ctrl->size);
> +       if (!ctrl->base) {
> +               pr_err("%s(): ioremap failed for %pa\n", __func__, &ctrl-=
>addr);
> +               err =3D -ENOMEM;
> +               goto err_release;
> +       }
> +
> +       spin_lock_init(&ctrl->lock);
> +
> +       switch (ctrl->type) {
> +       case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +               err =3D cbqri_probe_cc(ctrl);
> +               break;
> +       case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
> +               err =3D cbqri_probe_bc(ctrl);
> +               break;
> +       default:
> +               pr_err("unknown controller type %d\n", ctrl->type);
> +               err =3D -ENODEV;
> +               break;
> +       }
> +
> +       if (err)
> +               goto err_iounmap;
> +
> +       /*
> +        * max_rmid is used by resctrl_arch_system_num_rmid_idx()
> +        * Find the smallest mcid_count amongst all controllers.
> +        */
> +       max_rmid =3D min(max_rmid, ctrl->mcid_count);
> +
> +       return 0;
> +
> +err_iounmap:
> +       iounmap(ctrl->base);
> +       ctrl->base =3D NULL;
> +err_release:
> +       release_mem_region(ctrl->addr, ctrl->size);
> +       return err;
> +}
> diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
> new file mode 100644
> index 000000000000..0f3daae2e84f
> --- /dev/null
> +++ b/include/linux/riscv_qos.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __LINUX_RISCV_QOS_H
> +#define __LINUX_RISCV_QOS_H
> +
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <asm/qos.h>
> +
> +enum cbqri_controller_type {
> +       CBQRI_CONTROLLER_TYPE_CAPACITY,
> +       CBQRI_CONTROLLER_TYPE_BANDWIDTH,
> +       CBQRI_CONTROLLER_TYPE_UNKNOWN
> +};
> +
> +/* Capacity Controller hardware capabilities */
> +struct riscv_cbqri_capacity_caps {
> +       u16 ncblks; /* number of capacity blocks */
> +
> +       bool supports_alloc_at_code;
> +       bool supports_alloc_op_flush_rcid;
> +};
> +
> +/* Bandwidth Controller hardware capabilities */
> +struct riscv_cbqri_bandwidth_caps {
> +       u16 nbwblks; /* number of bandwidth blocks */
> +       u16 mrbwb;   /* max reserved bw blocks */
> +
> +       bool supports_alloc_at_code;
> +};
> +
> +struct cbqri_controller {
> +       void __iomem *base;
> +       /*
> +        * Protects multi-step MMIO register sequences on this controller=
.
> +        * CBQRI operations (e.g. CONFIG_LIMIT, READ_LIMIT) require writi=
ng
> +        * an operation register, waiting for the busy flag to clear, the=
n
> +        * reading back the result. These sequences must be atomic per
> +        * controller to prevent interleaving.
> +        */
> +       spinlock_t lock;
> +
> +       int ver_major;
> +       int ver_minor;
> +
> +       struct riscv_cbqri_bandwidth_caps bc;
> +       struct riscv_cbqri_capacity_caps cc;
> +
> +       bool alloc_capable;
> +
> +       phys_addr_t addr;
> +       phys_addr_t size;
> +       enum cbqri_controller_type type;
> +       u32 rcid_count;
> +       u32 mcid_count;
> +       struct list_head list;
> +
> +       struct cache_controller {
> +               u32 cache_level;
> +               u32 cache_size; /* in bytes */
> +               struct cpumask cpu_mask;
> +               /* Unique Cache ID from the PPTT table's Cache Type Struc=
ture */
> +               u32 cache_id;
> +       } cache;
> +
> +       struct mem_controller {
> +               /* Proximity Domain from SRAT table Memory Affinity Contr=
oller */
> +               u32 prox_dom;
> +               struct cpumask cpu_mask;
> +       } mem;
> +};
> +
> +extern struct list_head cbqri_controllers;
> +
> +#endif /* __LINUX_RISCV_QOS_H */
>
> --
> 2.43.0
>

Thanks,
Yunhui
