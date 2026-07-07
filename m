Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926E1684BE;
	Tue,  7 Jul 2026 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783385265; cv=none; b=KCEivLSdGonLa+EpoZBigWyJHk9gNsgoz6tDXRJK8j/ThSirKwteiftlEYXMxktpiU5gD/3VyjNR5rNXEINv71CnxVU/JHKjJ02oaqtFROXeZWu51PuOefJyVyFNXUSvOZgK3Uzh9CqyPnBSUz+vzndrnGPvjy+dzTr0cxXHL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783385265; c=relaxed/simple;
	bh=9jGzjxeXrxXVqYKimZzko9RXz8xMXQAPsJV/lOlgzaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S43J9cWRi6D0MeQE6G/jGNeBV3ciPTmgTMP3J7wKwiXeaonQdLc1upojcDmMxdJa3+3hoJnx6Y3RFUzRzS7pTD5HSqaOcNADdBhiXbNgWoexhdCuTs8+32XZBhtrX1n4621b7C88jY/tzZmBsOIX552fkOfJVJP4Y0r11VhB0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ChG20tvP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ChG20tvP"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9AC5D40E00DC;
	Tue,  7 Jul 2026 00:47:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F3Z5OTChvrSB; Tue,  7 Jul 2026 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783385251; bh=kcgM0/c6qvR91SpK8+yevi3/3NmOkMONfqeR/XQaYUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChG20tvPAbcw0tjkkrBgAQQJk70P/iMbBPa/g/jaZVngCIhLw8NEevPo13SZ/HNHg
	 lh1mambMMlcffLUsGlobKIIty5IFl2e5XCxNXfjv45+puVwe07c5iCuMzZlm0oyaFz
	 35x6S1VIEpHq9X7w9K9w6G2ZwmK8VyQe040o4GOBZfaPOhFymuKFbYOQIJtvRQAa1/
	 sMbnYwq2YLsU5SXPiyGLJOpoo1MNFvZypaqnGx9P7w1pQkoJRY42K7ODBMbnCt1hlW
	 wJgdx7H3IEz2U/ybz98yPGsxRitt6uGbwQLQ1ne66bC2Iknl12TpmAEd49A9Z3bmZB
	 cqynLyryP4IIOLEBsT8pUPZLrQXsqTjFkoaRtA0WutZ0uJP4vbZEhGy6n3uLBL4o68
	 GIYyVvj0lhwGfP+AXzmLYtg0VDQ2eepgTCztgJPvjcYSz//oLlNRUM4bO80OqEBrpI
	 oze4daxFj3xIWsXo0H2bTdlyKOxRqCu5s/vc/LaLHIG3zxEF6lfpHr4uRk9SRfdczI
	 NZDrikZ6zXXQsYDVffKch9T3vrH2BCe09iFSy0sNJ965iOFQv2e6nJA2/Mgl9T2ihr
	 OMb4Fc0M2Bn4wIQJWP6mL8ZFwciby91sDvuGuJ6t1TmI3UZPT7M9DobFPtmZ9nvn2A
	 ix7AYOUuPWy6h3KSj4fBUq3s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05FF540E0140;
	Tue,  7 Jul 2026 00:47:15 +0000 (UTC)
Date: Mon, 6 Jul 2026 17:47:13 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com,
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>

On Mon, Jul 06, 2026 at 11:29:07AM -0700, Pawan Gupta wrote:
> >  /**
> >   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
> >   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
> > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
> >  			continue;
> >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
> >  			continue;
> > -		if (!x86_match_vendor_cpu_type(c, m))
> > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
> 
> ... matching a hybrid CPU to any cpu_type.

I don't know what you mean here.

enum x86_topology_cpu_type {
   /* X86_CPU_TYPE_ANY */
   TOPO_CPU_TYPE_ANY = 0,
   TOPO_CPU_TYPE_PERFORMANCE,
   TOPO_CPU_TYPE_EFFICIENCY,
   TOPO_CPU_TYPE_UNKNOWN,
};

These are the Linux-specific CPU types and all vendor CPU types will be mapped
to them. I hope 255 are enough.

> Also, I think now cpu_vuln_blacklist[] needs TOPO_CPU_TYPE_EFFICIENCY
> instead of ATOM.
> 
>   VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,                   ATOM,      RFDS | VMSCAPE),
>   VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,          X86_STEP_MAX,      VMSCAPE),
>   VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,        X86_STEP_MAX,      RFDS | VMSCAPE),
>   VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,                  ATOM,      RFDS | VMSCAPE),

Ack, right, ATOM == EFFICIENCY in Intel-speak, so I'd need to convert those.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
