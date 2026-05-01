Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B7231827;
	Fri,  1 May 2026 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610725; cv=none; b=UV77BdE5M3271SR9JIR5rEOyG9njnJR6rTWaaofCyMxf6UqTpA9JGR7aOcWitOT2nMEDyVZQ0uphC9N6deizN6Lp/sBvnp6YCXWSoNvqBmp473WampfS9T8rrZ/9A1HdHhkXJiFlin1CU5F1XmFy22Yh3kGlKzYg0XgYY/FqJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610725; c=relaxed/simple;
	bh=0urt9bqbGp3y4rg3e1ksFahHj9pqpb5+cS/9lGfMSaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTvQesG76oS0qEuQ4oElCMkXVm8IGXnJld5B6h2A7y77i2eIagePhOXsLqiTy3XxbRg6KR/9UZyUVBMeEzm064tRVVZYG+nmPsLnDHKNomi0eJlGGDQCwun6COxcuVpJ/8EEqp96oet8UsH6EGUIufOW1F8ChlXxAVFT9X9BRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWME0HrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWME0HrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D3C2BCB7;
	Fri,  1 May 2026 04:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777610724;
	bh=0urt9bqbGp3y4rg3e1ksFahHj9pqpb5+cS/9lGfMSaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWME0HrS3+ZEPckX6tGyQtPb9xHhdBDN3q+ubDJmJc0Bih/PCJrsqizQtlxPBtWCF
	 sHZaYjKEbEkY/RS/x7ZytmU2iTneqz2bS6vpVUlbGw5p155eV1RtlQP6PRg5QnpnQo
	 Q4IphobPOyknjLvhiXir6NvcwdNDtoTwqbBT9h1KUqGo3g4NIvAI8LKqnTAn8By6Z/
	 XDp+VZ843+nTEfHigSg2wAqkxBO3pQTRZrMDcXiFVkWv4IexvL8zahxJympsqKuZtK
	 n7Km8CIWL+eKkFSRXc/8+cigobYlkT+NclXrtpidDd+1MoYCzxqqq3aEkC3NSyMTpJ
	 MVfmA/DXwSM9A==
Date: Thu, 30 Apr 2026 21:45:21 -0700
From: Drew Fustini <fustini@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH RFC v3 04/11] RISC-V: QoS: add CBQRI hardware interface
Message-ID: <afQv4dpMHUonDJcJ@x1>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
 <eeecb5df-64ee-46ef-b4a8-0f0cdc88f0ae@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeecb5df-64ee-46ef-b4a8-0f0cdc88f0ae@intel.com>

On Thu, Apr 30, 2026 at 04:15:05PM -0700, Reinette Chatre wrote:
> Hi Drew,
> 
> On 4/14/26 6:53 PM, Drew Fustini wrote:
> > diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> > new file mode 100644
> > index 000000000000..edbcbd9471b1
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos/internal.h
> 
> ...
> 
> > +
> > +struct cbqri_config {
> > +	u64 cbm; /* capacity block mask */
> > +	u64 rbwb; /* reserved bandwidth blocks */
> > +};
> 
> Is this struct necessary? From what I can tell it is used to pass a parameter to
> cbqri_apply_cache_config() and cbqri_apply_bw_config() where each just picks the
> one member of interest. Could parameter of interest just be provided directly to
> cbqri_apply_cache_config() and cbqri_apply_bw_config() without bouncing it
> through this struct first?

Agreed, the struct is unnecessary indirection. The two callers each
write one field and read it back immediately. I will drop it and pass
cbm / rbwb directly.

