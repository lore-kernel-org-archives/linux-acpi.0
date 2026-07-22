Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4774399E3;
	Wed, 22 Jul 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743810; cv=none; b=YdCybONjcnBVeMPhGhoHll/A/xHKf0AYxzpr3QKX5B1le4zJZ6EBC/FMPMtNnbmiyBHNfk/yCw0Cpoi2rkpPiI8FoHZfSCj394x1CYMJWv9IMNLU1ivVb98LjGbxEdwh6Z6ThV3cOAaRWnABVoLZZEwyC4jCL8XKHHlouAIG7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743810; c=relaxed/simple;
	bh=ffS3X3zEzTQTJwQcc2jPjnXZzV7nVOZ9UDD3rr4qp3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq2VdnRabwKIo+0D6Q4GXgIe/aA7M5HG28/wrfPj1WL7cPF7l9tYLRiPrrFeqrp7eKEoh9ivNgXnuImOdz6tSLcV0zZ2wA+ATOuXX8oriWy3DKWqDFzfY6CVnoECg+EldNmoydfO/OHVDFmruwtAcC2tEISAObJgmPiphNqj9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zmq+ZA5a; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zmq+ZA5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784743809; x=1816279809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ffS3X3zEzTQTJwQcc2jPjnXZzV7nVOZ9UDD3rr4qp3E=;
  b=Zmq+ZA5asKN4ULLqDcZUkn/K5FpA56uQUFUmfl8cTHSqN6tH8mBeEdHQ
   EFMav52Oeh4JH94pFsT7yDcMSK3NaraDA9hYR/nk50cpz0bG68INLxFpp
   AShHsVHC7K/LSqVBRF6ZpZB4oh/PV51NhsC9oYrSxTE/c+P9JSwCKrGE+
   gyOdHNqVr4XosoILSf4v5s2ZY40JR3N1s6jRAKDZo4CalRzXSnV7opsRG
   agUGE9ES+7ulk5AmSDmZ3HAlZ7EtoeAf69RU3gRBPcrPR4JeKoJQ6hicI
   ju0xuaD6zekbsEjKQZhg9+12IefcCh+hQ2qaOCLDnNz8XhqiMvSfUXazx
   A==;
X-CSE-ConnectionGUID: ykTAOXOUS5+VtsDLlG8d6g==
X-CSE-MsgGUID: zf+bRhCHRb2tylv/srSJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96527145"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="96527145"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 11:10:08 -0700
X-CSE-ConnectionGUID: MNb6Uw/VRSeDefLSLlzumA==
X-CSE-MsgGUID: 7PuRvL3QTcuy19/qQ179iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254775576"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 11:10:07 -0700
Date: Wed, 22 Jul 2026 11:09:58 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
References: <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>

