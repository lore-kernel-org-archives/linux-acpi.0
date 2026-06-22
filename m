Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF2359A68;
	Mon, 22 Jun 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121754; cv=none; b=tYE/cxLhGjlag92HqZ1BSV+ocuw+w8WyOhLhEqiSeQ8KgHcsLIGuZ8rS/zb1D1MEWo47cmAZ0pxKqGbrwI1dTQTfPAP7Pa/ZGiQGZ6Gyd3E0VjjwD3sTeAovSvtvplYiVF1Yx7FqB+f+rpXaHHFtmbM4pTkv3oa1fF68vU1VASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121754; c=relaxed/simple;
	bh=MB67wjo11zSyIcV/A0s8gJHujpIPJgHYQedDt2GBch0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhjQKuGXiP78ZDvATdkK5UvuAF2IB+T3vKIFfed0jGCLzKQw0M/DytF+xPKxFMTlxE8JxuSvPhQtwSGjON7QJ/s6vFGeb3lvZd1fvc+nFG5/TnrHnkDd91aU3b9iBkSvcR7APUp7yR5b6fS+4jU76nLDBKOklZL64Ifs2jHJaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro+wwemI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro+wwemI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E281F00A3A;
	Mon, 22 Jun 2026 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121753;
	bh=jiUK4zqlgPufMf5KeLuWGqbjOdMtUleMUc6fesqkDDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ro+wwemIX5Rnl9nAhj+phv88wYwnNld218ormKKPUv87BSnNLRpu9D4ciAcUA/9aV
	 kV4TvSmy+7jhFDP2oTR+Exc2QVRYoubH/yPD+VaTIMWT8VS/+p61VDFEaJPz++o8ne
	 kE9+3EKuoxURhelikJG9QDtIfxSkA0IT0eQUNH3RkoSTQU2Zt2RTfro5W1PVopTbiG
	 o41jD0WHJSDAZsV0Qj/arNHOdzJ2xoX9m2yvWfcQ8esxEH4ixQZ71B46G1ovm8h7h/
	 jVkEtJYrAXXnNEVq2SI1M44qgHwVIrCtuDv1A8wENZIgx2URMumPdgLlDT6YI543Sf
	 g4qAHZKxjQLsg==
Date: Mon, 22 Jun 2026 11:49:07 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Will Deacon <will@kernel.org>, Yu Peng <pengyu@kylinos.cn>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sudeep.holla@kernel.org
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
Message-ID: <ajkFE6TmwW6B/huP@lpieralisi>
References: <20260617060110.2846851-1-pengyu@kylinos.cn>
 <ajVVfnGIq_6zt2jC@willie-the-truck>
 <3cceb66d-4496-1a46-60ab-f43b0669fb71@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cceb66d-4496-1a46-60ab-f43b0669fb71@huawei.com>

On Mon, Jun 22, 2026 at 04:55:29PM +0800, Hanjun Guo wrote:
> On 2026/6/19 22:43, Will Deacon wrote:
> > +arm64 ACPI maintainers
> > 
> > On Wed, Jun 17, 2026 at 02:01:10PM +0800, Yu Peng wrote:
> > > I hit an early boot failure on an arm64 system built with 64K pages while
> > > parsing the ACPI MADT.
> > > 
> > > The failing system reports:
> > > 
> > >    PAGE_SIZE: 64K
> > >    MADT physical address: 0x5a7ae018
> > >    MADT length: 0x32094
> > 
> > The MADT isn't even 4k aligned, so why does the page size matter in this
> > case?
> > 
> > > The failure happens when acpi_table_parse_madt() calls into early_memremap()
> > > via __acpi_map_table(). The MADT itself is smaller than 256K, but its
> > > placement causes the early mapping to require 5 64K pages:
> > > 
> > >    offset within 64K page = 0x5a7ae018 & 0xffff = 0xe018
> > >    mapped range           = PAGE_ALIGN(0xe018 + 0x32094)
> > >                           = PAGE_ALIGN(0x400ac)
> > >                           = 0x50000
> > >    nrpages                = 0x50000 / 0x10000 = 5
> > > 
> > > On arm64, NR_FIX_BTMAPS is currently derived from a 256K per-slot budget:
> > > 
> > >    #define NR_FIX_BTMAPS        (SZ_256K / PAGE_SIZE)
> > > 
> > > So for 64K pages, NR_FIX_BTMAPS is 4. The mapping therefore fails the
> > > early_ioremap() check:
> > > 
> > >    if (WARN_ON(nrpages > NR_FIX_BTMAPS))
> > >            return NULL;
> > > 
> > > After that, MADT parsing fails and the boot continues with symptoms such as:
> > > 
> > >    ACPI: APIC not present
> > >    missing boot CPU MPIDR, not enabling secondaries
> > >    Kernel panic - not syncing: No interrupt controller found.
> > > 
> > > A firmware change can avoid this by placing MADT so that:
> > > 
> > >    (madt_phys & 0xffff) + madt_length <= SZ_256K
> > > 
> > > However, I do not think ACPI requires such placement, so this looks like a
> > > kernel-side robustness issue as well, especially on large arm64 systems where
> > > MADT can grow with CPU topology.
> > > 
> > > One possible kernel-side change is to increase the boot-time mapping budget for
> > > CONFIG_ARM64_64K_PAGES, for example using a 512K per-slot budget only in that
> > > configuration. I do not think this should be applied unconditionally to all
> > > page sizes, since the arm64 early fixmap code expects the boot-ioremap range
> > > to stay within one PMD.
> > > 
> > > Has anyone seen similar failures on arm64 64K systems?

First bug report I am aware of, perhaps this was papered over in FW,
MADT parsing failure is the first thing you would notice in bootstrapping
an ACPI system (FADT is not that big).

> > > 
> > > Would maintainers prefer treating this as a firmware layout issue, or would
> > > increasing the early_ioremap budget for 64K pages be acceptable?
> > 
> > It think it boils down to what ACPI says about the alignment of the MADT.
> 
> I checked the ACPI spec and it didn't require the alignment for ACPI
> tables, but in UEFI spec, it says (for aarch64):
> 
> ACPI Tables loaded at boot time can be contained in memory of type
> EfiACPIReclaimMemory (recommended) or EfiACPIMemoryNVS.
> 
> EFI memory descriptors of type EfiACPIReclaimMemory and EfiACPIMemoryNVS
> must be aligned on a 4 KiB boundary and must be a multiple of 4 KiB in
> size.
> 
> It only requires EfiACPIReclaimMemory type to be 4K aligned, not
> for each ACPI table, because ACPI tables can be packed into the
> allocated EfiACPIReclaimMemory type, correct me if I'm wrong!

I am afraid you are not wrong - we can't blame firmware (yet), this
has to be addressed.

Lorenzo
