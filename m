Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991111DE894
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404556; cv=pass; b=PQjNSnulpKK2P1WZ1P0JyNGO4A6W47lcpWr5wyyu2YNUjqBQ8V9ZujC6g2JRQIxF1kZdMP1FlGcZT20We5S/YfUCQVzcylVJXmOwCHnA9/iL+sbe/vttLmTtNQeGM2agRFQQowZVsLW2nzUerjS7UxhQz/MSB6xo6+l96ubae6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404556; c=relaxed/simple;
	bh=+iTn7rktHrpY5kkmnxRHPfGIOBYUcAxX8321/D3aLfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBx+X8R1IAM4RW4t8KT+P9dXkue22f36w/vBpGdDiIY71/h5e7NWz1+i4zBp8unZgo8EFXZUxw/uEOnUOsyVFN/ORImzq70DWrYDcQRYZoDjvAQPY8F5jraYuqDPin32AFFRvaFcZ7i1A5IHDbwisumAuCc4BpFTMQNBXTRl/H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QV7RdIrX; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QV7RdIrX"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7447778b9so2350971a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 19:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774404552; cv=none;
        d=google.com; s=arc-20240605;
        b=ZR/Nk+x5RAyPa6FoLThMbo+Hl9KsUqzdqYFKB9sXaR+l3tDxotVTxEP9nbu4rUTqd7
         3H+pH94LXviPKRDFIbXuidhlbsJNCrhx8BD+BYXKmpr4l8ilqNJ8V+/Lxy9B4ClDfu0Y
         NMLDsBrfQnFGaO1kR2dlbZ/gDQI+oSGtE7faOSLFF9NS2aCvnR7IdNHFTgy0f0s53I2t
         GV36Aq/tuFxJ/Rcz63oSBEyZkHo4myk9KSRqBC9RHkapXHwL04aV94SrfPFRgpswYZha
         vRvyxDPWdhWrWoo3EL45JI/SrFPvpN5oPioBoKIhN6nREGSlBvZj1RlLEGvVii89lHIL
         iokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oY0j2xHMOda0gXvzPlBKUaEg1d9WR65FZp2Xjx2PGkU=;
        fh=3hnqxbF59Oh4tstmaPEF4gQPEfdTUMV9uaRNWsrLDHE=;
        b=AbCyfJIzCCYw5cCDe4/13dDoHRDhJvXje6cBMKpbUlCY1Q5mxCIVlr9BQDWAIbJJs1
         uaJV2ZR9ewpouZuNvLB2Q4vddVfyddWG/RGBZEyeq4TXMAvyXFsRUsILZVpDeisdbuhT
         dUc4b+R4VrT8Gs+HFdAjdfY8VtgWHtvGoGPrmzic7pzHPIWNOWLJrIy+0T92wL01bTHI
         BA98X8OwAckjO0XxTjtycF/ItRygomrudN8rFUh+CgniMVHa2M4iJawIffAeQg3FKGt0
         cKH1lnfwreMRlR4V0XG4mqbkKHdZbnIt2U2zASF8LnewBmk7oxOqWnPqep7rVTWBQW9x
         Wx1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774404552; x=1775009352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY0j2xHMOda0gXvzPlBKUaEg1d9WR65FZp2Xjx2PGkU=;
        b=QV7RdIrXmLGolJLu2LF5++w03EX1/R5WzXwWaMkiWV4wkFej6iUUGJu0XtueEhn6JG
         HbdU7X2303P2iGhlSk4Uv2rIui6E2AoEM3MxfvjrT+6LG7VoiG96JZ3WMPh9p3zTg6by
         koJruE8ynmtJcPxfS8WFkLSM+yLy6VAONR/+YtAtc/dNa9tSLIP6JMXRH9Dg0fuRKlMe
         dE11zOTL9izmh+8vhTKqyPvz5uJwlZa4eiSSXW3PT/QgEO8cNVXmXo6WyV9RIO2xU6h0
         5B6TXjXXYzTJBb9YS6qOE94zWb43kpHYK2UfQwfOgGW3/bbVD1IEx3OQ+NiLjAYBly18
         wieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774404552; x=1775009352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oY0j2xHMOda0gXvzPlBKUaEg1d9WR65FZp2Xjx2PGkU=;
        b=oIYLJDc+NZZSG+wnJCgp3NYMfWxoWlGbJe58yPq4FPnh9yWPT0r5dtvpTdIp9KtIro
         F7T7HngxPlUxHz8i/poPFyj0WxFoZw7+pD5zVrzYcMuEygBhf1NkZXDuQr5KTmofQMF3
         iL9GlIxaoWJRp+i+Yy6VT7IayBpt2nHCj8dEYgwAzaoMBP0BnTDMFlPRz0BBkhbZ3ruw
         Tm4wTQAtzOFAC07j6HX+Rau4bQyCUy+w5C/2Kh5oxEzCHepBOP6qXMh3EzqS7m7C0O9g
         u7rs6fyWWJciNMDWppHq/KcKfcMlcBRKPy39VsdBVjbq1oEDxJ+NUOcnFNLYOi8hi0Bv
         SOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHI6NzwLK4WL0ic41cUXkIZ1u4mWAAJF1gEbCQg03anTiMozk8UenMWNOqBn3Zf+ejO/k90wbKWMby@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkWWToZOV3nF1jErUCVgAVoDGVvAUJM4bohXUIGIf6FWzO9W4
	YLQmiM4Zky7SBZrTqTICNsZlHQb5OQru1KM0f9epkX2RBlQFTJG1ylnOJ4JXuuKZ2JH5VLgqzEz
	E5CcYrTintWBbCKSiMfeAxGlwp6518LjZ+g223eZMJw==
X-Gm-Gg: ATEYQzzQgllXffU7m/Pny/uuhT+HKEglZPOpuvuOVPvrODRod1X0Cdc0LUdx6O0n1vI
	WZkGnxTaTEZxj8L6Gna98FbeKvxy09V6mB+2bSn8p9+1U5ShqF28C4jw2yONoxYIl2FJOW4CyVz
	oo2E78dMCoU49M90L8cH6bYt7K7mre4FOVZMShk9zxtumc5qpH1g6QQvrYCOqytpNKts9OMgdf0
	4ylWlfjNcM2tVaWSDdr5BbGFfyPuyN+rvfrwpCcafXgtjqm4leJ/qOctwk2lKc8yyavZV56+1zZ
	ZFKlx2ZjZTjsZQ==
X-Received: by 2002:a05:6830:3509:b0:7d7:f031:37c7 with SMTP id
 46e09a7af769-7d9d6747c69mr937927a34.3.1774404552282; Tue, 24 Mar 2026
 19:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 10:09:01 +0800
