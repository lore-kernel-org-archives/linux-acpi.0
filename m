Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F533CE8A;
	Fri, 19 Jun 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880196; cv=none; b=DyYds6fOvWELX1THMx8RBwWtCmkxVc8iVPqx9DKTmNFJCr/Kv9b054yOQZTdHZE+oTEa6uRLrEwNhKfITfNzEn2fTtNwSnVr98M5pU/aSilR4zHzwr4X45zUUAde03yOGCyUe9+x7lx1YhrH3R6RQzd26puAvUK11jocv/Ncd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880196; c=relaxed/simple;
	bh=sNm16L5ftjDlhF6/hyQVEuOsx6WdUtFRRqxXHSfwwOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9OQJDlbWD7HpBv6+OWOImVYRMT8HGLfkChlGXB5jiITgog/pkZWxoQ4UPO95p+I4Ib8WCbuZSPDKVhFWitKn/st6s1mALkq2FZCaWwcH8WzrE4gKPO21MOA5aVjJrLRol2W8CLQ3pgeMQTxOyXky/aEmJNX+/iuSc4w+KZL+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buwtobMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buwtobMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDD31F000E9;
	Fri, 19 Jun 2026 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781880195;
	bh=EIlNsIQj0kEdipfyw8JGQsqqTUPEkGp3JCVuP8lQoQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=buwtobMkHr0DOLNc9UZX4q/YAVNcCwXujLYAR3XthpBhEGfYbwZnA/ZnRvByeDUES
	 2FCVOCqelalG++ypX+KppY6r5T4wrNrqDpKDEDyHT8O4d9kbDWwEV6BWYtFdqGB5+L
	 Y9p/IAYmPnDONSJdyy3hwExxSJyNe0jGjPsge2iCeI7w2lGGX7GR+EG5sOOUU+5DZ5
	 rmKHM7/ge3QmAvWr6PdYejC90q4QKcohKhFbzMCCo5IxI1TWEpa2Rl53TYKWXN04xs
	 S2vh6jPiCEnJfLmS3KoAu9b+i63HX0wbKeaAp7k0ZIHSYSkc2JcrrK+nPsFOpclvJd
	 UBXYkbGvDG2qA==
Date: Fri, 19 Jun 2026 15:43:10 +0100
From: Will Deacon <will@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@kernel.org
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
Message-ID: <ajVVfnGIq_6zt2jC@willie-the-truck>
References: <20260617060110.2846851-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617060110.2846851-1-pengyu@kylinos.cn>

+arm64 ACPI maintainers

On Wed, Jun 17, 2026 at 02:01:10PM +0800, Yu Peng wrote:
> I hit an early boot failure on an arm64 system built with 64K pages while
> parsing the ACPI MADT.
> 
> The failing system reports:
> 
>   PAGE_SIZE: 64K
>   MADT physical address: 0x5a7ae018
>   MADT length: 0x32094

The MADT isn't even 4k aligned, so why does the page size matter in this
case?

> The failure happens when acpi_table_parse_madt() calls into early_memremap()
> via __acpi_map_table(). The MADT itself is smaller than 256K, but its
> placement causes the early mapping to require 5 64K pages:
> 
>   offset within 64K page = 0x5a7ae018 & 0xffff = 0xe018
>   mapped range           = PAGE_ALIGN(0xe018 + 0x32094)
>                          = PAGE_ALIGN(0x400ac)
>                          = 0x50000
>   nrpages                = 0x50000 / 0x10000 = 5
> 
> On arm64, NR_FIX_BTMAPS is currently derived from a 256K per-slot budget:
> 
>   #define NR_FIX_BTMAPS        (SZ_256K / PAGE_SIZE)
> 
> So for 64K pages, NR_FIX_BTMAPS is 4. The mapping therefore fails the
> early_ioremap() check:
> 
>   if (WARN_ON(nrpages > NR_FIX_BTMAPS))
>           return NULL;
> 
> After that, MADT parsing fails and the boot continues with symptoms such as:
> 
>   ACPI: APIC not present
>   missing boot CPU MPIDR, not enabling secondaries
>   Kernel panic - not syncing: No interrupt controller found.
> 
> A firmware change can avoid this by placing MADT so that:
> 
>   (madt_phys & 0xffff) + madt_length <= SZ_256K
> 
> However, I do not think ACPI requires such placement, so this looks like a
> kernel-side robustness issue as well, especially on large arm64 systems where
> MADT can grow with CPU topology.
> 
> One possible kernel-side change is to increase the boot-time mapping budget for
> CONFIG_ARM64_64K_PAGES, for example using a 512K per-slot budget only in that
> configuration. I do not think this should be applied unconditionally to all
> page sizes, since the arm64 early fixmap code expects the boot-ioremap range
> to stay within one PMD.
> 
> Has anyone seen similar failures on arm64 64K systems?
> 
> Would maintainers prefer treating this as a firmware layout issue, or would
> increasing the early_ioremap budget for 64K pages be acceptable?

It think it boils down to what ACPI says about the alignment of the MADT.

Lorenzo?

Will
