Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086746;
	b=fyMwxbhn/YHSXN6AIZjH4T8auJVHzDNwnlwyYi8clLzTd7LLw764XCQfnLc32k9guc2z
	 TPKn/UbLRpho2bj91h4mBYh/AEccxWF+1CnVHZgvTNglcRmrXx17I8NYOH/cul2jBOO96
	 o9eZE+1YSk8FEQzRCOiRgvrf+1f/KqoNRUjO1CM4n57b8qymUz15uEB6LQzulrbVCNQnn
	 yHzSgXt9bsqzOjADzM4MazTTlpZp7gh5YW4QhLmZOUNw+av4JnUbOVE5bT9hiQnyNlrdZ
	 xQNJNsLCx2/cd1FDDNqxH7NgYnMDLa7JbFKjzVxtxbA0OxOx6I1BaewKzcV+basTF7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i1+Hi/huCIzVC1j5zCeT9ezOVskfyS/VsJnnvUMwgz4=;
	b=eGByDsfkbyfI8YrlVeCAMSCqGvV6189OOiOLQrVSbIVLHUSu5llHQJQJdY56BwDjstke
	 av2+e//GMzECY90yk7IyGC23Y1UVWI+4l+lAg0ud1uzNLnXj/pZEq72zoHi+6thEZwcym
	 4EttAF3rfCiVNXIcRIlPTuT5O++xu0qfRvzoD7NZiI3d3/Htisxv91Hg1XczHBrsylNPN
	 F+WfVIli51iTCTXReYRhc3yiU6nEMXGikXcaF0jJA4RGULMXZzfCx0Zhyn7ZIUJkhbJVp
	 zU6ZfoN9b1eqILuLJbkrxzyLwqApvytcopPn7xYLLO0oKiuGRQYl6Yogmtle8JFnw5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EqmdUUmD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EA606A324
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 11:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EqmdUUmD
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1356931eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 03:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795086744; cv=none;
        d=google.com; s=arc-20260327;
        b=U1Rw6UFzlNVl2LOhKU2g0tG18GEfDgX8kR/zSJiwceGg2KGr7cVB+vH/oOgHA77eXG
         XT76Hln7YAgxGb4LYvEUK837sgy+5BI6SpDBGzj0I6yOdBQlOiGRivtPfntlnwxq1X0k
         ZJOAqPmJ2Ng2+51FW/Qtear+4Iv5wGEzV0iARJwY+AspeiwXHz4hFLhB8IdsxWt9wRbL
         RCX8W/HLNWLf/dDqAxnmC8wpCzqyc4h9I8QYM/zStozge3431An5TYFdo7lK/4QiyjG1
         foZdfaQWHrJIMO34XYRTrQywVa7isNoqNXfo2Vh7BKuB/7pHEPLlnFIXukflEWKJZmcx
         W0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1+Hi/huCIzVC1j5zCeT9ezOVskfyS/VsJnnvUMwgz4=;
        fh=pgf9znyiOFP2G/mCQTTyeAAnuwzxu9WiSEC+4DH1/QE=;
        b=YMEWW5FkWj3tWTMxB+7cerbQUDjIYI3bsgXM5BJrP2xtfVa4CiwzTD2Y0XAKXK2HqB
         VPboBwU2115FMxVSgK+Dr5DCDCyjHCqKt4HjZyktOdVtwMp6uz/Mm219i93iJbJJq7eP
         rXzu6a4WBS8+SI5X3mhFgtYh1qerjQgCta2Ap7hSTAoyZscj2tTb8CN4mShht2iswAVU
         Ff32eeeWLYMkJKeh792sC25g7fXofWtLlZ+QuJbS3DM7Vl5CXxDd3QVPat3i9S3T2dVL
         O3fnOMRdpzQAbjH+rDwlBdqQoQ4vgvV51I9wmjh5NUw3/kx90vCc0GeTE3cXX+F+Pjw2
         mEWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795086744; x=1795691544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i1+Hi/huCIzVC1j5zCeT9ezOVskfyS/VsJnnvUMwgz4=;
        b=EqmdUUmDplMHAQIj15+Njen2GWjEok21juOvmSPrMpMOE1HLvmFpEG2+tYjTWTsRCH
         X/v0MRkPDtod8cvFgKnmag3IclZleNcU1dm9Akj2If4NjcHkf5qJ1kbEK0hL+E5AxM2i
         7skr7/R0BirpXRUEDZNJlkA3NEZ/C1cwxgpiwEj1/SUcq0tcIoENHYxuT1rU4+EQdke+
         fyndGfNyUxuzMgpvc0qZOD+AaxwUS3IWCO+q9hYwO7OlFQUuVbcPQ/ujnWBDhvZ4rt9K
         5BeV5d5lWVStiOuZCZEaKkmVjD374RRFIxGHeWnac6CUReXvlcWL0/141+DQZEoX2WdI
         G1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795086744; x=1795691544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1+Hi/huCIzVC1j5zCeT9ezOVskfyS/VsJnnvUMwgz4=;
        b=ZU/t4pj0Aw9H8x48QXnNVgmrxAglHnmhtxbYp0rUW6puR3YqTFRZK/lS2IoXryQ9Pb
         tIe2RxukCiH6LVnXx2jEHydeYqFUzY6ka8f5EarwLl2D3SnAZG9hbsge7KBFTAUyibxg
         fliVhOsH7f998wKwKU7TRaA4iBh+kVp57THvneIw30kum792XES0NqqNhyAmmxPJINkp
         JEoMkY2IlhUtGdIuLXOjj0wkQitX/6U2pLU+1sw8nJlCgL85Zh+AbjfTp5dr8U2HPRiE
         bE4903Yo8uUul983hVB84RdshxVcoe6KypwAO3Su4ot81UylMkQ7W5EtGxUkA88kKEH3
         qMXQ==