X-Gm-Features: AaiRm52fTSVQF0KWp2ddM-jlDHilkvLjVr_b6jitCThegHWyDc--NbZeCi1nmVo
Message-ID: <CAEEQ3wkvsY=1Ep4n35tR4AHor7D_ZE6oTqrbpXP7VwhUrzZqbw@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl
 interface for CBQRI controllers
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add interface for CBQRI controller drivers to make use of the resctrl
> filesystem.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  arch/riscv/kernel/qos/qos_resctrl.c | 1192 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 1192 insertions(+)
>
> diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/=
qos_resctrl.c
> new file mode 100644
> index 000000000000..d500098599d2
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> @@ -0,0 +1,1192 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "qos: resctrl: " fmt
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/riscv_qos.h>
> +#include <linux/resctrl.h>
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +#include "internal.h"
> +
> +#define MAX_CONTROLLERS 6
> +static struct cbqri_controller controllers[MAX_CONTROLLERS];

We can get the total number of controllers, so we'll allocate dynamically.

> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCE=
S];
> +
> +static bool exposed_alloc_capable;
> +static bool exposed_mon_capable;
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
ffset);
> +
> +bool resctrl_arch_alloc_capable(void)
> +{
> +       return exposed_alloc_capable;
> +}
> +
> +bool resctrl_arch_mon_capable(void)
> +{
> +       return exposed_mon_capable;
> +}
> +
> +bool resctrl_arch_is_llc_occupancy_enabled(void)
> +{
> +       return true;
> +}
> +
> +bool resctrl_arch_is_mbm_local_enabled(void)
> +{
> +       return false;
> +}
> +
> +bool resctrl_arch_is_mbm_total_enabled(void)
> +{
> +       return false;
> +}
> +
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
> +{
> +       switch (rid) {
> +       case RDT_RESOURCE_L2:
> +               return is_cdp_l2_enabled;
> +
> +       case RDT_RESOURCE_L3:
> +               return is_cdp_l3_enabled;
> +
> +       default:
> +               return false;
> +       }
> +}
> +
> +int resctrl_arch_set_cdp_enabled(enum resctrl_res_level rid, bool enable=
)
> +{
> +       switch (rid) {
> +       case RDT_RESOURCE_L2:
> +               if (!exposed_cdp_l2_capable)
> +                       return -ENODEV;
> +               is_cdp_l2_enabled =3D enable;
> +               break;
> +
> +       case RDT_RESOURCE_L3:
> +               if (!exposed_cdp_l3_capable)
> +                       return -ENODEV;
> +               is_cdp_l3_enabled =3D enable;
> +               break;
> +
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +       if (l >=3D RDT_NUM_RESOURCES)
> +               return NULL;
> +
> +       return &cbqri_resctrl_resources[l].resctrl_res;
> +}
> +
> +struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain=
_list, int id)
> +{
> +       struct rdt_domain_hdr *hdr;
> +
> +       lockdep_assert_cpus_held();
> +
> +       list_for_each_entry(hdr, domain_list, list) {
> +               if (hdr->id =3D=3D id)
> +                       return hdr;
> +       }
> +
> +       return NULL;
> +}
> +
> +bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
> +{
> +       return false;
> +}
> +
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
> +                                enum resctrl_event_id evtid)
> +{
> +       /* RISC-V can always read an rmid, nothing needs allocating */
> +       return NULL;
> +}
> +
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
> +                              enum resctrl_event_id evtid, void *arch_mo=
n_ctx)
> +{
> +       /* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_reset_resources(void)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_dom=
ain *d,
> +                             enum resctrl_event_id evtid, u32 rmid, u32 =
closid,
> +                             u32 cntr_id, bool assign)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain=
 *d,
> +                          u32 unused, u32 rmid, int cntr_id,
> +                          enum resctrl_event_id eventid, u64 *val)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +       return 0;
> +}
> +
> +bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +       return false;
> +}
> +
> +int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable=
)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +       return 0;
> +}
> +
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
> +                            u32 unused, u32 rmid, int cntr_id,
> +                            enum resctrl_event_id eventid)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +       return false;
> +}
> +
> +int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +       return 0;
> +}
> +
> +/*
> + * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *   CLOSID on x86 is RCID on RISC-V
> + *     RMID on x86 is MCID on RISC-V
> + */
> +u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
> +{
> +       struct cbqri_resctrl_res *hw_res;
> +
> +       hw_res =3D container_of(res, struct cbqri_resctrl_res, resctrl_re=
s);
> +
> +       return hw_res->max_rcid;
> +}
> +
> +u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +       return max_rmid;
> +}
> +
> +u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
> +{
> +       return rmid;
> +}
> +
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +       *closid =3D ((u32)~0); /* refer to X86_RESCTRL_BAD_CLOSID */
> +       *rmid =3D idx;
> +}
> +
> +/* RISC-V resctrl interface does not maintain a default srmcfg value for=
 a given CPU */
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 r=
mid) { }
> +
> +void resctrl_arch_sched_in(struct task_struct *tsk)
> +{
> +       __switch_to_srmcfg(tsk);
> +}
> +
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u=
32 rmid)
> +{
> +       u32 srmcfg;
> +
> +       WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) !=3D closid);
> +       WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) !=3D rmid);
> +
> +       srmcfg =3D rmid << SRMCFG_MCID_SHIFT;
> +       srmcfg |=3D closid;
> +       WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
> +}
> +
> +void resctrl_arch_sync_cpu_closid_rmid(void *info)
> +{
> +       struct resctrl_cpu_defaults *r =3D info;
> +
> +       lockdep_assert_preemption_disabled();
> +
> +       if (r) {
> +               resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id=
(),
> +                                                        r->closid, r->rm=
id);
> +       }
> +
> +       resctrl_arch_sched_in(current);
> +}
> +
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> +{
> +       u32 srmcfg;
> +       bool match;
> +
> +       srmcfg =3D READ_ONCE(tsk->thread.srmcfg);
> +       match =3D (srmcfg & SRMCFG_RCID_MASK) =3D=3D closid;
> +       return match;
> +}
> +
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rm=
id)
> +{
> +       u32 tsk_rmid;
> +
> +       tsk_rmid =3D READ_ONCE(tsk->thread.srmcfg);
> +       tsk_rmid >>=3D SRMCFG_MCID_SHIFT;
> +       tsk_rmid &=3D SRMCFG_MCID_MASK;
> +
> +       return tsk_rmid =3D=3D rmid;
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain=
 *d,
> +                          u32 closid, u32 rmid, enum resctrl_event_id ev=
entid,
> +                          u64 *val, void *arch_mon_ctx)
> +{
> +       /*
> +        * The current Qemu implementation of CBQRI capacity and bandwidt=
h
> +        * controllers do not emulate the utilization of resources over
> +        * time. Therefore, Qemu currently sets the invalid bit in
> +        * cc_mon_ctr_val and bc_mon_ctr_val, and there is no meaningful
> +        * value other than 0 to return for reading an RMID (e.g. MCID in
> +        * CBQRI terminology)
> +        */
> +
> +       return 0;
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
> +                            u32 closid, u32 rmid, enum resctrl_event_id =
eventid)
> +{
> +       /* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_mon_event_config_read(void *info)
> +{
> +       /* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_mon_event_config_write(void *info)
> +{
> +       /* not implemented for the RISC-V resctrl interface */
> +}
> +
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_=
domain *d)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> +{
> +       /* not implemented for the RISC-V resctrl implementation */
> +}
> +
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +       int reg_offset;
> +       u64 reg;
> +
> +       reg_offset =3D CBQRI_CC_BLOCK_MASK_OFF;
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +
> +       reg =3D cbm;
> +       iowrite64(reg, ctrl->base + reg_offset);
> +}
> +
> +/* Set the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
> +static void cbqri_set_rbwb(struct cbqri_controller *ctrl, u64 rbwb)
> +{
> +       int reg_offset;
> +       u64 reg;
> +
> +       reg_offset =3D CBQRI_BC_BW_ALLOC_OFF;
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_RBWB_MASK;
> +       rbwb &=3D CBQRI_CONTROL_REGISTERS_RBWB_MASK;
> +       reg |=3D rbwb;
> +       iowrite64(reg, ctrl->base + reg_offset);
> +}
> +
> +/* Get the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
> +static u64 cbqri_get_rbwb(struct cbqri_controller *ctrl)
> +{
> +       int reg_offset;
> +       u64 reg;
> +
> +       reg_offset =3D CBQRI_BC_BW_ALLOC_OFF;
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       reg &=3D CBQRI_CONTROL_REGISTERS_RBWB_MASK;
> +       return reg;
> +}
> +
> +static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_o=
ffset)
> +{
> +       unsigned long timeout =3D jiffies + usecs_to_jiffies(1000);
> +       int busy;
> +       u64 reg;
> +
> +       while (time_before(jiffies, timeout)) {
> +               reg =3D ioread64(ctrl->base + reg_offset);
> +               busy =3D (reg >> CBQRI_CONTROL_REGISTERS_BUSY_SHIFT) &
> +                       CBQRI_CONTROL_REGISTERS_BUSY_MASK;
> +               if (!busy)
> +                       return 0;
> +       }
> +
> +       pr_warn("%s(): busy timeout", __func__);
> +       return -EIO;
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
> +       reg &=3D ~(CBQRI_CONTROL_REGISTERS_OP_MASK << CBQRI_CONTROL_REGIS=
TERS_OP_SHIFT);
> +       reg |=3D (operation & CBQRI_CONTROL_REGISTERS_OP_MASK) <<
> +               CBQRI_CONTROL_REGISTERS_OP_SHIFT;
> +       reg &=3D ~(CBQRI_CONTROL_REGISTERS_RCID_MASK <<
> +                CBQRI_CONTROL_REGISTERS_RCID_SHIFT);
> +       reg |=3D (rcid & CBQRI_CONTROL_REGISTERS_RCID_MASK) <<
> +               CBQRI_CONTROL_REGISTERS_RCID_SHIFT;
> +
> +       /* CBQRI capacity AT is only supported on L2 and L3 caches for no=
w */
> +       if (ctrl->ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY &=
&
> +           ((ctrl->ctrl_info->cache.cache_level =3D=3D 2 && is_cdp_l2_en=
abled) ||
> +           (ctrl->ctrl_info->cache.cache_level =3D=3D 3 && is_cdp_l3_ena=
bled))) {
> +               reg &=3D ~(CBQRI_CONTROL_REGISTERS_AT_MASK <<
> +                        CBQRI_CONTROL_REGISTERS_AT_SHIFT);
> +               switch (type) {
> +               case CDP_CODE:
> +                       reg |=3D (CBQRI_CONTROL_REGISTERS_AT_CODE &
> +                               CBQRI_CONTROL_REGISTERS_AT_MASK) <<
> +                               CBQRI_CONTROL_REGISTERS_AT_SHIFT;
> +                       break;
> +               case CDP_DATA:
> +               default:
> +                       reg |=3D (CBQRI_CONTROL_REGISTERS_AT_DATA &
> +                               CBQRI_CONTROL_REGISTERS_AT_MASK) <<
> +                               CBQRI_CONTROL_REGISTERS_AT_SHIFT;
> +                       break;
> +               }
> +       }
> +
> +       iowrite64(reg, ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation",=
 __func__);
