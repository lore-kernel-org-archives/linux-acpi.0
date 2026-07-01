Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274152F3622;
	Fri,  3 Jul 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068477; cv=none; b=eskrPczEc7K/vC74+5SdoLOh7jNuGx3QZsUxZEOQrwZeLAF6KEAeub4mxPxoRwpmY8KrhImnun6icxEYaXVC821A2Sm1buAM6AWeNHVB8fveEaCHbGsXrSw3hlt9VZms0qtxlbLcXSHjq3G72q5wrKUds8UaAsqEF19IrdFlWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068477; c=relaxed/simple;
	bh=NpBlximhQAzmFuW3CbHn1JpI2uwh8kzm6k5+vboRqUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg80p8ynkF1iSXOuoluOLlZnUwoPpcetDOSPNIrpz9jReKtZrmlNpLQj28+g5zwLYFoB7FPKna1MirsVsCa8Qp7Ae+g2LBRgeoeS+JQu4BfCD1PtulRekTNceHXFqXBG8+hxFklSZLHl4wXlvno9s4Ldf4dYthumCaEHT4CBq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W1IwFSYr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W1IwFSYr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173D71F60;
	Fri,  3 Jul 2026 01:47:51 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838AB3F905;
	Fri,  3 Jul 2026 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783068475; bh=NpBlximhQAzmFuW3CbHn1JpI2uwh8kzm6k5+vboRqUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W1IwFSYrEGjHolem5ODtotNpxmIVDuvNmasOo0DB4mk02ya/vhK2hqF5pDAqkyJPY
	 f7Nz8dcjGapUxlgcFQ2ecuhpIfwuUM3rWrriheS9EfeTle7rARIatAguCVWbGI/GRL
	 IqNb48GIqNV0t1PszcjooZmlYIA/1mxJEsEUK8GI=
Message-ID: <717a2f77-7caa-4cf5-acd5-c2f86686e34e@arm.com>
Date: Wed, 1 Jul 2026 21:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 04/15] arm_mpam: propagate MSC read errors for
 mpam_msc_read_mbwu_l()
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-5-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> Allow the mpam_msc_read_mbwu_l() function to return an error, and
> propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 011d1e3544d7..1d06902fb970 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1106,6 +1106,7 @@ static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
>  
>  static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)

Now that your changing the other helpers to return an error and pass a
pointer to hold the register value it would seem more consistent for
this call to follow the same pattern.

Thanks,

Ben

>  {
> +	int ret;
>  	int retry = 3;
>  	u32 mbwu_l_low;
>  	u32 mbwu_l_high1, mbwu_l_high2;
> @@ -1115,11 +1116,17 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>  	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> -	__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +	if (ret)
> +		return MSMON___L_NRDY;
> +
>  	do {
>  		mbwu_l_high1 = mbwu_l_high2;
> -		__mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
> -		__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +		ret = __mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
> +		if (!ret)
> +			ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +		if (ret)
> +			return MSMON___L_NRDY;
>  
>  		retry--;
>  	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);