X-Forwarded-Encrypted: i=1; AL+hErEIoOqd/4m7uOe7/zC+1ttducQUdI4RMxVew5yzhJ5xQBmezbwfi5qwBpeHnn00u0HKuGhkKnlaYndz@vger.kernel.org
X-Gm-Message-State: APuU4Z//Qk9Ar5zJ4eodc2ULKEuLVqutQLfjrXL4EGiUayjYG9ps+ZLG
	ZLkJErjBdrzHzNE/VQ4D4WSVwwEFC0SqKM1MCGlGvJ/Erl9PiswyFqCGTvFEMvKXXc1CGeT+OXe
	FNq15H/ZSMZm0yUgKhLYmWn2YJmimRRmf7hGTzA6jmg==
X-Gm-Gg: AYBFou3DMG9yHUMvXOlULNMIO2T2RFUWm5R73P4yF7Jvl2lTC11z5Nc13XNMrjbLrBq
	/WvJFTRaxsi9cufyciX4Jl2NkWMWa2GB4uz42Sgpi75BIPPzakQg14/F+WhTPJRu7NQQK6Bh7Th
	2Ajmkm7+F/X5e9Hie0r2qkR+C6ngGR9pexK0SsNO+mAhOFui7ltsirCJJ0KE/CWYd15zMsVeQAp
	qzZRDxcKMOVNWyNZsuScI3KJAcO1ERDX1pvrLOl7QkMzje6o9eNO0U0mSuTn61n3zZMPazEB+sX
	SoBcQkoYJluDxbK1rhnLG6lpYKlpdgVmSOrdoDf8A0dVAk6SJGI3Hnf+gLoOoaMIFZhWWB6CVh2
	fONlp5ZERD5U5xvC4Udm0dAgf0t8+DE3X2ksTiFJoOJY=
X-Received: by 2002:a05:6820:1383:b0:71a:6171:83ca with SMTP id
 006d021491bc7-71b185b69f6mr4499629eaf.33.1795086743424; Thu, 19 Nov 2026
 03:12:23 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org> <20261117-acpi-rqsc-v1-3-381ce645751e@kernel.org>
In-Reply-To: <20261117-acpi-rqsc-v1-3-381ce645751e@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 19 Nov 2026 19:12:10 +0800
X-Gm-Features: AclHuK8A4S8hivuRzbEd2-PIantq4JSlLJM-uCeYM068lq8FBMTTp4bISI460sk
Message-ID: <CAEEQ3wnnYTdVvH+NVWLSG+rk2bTZrDF4bF1F74R0jSuhQWzaGQ@mail.gmail.com>
Subject: Re: [External] [PATCH 3/3] riscv_cbqri: Bind to RQSC platform devices
To: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Cc: Sunil V L <sunilvl@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup.patel@oss.qualcomm.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Zeng Heng <zengheng@picoheart.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Ben Horgan <ben.horgan@arm.com>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
	Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
	Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	=?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Samuel Holland <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn, 
	liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>, 
	Peter Newman <peternewman@google.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
	Jonathan Cameron <jic23@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Nov 18, 2026 at 6:12=E2=80=AFAM Drew Fustini (Tenstorrent)
