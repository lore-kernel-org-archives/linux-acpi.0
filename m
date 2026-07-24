Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940130D419;
	Fri, 24 Jul 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887646; cv=none; b=fYoN1dvExeuyo9T3FFYCWnYM8Bgt5yUm9ruGR2JbJL9Nhoq7LNjd5kvPCzL4LJDUQnyb6hMCaVA3cgW3DViJYQX/7y+6BWc9mpAkCOpLIeCLfIyphjiha6wumXH2ttoU/7eS8wRfhgAwuu85V/zgqXmukWC1nm6UAbxW8FePPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887646; c=relaxed/simple;
	bh=IXzh/8bK1zNTpfZjPYFy/WUVS08PFHKD0aqFn2sncBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhWX4ue32VYwO/AqWLpO0Em5l5SwbHVi873wxnjq6EHIqIUGXCohNPeeRhp9CR88mX+/iWw1MeNWneft0OSyfMXLnEHFpVsXDqnX3Egzya2NTYnNmAUBbE+D/pPU51li/K+qs+LAlSkzwbbR21iyuGA3oR2qM4WMJMA0m5T8M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR3El8GC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR3El8GC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F0C1F000E9;
	Fri, 24 Jul 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887645;
	bh=nHuP6bPtltApuvt/CGu+Y0u1H1Z7746eWowarKp3ehA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dR3El8GCFgDgpZ1hsQ2MGR7+lPPtY2XpcgkUXJk6M+v/VuIweYuBrV5A8PG0o9ihl
	 KZ5gY4CEzwkdOj4HTlr1/Xuh/bpAmrBwasqwZRYt7F7IctvDOfUHP6YxMvri69DHko
	 AFL+bVQZa37hBDA12o1+RcM50zsFPmyT/mWjlGvxch0aJcfW0wQJSeLk4EMb3mUIHb
	 ZI+7f9QMU3wNnI+tBq/CFReNIi+f8jcuavP29WUA5U/PNkhWzw+m3kWdBzhJeJ3E5S
	 llYrrH7NPT1XILCoOqa4qD1j3E/Tuv5MmDt9ZGguuBNONr55/r0AqSHues/hTuwcF+
	 6ue5howkulK7Q==
Date: Fri, 24 Jul 2026 11:07:20 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for state
 saving function
Message-ID: <20260724-important-curassow-of-support-ce4777@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-7-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723155454.1760823-7-andre.przywara@arm.com>

On Thu, Jul 23, 2026 at 05:54:50PM +0200, Andre Przywara wrote:
> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index bcff53477133..6329443c451f 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
>  
>  		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>  			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		if (ret)
> +			return ret;

How does it work in general with PCC. Now that you can fail at any point,
what happens to the write that occurs before a failed read like above one.
Who will take care of erasing those new writes or it doesn't matter ?
Just checking as I don't have much knowledge on MPAM intrinsics.

-- 
Regards,
Sudeep