> +               return -EIO;
> +       }
> +
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       status =3D (reg >> CBQRI_CONTROL_REGISTERS_STATUS_SHIFT) &
> +                 CBQRI_CONTROL_REGISTERS_STATUS_MASK;
> +       if (status !=3D 1) {
> +               pr_err("%s(): operation %d failed: status=3D%d", __func__=
, operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_apply_cache_config(struct cbqri_resctrl_dom *hw_dom, u3=
2 closid,
> +                                   enum resctrl_conf_type type, struct c=
bqri_config *cfg)
> +{
> +       struct cbqri_controller *ctrl =3D hw_dom->hw_ctrl;
> +       int reg_offset;
> +       int err =3D 0;
> +       u64 reg;
> +
> +       if (cfg->cbm !=3D hw_dom->ctrl_val[closid]) {
> +               /* Store the new cbm in the ctrl_val array for this closi=
d in this domain */
> +               hw_dom->ctrl_val[closid] =3D cfg->cbm;
> +
> +               /* Set capacity block mask (cc_block_mask) */
> +               cbqri_set_cbm(ctrl, cfg->cbm);
> +
> +               /* Capacity config limit operation */
> +               err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CON=
FIG_LIMIT, closid, type);
> +               if (err < 0) {
> +                       pr_err("%s(): operation failed: err =3D %d", __fu=
nc__, err);
> +                       return err;
> +               }
> +
> +               /* Clear cc_block_mask before read limit to verify op wor=
ks*/
> +               cbqri_set_cbm(ctrl, 0);
> +
> +               /* Performa capacity read limit operation to verify block=
mask */
> +               err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT, closid, type);
> +               if (err < 0) {
> +                       pr_err("%s(): operation failed: err =3D %d", __fu=
nc__, err);
> +                       return err;
> +               }
> +
> +               /* Read capacity blockmask to verify it matches the reque=
sted config */
> +               reg_offset =3D CBQRI_CC_BLOCK_MASK_OFF;
> +               reg =3D ioread64(ctrl->base + reg_offset);
> +               if (reg !=3D cfg->cbm) {
> +                       pr_warn("%s(): failed to verify allocation (reg:%=
llx !=3D cbm:%llx)",
> +                               __func__, reg, cfg->cbm);
> +                       return -EIO;
> +               }
> +       }
> +
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
> +       reg &=3D ~(CBQRI_CONTROL_REGISTERS_OP_MASK << CBQRI_CONTROL_REGIS=
TERS_OP_SHIFT);
> +       reg |=3D  (operation & CBQRI_CONTROL_REGISTERS_OP_MASK) <<
> +                CBQRI_CONTROL_REGISTERS_OP_SHIFT;
> +       reg &=3D ~(CBQRI_CONTROL_REGISTERS_RCID_MASK << CBQRI_CONTROL_REG=
ISTERS_RCID_SHIFT);
> +       reg |=3D  (rcid & CBQRI_CONTROL_REGISTERS_RCID_MASK) <<
> +                CBQRI_CONTROL_REGISTERS_RCID_SHIFT;
> +       iowrite64(reg, ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation",=
 __func__);
