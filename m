Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F2436BF7;
	Mon,  6 Jul 2026 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362562; cv=none; b=h8qLJmmJa0wyR6Y2MtgAdzBlWgLsuHm7wddk1BF+CDxIoQAasxtKtKAYG5lHvHBr70+7BayfzD4cr8Yny8bCz029WqCgs/KZAbC8z9xBa+Eijdwz7aKY2QKjkei7MQTGDnsHDhZzFYBuxNQJlPecG0lH3nw3+0Roxc57gsHamC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362562; c=relaxed/simple;
	bh=vpypzWKI66Pglyg5BkxV01BGG0O94sct/OWR2lvFxS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDXJJgkysCYCenkw/t7BDSCXZmyekMzpU7XzJuF5EtNARU+7IYt4yiqFvFjCn2VlKkAqUkrdtXRMUVgveZryV2uy0S9TwR90tcpyDSWsmZqOQVh3xxaIm1SlChGSQRnjpu9x6YcKUlZgqLQGaLfmslz4qtv1NmpoY2vS/3T3RJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blpZ7Rr+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blpZ7Rr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783362559; x=1814898559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpypzWKI66Pglyg5BkxV01BGG0O94sct/OWR2lvFxS0=;
  b=blpZ7Rr+LvIs5SCHrN+ZGRR1olYQk9DvYGhe2tjQoTvpTAEqOAvK7UwT
   orsuUWbyDejVMDgeaYIkH/5S3N9iuM8UB3bMzPO3TD002BvrXHUlcQgiQ
   UNmIuaOloQkq4P3XMKhWjowit/ANylF2/F6a9yUkom1g6Y4ISiiNXJ4RY
   U/Jeb/OgFa3pHazCE+teqjGZT7Z9o/GmCrCdAVfx6zeHjhRuoRd7+FxJO
   OAQ+D28A99jHXuHH4/EP9ruQLJJUlvjHySMRwpzkCLWUKhqZ5wLXOcoKG
   cnV6KZAfHxFV93oxn6QnEvklAXGt/2zpeBULyE5uLIpGjpGPG7oaIxAYO
   g==;
X-CSE-ConnectionGUID: mRi1iHqyQWC94SvluxMc0A==
X-CSE-MsgGUID: p+D+Rd+FS0moaoXkqAwZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84194411"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84194411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:29:18 -0700
X-CSE-ConnectionGUID: 9AucuqkuStuSHhkj2B1QsQ==
X-CSE-MsgGUID: ONQ40QQaSN+QST8JNucA4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258704045"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:29:18 -0700
Date: Mon, 6 Jul 2026 11:29:07 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>

On Fri, Jul 03, 2026 at 12:32:22PM -0700, Borislav Petkov wrote:
> + Dave and Pawan.
> 
> On Thu, Jul 02, 2026 at 04:03:37PM -0700, Borislav Petkov wrote:
> > On Fri, Jul 03, 2026 at 12:06:32AM +0200, Thomas Gleixner wrote:
> > > Just do the mapping to vendor-agnostic types _once_ when you enumerate the CPU
> > > and store that information in the per CPU data.
> > > 
> > > Then you can do proper vendor agnostic matching against that and define
> > > the TYPE_ANY value as you want without ever colliding with vendor
> > > muck.
> > > 
> > > As a bonus get_topology_cpu_type() goes away too as the translation has
> > > been done already.
> > 
> > Yeah, we should've done it from the very beginning this way. Lemme hack it up
> > and see how it looks like.
> > 
> > Thanks for the cool idea.
> 
> Something like the totally untested below - but it builds at least.
> 
> We've allocated a u8 for the struct x86_cpu_id member type and we compare that
> to enum x86_topology_cpu_type cpu_type. I guess that's ok for now...
> 
> There's potential for more cleanup by removing the ->intel_type and ->amd_type
> and converting them all to our internal represenation of CPU_TYPE but that's
> for later and other patches anyway.
> 
> Thoughts?
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 8d8f890c4bc0..746822bd71fb 100644
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

This looks good to me. However, we need to take care of some special cases
like ...

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
> -
>  struct x86_topology_system {
>  	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
>  	unsigned int	dom_size[TOPO_MAX_DOMAIN];
> @@ -160,7 +154,6 @@ extern unsigned int __num_nodes_per_package;
>  struct cpuinfo_x86;
>  
>  const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
> -enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
>  
>  static inline unsigned int topology_max_packages(void)
>  {
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index be4c5e9e5ff6..b8f5dd0a8117 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -241,7 +241,6 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
>   */
>  int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  {
> -	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
>  	bool prefcore;
>  	int ret;
>  	u32 tmp;
> @@ -273,8 +272,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  
>  	/* detect if running on heterogeneous design */
>  	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
> -		switch (core_type) {
> +		switch (cpu_data(cpu).topo.cpu_type) {
>  		case TOPO_CPU_TYPE_UNKNOWN:
> +		case TOPO_CPU_TYPE_ANY:
>  			pr_warn("Undefined core type found for cpu %d\n", cpu);
>  			break;
>  		case TOPO_CPU_TYPE_PERFORMANCE:
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 4604802692da..7ab077f0cc66 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -5,34 +5,6 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  
> -/**
> - * x86_match_vendor_cpu_type - helper function to match the hardware defined
> - *                             cpu-type for a single entry in the x86_cpu_id
> - *                             table. Note, this function does not match the
> - *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
> - *                             TOPO_CPU_TYPE_PERFORMANCE.
> - * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
> - * @m: Pointer to the x86_cpu_id entry to match against.
> - *
> - * Return: true if the cpu-type matches, false otherwise.
> - */
> -static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
> -{
> -	if (m->type == X86_CPU_TYPE_ANY)
> -		return true;
> -
> -	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
> -	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -		return true;
> -
> -	if (c->x86_vendor == X86_VENDOR_INTEL)
> -		return m->type == c->topo.intel_type;
> -	if (c->x86_vendor == X86_VENDOR_AMD)
> -		return m->type == c->topo.amd_type;
> -
> -	return false;
> -}
> -
>  /**
>   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
>   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  			continue;
>  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
>  			continue;
> -		if (!x86_match_vendor_cpu_type(c, m))
> +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)

... matching a hybrid CPU to any cpu_type.

Also, I think now cpu_vuln_blacklist[] needs TOPO_CPU_TYPE_EFFICIENCY
instead of ATOM.

  VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,                   ATOM,      RFDS | VMSCAPE),
  VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,          X86_STEP_MAX,      VMSCAPE),
  VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,        X86_STEP_MAX,      RFDS | VMSCAPE),
  VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,                  ATOM,      RFDS | VMSCAPE),
