Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9A30C160;
	Wed, 22 Jul 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748142; cv=none; b=nVqLUy8Euj3KIOY++FXeeWLcalmFN/ouvseU72sWnP+yePTbZYoxrXosJ/5B3nYbTcgI+IVNFwya6Mk9MgjPUz0jVbPILaxqh/kv5rZ3TU/3s79qbyhZFZO6NGo98MJQPU5zVVl1wJuWr4mCsg9FGG7adbDhB+cJPDbyj2hjWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748142; c=relaxed/simple;
	bh=It+jlZbdt75/W/l+4ayQJmweZv0QJaaEkujYz4B0myM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/O3VSgQ0FfIO/NKO3L9DUvOZnI8XOJC0LVb/jIrTi37fNFg3Ny87BhR61JnRqUsr3Jhcyt5SIOri1+UuHhXAzFKGGUYIeAPYY0fJBcydV9Yxtgd/k4he0esrNy0MkLSh1WTUWrcfeMJraOgEA2nRLJuXmPXRyuvIcxRCImsJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHBD53oi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHBD53oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784748140; x=1816284140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=It+jlZbdt75/W/l+4ayQJmweZv0QJaaEkujYz4B0myM=;
  b=UHBD53oi38igoUWP22BTxMhYYMw8KFX59YF45aOHqkxg99FN8zIxLDOy
   aTSrzb7PFxgd0qk2l0aTWdPJ+vPIeYgQVf/tlYuL8SvAJTGPZJekHT2lt
   PvBjjlAnYgCmGXNBrRayKGovj1b2D9I8zVrZ1fzsqSMRoRbAbxOSzkUaD
   3ivSPklvyKxLxCxM1SvMql0vbSCVTOXQo6HJ/ymJi6c8kJGlPLK3jhzmh
   NDrG69YO4D/8TOEO3C9U35R1ksZCkgl+cpFoN6a4nEXj6suSZEEsyzVxB
   IvcIDfizXpvqrHtJ1iWobf1WFcFG2yLtg8mjJUNgvf92vzpyv3kRqJ5FP
   g==;
X-CSE-ConnectionGUID: i2FyeJ5GQz2Q6t7gSon1tA==
X-CSE-MsgGUID: 1RnNBfW1SJauLnMlrhYy0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96533304"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96533304"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:22:19 -0700
X-CSE-ConnectionGUID: bkAQB5SQSHKP2LN7aZnjAg==
X-CSE-MsgGUID: Om0ZN1U+RS+9twYqG/Hz1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="253824289"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:22:20 -0700
Date: Wed, 22 Jul 2026 12:22:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
References: <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>

On Wed, Jul 22, 2026 at 11:31:52AM -0700, Borislav Petkov wrote:
> On Wed, Jul 22, 2026 at 11:09:58AM -0700, Pawan Gupta wrote:
> > > +enum x86_topology_cpu_type {
> > > +	/* X86_CPU_TYPE_ANY */
> > > +	TOPO_CPU_TYPE_ANY = 0,
> > 
> > I don't really understand the purpose of TOPO_CPU_TYPE_ANY here. In the cpu
> > matching infrastructure, X86_CPU_TYPE_ANY makes sense. Here I fail to
> > understand how is TOPO_CPU_TYPE_ANY different from UNKNOWN? A table passed
> > to x86_match_cpu() with X86_CPU_TYPE_ANY entry will match any CPU type
> > including TOPO_CPU_TYPE_UNKNOWN.
> 
> This will go away in future patches. We do one logical thing per patch and
> removing UNKNOWN is not it. I have it on my TODO list to clean up everything
> here.

Unless I am misreading, TOPO_CPU_TYPE_ANY is introduced in this patch.
X86_*_ANY in x86_match_cpu() are much needed wildcards, I dont really
understand why x86_topology_cpu_type needs to carry a wildcard. It should
reflect the true state, PERFORMANCE, EFFICIENCY or UNKNOWN.

Between ANY and UNKNOWN, I would prefer UNKNOWN when CPU did not report a
type.

> > 
> > > +	TOPO_CPU_TYPE_PERFORMANCE,
> > > +	TOPO_CPU_TYPE_EFFICIENCY,
> > > +	TOPO_CPU_TYPE_UNKNOWN,
> > > +};
> 
> ...
> 
> > > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
> > >  			continue;
> > >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
> > >  			continue;
> > > -		if (!x86_match_vendor_cpu_type(c, m))
> > > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
> > 
> > In line with what Thomas pointed that cpu_type is not a system property, I
> > suggest matching cpu_type should be dropped from x86_match_cpu(). More so
> > because it only uses boot_cpu_data and misses the other types of secondary
> > CPUs. I feel it is not a reliable way to match CPU types. Thoughts?
> 
> How do you suggest we match CPU types on the whole system?
> 
> I.e., "do this workaround only on the performance cores", for example.
> 
> c->topo.cpu_type is perfect for that then.

Ya. If need be, a mask of each possible cpu_type can be built for
dispatching work selectively.
