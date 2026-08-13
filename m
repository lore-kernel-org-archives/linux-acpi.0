Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265444334A4;
	Thu, 13 Aug 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646132; cv=none; b=S17X+cCKFaVJE+FQzSzjPBCMH4zDYW2oFD/fwd+Oibh5uwl+NlxC65AHV9FyPVyuRnCVfcukzcrSWmLB0HPLpi0G4YrwDt5UyQuhm9fxXAHYGkKK+iwY/6bZgXInzwpm9B3dhqE5+h2Y7uQCYPq1dNZSonMfom2XBghKfNpFgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646132; c=relaxed/simple;
	bh=ypR6W/dNnMSW894YQ07/N4UOntpoZiX7QMEFKrEpAwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjbF8gJhpXbh2I5Fq/E/C3Id3sAZoiLjpK9wpiZ5l7ohX2jNrtII/87VfPLbIcGgYg5mreJLfhgqMn7F6eECT9FNIWDm7t8EzyA7VBvcwqOsfqtUX/TKzinJtuofvUeFAXs8QP9j9HjGxatbGv2vNsF45BLqSsFGNAdwnN2rlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eks41NNL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eks41NNL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 731871AC1;
	Thu, 13 Aug 2026 11:35:25 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 979B93F66F;
	Thu, 13 Aug 2026 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786646129; bh=ypR6W/dNnMSW894YQ07/N4UOntpoZiX7QMEFKrEpAwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eks41NNLCuKhGX7jr3b/ziw2jjyu4b6RY3o7+K2p0YxThjLoC/ZsyCEtj8CxqIhVy
	 Fqk0SRdFHB1WN7neolRNAGa7ZAnT+htTuk+Dwmf9o84jM5TUixFXCRkY8EcbeGwoFR
	 9CNz/IogP70V7fqJ/A0slCmbuBMDXlRsMhOhtZYM=
Message-ID: <5b01a446-929a-4b35-8f6f-174175a87ff4@arm.com>
Date: Thu, 13 Aug 2026 19:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: IORT: validate node and RMR extents
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Joerg Roedel <jroedel@suse.de>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 5:01 pm, Pengpeng Hou wrote:
> The original patch combined the generic IORT node walk with the
> IOMMU-specific RMR descriptor and ID-mapping arrays.  This version
> separates those contracts as requested.
> 
> Patch 1 validates the root node area, complete node headers and advertised
> node lengths in each generic walker.  Patch 2, built only with
> CONFIG_IOMMU_API, validates the fixed RMR payload and both arrays before
> walking them.

But why? If a platform really did have an IORT that's so obviously 
malformed or corrupted, why would we assume that all its other ACPI 
tables are valid enough to even be able to boot as far as running this 
code? Or conversely, what if the table does happen to have the correct 
structure but is still full of nonsense such that we end up exploding 
later when a driver touches bogus iomem?

Mainline Linux is not a firmware validation suite; if we can't assume 
basic stuff like table headers are correct then there's basically not 
much point in even trying. Also it is highly unlikely that people who 
write firmware would ship it without doing any testing; if Linux crashes 
horribly the first time they try to boot their new build, they're 
probably going to notice that something's wrong. However, from 
experience, if Linux does successfully boot to a shell then they may 
assume it's fine and ship it even if the IORT node ID mapping offsets 
are bogus so MSIs don't work and devices have fallen back to legacy 
interrupts...

Thus if anything there's an argument to be made that the more we try to 
be robust against unreasonably broken firmware, the more unreasonably 
broken firmware will propagate into the wild. And if you think people 
will care about kernel warnings, try looking at the boot logs of just 
about any production Android device ;)

Thanks,
Robin.

> 
> Changes since v1:
> https://lore.kernel.org/all/20260706094300.82618-1-pengpeng@iscas.ac.cn/
> - split generic traversal from RMR array validation
> - validate root node_offset and node_count before pointer construction
> - scope RMR helpers with their CONFIG_IOMMU_API users
> - document why a zero-count array needs no offset validation
> 
> Testing used Linux 3d6d817622b0 plus this series, GCC 13.3 and QEMU
> 8.2.2 with a Cortex-A57 arm64 CPU model.  A temporary KUnit harness in
> iort.c called the actual static validation helpers; the harness is not
> part of this series.  The acpi_iort_bounds suite passed both tests,
> covering invalid root offsets, truncated node and RMR payload extents,
> and out-of-bounds RMR descriptor and ID-mapping arrays.
> 
> This did not exercise a platform-provided IORT table through the complete
> boot-time discovery path.
> 
> Pengpeng Hou (2):
>    ACPI: IORT: validate table and node extents before traversal
>    ACPI: IORT: validate RMR node array extents
> 
>   drivers/acpi/arm64/iort.c | 117 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 109 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13

