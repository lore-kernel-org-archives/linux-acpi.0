Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92163B9;
	Thu,  2 Jul 2026 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952057; cv=none; b=C5mAiWY0vDuSwk5SOWzQpL3XRPR1L/hqGD2KufY5LoGLnhjjgvi+59aflCcsnGeRloVmDCbn4QcEmh3G6Sj1myOKwaA4tKfPuNxwBBqHc4xKA/D37romCCBjWznUzxRCMLsey5giitemjrGedlZFbAr2xi9T2uBEASfbx0nGHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952057; c=relaxed/simple;
	bh=CPzJ+I7NovQZifc0w68Ee4fm5sjWGOuPE8rp93526sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VofOUIkP/I4ykefCbNXmB9xnqoaiKqyRT9zMsBh5n/ygouEbS+9NfA2BGy7byUd0iZbSFS/fFcBgj5Ft238JwAg+9UTyp7UudxDzMChOi7Jku52kDs01Id3uVaVQ8P1PH7dorZbUuwcMDXAfC8hBbOIYDs2eHTs1d4Uk7JzysUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sb1Q0hW+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sb1Q0hW+"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8AD1340E01B4;
	Thu,  2 Jul 2026 00:27:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3RywDF9COYDO; Thu,  2 Jul 2026 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782952042; bh=TOCDlGjElYtp3geq9uTU5Pi4ecETBBX38lqmH1SKJ/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sb1Q0hW+IzIKfYmyc1aaPwQuVnAvbf3kFj9TWLFW+GxUQ8wuGjALqYZudiDvtl6MA
	 yFU5IIx/QL+IqtdJQsiu9Ux/2M/u4USGGAHhpnMXh7jQf3Rqq7VERSqLTFDLm8lwPt
	 2X/ch835ufXvRGEuA9pP3FogkuOjHMdtB9U9vkkuUxFSWUvyOiqzCJ69jFUjH/YspH
	 Bn181CnDBPTEJdELhweKiT/XV67rI9irKYB0DGhLCnOPcpsCZ9OD1IYarWUk0v0gwr
	 rTMTLMuq/EI2Yy2Gc6TlZx3b1vjPiS+rHBdRm4wVtDxJ74zWlAWziObuKjwwYdWNKZ
	 IKqODAJ/m25dslhGIesgR0D2L9tjhG0+ynWospauY4iwrbeeEZS0FOUjG2aSC8kB1f
	 pe87SeSgRGQAgQdY7H5mQArtDW/UWsPAZjGRVanVGa2JezdxTeZedG9KBfH8/nA91S
	 t6dsZmlj5LfjnIWzLIX1dezoy/sYNnLbjURPwYvpcWhcyhsK5v18EZTDfzxyBKISLI
	 K7SpodIUxz4TQyuGrvUCZ7u87wi5yA2FP9YfR8QNzoAmIbcf4ASR5/woF89nEvGK+D
	 nG8MywHVJCgO58BxWHL9rY01VNj8+vB8fqL91BzQxFaAix/VgQs+EUYA9cfx2/bkzv
	 1kjYgmSSDlXUAhP3ixrFJu2Q=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D50540E0140;
	Thu,  2 Jul 2026 00:27:07 +0000 (UTC)
Date: Wed, 1 Jul 2026 17:27:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Vishal Badole <Vishal.Badole@amd.com>, dave.hansen@linux.intel.com,
	tglx@kernel.org
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, peterz@infradead.org,
	tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629094349.533301-2-Vishal.Badole@amd.com>

On Mon, Jun 29, 2026 at 03:13:48PM +0530, Vishal Badole wrote:
> Replace the bare 0/1 in get_topology_cpu_type() with named constants
> that mirror what the AMD APM publishes for CPUID Fn0x80000026
> EBX[31:28] (Extended CPU Topology, Core Type):
> 
>   0 - Performance core
>   1 - Efficient core
>   2 - Low-power core (used by a follow-up)
> 
> No functional change.
> 
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
>  arch/x86/include/asm/topology.h       | 6 ++++++
>  arch/x86/kernel/cpu/topology_common.c | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 0ba9bdb99871..9658b5676ce6 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -120,6 +120,12 @@ enum x86_topology_cpu_type {
>  	TOPO_CPU_TYPE_UNKNOWN,
>  };
>  
> +enum amd_cpu_type {
> +	AMD_CPU_TYPE_PERFORMANCE	= 0,

Sashiko says here:

---
  Will this break CPU matching if a driver attempts to target only AMD performance
  cores?
  The x86_cpu_id matching infrastructure treats 0 as the X86_CPU_TYPE_ANY wildcard.
  If a developer uses AMD_CPU_TYPE_PERFORMANCE (which evaluates to 0) in an
  x86_cpu_id match table, the infrastructure will interpret it as a wildcard:
  arch/x86/kernel/cpu/match.c:x86_match_vendor_cpu_type() {
  	...
  	if (m->type == X86_CPU_TYPE_ANY)
  		return true;
  	...
  }
  Could this cause drivers to silently bind to all AMD core types, including
  efficiency and low-power cores, instead of just the performance cores?
---

see https://sashiko.dev/#/patchset/20260629094349.533301-1-Vishal.Badole%40amd.com

And it does make sense to me - x86_match_vendor_cpu_type() is supposed to
receive the *hardware* defined CPU type - not the generic ones. And I think
that was a mistake because the value 0 on AMD means a performance core type
but in the kernel we called it X86_CPU_TYPE_ANY. Which is also not surprising
- all our ANY types are 0.

Now, one fix would be if we define X86_CPU_TYPE_ANY as 0xff and hope that
Intel will never define it.

On AMD that value is guaranteed to be invalid because the core type field is
only 4 bits.

But it can happen that one vendor's core type field can match another core
type of the other vendor. Which would mean that we cannot use X86_VENDOR_ANY
in any of the match_id tables when using a core type.

Or, we do the proper fix and we map all vendor core types to the kernel's,
vendor-agnostic TOPO_CPU_TYPE_* enums and then we're all good - we'd only need
to convert the vendor ones to the generic ones on comparison but we do that
anyway.

Thoughts?

> +	AMD_CPU_TYPE_EFFICIENCY		= 1,
> +	AMD_CPU_TYPE_LOW_POWER		= 2,
> +};
> +
>  struct x86_topology_system {
>  	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
>  	unsigned int	dom_size[TOPO_MAX_DOMAIN];
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index cf7513416b70..e1cc25a115ca 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -42,8 +42,8 @@ enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
>  	}
>  	if (c->x86_vendor == X86_VENDOR_AMD) {
>  		switch (c->topo.amd_type) {
> -		case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
> -		case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
> +		case AMD_CPU_TYPE_PERFORMANCE:	return TOPO_CPU_TYPE_PERFORMANCE;
> +		case AMD_CPU_TYPE_EFFICIENCY:	return TOPO_CPU_TYPE_EFFICIENCY;
>  		}
>  	}
>  
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
