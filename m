Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF063B7B68;
	Thu, 30 Jul 2026 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447998; cv=none; b=V1+ulxor8mObtINDYCTny7vbtCBwyRIFlxwcTeJoDZLH4JfAkZOvwtK/7Q46gdh99rXx9iR6SipyqAKum5f8T3k8cdOeXvnbOhlV4huazjcpTgUu7NLsPr/0m04ByoZiST/AIRINSGz2spHFKh+f7EZjouNqSy0GPRjnqDaslIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447998; c=relaxed/simple;
	bh=2+k0XaYJ+7CfMcgv+lBd6cEbDFVWx3e3IlEdioUdBx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jODWC474bD8z5OCNv0qsioXch3b3+POW8Aezt/vudpEgOWy+ShLRpoV8TKTqQCXdlVlQy2rCuh2Ds8P9t8zwsqfs2cy546oCv5t+HtjclKvqiY/JBey56i013IULPB7axoL9LdVSlnehV4Wx9y0NTq5YeXMRHmJS+jSmejgCkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wpYa8-0000mi-BV; Thu, 30 Jul 2026 21:46:24 +0000
Message-ID: <b9d57d9f-61c7-4e62-a120-7631bdb7069b@trager.us>
Date: Thu, 30 Jul 2026 14:46:16 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] arm_mpam: prepare mon_sel locking for MPAM-Fb
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Ritwick Sharma <ritwick.sharma@arm.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260730152539.2712312-1-andre.przywara@arm.com>
 <20260730152539.2712312-8-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260730152539.2712312-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 8:25 AM, Andre Przywara wrote:

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 38450c55e45e..d175d1d50030 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2230,7 +2230,10 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   
> -	mpam_mon_sel_lock_init(msc);
> +	err = mpam_mon_sel_lock_init(dev, msc);
> +	if (err)
> +		return ERR_PTR(err);
> +
>   	msc->id = pdev->id;
>   	msc->pdev = pdev;
>   	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>
msc->iface is set below, it needs to be set before calling 
mpam_mon_sel_lock_init() so PCC devices initalize mon_sel_mtex, while 
MMIO initialize the spinlock.