On Mon, Jul 20, 2026 at 08:18:58PM -0700, Borislav Petkov wrote:
> On Wed, Jul 08, 2026 at 01:24:05AM +0200, Thomas Gleixner wrote:
> > If that's the only case to handle, then sure that open coded check is
> > fine.
> 
> This is ontop of tip:x86/cpu which already has Pawan's change that drops the
> one Intel-specific CPU type use.
> 
> It boots here so... :-P
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 2 Jul 2026 17:00:28 -0700
> Subject: [PATCH] x86/topo: Map vendor CPU types to generic Linux such types
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Sashiko reported¹ that a confusion could ensue if a vendor-specific CPU
> type 0 (performance) gets attempted to be used in a x86_cpu_id match
> table. The current logic treats 0 as the wildcard X86_CPU_TYPE_ANY and
> such a thing would end up matching the wrong CPUs.
> 
> This is all backwards because we started using the vendor-specific CPU
> type number instead of using a Linux-defined, generic CPU type which
> is agnostic.
> 
> Convert the current logic to it before users start appearing.
> 
>   ¹https://sashiko.dev/#/patchset/20260629094349.533301-1-Vishal.Badole%40amd.com
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20260629094349.533301-2-Vishal.Badole@amd.com
> ---
>  arch/x86/include/asm/processor.h      | 18 ++++++++++++----
>  arch/x86/include/asm/topology.h       |  7 -------
>  arch/x86/kernel/acpi/cppc.c           |  4 ++--
>  arch/x86/kernel/cpu/match.c           | 30 +--------------------------
>  arch/x86/kernel/cpu/topology.h        |  1 +
>  arch/x86/kernel/cpu/topology_amd.c    |  6 ++++--
>  arch/x86/kernel/cpu/topology_common.c |  8 +++++--
>  7 files changed, 28 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 87b1d4c0727e..fc0350fe8f5e 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -68,9 +68,13 @@ extern u16 __read_mostly tlb_lld_2m;
>  extern u16 __read_mostly tlb_lld_4m;
>  extern u16 __read_mostly tlb_lld_1g;
>  
> -/*
> - * CPU type and hardware bug flags. Kept separately for each CPU.
> - */
> +enum x86_topology_cpu_type {
> +	/* X86_CPU_TYPE_ANY */
> +	TOPO_CPU_TYPE_ANY = 0,

I don't really understand the purpose of TOPO_CPU_TYPE_ANY here. In the cpu
matching infrastructure, X86_CPU_TYPE_ANY makes sense. Here I fail to
understand how is TOPO_CPU_TYPE_ANY different from UNKNOWN? A table passed
to x86_match_cpu() with X86_CPU_TYPE_ANY entry will match any CPU type
including TOPO_CPU_TYPE_UNKNOWN.

> +	TOPO_CPU_TYPE_PERFORMANCE,
> +	TOPO_CPU_TYPE_EFFICIENCY,
> +	TOPO_CPU_TYPE_UNKNOWN,
> +};
>  
>  struct cpuinfo_topology {
>  	// Real APIC ID read from the local APIC
> @@ -104,7 +108,7 @@ struct cpuinfo_topology {
>  
>  	// Hardware defined CPU-type
>  	union {
> -		u32		cpu_type;
> +		u32		hw_cpu_type;
>  		struct {
>  			// CPUID.1A.EAX[23-0]
>  			u32	intel_native_model_id	:24;
> @@ -119,8 +123,14 @@ struct cpuinfo_topology {
>  				amd_type		:4;
>  		};
>  	};
> +
> +	// Linux vendor-agnostic CPU type
> +	enum x86_topology_cpu_type cpu_type;
>  };
>  
> +/*
> + * CPU type and hardware bug flags. Kept separately for each CPU.
> + */
>  struct cpuinfo_x86 {
>  	union {
>  		/*
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 8fb61d2465eb..ef76ba674f1b 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -114,12 +114,6 @@ enum x86_topology_domains {
>  	TOPO_MAX_DOMAIN,
>  };
>  
> -enum x86_topology_cpu_type {
> -	TOPO_CPU_TYPE_PERFORMANCE,
> -	TOPO_CPU_TYPE_EFFICIENCY,
> -	TOPO_CPU_TYPE_UNKNOWN,
> -};
...
>  /**
>   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
>   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  			continue;
>  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
>  			continue;
> -		if (!x86_match_vendor_cpu_type(c, m))
> +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)

In line with what Thomas pointed that cpu_type is not a system property, I
suggest matching cpu_type should be dropped from x86_match_cpu(). More so
because it only uses boot_cpu_data and misses the other types of secondary
CPUs. I feel it is not a reliable way to match CPU types. Thoughts?

>  			continue;
>  		return m;
>  	}
> diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
> index 37326297f80c..74e02bacd854 100644
> --- a/arch/x86/kernel/cpu/topology.h
> +++ b/arch/x86/kernel/cpu/topology.h
> @@ -22,6 +22,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>  bool cpu_parse_topology_ext(struct topo_scan *tscan);
>  void cpu_parse_topology_amd(struct topo_scan *tscan);
>  void cpu_topology_fixup_amd(struct topo_scan *tscan);
> +enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
>  
>  static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
>  {
> diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
> index da080d732e10..c5a6944df86a 100644
> --- a/arch/x86/kernel/cpu/topology_amd.c
> +++ b/arch/x86/kernel/cpu/topology_amd.c
> @@ -177,8 +177,10 @@ static void topoext_fixup(struct topo_scan *tscan)
>  
>  static void parse_topology_amd(struct topo_scan *tscan)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
> -		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {

Slightly unrelated to this patch, on AMD is it that hw_cpu_type only
available on hybrid systems? On Intel ...

> +		tscan->c->topo.hw_cpu_type = cpuid_ebx(0x80000026);
> +		tscan->c->topo.cpu_type    = get_topology_cpu_type(tscan->c);
> +	}
>  
>  	/*
>  	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index cf7513416b70..b9d025f3373a 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -168,8 +168,12 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  	case X86_VENDOR_INTEL:
>  		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
>  			parse_legacy(tscan);
> -		if (c->cpuid_level >= 0x1a)
> -			c->topo.cpu_type = cpuid_eax(0x1a);
> +
> +		if (c->cpuid_level >= 0x1a) {
> +			c->topo.hw_cpu_type = cpuid_eax(0x1a);
> +			c->topo.cpu_type    = get_topology_cpu_type(c);

... hw_cpu_type could be enumerated on non-hybrid parts.

> +		}
> +
>  		break;
>  	}
>  }
