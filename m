Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C643DA26;
	Thu, 30 Jul 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431437; cv=none; b=CKB+0bh4GuxkXdBCPjQrS0Lba9N94WlZXfTiE+tJRcbuYAEXW2y58wskzL/Q3r70a4DvhtlUKMeLKZIXocZwWLtpvbaBU/Y6FfLwIZIDu1eQWCpPbfWcJmTQwOXFnCxFnVenMfcO3O2FpGqEVgpb4ui+KNm1hA3b7tXsvbkqcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431437; c=relaxed/simple;
	bh=NEV1SeAY7e9fur5jsw64YihesSttf5xPw9v8EsYpE7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gl7Od3X5TNJlzFP4TsEwlwzH3nQBM9cDPoPHhXpcwHjCw5gePLnxy11bzu+MmZHa1Rm14yUolaEzXp8aC8zX+iWOYknXMdgvY51u5dEvrw7AT+L+EvLiQf1YzglA3XuYWf2ljHH3zgDtIyPXT7PgpMzUD6xbI//WyRbKgcQLsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rKfe24nH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rKfe24nH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8165C15A1;
	Thu, 30 Jul 2026 10:10:30 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABEEB3F7B4;
	Thu, 30 Jul 2026 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785431434; bh=NEV1SeAY7e9fur5jsw64YihesSttf5xPw9v8EsYpE7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rKfe24nHrRUQFSs7BPeQVC3d7nntvLRKXTHJnKrjfXFM0j9YtvPULxv7b26v23U6Z
	 vF4B+v10W3rmV33Aqo2JzjWUVF/Bb7Yd5scIjuNwJ2PSfY8ByP9FDeP1Ed2s9qTXm1
	 QsLIDgQesgSQP1tZSl6JoW5eTQDWNfsxzWcYzaxA=
Message-ID: <af820923-c423-4f19-99dd-7d8fdd2da864@arm.com>
Date: Thu, 30 Jul 2026 18:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v6 00/10] arm_mpam: Add MPAM-Fb firmware support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260730152539.2712312-1-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260730152539.2712312-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/30/26 16:25, Andre Przywara wrote:
[...]
> The first six patches rework all MSC access wrappers to propagate error
> information. Pure MMIO based MSC accesses would never fail, but the
> MPAM-Fb access can go wrong in multiple ways. The patches have been split
> up purely for reviewing reasons, if the number is a problem, we could as
> well squash them. Please note that until the very last patch of this series
> any MSC accesses would always only return 0, it's only the final enablement
> of MPAM-Fb that could possibly introduce errors. Hence all former patches
> can add error handling gradually, those code paths wouldn't be triggered
> before patch 10/10.

I had a go at injecting some errors and noticed that at least some aren't getting to user space.
When writing the schemata file any MPAM-Fb error is not propagated to the user. The
resctrl_arch_update_domains() continues to return 0 as there are some missing links in the chain
down to the writes, e.g. __write_config() always returns 0.

Thanks,

Ben

