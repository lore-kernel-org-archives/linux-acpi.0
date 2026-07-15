Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE112D1F1;
	Wed, 15 Jul 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145163; cv=none; b=GH8Pkq5I0JoGyUgWHfQVRG8QQvc+PFPOzvi0ED2gLfQX6BaqKInJsQoUm/DIw/OHh5wsXWPPkrrx0BXqxt1hNkrDBIe+hfQba13NdEmAzytQ+QKRCAvBvl1G7wPFLhVJzQ+U19GgCHpjlUm0N0QPrg4wfu0G/vSeZJFNSX9H9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145163; c=relaxed/simple;
	bh=36/Aqi3Aq4FcrIEaR6ebxxaIu6OMO3oT3qoBypqoO0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URMNHzVw4l8bptZMJ5bdnXNDn5KJljnODfj30tBUR91UvcgzFVP01qKGcKzSnuY9SZbYrjiP+t3S10fbByMgfQH0yW9+S8m6QHlsZ6pq6Co10M7M47ujrryFWz9mPKXugKMh+MyslAyk0AtAIEP0xAHFs/yV9Q4v5yZ5qFKwtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wk5ee-0008Vc-Ky; Wed, 15 Jul 2026 19:52:28 +0000
Message-ID: <673b79c0-d2e6-44a6-a1a8-a2ff92f2ff53@trager.us>
Date: Wed, 15 Jul 2026 12:52:20 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] arm_mpam: propagate MSC read errors for
 __ris_msmon_read()
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-7-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260710144520.917375-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/26 7:45 AM, Andre Przywara wrote:

> @@ -1748,6 +1758,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>   {
>   	int i;
>   	u64 val;
> +	int ret = 0;
>   	struct mon_read mwbu_arg;
>   	struct mpam_msc_ris *ris = _ris;
>   	struct mpam_class *class = ris->vmsc->comp->class;
> @@ -1760,10 +1771,14 @@ static int mpam_restore_mbwu_state(void *_ris)
>   			mwbu_arg.val = &val;
>   
>   			__ris_msmon_read(&mwbu_arg);
> +			if (mwbu_arg.err) {
> +				ret = mwbu_arg.err;
> +				break;
> +			}
>   		}
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   /* Call with MSC cfg_lock held */


mwbu_arg is never initialized and __ris_msmon_read() only writes ->err 
on failure. If on a successful read mwb_arg.err tests stack garbage it 
can spuriously break ot of the loop, leaving the remaining monitors 
unrestored, and return a junk error code.

Setting `struct mon_read mwbu_arg = {};` matches what mpam_msmon_read() 
already does. Additionally val should be initialized to 0 too. 
__ris_msmon_reaD() does *m->val += now, and although the result is 
discarded here, KMSAN would flag the uninitialized read.