<fustini@kernel.org> wrote:
>
> Let the capacity controller driver probe the "cbqri-capacity" platform
> devices created from the RQSC table. The cache is named by its PPTT
> Cache ID and the PPTT gives its level. Select ACPI_RQSC so the table is
> parsed and drop the OF dependency.
>
> No change for device tree systems.
>
> Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
> ---
>  drivers/resctrl/Kconfig          |  11 ++--
>  drivers/resctrl/cbqri_capacity.c | 111 ++++++++++++++++++++++++++++-----=
------
>  2 files changed, 87 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 844dfd75e2aa..491c867f8c5c 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -35,6 +35,7 @@ config ARM64_MPAM_RESCTRL_FS
>  menuconfig RISCV_CBQRI
>         bool "RISC-V CBQRI support"
>         depends on RISCV && RISCV_ISA_SSQOSID
> +       select ACPI_RQSC if ACPI
>         select ARCH_HAS_CPU_RESCTRL
>         default y
>         help
> @@ -47,14 +48,14 @@ if RISCV_CBQRI
>
>  config RISCV_CBQRI_CAPACITY
>         bool "RISC-V CBQRI cache capacity-allocation controller"
> -       depends on OF
>         help
>           Enable driver for a RISC-V CBQRI capacity controller that
> -         governs a CPU cache, matching the "riscv,cbqri-capacity-control=
ler"
> -         compatible. The controller's cache phandle gives the cache leve=
l and
> -         id, which the driver registers as a resctrl cache-allocation re=
source.
> +         governs a CPU cache, described in device tree by the
> +         "riscv,cbqri-capacity-controller" compatible or in ACPI by the =
RQSC
> +         table. The firmware description gives the cache level and id, w=
hich
> +         the driver registers as a resctrl cache-allocation resource.
>
> -         Say N unless your device tree describes a CBQRI capacity contro=
ller.
> +         Say N unless your firmware describes a CBQRI capacity controlle=
r.
>
>  endif
>
> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_cap=
acity.c
> index 6f3d06c4f74b..7013f1a50ffd 100644
> --- a/drivers/resctrl/cbqri_capacity.c
> +++ b/drivers/resctrl/cbqri_capacity.c
> @@ -3,11 +3,14 @@
>   * Platform driver for a RISC-V CBQRI capacity controller that backs a C=
PU
>   * cache. The controller is described in device tree by the generic
>   * "riscv,cbqri-capacity-controller" compatible together with a phandle =
to the
> - * cache node it governs. The driver hands it to the CBQRI core, which p=
robes
> - * the capabilities register and exposes a controller that supports allo=
cation
> - * as the resctrl cache allocation resource for that cache.
> + * cache node it governs, or in ACPI by the RQSC table, whose parser cre=
ates a
> + * "cbqri-capacity" platform device that carries the PPTT Cache ID of th=
e
> + * cache. The driver hands it to the CBQRI core, which probes the capabi=
lities
> + * register and exposes a controller that supports allocation as the res=
ctrl
> + * cache allocation resource for that cache.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
>  #include <linux/device-id/of.h>
> @@ -15,45 +18,32 @@
>  #include <linux/ioport.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/riscv_cbqri.h>
>  #include <linux/types.h>
>
> -static int cbqri_capacity_probe(struct platform_device *pdev)
> +static int cbqri_capacity_of_cache(struct device *dev, u32 *cache_level,
> +                                  u32 *cache_id)
>  {
> -       struct device *dev =3D &pdev->dev;
> -       struct cbqri_controller_info info =3D {};
>         struct device_node *cache_np;
> -       struct resource *res;
> -       void __iomem *base;
> -       u32 rcid_count, cache_level, cache_id;
>         bool found =3D false;
>         int cpu, ret;
>
> -       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> -
> -       ret =3D of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &r=
cid_count);
> -       if (ret) {
> -               dev_err(dev, "missing riscv,cbqri-rcid\n");
> -               return ret;
> -       }
> -
>         cache_np =3D of_parse_phandle(dev->of_node, "riscv,cbqri-cache", =
0);
>         if (!cache_np) {
>                 dev_err(dev, "missing riscv,cbqri-cache phandle\n");
>                 return -EINVAL;
>         }
>
> -       ret =3D of_property_read_u32(cache_np, "cache-level", &cache_leve=
l);
> +       ret =3D of_property_read_u32(cache_np, "cache-level", cache_level=
);
>         if (ret) {
>                 dev_err(dev, "%pOF: missing cache-level\n", cache_np);
>                 goto out_put;
>         }
>
> -       if (cache_level !=3D 2 && cache_level !=3D 3) {
> +       if (*cache_level !=3D 2 && *cache_level !=3D 3) {
>                 dev_err(dev, "%pOF: unsupported cache-level %u\n",
> -                       cache_np, cache_level);
> +                       cache_np, *cache_level);
>                 ret =3D -EINVAL;
>                 goto out_put;
>         }
> @@ -73,10 +63,10 @@ static int cbqri_capacity_probe(struct platform_devic=
e *pdev)
>          */
>         cpus_read_lock();
>         for_each_online_cpu(cpu) {
> -               struct cacheinfo *ci =3D get_cpu_cacheinfo_level(cpu, cac=
he_level);
> +               struct cacheinfo *ci =3D get_cpu_cacheinfo_level(cpu, *ca=
che_level);
>
>                 if (ci && ci->fw_token =3D=3D cache_np) {
> -                       cache_id =3D ci->id;
> +                       *cache_id =3D ci->id;
>                         found =3D true;
>                         break;
>                 }
> @@ -85,11 +75,74 @@ static int cbqri_capacity_probe(struct platform_devic=
e *pdev)
>
>         if (!found) {
>                 dev_err(dev, "%pOF: no online hart reports an L%u cache w=
ith a cache id for this node\n",
> -                       cache_np, cache_level);
> +                       cache_np, *cache_level);
>                 ret =3D -ENODEV;
> -               goto out_put;
>         }
>
> +out_put:
> +       of_node_put(cache_np);
> +       return ret;
> +}
> +
> +/*
> + * The RQSC table names the cache by its PPTT Cache ID, which the table =
parser
> + * passes on in the riscv,cbqri-cache-id property. cacheinfo takes the c=
ache
> + * id from the same PPTT field, and the PPTT gives the level of the cach=
e.
> + */
> +static int cbqri_capacity_acpi_cache(struct device *dev, u32 *cache_leve=
l,
> +                                    u32 *cache_id)
> +{
> +       int level, ret;
> +
> +       ret =3D device_property_read_u32(dev, "riscv,cbqri-cache-id", cac=
he_id);
> +       if (ret) {
> +               dev_err(dev, "missing riscv,cbqri-cache-id\n");
> +               return ret;
> +       }
> +
> +       level =3D find_acpi_cache_level_from_id(*cache_id);
> +       if (level < 0) {
> +               dev_err(dev, "no PPTT cache with Cache ID %u\n", *cache_i=
d);
> +               return level;
> +       }
> +
> +       if (level !=3D 2 && level !=3D 3) {
> +               dev_err(dev, "unsupported cache level %d for Cache ID %u\=
n",
> +                       level, *cache_id);
> +               return -EINVAL;
> +       }
> +
> +       *cache_level =3D level;
> +
> +       return 0;
> +}
> +
> +static int cbqri_capacity_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct cbqri_controller_info info =3D {};
> +       struct resource *res;
> +       void __iomem *base;
> +       u32 rcid_count, cache_level, cache_id;
> +       int ret;
> +
> +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       ret =3D device_property_read_u32(dev, "riscv,cbqri-rcid", &rcid_c=
ount);
> +       if (ret) {
> +               dev_err(dev, "missing riscv,cbqri-rcid\n");
> +               return ret;
> +       }
> +
> +       if (dev->of_node)
> +               ret =3D cbqri_capacity_of_cache(dev, &cache_level, &cache=
_id);
> +       else
> +               ret =3D cbqri_capacity_acpi_cache(dev, &cache_level, &cac=
he_id);
> +       if (ret)
> +               return ret;
> +
>         info.type =3D CBQRI_CONTROLLER_TYPE_CAPACITY;
>         info.base =3D base;
>         info.addr =3D res->start;
> @@ -101,15 +154,13 @@ static int cbqri_capacity_probe(struct platform_dev=
ice *pdev)
>         ret =3D riscv_cbqri_register_cc(&info);
>         if (ret) {
>                 dev_err(dev, "failed to register capacity controller: %d\=
n", ret);
> -               goto out_put;
> +               return ret;
>         }

The same multiple-controller case applies to RQSC-described devices here:

https://lore.kernel.org/all/CAEEQ3w=3DvoZYrfcMuKC_SQG9U8hYN_thcc02nf_PgMu5U=
yuG32Q@mail.gmail.com/


>
>         dev_info(dev, "registered L%u capacity controller at %pa (cache_i=
d=3D%u, rcid=3D%u)\n",
>                  cache_level, &info.addr, cache_id, rcid_count);
>
> -out_put:
> -       of_node_put(cache_np);
> -       return ret;
> +       return 0;
>  }
>
>  static const struct of_device_id cbqri_capacity_of_match[] =3D {
>
> --
> 2.43.0
>

Thanks,
Yunhui
