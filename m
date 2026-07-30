Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB5285CAE;
	Thu, 30 Jul 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410421; cv=none; b=G8lfWpKYuJ8su0lWHjuGx2vXjCphinfUAWMVQJEg41WFmZrH5YCwamPI0HGexZXOYeJwBq3ljtjJcjaCyO+JWtvaNufQR6bO5vBw0FCedsMJBonqP5cya2BTymmb0Hub3cmgYh8+qZdav+xC0ZMXyY9jwTPb77E7Sh+rDuNFAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410421; c=relaxed/simple;
	bh=C4AQJN9tMTKQF7Tu1mssGfWe2EOvFVRNJhCVHDLw5yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4Q02RdUYFImMDfRQ8a2qNDixtLbhxFohf2dN2gQhk+9iue1avCr6D/s3G6mhcyitFDAQP2cEqctlMV2p0kyHGDScuhxAePsnPrY1iFvgKua08xnHwGoGlP7pA+MAJwZUNIpk1vMb6FbTnaqN2fKt+TxPyKYrjHVbjZxwwyE6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=br6pLnns; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="br6pLnns"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F511684;
	Thu, 30 Jul 2026 04:20:14 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE7403F763;
	Thu, 30 Jul 2026 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785410418; bh=C4AQJN9tMTKQF7Tu1mssGfWe2EOvFVRNJhCVHDLw5yc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=br6pLnnsQ4i4OH1unxzDM7UwyVts057gYJiSoDX1AinSCol54eG0xAuH/lqKhliwo
	 xZ6MAE9ztSrn2T7EA/9Wt67o2bAsqHgHEXd0XXBKr/GYgnVAK4q+utWBnt3m5ga5vo
	 7vUKCq2iQlRiXkbamShDTNxxztQwE7zHVD8q6Alk=
Message-ID: <2821782c-67af-432d-8569-4328e6354147@arm.com>
Date: Thu, 30 Jul 2026 12:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v5 01/10] arm_mpam: let low level MSC accessors return an
 error
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
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-2-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260729134124.2506269-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/29/26 14:41, Andre Przywara wrote:
> The upcoming MPAM-Fb support does not use MMIO primitives to access an
> MSC, but employs a shared-memory/doorbell based firmware protocol.
> Its complexity means that it must be able to handle errors, whereas we
> always assume an MMIO based MSC access succeeds today.
> 
> Change the __mpam_read_reg() low level accessor function to return the
> requested data through a pointer, and return an error code instead.
> Also change the __mpam_write_reg() accessor function to return an error
> code. At the moment this is always 0, so all error handling paths are
> not exercised at the moment. This will change later when alternative
> MSC access methods like MPAM-Fb are activated.
> 
> Change all direct users of those MSC wrappers to comply with the new
> prototypes, though the errors are not propagated all the way up yet.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben
