Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20D3264FB;
	Fri,  3 Jul 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107603; cv=none; b=dh3/av2yC/u0fx0q469bAfcF4zegxHIxsfr1N89N2EawtKY5PkrndabJZIecrH6b2+3vHUhFHL8KNpX3hsWAJyBfuHLWqEIM6PdFfCij/NOzu4V1UDGPxMjGwc0pENc3UJsZxPjCLCJHSKuQArKcB9xT9pVPbwJv0lj0R3tdWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107603; c=relaxed/simple;
	bh=5Eh7D8mry7V+e+USyyWin6RviaomZOACDt5grPf0D3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZhdIwuzxEm5wA68bUu/E5Rf0i7CB3J30lBtb/9+QfJtxVn2tBDvsw9PI9AafAUWSWrLpUJ+DKOhQ5i1VDP3OlqnPsTf4pss+bD9f34/mASnyJirplgA2ZiYUIMsAHhHZkSbkN5KXfvyFJNG2e2sPsKbcADxPILGjg7ZjR/F2yCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw0b9W3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw0b9W3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7B11F000E9;
	Fri,  3 Jul 2026 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783107602;
	bh=5Eh7D8mry7V+e+USyyWin6RviaomZOACDt5grPf0D3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hw0b9W3GW4cquJLB+d7/u7P4CleM6rpyjaIoSLJwO1VwHb5n9thcktNBbVBZrKAdF
	 GmcikziSPw1/ymi7bf2X7tr+iCPflzJVIzpUNnkbl4oK2fFBH0ErjGlNGcVgleKAfP
	 LDtMeQTWxqa2350L5DUpfvpu1ipaB2mf5PCTctDxki27n7wmsEQiWNwCHmjaV1qqux
	 /ZqxLuF1UfSBTgA57bUP+s4ICn6I4kLmi/26cUeSf28U1jQUv/vT8L4BcoHhZETeyF
	 792HxHmsPEz3aWLLxQ7R8iALSeUU/SSBxvSHHI2GUpaUZtZF6ZiOdfbgkDvA0fUhBb
	 W0r/XfyZocTeQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>
Cc: Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org,
 hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
 wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
In-Reply-To: <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local> <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
Date: Fri, 03 Jul 2026 21:39:59 +0200
Message-ID: <87jyrblv5c.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 03 2026 at 12:32, Borislav Petkov wrote:
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

Looks reasonable to me and should avoid all the nonsense you had to work
around before.
