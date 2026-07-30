Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405E3C063F;
	Thu, 30 Jul 2026 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450521; cv=none; b=Uu67JVJYvZoh3FsEFJ1PJRYd5AqRmCjrfRG2WlVhh/enY9erEG7Hl5OwBrmrGprfxoQDM6+FTEtAeizNXSSVNKB6ZdX/QAM8+9MRAV7rCvpWWpdyqt5WMN+tEhUtJmhSNP+6i9DlFHFVf6n/KEvhxQNfVQR672BDORfLcmwhDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450521; c=relaxed/simple;
	bh=IbYqgy4sxZxGq7ezV6QGfxt5FRVxWscWOB/01CG10AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxqoyoyYECzAbF4nI/eF6FI/QBg1rweZxEJ6J8dgPhD+fy0i1GH5ubfqmUYajG+lrO2611aPPyBh3YlUpnE5j4vt1BmcIim1fLUNCfttYvYFZA6DBTR946d62+FF1K4VPaaPlVzCBTqOjKu0POuhsmb+SPR46FUnwB+IQCj9OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wpZEp-0000wX-Ap; Thu, 30 Jul 2026 22:28:27 +0000
Message-ID: <c3d43f56-b875-4bbd-b249-1a5f33cd54ed@trager.us>
Date: Thu, 30 Jul 2026 15:28:19 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
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
 <20260730152539.2712312-11-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260730152539.2712312-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/30/26 8:25 AM, Andre Przywara wrote:
> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
> +					       int subspace_id)
> +{
> +	struct mpam_pcc_chan *cur;
> +
> +	guard(mutex)(&pcc_chan_list_lock);
> +
> +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
> +		if (cur->subspace_id == subspace_id) {
> +			kref_get(&cur->refcount);
> +
> +			return cur;
> +		}
> +	}
> +
> +	cur = kzalloc_obj(*cur);
> +	if (!cur)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cur->pcc_cl.dev = dev;
> +	cur->pcc_cl.tx_block = true;
> +
> +	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
> +	if (IS_ERR(cur->pcc_chan)) {
> +		long err = PTR_ERR(cur->pcc_chan);
> +
> +		kfree(cur);
> +		return ERR_PTR(err);
> +	}
> +
> +	/* Timeout based on the "nominal latency" from the PCC ACPI table. */
> +	cur->pcc_cl.tx_tout = cur->pcc_chan->latency * 5;
I think this may need a unit conversion. ACPI 6.6 describes PCC nominal 
latency in microseconds, and the PCC mailbox driver appears to copy that 
value directly into pcc_chan->latency. However mbox_client::tx_tout is 
documented in milliseconds.

If I'm reading that correctly, assigning latency * 5 would make the 
timeout 1000 times longer than intended. Would something like this be 
better?

cur->pcc_cl.tx_tout = DIV_ROUND_UP_ULL((u64)cur->pcc_chan->latency * 5, 
USEC_PER_MSEC);