> +               return -EIO;
> +       }
> +
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       status =3D (reg >> CBQRI_CONTROL_REGISTERS_STATUS_SHIFT) &
> +                 CBQRI_CONTROL_REGISTERS_STATUS_MASK;
> +       if (status !=3D 1) {
> +               pr_err("%s(): operation %d failed with status =3D %d",
> +                      __func__, operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_apply_bw_config(struct cbqri_resctrl_dom *hw_dom, u32 c=
losid,
> +                                enum resctrl_conf_type type, struct cbqr=
i_config *cfg)
> +{
> +       struct cbqri_controller *ctrl =3D hw_dom->hw_ctrl;
> +       int ret =3D 0;
> +       u64 reg;
> +
> +       if (cfg->rbwb !=3D hw_dom->ctrl_val[closid]) {
> +               /* Store the new rbwb in the ctrl_val array for this clos=
id in this domain */
> +               hw_dom->ctrl_val[closid] =3D cfg->rbwb;
> +
> +               /* Set reserved bandwidth blocks */
> +               cbqri_set_rbwb(ctrl, cfg->rbwb);
> +
> +               /* Bandwidth config limit operation */
> +               ret =3D cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CON=
FIG_LIMIT, closid);
> +               if (ret < 0) {
> +                       pr_err("%s(): operation failed: ret =3D %d", __fu=
nc__, ret);
> +                       return ret;
> +               }
> +
> +               /* Clear rbwb before read limit to verify op works*/
> +               cbqri_set_rbwb(ctrl, 0);
> +
> +               /* Bandwidth allocation read limit operation to verify */
> +               ret =3D cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT, closid);
> +               if (ret < 0) {
> +                       pr_err("%s(): operation failed: ret =3D %d", __fu=
nc__, ret);
> +                       return ret;
> +               }
> +
> +               /* Read bandwidth allocation to verify it matches the req=
uested config */
> +               reg =3D cbqri_get_rbwb(ctrl);
> +               if (reg !=3D cfg->rbwb) {
> +                       pr_warn("%s(): failed to verify allocation (reg:%=
llx !=3D rbwb:%llu)",
> +                               __func__, reg, cfg->rbwb);
> +                       return -EIO;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type t, u32 cfg=
_val)
> +{
> +       struct cbqri_controller *ctrl;
> +       struct cbqri_resctrl_dom *dom;
> +       struct cbqri_config cfg;
> +       int err =3D 0;
> +
> +       dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_do=
m);
> +       ctrl =3D dom->hw_ctrl;
> +
> +       if (!r->alloc_capable)
> +               return -EINVAL;
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               cfg.cbm =3D cfg_val;
> +               err =3D cbqri_apply_cache_config(dom, closid, t, &cfg);
> +               break;
> +       case RDT_RESOURCE_MBA:
> +               /* covert from percentage to bandwidth blocks */
> +               cfg.rbwb =3D cfg_val * ctrl->bc.nbwblks / 100;
> +               err =3D cbqri_apply_bw_config(dom, closid, t, &cfg);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return err;
> +}
> +
> +int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
> +{
> +       struct resctrl_staged_config *cfg;
> +       enum resctrl_conf_type t;
> +       struct rdt_ctrl_domain *d;
> +       int err =3D 0;
> +
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +               for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                       cfg =3D &d->staged_config[t];
> +                       if (!cfg->have_new_ctrl)
> +                               continue;
> +                       err =3D resctrl_arch_update_one(r, d, closid, t, =
cfg->new_ctrl);
> +                       if (err) {
> +                               pr_warn("%s(): update failed (err=3D%d)",=
 __func__, err);
> +                               return err;
> +                       }
> +               }
> +       }
> +       return err;
> +}
> +
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type type)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct cbqri_controller *ctrl;
> +       int reg_offset;
> +       u32 percent;
> +       u32 rbwb;
> +       u64 reg;
> +       int err;
> +
> +       hw_dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom);
> +
> +       ctrl =3D hw_dom->hw_ctrl;
> +
> +       if (!r->alloc_capable)
> +               return resctrl_get_default_ctrl(r);
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               /* Clear cc_block_mask before read limit operation */
> +               cbqri_set_cbm(ctrl, 0);
> +
> +               /* Capacity read limit operation for RCID (closid) */
> +               err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT, type, closid);
> +               if (err < 0) {
> +                       pr_err("%s(): operation failed: err =3D %d", __fu=
nc__, err);
> +                       return resctrl_get_default_ctrl(r);
> +               }
> +
> +               /* Read capacity block mask for RCID (closid) */
> +               reg_offset =3D CBQRI_CC_BLOCK_MASK_OFF;
> +               reg =3D ioread64(ctrl->base + reg_offset);
> +
> +               /* Update the config value for the closid in this domain =
*/
> +               hw_dom->ctrl_val[closid] =3D reg;
> +               return hw_dom->ctrl_val[closid];
> +
> +       case RDT_RESOURCE_MBA:
> +               /* Capacity read limit operation for RCID (closid) */
> +               err =3D cbqri_bc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT, closid);
> +               if (err < 0) {
> +                       pr_err("%s(): operation failed: err =3D %d", __fu=
nc__, err);
> +                       return resctrl_get_default_ctrl(r);
> +               }
> +
> +               hw_dom->ctrl_val[closid] =3D cbqri_get_rbwb(ctrl);
> +
> +               /* Convert from bandwidth blocks to percent */
> +               rbwb =3D hw_dom->ctrl_val[closid];
> +               rbwb *=3D 100;
> +               percent =3D rbwb / ctrl->bc.nbwblks;
> +               if (rbwb % ctrl->bc.nbwblks)
> +                       percent++;
> +               return percent;
> +
> +       default:
> +               return resctrl_get_default_ctrl(r);
> +       }
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
> +       reg &=3D ~(CBQRI_CONTROL_REGISTERS_OP_MASK << CBQRI_CONTROL_REGIS=
TERS_OP_SHIFT);
> +       reg |=3D (operation & CBQRI_CONTROL_REGISTERS_OP_MASK) << CBQRI_C=
ONTROL_REGISTERS_OP_SHIFT;
> +       iowrite64(reg, ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset) < 0) {
> +               pr_err("%s(): BUSY timeout when executing the operation",=
 __func__);
> +               return -EIO;
> +       }
> +
> +       /* Get the operation status */
> +       reg =3D ioread64(ctrl->base + reg_offset);
> +       *status =3D (reg >> CBQRI_CONTROL_REGISTERS_STATUS_SHIFT) &
> +                  CBQRI_CONTROL_REGISTERS_STATUS_MASK;
> +
> +       /*
> +        * Check for the AT support if the register is implemented
> +        * (if not, the status value will remain 0)
> +        */
> +       if (*status !=3D 0) {
> +               /* Set the AT field to a valid value */
> +               reg =3D saved_reg;
> +               reg &=3D ~(CBQRI_CONTROL_REGISTERS_AT_MASK << CBQRI_CONTR=
OL_REGISTERS_AT_SHIFT);
> +               reg |=3D CBQRI_CONTROL_REGISTERS_AT_CODE << CBQRI_CONTROL=
_REGISTERS_AT_SHIFT;
> +               iowrite64(reg, ctrl->base + reg_offset);
> +               if (cbqri_wait_busy_flag(ctrl, reg_offset) < 0) {
> +                       pr_err("%s(): BUSY timeout when setting AT field"=
, __func__);
> +                       return -EIO;
> +               }
> +
> +               /*
> +                * If the AT field value has been reset to zero,
> +                * then the AT support is not present
> +                */
> +               reg =3D ioread64(ctrl->base + reg_offset);
> +               at =3D (reg >> CBQRI_CONTROL_REGISTERS_AT_SHIFT) & CBQRI_=
CONTROL_REGISTERS_AT_MASK;
> +               if (at =3D=3D CBQRI_CONTROL_REGISTERS_AT_CODE)
> +                       *access_type_supported =3D true;
> +               else
> +                       *access_type_supported =3D false;
> +       }
> +
> +       /* Restore the original register value */
> +       iowrite64(saved_reg, ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset) < 0) {
> +               pr_err("%s(): BUSY timeout when restoring the original re=
gister value", __func__);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Note: for the purposes of the CBQRI proof-of-concept, debug logging
> + * has been left in this function that detects the properties of CBQRI
> + * capable controllers in the system. pr_info calls would be removed
> + * before submitting non-RFC patches.
> + */
> +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_inf=
o,
> +                                 struct cbqri_controller *ctrl)
> +{
> +       int err =3D 0, status;
> +       u64 reg;
> +
> +       pr_info("controller info: type=3D%d addr=3D0x%lx size=3D%lu max-r=
cid=3D%u max-mcid=3D%u",
> +               ctrl_info->type, ctrl_info->addr, ctrl_info->size,
> +               ctrl_info->rcid_count, ctrl_info->mcid_count);
> +
> +       /* max_rmid is used by resctrl_arch_system_num_rmid_idx() */
> +       max_rmid =3D ctrl_info->mcid_count;
> +
> +       ctrl->ctrl_info =3D ctrl_info;
> +
> +       /* Try to access the memory-mapped CBQRI registers */
> +       if (!request_mem_region(ctrl_info->addr, ctrl_info->size, "cbqri_=
controller")) {
> +               pr_warn("%s(): request_mem_region failed for cbqri_contro=
ller at 0x%lx",
> +                       __func__, ctrl_info->addr);
> +               return -EBUSY;
> +       }
> +       ctrl->base =3D ioremap(ctrl_info->addr, ctrl_info->size);
> +       if (!ctrl->base) {
> +               pr_warn("%s(): goto err_release_mem_region", __func__);
> +               goto err_release_mem_region;
> +       }
> +
> +       ctrl->alloc_capable =3D false;
> +       ctrl->mon_capable =3D false;
> +
> +       /* Probe capacity allocation and monitoring features */
> +       if (ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY) {
> +               pr_info("probe capacity controller");
> +
> +               /* Make sure the register is implemented */
> +               reg =3D ioread64(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
> +               if (reg =3D=3D 0) {
> +                       err =3D -ENODEV;
> +                       goto err_iounmap;
> +               }
> +
> +               ctrl->ver_minor =3D reg & CBQRI_CC_CAPABILITIES_VER_MINOR=
_MASK;
> +               ctrl->ver_major =3D reg & CBQRI_CC_CAPABILITIES_VER_MAJOR=
_MASK;
> +
> +               ctrl->cc.supports_alloc_op_flush_rcid =3D (reg >> CBQRI_C=
C_CAPABILITIES_FRCID_SHIFT)
> +                       & CBQRI_CC_CAPABILITIES_FRCID_MASK;
> +
> +               ctrl->cc.ncblks =3D (reg >> CBQRI_CC_CAPABILITIES_NCBLKS_=
SHIFT) &
> +                                  CBQRI_CC_CAPABILITIES_NCBLKS_MASK;
> +
> +               /* Calculate size of capacity block in bytes */
> +               ctrl->cc.blk_size =3D ctrl_info->cache.cache_size / ctrl-=
>cc.ncblks;
> +               ctrl->cc.cache_level =3D ctrl_info->cache.cache_level;
> +
> +               pr_info("version=3D%d.%d ncblks=3D%d blk_size=3D%d cache_=
level=3D%d",
> +                       ctrl->ver_major, ctrl->ver_minor,
> +                       ctrl->cc.ncblks, ctrl->cc.blk_size, ctrl->cc.cach=
e_level);
> +
> +               /* Probe monitoring features */
> +               err =3D cbqri_probe_feature(ctrl, CBQRI_CC_MON_CTL_OFF,
> +                                         CBQRI_CC_MON_CTL_OP_READ_COUNTE=
R, &status,
> +                                         &ctrl->cc.supports_mon_at_code)=
;
> +               if (err) {
> +                       pr_warn("%s() failed to probe cc_mon_ctl feature"=
, __func__);
> +                       goto err_iounmap;
> +               }
> +
> +               if (status =3D=3D CBQRI_CC_MON_CTL_STATUS_SUCCESS) {
> +                       pr_info("cc_mon_ctl is supported");
> +                       ctrl->cc.supports_mon_op_config_event =3D true;
> +                       ctrl->cc.supports_mon_op_read_counter =3D true;
> +                       ctrl->mon_capable =3D true;
> +               } else {
> +                       pr_info("cc_mon_ctl is NOT supported");
> +                       ctrl->cc.supports_mon_op_config_event =3D false;
> +                       ctrl->cc.supports_mon_op_read_counter =3D false;
> +                       ctrl->mon_capable =3D false;
> +               }
> +               /*
> +                * AT data is "always" supported as it has the same value
> +                * than when AT field is not supported.
> +                */
> +               ctrl->cc.supports_mon_at_data =3D true;
> +               pr_info("supports_mon_at_data: %d, supports_mon_at_code: =
%d",
> +                       ctrl->cc.supports_mon_at_data, ctrl->cc.supports_=
mon_at_code);
> +
> +               /* Probe allocation features */
> +               err =3D cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
> +                                         CBQRI_CC_ALLOC_CTL_OP_READ_LIMI=
T,
> +                                         &status, &ctrl->cc.supports_all=
oc_at_code);
> +               if (err) {
> +                       pr_warn("%s() failed to probe cc_alloc_ctl featur=
e", __func__);
> +                       goto err_iounmap;
> +               }
> +
> +               if (status =3D=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
> +                       pr_info("cc_alloc_ctl is supported");
> +                       ctrl->cc.supports_alloc_op_config_limit =3D true;
> +                       ctrl->cc.supports_alloc_op_read_limit =3D true;
> +                       ctrl->alloc_capable =3D true;
> +                       exposed_alloc_capable =3D true;
> +               } else {
> +                       pr_info("cc_alloc_ctl is NOT supported");
> +                       ctrl->cc.supports_alloc_op_config_limit =3D false=
;
> +                       ctrl->cc.supports_alloc_op_read_limit =3D false;
> +                       ctrl->alloc_capable =3D false;
> +               }
> +               /*
> +                * AT data is "always" supported as it has the same value
> +                * than when AT field is not supported
> +                */
> +               ctrl->cc.supports_alloc_at_data =3D true;
> +               pr_info("supports_alloc_at_data: %d, supports_alloc_at_co=
de: %d",
> +                       ctrl->cc.supports_alloc_at_data,
> +                       ctrl->cc.supports_alloc_at_code);
> +       } else if (ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_BANDWIDTH=
) {
> +               pr_info("probe bandwidth controller");
> +
> +               /* Make sure the register is implemented */
> +               reg =3D ioread64(ctrl->base + CBQRI_BC_CAPABILITIES_OFF);
> +               if (reg =3D=3D 0) {
> +                       err =3D -ENODEV;
> +                       goto err_iounmap;
> +               }
> +
> +               ctrl->ver_minor =3D reg & CBQRI_BC_CAPABILITIES_VER_MINOR=
_MASK;
> +               ctrl->ver_major =3D reg & CBQRI_BC_CAPABILITIES_VER_MAJOR=
_MASK;
> +
> +               ctrl->bc.nbwblks =3D (reg >> CBQRI_BC_CAPABILITIES_NBWBLK=
S_SHIFT) &
> +                                   CBQRI_BC_CAPABILITIES_NBWBLKS_MASK;
> +               ctrl->bc.mrbwb =3D (reg >> CBQRI_BC_CAPABILITIES_MRBWB_SH=
IFT) &
> +                                 CBQRI_BC_CAPABILITIES_MRBWB_MASK;
> +
> +               pr_info("version=3D%d.%d nbwblks=3D%d mrbwb=3D%d",
> +                       ctrl->ver_major, ctrl->ver_minor,
> +                       ctrl->bc.nbwblks, ctrl->bc.mrbwb);
> +
> +               /* Probe monitoring features */
> +               err =3D cbqri_probe_feature(ctrl, CBQRI_BC_MON_CTL_OFF,
> +                                         CBQRI_BC_MON_CTL_OP_READ_COUNTE=
R,
> +                                         &status, &ctrl->bc.supports_mon=
_at_code);
> +               if (err) {
> +                       pr_warn("%s() failed to probe bc_mon_ctl feature"=
, __func__);
> +                       goto err_iounmap;
> +               }
> +
> +               if (status =3D=3D CBQRI_BC_MON_CTL_STATUS_SUCCESS) {
> +                       pr_info("bc_mon_ctl is supported");
> +                       ctrl->bc.supports_mon_op_config_event =3D true;
> +                       ctrl->bc.supports_mon_op_read_counter =3D true;
> +                       ctrl->mon_capable =3D true;
> +                       exposed_mon_capable =3D true;
> +               } else {
> +                       pr_info("bc_mon_ctl is NOT supported");
> +                       ctrl->bc.supports_mon_op_config_event =3D false;
> +                       ctrl->bc.supports_mon_op_read_counter =3D false;
> +                       ctrl->mon_capable =3D false;
> +               }
> +               /*
> +                * AT data is "always" supported as it has the same value
> +                * than when AT field is not supported
> +                */
> +               ctrl->bc.supports_mon_at_data =3D true;
> +               pr_info("supports_mon_at_data: %d, supports_mon_at_code: =
%d",
> +                       ctrl->bc.supports_mon_at_data, ctrl->bc.supports_=
mon_at_code);
> +
> +               /* Probe allocation features */
> +               err =3D cbqri_probe_feature(ctrl, CBQRI_BC_ALLOC_CTL_OFF,
> +                                         CBQRI_BC_ALLOC_CTL_OP_READ_LIMI=
T,
> +                                         &status, &ctrl->bc.supports_all=
oc_at_code);
> +               if (err) {
> +                       pr_warn("%s() failed to probe bc_alloc_ctl featur=
e", __func__);
> +                       goto err_iounmap;
> +               }
> +
> +               if (status =3D=3D CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
> +                       pr_warn("bc_alloc_ctl is supported");
> +                       ctrl->bc.supports_alloc_op_config_limit =3D true;
> +                       ctrl->bc.supports_alloc_op_read_limit =3D true;
> +                       ctrl->alloc_capable =3D true;
> +                       exposed_alloc_capable =3D true;
> +               } else {
> +                       pr_warn("bc_alloc_ctl is NOT supported");
> +                       ctrl->bc.supports_alloc_op_config_limit =3D false=
;
> +                       ctrl->bc.supports_alloc_op_read_limit =3D false;
> +                       ctrl->alloc_capable =3D false;
> +               }
> +
> +               /*
> +                * AT data is "always" supported as it has the same value
> +                * than when AT field is not supported
> +                */
> +               ctrl->bc.supports_alloc_at_data =3D true;
> +               pr_warn("supports_alloc_at_data: %d, supports_alloc_at_co=
de: %d",
> +                       ctrl->bc.supports_alloc_at_data, ctrl->bc.support=
s_alloc_at_code);
> +       } else {
> +               pr_warn("controller type is UNKNOWN");
> +               err =3D -ENODEV;
> +               goto err_release_mem_region;
> +       }
> +
> +       return 0;
> +
> +err_iounmap:
> +       pr_warn("%s(): err_iounmap", __func__);
> +       iounmap(ctrl->base);
> +
> +err_release_mem_region:
> +       pr_warn("%s(): err_release_mem_region", __func__);
> +       release_mem_region(ctrl_info->addr, ctrl_info->size);
> +
> +       return err;
> +}
> +
> +static struct rdt_ctrl_domain *qos_new_domain(struct cbqri_controller *c=
trl)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct rdt_ctrl_domain *domain;
> +
> +       hw_dom =3D kzalloc(sizeof(*hw_dom), GFP_KERNEL);
> +       if (!hw_dom)
> +               return NULL;
> +
> +       /* associate this cbqri_controller with the domain */
> +       hw_dom->hw_ctrl =3D ctrl;
> +
> +       /* the rdt_domain struct from inside the cbqri_resctrl_dom struct=
 */
> +       domain =3D &hw_dom->resctrl_ctrl_dom;
> +
> +       INIT_LIST_HEAD(&domain->hdr.list);
> +
> +       return domain;
> +}
> +
> +static int qos_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ct=
rl_domain *d)
> +{
> +       struct cbqri_resctrl_res *hw_res;
> +       struct cbqri_resctrl_dom *hw_dom;
> +       u64 *dc;
> +       int err =3D 0;
> +       int i;
> +
> +       hw_res =3D container_of(r, struct cbqri_resctrl_res, resctrl_res)=
;
> +       if (!hw_res)
> +               return -ENOMEM;
> +
> +       hw_dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom);
> +       if (!hw_dom)
> +               return -ENOMEM;
> +
> +       dc =3D kmalloc_array(hw_res->max_rcid, sizeof(*hw_dom->ctrl_val),
> +                          GFP_KERNEL);
> +       if (!dc)
> +               return -ENOMEM;
> +
> +       hw_dom->ctrl_val =3D dc;
> +
> +       for (i =3D 0; i < hw_res->max_rcid; i++, dc++) {
> +               err =3D resctrl_arch_update_one(r, d, i, 0, resctrl_get_d=
efault_ctrl(r));
> +               if (err)
> +                       return 0;
> +               *dc =3D resctrl_get_default_ctrl(r);
> +       }
> +       return 0;
> +}
> +
> +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ct=
rl, int *id)
> +{
> +       struct rdt_ctrl_domain *domain =3D NULL;
> +       struct cbqri_resctrl_res *cbqri_res =3D NULL;
> +       struct rdt_resource *res =3D NULL;
> +       int internal_id =3D *id;
> +       int err =3D 0;
> +
> +       domain =3D qos_new_domain(ctrl);
> +       if (!domain)
> +               return -ENOSPC;
> +       if (ctrl->ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY) =
{
> +               cpumask_copy(&domain->hdr.cpu_mask, &ctrl->ctrl_info->cac=
he.cpu_mask);
> +               if (ctrl->ctrl_info->cache.cache_level =3D=3D 2) {
> +                       cbqri_res =3D &cbqri_resctrl_resources[RDT_RESOUR=
CE_L2];
> +                       cbqri_res->max_rcid =3D ctrl->ctrl_info->rcid_cou=
nt;
> +                       cbqri_res->max_mcid =3D ctrl->ctrl_info->mcid_cou=
nt;
> +                       res =3D &cbqri_res->resctrl_res;
> +                       res->mon.num_rmid =3D ctrl->ctrl_info->mcid_count=
;
> +                       res->rid =3D RDT_RESOURCE_L2;
> +                       res->name =3D "L2";
> +                       res->alloc_capable =3D ctrl->alloc_capable;
> +                       res->mon_capable =3D ctrl->mon_capable;
> +                       res->schema_fmt =3D RESCTRL_SCHEMA_BITMAP;
> +                       res->ctrl_scope =3D RESCTRL_L2_CACHE;
> +                       res->cache.arch_has_sparse_bitmasks =3D false;
> +                       res->cache.arch_has_per_cpu_cfg =3D false;
> +                       res->cache.cbm_len =3D ctrl->cc.ncblks;
> +                       res->cache.shareable_bits =3D resctrl_get_default=
_ctrl(res);
> +                       res->cache.min_cbm_bits =3D 1;
> +               } else if (ctrl->ctrl_info->cache.cache_level =3D=3D 3) {
> +                       cbqri_res =3D &cbqri_resctrl_resources[RDT_RESOUR=
CE_L3];
> +                       cbqri_res->max_rcid =3D ctrl->ctrl_info->rcid_cou=
nt;
> +                       cbqri_res->max_mcid =3D ctrl->ctrl_info->mcid_cou=
nt;
> +                       res =3D &cbqri_res->resctrl_res;
> +                       res->mon.num_rmid =3D ctrl->ctrl_info->mcid_count=
;
> +                       res->rid =3D RDT_RESOURCE_L3;
> +                       res->name =3D "L3";
> +                       res->schema_fmt =3D RESCTRL_SCHEMA_BITMAP;
> +                       res->ctrl_scope =3D RESCTRL_L3_CACHE;
> +                       res->alloc_capable =3D ctrl->alloc_capable;
> +                       res->mon_capable =3D ctrl->mon_capable;
> +                       res->cache.arch_has_sparse_bitmasks =3D false;
> +                       res->cache.arch_has_per_cpu_cfg =3D false;
> +                       res->cache.cbm_len =3D ctrl->cc.ncblks;
> +                       res->cache.shareable_bits =3D resctrl_get_default=
_ctrl(res);
> +                       res->cache.min_cbm_bits =3D 1;
> +               } else {
> +                       pr_warn("%s(): unknown cache level %d", __func__,
> +                               ctrl->ctrl_info->cache.cache_level);
> +                       err =3D -ENODEV;
> +                       goto err_free_domain;
> +               }
> +       } else if (ctrl->ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_BAN=
DWIDTH) {
> +               if (ctrl->alloc_capable) {
> +                       cbqri_res =3D &cbqri_resctrl_resources[RDT_RESOUR=
CE_MBA];
> +                       cbqri_res->max_rcid =3D ctrl->ctrl_info->rcid_cou=
nt;
> +                       cbqri_res->max_mcid =3D ctrl->ctrl_info->mcid_cou=
nt;
> +                       res =3D &cbqri_res->resctrl_res;
> +                       res->mon.num_rmid =3D ctrl->ctrl_info->mcid_count=
;
> +                       res->rid =3D RDT_RESOURCE_MBA;
> +                       res->name =3D "MB";
> +                       res->schema_fmt =3D RESCTRL_SCHEMA_RANGE;
> +                       res->ctrl_scope =3D RESCTRL_L3_CACHE;
> +                       res->alloc_capable =3D ctrl->alloc_capable;
> +                       res->mon_capable =3D false;
> +                       res->membw.delay_linear =3D true;
> +                       res->membw.arch_needs_linear =3D true;
> +                       res->membw.throttle_mode =3D THREAD_THROTTLE_UNDE=
FINED;
> +                       // The minimum percentage allowed by the CBQRI sp=
ec
> +                       res->membw.min_bw =3D 1;
> +                       // The maximum percentage allowed by the CBQRI sp=
ec
> +                       res->membw.max_bw =3D 80;
> +                       res->membw.bw_gran =3D 1;

1. Wrap this into a function.

2. Also, mweight controller support needs to be added here.
We may need to add RDT_RESOURCE_MB_WEIGHT to the enumeration:
enum resctrl_res_level {
...
RDT_RESOURCE_MB_WEIGHT,
...
};

3. We need to implement cbqri_set_mweight() and cbqri_get_mweight().


4. We need to add monitor controllers (domains) for both capacity and MBW.


> +               }
> +       } else {
> +               pr_warn("%s(): unknown resource %d", __func__, ctrl->ctrl=
_info->type);
> +               err =3D -ENODEV;
> +               goto err_free_domain;
> +       }
> +
> +       domain->hdr.id =3D internal_id;
> +       err =3D qos_init_domain_ctrlval(res, domain);
> +       if (err)
> +               goto err_free_domain;
> +
> +       if (cbqri_res) {
> +               list_add_tail(&domain->hdr.list, &cbqri_res->resctrl_res.=
ctrl_domains);
> +               *id =3D internal_id;
> +               err =3D resctrl_online_ctrl_domain(res, domain);
> +               if (err) {
> +                       pr_warn("%s(): failed to online cbqri_res domain"=
, __func__);
> +                       goto err_free_domain;
> +               }
> +       }
> +
> +       return 0;
> +
> +err_free_domain:
> +       pr_warn("%s(): err_free_domain", __func__);
> +       kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom));
> +
> +       return err;
> +}
> +
> +int qos_resctrl_setup(void)
> +{
> +       struct rdt_ctrl_domain *domain, *domain_temp;
> +       struct cbqri_controller_info *ctrl_info;
> +       struct cbqri_controller *ctrl;
> +       struct cbqri_resctrl_res *res;
> +       static int found_controllers;
> +       int err =3D 0;
> +       int id =3D 0;
> +       int i;
> +
> +       list_for_each_entry(ctrl_info, &cbqri_controllers, list) {
> +               err =3D cbqri_probe_controller(ctrl_info, &controllers[fo=
und_controllers]);
> +               if (err) {
> +                       pr_warn("%s(): failed (%d)", __func__, err);
> +                       goto err_unmap_controllers;
> +               }
> +
> +               found_controllers++;
> +               if (found_controllers > MAX_CONTROLLERS) {
> +                       pr_warn("%s(): increase MAX_CONTROLLERS value", _=
_func__);
> +                       break;
> +               }
> +       }
> +
> +       for (i =3D 0; i < RDT_NUM_RESOURCES; i++) {
> +               res =3D &cbqri_resctrl_resources[i];
> +               INIT_LIST_HEAD(&res->resctrl_res.ctrl_domains);
> +               INIT_LIST_HEAD(&res->resctrl_res.mon_domains);
> +               res->resctrl_res.rid =3D i;
> +       }
> +
> +       for (i =3D 0; i < found_controllers; i++) {
> +               ctrl =3D &controllers[i];
> +               err =3D qos_resctrl_add_controller_domain(ctrl, &id);
> +               if (err) {
> +                       pr_warn("%s(): failed to add controller domain (%=
d)", __func__, err);
> +                       goto err_free_controllers_list;
> +               }
> +               id++;
> +
> +               /*
> +                * CDP (code data prioritization) on x86 is similar to
> +                * the AT (access type) field in CBQRI. CDP only supports
> +                * caches so this must be a CBQRI capacity controller.
> +                */
> +               if (ctrl->ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_CA=
PACITY &&
> +                   ctrl->cc.supports_alloc_at_code &&
> +                   ctrl->cc.supports_alloc_at_data) {
> +                       if (ctrl->ctrl_info->cache.cache_level =3D=3D 2)
> +                               exposed_cdp_l2_capable =3D true;
> +                       else
> +                               exposed_cdp_l3_capable =3D true;
> +               }
> +       }
> +
> +       pr_info("exposed_alloc_capable =3D %d", exposed_alloc_capable);
> +       pr_info("exposed_mon_capable =3D %d", exposed_mon_capable);
> +       pr_info("exposed_cdp_l2_capable =3D %d", exposed_cdp_l2_capable);
> +       pr_info("exposed_cdp_l3_capable =3D %d", exposed_cdp_l3_capable);

One line of pr_info? Print total controllers, capacity and MBW counts


> +
> +       return resctrl_init();
> +
> +err_free_controllers_list:
> +       for (i =3D 0; i < RDT_NUM_RESOURCES; i++) {
> +               res =3D &cbqri_resctrl_resources[i];
> +               list_for_each_entry_safe(domain, domain_temp, &res->resct=
rl_res.ctrl_domains,
> +                                        hdr.list) {
> +                       kfree(domain);
> +               }
> +       }
> +
> +err_unmap_controllers:
> +       for (i =3D 0; i < found_controllers; i++) {
> +               iounmap(controllers[i].base);
> +               release_mem_region(controllers[i].ctrl_info->addr, contro=
llers[i].ctrl_info->size);
> +       }
> +
> +       return err;
> +}
> +
> +int qos_resctrl_online_cpu(unsigned int cpu)
> +{
> +       resctrl_online_cpu(cpu);
> +       return 0;
> +}
> +
> +int qos_resctrl_offline_cpu(unsigned int cpu)
> +{
> +       resctrl_offline_cpu(cpu);
> +       return 0;
> +}
> +
>
> --
> 2.43.0
>

Thanks,
Yunhui
