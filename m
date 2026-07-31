Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8064519BA;
	Fri, 31 Jul 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515539; cv=none; b=TFZ4ZWtNwmUDX9CNv99VBtM1Kgvlk04R1f4LPt9phdMEE4M+Git+gB8Ho+dNDScNXI7YAOvVtlADJoD1boaSwUOlMJJWVzKoTq76iohVwb8Ns34Uy3cZiRGS2T7mErP0lHKHkJE9xE5i5tUoyUSsU4aaKPM4WRbs10T2JmZq22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515539; c=relaxed/simple;
	bh=VbxlaKfrlvVQz4HJBJtoAZXt2oWQTXMKrfRAQCHlrvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYCrvW0UzRsCoU1NZaxVMqAE/dZGlHdVvmSor5RsOONFP/MNHbTmml+PqLNXEAyda+C+QhmotSJvDfL9VbXKxIXk/Km0IS503pos/yznm0q1bDND3GDmQSrGzZpvWiAlBycMLEd09ZcrnG3TRIosJOsA56k/iOBZr6ENtxlyRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hPN34vbp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hPN34vbp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E4B1204C;
	Fri, 31 Jul 2026 09:32:12 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A233F86F;
	Fri, 31 Jul 2026 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785515536; bh=VbxlaKfrlvVQz4HJBJtoAZXt2oWQTXMKrfRAQCHlrvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hPN34vbp4F+JtFjYjq6NM52DmQeW5hEDr6P+aePDLP9XQTBQlk/4DQFEiSoKV7i9C
	 9tODQZM7wZhedQAcGCLw4TeprZtegBAK6FHBJmda9baR/SbeWQElXQPVb/B+u6elaV
	 RDBrh+ctknoQg4I+hoR4xBAtYGanTZKVFUFlZhpc=
Message-ID: <771b0fb7-7689-49dd-a06f-8bef174e432d@arm.com>
Date: Fri, 31 Jul 2026 18:32:06 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] arm_mpam: Add MPAM-Fb firmware support
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
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
 <af820923-c423-4f19-99dd-7d8fdd2da864@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <af820923-c423-4f19-99dd-7d8fdd2da864@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/30/26 19:10, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/30/26 16:25, Andre Przywara wrote:
> [...]
>> The first six patches rework all MSC access wrappers to propagate error
>> information. Pure MMIO based MSC accesses would never fail, but the
>> MPAM-Fb access can go wrong in multiple ways. The patches have been split
>> up purely for reviewing reasons, if the number is a problem, we could as
>> well squash them. Please note that until the very last patch of this series
>> any MSC accesses would always only return 0, it's only the final enablement
>> of MPAM-Fb that could possibly introduce errors. Hence all former patches
>> can add error handling gradually, those code paths wouldn't be triggered
>> before patch 10/10.
> 
> I had a go at injecting some errors and noticed that at least some aren't getting to user space.
> When writing the schemata file any MPAM-Fb error is not propagated to the user. The
> resctrl_arch_update_domains() continues to return 0 as there are some missing links in the chain
> down to the writes, e.g. __write_config() always returns 0.

Ah yeah, that's true. With the write functions using a compatible 
prototype (just ignoring the new return value) this is harder to check, 
since the compiler is just fine with it.

So I propagate all MSC access errors now in mpam_reprogram_ris_partid(), 
and the depending mpam_apply_config(), __write_config and 
mpam_reset_ris() functions. From my quick analysis I'd say that covers 
all functions now that mpam_devices.c exports. That will be a new patch 
07/11.

Cheers,
Andre
