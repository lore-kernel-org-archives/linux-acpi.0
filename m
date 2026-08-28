Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC93164D6;
	Fri, 28 Aug 2026 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897067; cv=none; b=BI01hChcN6ZbMXiV9U3B5/YSyGdDlfRaEcARhfmCPOKcEC0A/3Aua07aLSGg0JlnpajNDeEzTyT62sYV9RhBv407uTxBA85vcC4vVOODekSZX0tWun9YdYMbWjHuSuIEDln5vxH3oSEWENyPC6bAwSwmFRQ/0XYMp07ru7+d82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897067; c=relaxed/simple;
	bh=M4MGkdAZoE7j9CsmHdKdsbS6uOe+HOhnoMjllUoMQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw5mebORL2sQI77XRdRm6McAUCa80ziuXl2ex3ptvDFpu7hRJihz02mgRF4GvReEhOqIHdK7O0JVEUR8GVfgRCxcKnlNgSNH7GKtKdYfa34QBcxKiqq6Ay78Il/LRkGv6fmnxkfaUNoX/AgBF1ducf6lqYUAi8j9xMfL4/q3flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1FTlJ85; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1FTlJ85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787897065; x=1819433065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4MGkdAZoE7j9CsmHdKdsbS6uOe+HOhnoMjllUoMQo4=;
  b=W1FTlJ85NFbNO5lIVHtKv0/bJL8pvHYaMiLpVXFaFk3Zuts6eeuRfQm+
   pmsj9I9LEv8p10UF+vneJ8M8Z0z1aDZLjm/2k6aZQABjIFIMafbBZ7/cO
   wiiiQauS+yuY9oROAXmVRvNZS8cWtnlBK+dXh0fuXWrS8lMpbLvGuMrBC
   AH8+cpO4bjTTnv9oXMr00zH/qO5zKQzk8MDLwLP3FNDeQub/MFuzvR/0a
   3+gxZkJgXRqdwsBjAMmXklP1ud6QkDBhFf2bjmnnuZsR9vMzzbfwc0vBl
   6ZpIYViwqU4auJ9W351wIYErLRswO5NDMhgedujV5/hVpzNBEsO1FcnmX
   A==;
X-CSE-ConnectionGUID: jvFHiOaBT4K2bb/aFfZVwA==
X-CSE-MsgGUID: KGMDlS0LTUymF9IMf5ATsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="87534460"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="87534460"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:04:25 -0700
X-CSE-ConnectionGUID: FObAe5TNQoacAXm70EWaUQ==
X-CSE-MsgGUID: bppNnDiTSZaroWrvAJtlfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="272287430"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:04:25 -0700
Date: Thu, 27 Aug 2026 23:04:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <xsoek4nqflm4b54c4gc334hv4jqkpgnmi3mu5xffz4vevtmmrt@vfkoedmpssfy>
References: <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
 <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
 <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>
 <20260722212314.GFamE0wsvHL6eLvTjT@fat_crate.local>
 <20260827204425.GDapChqT4IymVmrf7T@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827204425.GDapChqT4IymVmrf7T@fat_crate.local>

On Thu, Aug 27, 2026 at 01:44:25PM -0700, Borislav Petkov wrote:
> Here's the cleanup ontop, lemme know pls whether that makes sense.
> 
> Some noteworthy things:
> 
> * this basically switches to TOPO_CPU_TYPE and only the detection code knows
> about the vendor-specific ones. The generic types are union set of both.
> 
> * We do some CPUID calls where needed:
> 
> -			native_id = c->topo.intel_native_model_id;
> +			native_id = cpuid_eax(0x1a) & GENMASK(23, 0);
> 
> and in get_topology_cpu_type() but those will go away too with Ahmed's rework
> 
> The rest is just manual conversion labour. Oh, and TOPO_CPU_TYPE_ANY is gone
> too, so that Pawan can sleep at night :-P

And put my OCD to rest :-)
(BTW, some of that is acquired occupational hazard.)

> Thoughts?

Overall, looks like a good cleanup to me.

> I think it is better this way instead of carrying intel_type and amd_type in
> cpuinfo - now the topology code is preparing things for us.
> 
> I'll split it into proper patches if people are ok with it.
> 
> Thx.
...
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -35,13 +35,17 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>  enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
>  {
>  	if (c->x86_vendor == X86_VENDOR_INTEL) {
> -		switch (c->topo.intel_type) {
> +		unsigned int type = (cpuid_eax(0x1a) >> 24) & 0xff;

You already mentioned about the cpuid taken care elsewhere, just noting
that this needs a (c->cpuid_level >= 0x1a) check.

> +		switch (type) {
>  		case INTEL_CPU_TYPE_ATOM: return TOPO_CPU_TYPE_EFFICIENCY;
>  		case INTEL_CPU_TYPE_CORE: return TOPO_CPU_TYPE_PERFORMANCE;
>  		}
>  	}

Since x86_match_cpu() matches with boot_cpu_data, one rough edge remaining
is, a secondary cpu_type in a hybrid system can never be matched. For
this reason X86_MATCH_VFM_CPU_TYPE() is of little use now.
