Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639853C465;
	Tue,  7 Jul 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783457201; cv=none; b=gVHf3f9Gy1dPS/KUmXuqcmoFUj9CmNL5KllizD3eYveiNXct+tG0p3Ug/g0p+Y0FkPpKMcR1uW/ZxgpQbwnkN2GRge40xhm0ChkHi4+9cTcpzSuccUokyEL+pSWOp3YapdMS0FKwxNRTmZYFIiI7D4TOqd4GSiBmwDhZB/rIVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783457201; c=relaxed/simple;
	bh=2feor4Rlk8F63yEp8C54LWJS5oVwdvCQadM9ku0qZw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/yNVOUgLCiYhdjFkzFX4tCRJ2075HjY9x98+Z7QU63JwbTUtuAnooO5+DIN5ShBaDGGphN728f9Y30xePJKMkHkaLxeEb/qIRA6wCIMlmRs+xRXry+ky+/2Xb8MpVrHxoAJZNJZC3QVGgeH3j7121vXy6o9vTclG0De9FjQ8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OB6RMc7Q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OB6RMc7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783457200; x=1814993200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2feor4Rlk8F63yEp8C54LWJS5oVwdvCQadM9ku0qZw0=;
  b=OB6RMc7QIhmbeIIJT//HDYJiCdG02LMKwvVlqxqmIEi3KujIVb8fOyYU
   5RiDpe+vCJsKDa2T5+r+TtegGcO+Xar27SvDZcA6h353tp46OOc36uNjF
   4StKnw1wj1pr25H4J66VmPeza44DHkMDh4J/mbKFPP6oGoADXp6gjrjON
   6B9dwizQrZy7gS92uVoOmYaQ9qnZuOgNxjBNexBQkvDoKw+vnyhDUO454
   rvZvugmzRsXM96ueJHxElzFJI+axq4WHjsI20+hbB7VT+/nSiVxKzUUv4
   m0e5VsTN+37p+ugx6/xnd6sqKagk8WQeFJnZPi1xn+ehWiDcMcWs0UMJO
   Q==;
X-CSE-ConnectionGUID: DLy6ve45R/uP28lwDB78Ow==
X-CSE-MsgGUID: hOW4tm2eROu1jDDR6whUDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95270879"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95270879"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 13:46:39 -0700
X-CSE-ConnectionGUID: jyKvUcW8QsWTsCDnfB2e8w==
X-CSE-MsgGUID: Kzqyu0CXQb+oL6gt8MZBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254170394"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 13:46:39 -0700
Date: Tue, 7 Jul 2026 13:46:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com, 
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, peterz@infradead.org, tony.luck@intel.com, 
	chang.seok.bae@intel.com, wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlv6sin7.ffs@fw13>

On Tue, Jul 07, 2026 at 09:29:32PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 07 2026 at 10:52, Pawan Gupta wrote:
> > On Mon, Jul 06, 2026 at 05:47:13PM -0700, Borislav Petkov wrote:
> >> On Mon, Jul 06, 2026 at 11:29:07AM -0700, Pawan Gupta wrote:
> >> > >  /**
> >> > >   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
> >> > >   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> >> > > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
> >> > >  			continue;
> >> > >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
> >> > >  			continue;
> >> > > -		if (!x86_match_vendor_cpu_type(c, m))
> >> > > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
> >> > 
> >> > ... matching a hybrid CPU to any cpu_type.
> >> 
> >> I don't know what you mean here.
> >
> > Vulnerability enumeration is done on the BSP, for a hybrid system with BSP
> > as a performance-core, a vulnerability that only affects efficiency-cores
> > would not be enumerated. So, x86_match_cpu() currently returns a match for
> > any cpu-type on a hybrid system.
> 
> Abusing the type, which enumerates performance properties, for
> vulnerability crystal ball logic is simply broken.
> 
> The type is a per CPU property and has nothing to do with hybrid or
> not. Hybrid is a packet property.
> 
> Just because it is convenient does not make it more correct. If you need
> to enable mitigations on hybrid systems, then explicitely check for the
> hybrid property.

Right, I was convoluting 2 different goals. Vulnerability enumeration
should explicitly check for hybrid.

Currently, only RFDS needs to check for hybrid. It is probably not worth
creating a new mechanism for cpu_type check for vulnerability enumeration.
Below should work with current set of CPUs. Please let me know if there is
a better way to handle this:

---
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..836076b1a3b5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1316,10 +1316,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
-	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS | VMSCAPE),
-	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS | VMSCAPE),
@@ -1388,7 +1386,20 @@ static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
-	return cpu_matches(cpu_vuln_blacklist, RFDS);
+	if (!cpu_matches(cpu_vuln_blacklist, RFDS))
+		return false;
+
+	/*
+	 * ADL and RPL are only affected if they have Atom CPUs.
+	 * Hybrids have both Core and Atom CPUs, mark them vulnerable.
+	 */
+	if ((boot_cpu_data.x86_model == 0x97 ||
+	     boot_cpu_data.x86_model == 0xB7) &&
+	     boot_cpu_data.topo.hw_cpu_type == INTEL_CPU_TYPE_CORE &&
+	     !boot_cpu_has(X86_FEATURE_HYBRID_CPU))
+		return false;
+
+	return true;
 }
 
 static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