> > +
> > +#endif /* _ASM_RISCV_QOS_INTERNAL_H */
> > diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> > new file mode 100644
> > index 000000000000..6d294f2f2504
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> > @@ -0,0 +1,432 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#define pr_fmt(fmt) "qos: resctrl: " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/ioport.h>
> > +#include <linux/resctrl.h>
> > +#include <linux/riscv_qos.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +#include <asm/qos.h>
> > +#include "internal.h"
> > +
> > +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
> > +
> > +static bool exposed_alloc_capable;
> > +/* CDP (code data prioritization) on x86 is AT (access type) on RISC-V */
> > +static bool exposed_cdp_l2_capable;
> > +static bool exposed_cdp_l3_capable;
> > +static bool is_cdp_l2_enabled;
> > +static bool is_cdp_l3_enabled;
> 
> These CDP values could also be handled as part of struct cbqri_resctrl_res, similar
> to how CDP is managed with struct rdt_hw_resource. There does seem to be a hidden
> assumption in this implementation that if *any* cache controller at particular level
> supports CDP (which will cause global exposed_cdp_l{2,3}_capable to be true) then all cache
> controllers at that level are assumed to support CDP even though this property is
> enumerated separately for every cache controller making it possible for this
> support to not be uniform.
> 
> ...

Good point. This is fixed in v4 which I was about to send. The
controller-level cap is now stored on each controller as
cc.supports_alloc_at_code and cc.supports_alloc_at_data, and
cbqri_resctrl_pick_caches() rejects a heterogeneous-CDP set at the same
cache level. Therefore, resctrl never sees a global-capable bit that
some controllers cannot honour. I will take a look at folding this into
struct cbqri_resctrl_res to make it simpler.

> > +/* Perform capacity allocation control operation on capacity controller */
> > +static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation, int rcid,
> > +			     enum resctrl_conf_type type)
> > +{
> > +	int reg_offset = CBQRI_CC_ALLOC_CTL_OFF;
> > +	int status;
> > +	u64 reg;
> > +
> > +	reg = ioread64(ctrl->base + reg_offset);
> > +	reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> > +	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> > +	reg &= ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
> > +	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
> > +
> > +	/* CBQRI capacity AT is only supported on L2 and L3 caches for now */
> > +	if (ctrl->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&
> > +	    ((ctrl->cache.cache_level == 2 && is_cdp_l2_enabled) ||
> > +	    (ctrl->cache.cache_level == 3 && is_cdp_l3_enabled))) {
> > +		reg &= ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> > +		switch (type) {
> > +		case CDP_CODE:
> > +			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> > +					  CBQRI_CONTROL_REGISTERS_AT_CODE);
> > +			break;
> > +		case CDP_DATA:
> > +		default:
> > +			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> > +					  CBQRI_CONTROL_REGISTERS_AT_DATA);
> > +			break;
> > +		}
> > +	}
> 
> There does not seem to be any special enabling when resctrl enables CDP via
> resctrl_arch_set_cdp_enabled() so I assume CDP is always enabled? Does that mean
> that when CDP is disabled from resctrl perspective (thus, both is_cdp_l2_enabled
> and is_cdp_l3_enabled are false, but exposed_cdp_l2_capable and exposed_cdp_l3_capable
> are true) then the default behavior is that allocation applies to both code and data
> and it is not necessary to set both CBQRI_CONTROL_REGISTERS_AT_CODE and
> CBQRI_CONTROL_REGISTERS_AT_DATA?

Good question. I think this is a bug. resctrl_arch_set_cdp_enabled() is
implemented in v4 and toggles the is_cdp_l{2,3}_enabled flags. When CDP
is disabled, the AT field is left at 0 in cbqri_cc_alloc_op(). But BQRI
encodes AT=0 as data, so it only programs the data config and silently
leaves code config at whatever the hardware default is.

The fix would be to issue two CONFIG_LIMIT ops, AT=data and AT=code, for
the same cbm when supports_alloc_at_code is true and CDP is disabled.
Thanks for catching this.

[..]
> > +	/*
> > +	 * max_rmid is used by resctrl_arch_system_num_rmid_idx()
> > +	 * Find the smallest mcid_count amongst all controllers.
> > +	 */
> > +	max_rmid = min(max_rmid, ctrl->mcid_count);
> 
> This computation appears to include all controllers, whether they support monitoring or not.
> What will ctrl->mcid_count be on a controller that does not support monitoring?

Good catch. I will gate the minimum on ctrl->mon_capable.

Thanks,
Drew
