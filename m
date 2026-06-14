Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870282BE7DB;
	Sun, 14 Jun 2026 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428126; cv=none; b=T1hF31NTkIJmp7DsPTprIcgC1RO10Y6DLFZ4pVzBv9xaG4fCewP/5Zszh6KHq00lan9iIXRsVLLap6pcak7fjTLXg3M6Dq7JqAbqtdnPRLunLcVvpL0bQg4gTdlqFK2eytm0CO6AGScl7cE9WKlMyBjJF+bvDZ9nUWi3YYaasz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428126; c=relaxed/simple;
	bh=ds1HsbZs+TpMLIF0S0Y/rsn8pgGEfs4bWpfItaniQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwoiIVADzaYeRY+zdP4cuFYKiBJNpNhAEeJslS2Dy9grm3Vjnc/LafUjKvSCcuuKVjUhfQpeWbnYB5/TNj/8O/050s+AjuJgUKNTHRcjJ3Quz2gpAVFZOZOTf1qNRM5CuqPSWiJ4R6284rkUK4b8DOSJqbytt8iuCHxmktO8Ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmDgkLjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmDgkLjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CAE1F000E9;
	Sun, 14 Jun 2026 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781428125;
	bh=9LYN2F22JfxLMFILRwK47fnnXK4CRYMdn70feq0hkAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmDgkLjtoZnLFZgAtR+vHMK67JuchCave9VSHr4gLxyba74SghnllzjeHu1vbkQOW
	 XMApUd/vQy4am3/StkR3hL+lROIGeGWOtRo949v3aVeGb9zi8sfmGMdbwQGgC7T5fH
	 i2A7clnIf1ZvlIDh41v0VNmHzZq2u55//0upr281SoxrShLFRXxfcU3mk6AJIyCr5N
	 5YyVO6Fsl3tlEDNaZeeEUxHQTAN0b3oc9b8C6+IfnDtEEgxEseTYT2914AIAMH+r7c
	 dqZeXh3ZbKvgMrRtOx1GuOwyKd7+ZYYMYz5+bgKsStmqg8oZrwzNSzAbLtGPuV6pkV
	 xPkPs0FBsBsuQ==
Date: Sun, 14 Jun 2026 12:08:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, kernel-team@meta.com, corbet@lwn.net,
	skhan@linuxfoundation.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
	akpm@linux-foundation.org, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	elver@google.com, kuba@kernel.org, ebiggers@kernel.org,
	lirongqing@baidu.com, paulmck@kernel.org, dave.jiang@intel.com,
	jic23@kernel.org, xueshuai@linux.alibaba.com, kai.huang@intel.com
Subject: Re: [RFC PATCH 1/3] mm/numa: add exclusive node pool and
 numa=standby boot parameter
Message-ID: <ai5vj_RjSxl_FLu-@kernel.org>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
 <aip5IWmxg9CWg8hQ@kernel.org>
 <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>

On Thu, Jun 11, 2026 at 10:04:01AM -0400, Gregory Price wrote:
> On Thu, Jun 11, 2026 at 12:00:17PM +0300, Mike Rapoport wrote:
> > > 1) Can we do dynamic addition of nodes?
> > > 
> > >    Not Trivially
> > > 
> > >    Some services utilize num_possible_nodes() as a static value to
> > >    calculate the amount of resources to use at runtime (bpf, md/raid5).
> > > 
> > >    Example: futex_init uses num_possible_nodes() as part of its
> > >             hashsize calculation during __init.
> > 
> > AFAIU, we don't add the additional nodes for generic hotplug memory but
> > rather for exclusive use of by drivers/applications that are aware of these
> > nodes.
> 
> The intent is to use for "non-generic" hotplug (see the whole private
> node series [1]), which would eventually still use the hotplug mechanism
> just not for generic memory.
> 
> [1] https://lore.kernel.org/linux-mm/20260222084842.1824063-1-gourry@gourry.net/
> 
> > Wouldn't adding them to possible nodes actually skew the calculation of the
> > resources by the services utilizing num_possible_nodes()?
> > 
> > With the futex_init() example, won't be hashsize scaled down two much
> > because we've added these special nodes to the possible mask?
> >
> 
> The result is the same as BIOS reserving nodes with PXM entries that
> don't get used.  The CXL ACPI Tables do this for CXL Fixed Memory
> Windows that may never be hotplugged.

Well, even without CXL there could be nodes that may never be hotplugged, I
suppose that with CXL the difference between available and possible
nodes can get much larger.
 
> So really i think you're pointing out that futex_init() here probably
> shouldn't be using num_possible_nodes?

I'd rather say that num_possible_nodes() with and without CXL (or other
differentiated memory) has different semantics.
Maybe we need to add a new primitive for possible differentiated nodes and
keep num_possible_nodes() to mean "number of possible nodes with normal
memory".
 
> ~Gregory

-- 
Sincerely yours,
Mike.
