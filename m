Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B58175A79;
	Wed, 22 Jul 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745152; cv=none; b=HaCVaDWNo3xUHTCHYPwojJyzRdaMqCKMJ4YYqn2ZbHLDRrOpcWg696PFPwfHYP97zz6musGkVAcJgkARaPSEbEi3+GiEXwSja+giQ52vMqmsnsbPspI3NFxrGbSPJtng03a8i4/sxHy5sC1yAlDE4vuDVN4xtXSj/zRaorsBTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745152; c=relaxed/simple;
	bh=kMI/V693fTDaB4DpLwKmHzAiMjoZWKqDKRwe4pStpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y93M6FZSDDeOe/W1tBdrQG+jmINvLd2A+KmN5I2sz07kdh3e7Eppeh4dIZB0CtlTOxKaO5NXekGoywdIQKoQpxiz7DjEnwfFpWs5estMu5pC0eS2u78uzZR1/pdwv9s+FfxTStACPu9BweyaCYTTp3dPUrOQKnVU7khqAjLK5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HJwP2ER9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HJwP2ER9"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8134440E00C4;
	Wed, 22 Jul 2026 18:32:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bS9HcZfNgY21; Wed, 22 Jul 2026 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784745131; bh=KZOI3/Algyctgch0kXam4o0kKinpyGB/t+yju7pdlEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJwP2ER9uYAU9sVf3Vcc6sn3kdjLMmluC47q7Sobv5HRUnvqe3gMgNgOn1e7bX+MT
	 yIcgy1ItUd37FihpGCMI2emHLnK/zAgqOS2m7Mgqwqa1kOyGvOHaZqm//CZxXEQPuR
	 IiivPRzNSS7kjyUMNR7huSI2+P12H/kuFVY8tTI7vQL1mBK+Bxq+ur/m2FKb4Gs512
	 FE+CWM4YvONum5sgliIfvd14HqsIclFhq4Nq+6Ro7SaBLi9mQItlxc4IfWzGer0rim
	 EIdxtusS1/CgVcK6CAQ+UanDn0ZpLXRe6LRU8gse2L4OH3Xo0BM1Yft9vrr56aHPu6
	 UoNE4paxqFmNOva+lZhIqZGXNFyTacDW6Ezwh/atPW5KFQh6EIzvNZNUe6vdQViNJg
	 AD9nhihM3mpScsQyP9dAV8IopXaBLNPapXQT8Az2DCPVLiUU5gmrShltep2LXo2pDG
	 3C0aotJnAfdfBEYPy+VLrWYwbTSlodFCn8/B8nPWxfw3WZ7kjDxothsAHxSEvINkhe
	 Z9hOU+DTqWt+ZsvVr2lfBA0GAvjRStanRfIdh5iK4esFcTZQvqoSkdj66eeRkbxdUM
	 wYjs1ZbIwYD0mmosjHv+T+CRbTeV+CYUk28668B6YMODixfutuoleFfOoAjaXvWMka
	 IjsmPtiTqdP4MrULy8UCeiuQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D70E140E00DC;
	Wed, 22 Jul 2026 18:31:55 +0000 (UTC)
Date: Wed, 22 Jul 2026 11:31:52 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com,
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
References: <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>

On Wed, Jul 22, 2026 at 11:09:58AM -0700, Pawan Gupta wrote:
> > +enum x86_topology_cpu_type {
> > +	/* X86_CPU_TYPE_ANY */
> > +	TOPO_CPU_TYPE_ANY = 0,
> 
> I don't really understand the purpose of TOPO_CPU_TYPE_ANY here. In the cpu
> matching infrastructure, X86_CPU_TYPE_ANY makes sense. Here I fail to
> understand how is TOPO_CPU_TYPE_ANY different from UNKNOWN? A table passed
> to x86_match_cpu() with X86_CPU_TYPE_ANY entry will match any CPU type
> including TOPO_CPU_TYPE_UNKNOWN.

This will go away in future patches. We do one logical thing per patch and
removing UNKNOWN is not it. I have it on my TODO list to clean up everything
here.

> 
> > +	TOPO_CPU_TYPE_PERFORMANCE,
> > +	TOPO_CPU_TYPE_EFFICIENCY,
> > +	TOPO_CPU_TYPE_UNKNOWN,
> > +};

...

> > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
> >  			continue;
> >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
> >  			continue;
> > -		if (!x86_match_vendor_cpu_type(c, m))
> > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
> 
> In line with what Thomas pointed that cpu_type is not a system property, I
> suggest matching cpu_type should be dropped from x86_match_cpu(). More so
> because it only uses boot_cpu_data and misses the other types of secondary
> CPUs. I feel it is not a reliable way to match CPU types. Thoughts?

How do you suggest we match CPU types on the whole system?

I.e., "do this workaround only on the performance cores", for example.

c->topo.cpu_type is perfect for that then.

> Slightly unrelated to this patch, on AMD is it that hw_cpu_type only
> available on hybrid systems?

No idea. I will dig through that later, when cleaning up.

If only available on hybrid systems, we will have to fake something there,
X86_CPU_TYPE_ANY perhaps.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
