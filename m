Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF31A6823;
	Tue,  7 Jul 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446770; cv=none; b=CEDlkYvRNeFzFx9w+eNaoebarT4z1wbDpNdUqSQLkZK/hKsVWT16+zpLnGz7A2u6uvYWJJGK9k+aT+GU+/Q8G36xHcOkykhdEC7884gE2MIkYm8sg5Z0hYO8uFXdUleTSbGBGY/B9QwveuucKllgnqSc1Es2QozH9jMu4sHFrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446770; c=relaxed/simple;
	bh=1h0GjdZgYvvXWeVjtn91wifN191ALxykCY1UGdW9Brc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdyu0DfSgGZmVk9p6DtRsqWW6Vma6eD79htG9mfVH0NqBvdOz82UJUYf5kkZA2//Vr/g8H9UrHF+cVxEuTkX5Ib9//MoqdvwPLa12tAbG9si7KFOHZ7LDdZ1IO01l4tp6mSKvACx0HSLiAmBG1+3BxLwzuusNkkcq+mIfdESXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFFAk+0Y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFFAk+0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783446769; x=1814982769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1h0GjdZgYvvXWeVjtn91wifN191ALxykCY1UGdW9Brc=;
  b=jFFAk+0Yjc8SvdR9+Ke8nKT1yLKbA0RIIFhcW+Q0CVUCbjA6FnvQAkmZ
   7qhI06OpkN6hRPyfu/eVa1xAqRZXG5IwiaY9uXQc1hGPTqoVCRFKD6+f9
   YvjhD9WWlO8jnwZvcB2HkL1zo58ofBJ+ptRwrqIaXHDCQ7VVypJj100rx
   d6XNUq7wKSmtngrZc0K5uB3uW3R/NA0zfTtHHuv7IgZPPIBkiYxhERlWf
   +7YcLr+sfWLl2UPWSs2FAeE4jJtbGUvEAgezHTdOjFA1ql8y5zXDo9GlA
   Md3U47uMTkhkPxFIMS31xRI5X5rs5jAIgKkmMvN7vlEtrRJ+kax2nBxJ8
   g==;
X-CSE-ConnectionGUID: Zaj8C6zsTCGwUu8TFKHs+g==
X-CSE-MsgGUID: yrfN70+GQpSd2WvmkoKM5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="109645918"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109645918"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:52:48 -0700
X-CSE-ConnectionGUID: nO4gsqrNT/yfRtvYWwRXaQ==
X-CSE-MsgGUID: 6Rntm+nHQo24/gfR27b7Mg==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:52:48 -0700
Date: Tue, 7 Jul 2026 10:52:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>

On Mon, Jul 06, 2026 at 05:47:13PM -0700, Borislav Petkov wrote:
> On Mon, Jul 06, 2026 at 11:29:07AM -0700, Pawan Gupta wrote:
> > >  /**
> > >   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
> > >   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> > > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
> > >  			continue;
> > >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
> > >  			continue;
> > > -		if (!x86_match_vendor_cpu_type(c, m))
> > > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
> > 
> > ... matching a hybrid CPU to any cpu_type.
> 
> I don't know what you mean here.

Vulnerability enumeration is done on the BSP, for a hybrid system with BSP
as a performance-core, a vulnerability that only affects efficiency-cores
would not be enumerated. So, x86_match_cpu() currently returns a match for
any cpu-type on a hybrid system.

> enum x86_topology_cpu_type {
>    /* X86_CPU_TYPE_ANY */
>    TOPO_CPU_TYPE_ANY = 0,
>    TOPO_CPU_TYPE_PERFORMANCE,
>    TOPO_CPU_TYPE_EFFICIENCY,
>    TOPO_CPU_TYPE_UNKNOWN,
> };
> 
> These are the Linux-specific CPU types and all vendor CPU types will be mapped
> to them. I hope 255 are enough.

255 should be more than enough, but it doesn't take resolve the problem of
matching a hybrid CPU to any cpu_type.

Apart from struct cpuinfo_x86 for each CPU, we have separate boot_cpu_data
for BSP. One possible solution is to set cpu_type to TOPO_CPU_TYPE_ANY in
BSP specific struct for hybrid systems.

For more accurate matching, x86_topology_cpu_type could be a u32 with
bit-fields for each CPU type. And boot_cpu_data can have:

  boot_cpu_data.topo.cpu_type = (TOPO_CPU_TYPE_PERFORMANCE | TOPO_CPU_TYPE_EFFICIENCY | ...)

on a hybrid system. Problem with this approach is, unless secondary CPUs
are brought up, BSP will not know what all cpu-types are present in the
system. Also with bit-fields, possible cpu-types are further limited.

To circumvent this problem, current implementation matches a hybrid CPU
with any cpu_type.

> > Also, I think now cpu_vuln_blacklist[] needs TOPO_CPU_TYPE_EFFICIENCY
> > instead of ATOM.
> > 
> >   VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,                   ATOM,      RFDS | VMSCAPE),
> >   VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,          X86_STEP_MAX,      VMSCAPE),
> >   VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,        X86_STEP_MAX,      RFDS | VMSCAPE),
> >   VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,                  ATOM,      RFDS | VMSCAPE),
> 
> Ack, right, ATOM == EFFICIENCY in Intel-speak, so I'd need to convert those.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
