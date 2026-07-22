Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424C3DC4AF;
	Wed, 22 Jul 2026 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753888; cv=none; b=Zu5j7CSOgA+cnT4bDEhoqtjny2jP9Uv2anRSjfsZXjqZwgzoWAVDRuQu1dILPF2vv7sgBq9ArWTxUeYs+xr3cIP/PN7Qj4m+IfYqZKwsS1U+EXMg434D/tvrzVWjnVW7gKBJJVKPhcHd0kMiEtN05609L0/NCH+GacLXvQOLkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753888; c=relaxed/simple;
	bh=FOc6NRCYANFMRr0hBxsonXdnmMkQun+bMIRpRo/4eNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU8QaroKpxMif39n9sVEhJqht2zzxlZ6vbnu7/0IC1na7H4wt28nl7GyNba0p/mCR6MhSbBvTJJZ0ZSDNo74c6RmAvvmNUZn40TyKXrXf+2PyZL1NO49ot8O7CUlgfHZ2ikAw6xribhe62I7mVtSvA9q5UOCEUn0CI27Vd6PuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAGThg9P; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAGThg9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784753887; x=1816289887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOc6NRCYANFMRr0hBxsonXdnmMkQun+bMIRpRo/4eNA=;
  b=YAGThg9PJxmESxHuLHx2EYV6M21m52QGOZ3X0yAyYtJaq05L3Oi9zq97
   zVyqAQ2kGfA0O57IsRYX11z15sxZlNluVHAD5u5qX4byXNeXLwFJ2U2v2
   yqa/bCQsLk3RlEl1MBpRT43GXVI3fn6FuEdRSLTFLO0LHrt5j01GPgafE
   slG87xbOyKfHG/iLpp9Mj2d339Kq9/ccOKM7j9A+Ku1jsuHF386RRWP/V
   zgc5xYXBDMhshDT5PIBxva+rZz0Wwk2xLQVFWb1brz5RJUSkomJTWDwXx
   d+l9pimjlXemZKmDTvJpuBwZQRYB+DQSkNqIl0OzUEv+N7T4rNEXgRunc
   g==;
X-CSE-ConnectionGUID: 2kn77c85RzKdQEmiyhEEyg==
X-CSE-MsgGUID: jZ2N+Gn1Qwi36mNmQ/K11Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95754959"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="95754959"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 13:58:06 -0700
X-CSE-ConnectionGUID: /QdRJwExTG+pViWxBKxgcw==
X-CSE-MsgGUID: BHnap6o4RISlppRLemeRiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="258272596"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 13:58:06 -0700
Date: Wed, 22 Jul 2026 13:57:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>
References: <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
 <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>

On Wed, Jul 22, 2026 at 12:51:05PM -0700, Borislav Petkov wrote:
> On Wed, Jul 22, 2026 at 12:22:11PM -0700, Pawan Gupta wrote:
> > Unless I am misreading, TOPO_CPU_TYPE_ANY is introduced in this patch.
> > X86_*_ANY in x86_match_cpu() are much needed wildcards, I dont really
> > understand why x86_topology_cpu_type needs to carry a wildcard. It should
> > reflect the true state, PERFORMANCE, EFFICIENCY or UNKNOWN.
> > 
> > Between ANY and UNKNOWN, I would prefer UNKNOWN when CPU did not report a
> > type.
> 
> Because X86_CPU_TYPE_ANY is already there and it is 0 and TOPO_CPU_TYPE_ANY is
> supposed to be the same and mirror it.

This is exactly what I don't understand. For a wildcard X86_CPU_TYPE_ANY
that matches TOPO_CPU_TYPE_*, do we really need TOPO_CPU_TYPE_ANY for
matching to work?

> Did you even read my mail where I explain that we don't do multiple things in
> one patch?

Yes, but my main concern is about addition of TOPO_CPU_TYPE_ANY. If we
don't add TOPO_CPU_TYPE_ANY, second patch will not be needed. Sorry if I am
mis-interpreting things.

> > Ya. If need be, a mask of each possible cpu_type can be built for
> > dispatching work selectively.
>
> Instead of doing the completely sensible thing and keeping a per-CPU type?

My earlier comment was unnecessary, and putting us off-track here. Please
ignore this part.

(Just to clarify what I meant: For dispatching work to all P-cores in your
example scenario with something like on_each_cpu_mask() we would need a
mask of all P-cores. Such a mask can be built/cached using the per-CPU type
information).
