Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A023B059D;
	Thu, 30 Jul 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410749; cv=none; b=UtrVgG/ybNchCYdJzEjNRkw8eq+LaH/hsVPp1FoHqTYVHrV/8vHMFVuVGsvXzLoKGV2OQ+mjxfUCC3Y6Moq6G3hWzyiBz6L3Dnx1Ngxbr12gJW71R6pr39XVy2WAYmCVUeujtTrZLLK78wsR5aXqDiB37VQDR5X7vk3JvCOYD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410749; c=relaxed/simple;
	bh=JxYOt8lfWzwoJbozcTfFguNJLsAmOoYSqg7T0yNYv94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Du3Ww6xfjY9qZ50pCm9QgPMevjqOSzFQ/g3DGjhPeNsXj4IXO26xoGW1R2IVrWLZpcaEr1WuhA9FsXDZBWoCjY3NToXivRbozl5MoHmAEI3SoWGE7gctkUBL9ZTrPyRUwq+f72+wvhKKAm155Hq8vYQY/zd3a+iWUt1zS/adsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HflOHk2Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HflOHk2Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 065D41688;
	Thu, 30 Jul 2026 04:25:43 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73023F763;
	Thu, 30 Jul 2026 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785410747; bh=JxYOt8lfWzwoJbozcTfFguNJLsAmOoYSqg7T0yNYv94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HflOHk2Yk+pqwikVgeCqFT+7jRhBs4+qSrISa0Vne3r6PhQUiMUg9BxlOfEwHSZDk
	 r5S0uyPhZ3Vy/LOCvs9kGkeXwJ102ybvHAvF82O3jkYaw1cTwLAJhVrQmNfukW8H56
	 0a3A+VFYfysWWWeO65Gbq+eKXGuUUbV+C+LZXAFM=
Message-ID: <a848fdc8-995d-4c90-b03b-dde315737014@arm.com>
Date: Thu, 30 Jul 2026 12:25:42 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v5 04/10] arm_mpam: propagate MSC access errors for msmon
 helpers
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
 <20260729134124.2506269-5-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260729134124.2506269-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/29/26 14:41, Andre Przywara wrote:
> Allow the helper functions for msmon accesses to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben

