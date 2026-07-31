Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6263C9EC2;
	Fri, 31 Jul 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492721; cv=none; b=Nwp5glzyX7p1+eUJuBjUQX/fBa/hxosQZZf9RVLCZC+8EFyBpx0NFexRiYdM3+YiLrrmcqLnrp8ZXqhyxKMud+LULDE4w1r73/Sj2p/AMwHzZDH7xQkEsiocWjthWATbLXt/IMvBDtrT0RRnKpxOhlX+3KuwGT2B3vYdfBQl6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492721; c=relaxed/simple;
	bh=RLS3/hfdCm6N4efnsqtV235Qxd88UElm9zNsArg8c8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzVvolYdF844xhFpSd9FcsuwmBbkfGLFXR4wZ83D0sBzAKa1yCUCIK+0UsD6lqWx46btKsY76yPgv/JDrluBPooPvLCia7k7EN24Q2tnc5GRWOnBm3mxoinwSeEqUbAqog3kpoctIXzGs9lIN2cp2A9uu9z465Trn26ReShCSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bnRfKAlm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bnRfKAlm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210D7165C;
	Fri, 31 Jul 2026 03:11:38 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4AF3F86F;
	Fri, 31 Jul 2026 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785492702; bh=RLS3/hfdCm6N4efnsqtV235Qxd88UElm9zNsArg8c8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bnRfKAlmHFVVBv9DMLUdgTeR1G/1D3Ncia+1IKAI5TDeb9jIfXNynWvyDrP7+YKT8
	 jo8Nz0tKjkZv0/B/D+MntRD7ncpk6xVBBkragociRiJ9KSN9Tcoqexjapf2+5zW5hj
	 PqRV/xtD5nYgdiAr9WDOdwnhZY+oXFzQkzG2ES5I=
Message-ID: <d22d8dae-e005-4353-a360-c38f2a52b2f4@arm.com>
Date: Fri, 31 Jul 2026 12:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
To: Lee Trager <lee@trager.us>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
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
 <c3d43f56-b875-4bbd-b249-1a5f33cd54ed@trager.us>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <c3d43f56-b875-4bbd-b249-1a5f33cd54ed@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 7/31/26 00:28, Lee Trager wrote:
> 
> On 7/30/26 8:25 AM, Andre Przywara wrote:
>> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
>> +                           int subspace_id)
>> +{
>> +    struct mpam_pcc_chan *cur;
>> +
>> +    guard(mutex)(&pcc_chan_list_lock);
>> +
>> +    list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
>> +        if (cur->subspace_id == subspace_id) {
>> +            kref_get(&cur->refcount);
>> +
>> +            return cur;
>> +        }
>> +    }
>> +
>> +    cur = kzalloc_obj(*cur);
>> +    if (!cur)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    cur->pcc_cl.dev = dev;
>> +    cur->pcc_cl.tx_block = true;
>> +
>> +    cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
>> +    if (IS_ERR(cur->pcc_chan)) {
>> +        long err = PTR_ERR(cur->pcc_chan);
>> +
>> +        kfree(cur);
>> +        return ERR_PTR(err);
>> +    }
>> +
>> +    /* Timeout based on the "nominal latency" from the PCC ACPI 
>> table. */
>> +    cur->pcc_cl.tx_tout = cur->pcc_chan->latency * 5;
> I think this may need a unit conversion. ACPI 6.6 describes PCC nominal 
> latency in microseconds, and the PCC mailbox driver appears to copy that 
> value directly into pcc_chan->latency. However mbox_client::tx_tout is 
> documented in milliseconds.

Ah, good point, they are indeed using different units.
Will fix that.

Thanks,
Andre

> If I'm reading that correctly, assigning latency * 5 would make the 
> timeout 1000 times longer than intended. Would something like this be 
> better?
> 
> cur->pcc_cl.tx_tout = DIV_ROUND_UP_ULL((u64)cur->pcc_chan->latency * 5, 
> USEC_PER_MSEC);

