Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FE23BD05;
	Tue,  4 Aug 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885576; cv=none; b=dzXfqKE0qwnAFQ56Tq4ChCs4Fbz1pcstjmRWe7wDFb7+66UTwdZX4iKm+CTumVSUWe/16Fs37gDe2Tje3gXhJtwvWLg3Fud18/gTJ1vN0u9dNWeXXe/LPDNvvXASr5HQVqhNnbwpzOc/JK7bC71Qh5yNr1uNxswSQbukHKjk7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885576; c=relaxed/simple;
	bh=5f9ZdClcs8TDvwfo6MdAkYjHiyJ9Gbo0iLndsUOWpdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gh2Z+SFcEfK0LmjrZljfa8iNpoE+sJ1KPxmIypiJEtZirKDR1Oe5H/o58A4KpDLAHy17uynKGjPzwQdBTYPXuqQWHmKUrkhJRJ3hlmRbyKsd2pTbOOMLiIkoQd+wjON/e3o0aW+gDDhoeKSyAay1Ej81nUDgIiikMl83ONseRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wrOPh-0006Bl-UH; Tue, 04 Aug 2026 23:19:14 +0000
Message-ID: <78890db3-f5e3-402b-a604-a79394141fbd@trager.us>
Date: Tue, 4 Aug 2026 16:19:06 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/11] arm_mpam: detect and enable MPAM-Fb PCC support
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
 Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260804100627.3217149-1-andre.przywara@arm.com>
 <20260804100627.3217149-12-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260804100627.3217149-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 3:06 AM, Andre Przywara wrote:

>   /*
>    * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>    * can be enabled.
> @@ -2275,6 +2362,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   {
>   	struct mpam_msc *msc = platform_get_drvdata(pdev);
>   
> +	mpam_pcc_chan_put(msc->pcc_chan);
> +
>   	mutex_lock(&mpam_list_lock);
>   	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);

I think the PCC channel lifetime needs to follow the MSC's deferred 
lifetime.


mpam_msc_drv_remove() currently drops the PCC channel reference before 
removing the MSC from SRCU-protected lists. If this is the final 
reference, an existing SRCU reader can still enter 
mpam_fb_send_request() through the retained MSC and access the freed 
channel. A new reader could also find the MSC before list_del_rcu().


Moving mpam_pcc_chan_put() after mpam_free_garbage() is not sufficient 
because the garbage list is global and can be drained concurrently. e.g

1. One caller queues the MSC.

2. Another caller claims it with llist_del_all() and waits in 
synchronize_srcu()

3. The first caller finds the garbage list empty and returns without 
performing a grace period.

4. The first caller releases the channel while the reader blocking the 
other collector can still be using it.


Would it make sense to associate an optional release callback for each 
garbage entry? An MSC entry could use that callback to drop its PCC 
reference after the collector that claimed the entry completes 
synchronize_srcu(), but before the MSC is freed. This would keep the 
grace period and channel release under the ownership of the same 
collector. This would also handle mpam_disable(), which currently 
destroys and frees PCC-backed MSCs without dropping their PCC channel 
references.

