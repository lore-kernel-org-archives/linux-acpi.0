Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8C36680E;
	Tue, 21 Jul 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645681; cv=none; b=dMqS2lf51AxFA+3Gxc8v9EBOEg6IzFOpA1rdn1BNwOSZ3EnOYg1YcY7wsMHrRZg5iAU4t/WpPS6bQBOC8PGh9Kk//3WWyV6BE69JYPsGm2HWGs1s+xwbo0dWFsYPOddMaJFSbJEiRjIyaoa1XMygNZHxylITcT4CW6dNZ/FAX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645681; c=relaxed/simple;
	bh=MitdL30heQSAH7WS0YQpZljVY3sO1FWU+W23/+uIAe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqzzGZJCYHKD9BHswMH0evU/FFeGCJCm7mn/2wgtNDSI7ClO/bWIlTBdnO3XZ3Kxbg197wOQRha3dEIIR5vargprEaSxrtKDjbQOesoMz3sWo6Fc0Hsk8Vh9CKQSEJSJWN11cirLe36XZKaulw2m8O3xPPHbI6pkjBdHGgxy4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BBWuskjt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BBWuskjt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E058D152B;
	Tue, 21 Jul 2026 07:54:34 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251EF3F86F;
	Tue, 21 Jul 2026 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784645679; bh=MitdL30heQSAH7WS0YQpZljVY3sO1FWU+W23/+uIAe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BBWuskjtszvLN5RjnQFmSXDBnb5rmM7GLCwJ9I/v92BznbOltddup6q68nKrSIduz
	 0kAsQHVSgQ1UqICtuVfak65akUtXJ0GRTZ45qz8zI/YqWlnxrGfJZxmzXl66TMH3uJ
	 PUpNBhzY/6DBQiViSY6vC9KLV0CKTrev1FKnnDg8=
Message-ID: <b943d2e7-9f74-40f6-bbaa-84642ea785eb@arm.com>
Date: Tue, 21 Jul 2026 16:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC support
To: Niyas Sait <niyas.sait@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-17-andre.przywara@arm.com>
 <9ac5f187-ff48-434b-a1c0-7f73b442083c@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <9ac5f187-ff48-434b-a1c0-7f73b442083c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Niyas,

On 7/14/26 14:32, Niyas Sait wrote:
> On 10/07/2026 15:45, Andre Przywara wrote:
>> +    cur->pcc_cl.dev = dev;
>> +    cur->pcc_cl.rx_callback = mpam_pcc_rx_callback;
>> +    cur->pcc_cl.tx_block = true;
>> +    cur->pcc_cl.tx_tout = 1000; /* 1s */
> 
> Should this timeout be based on nominal latency reported in PCC table 
> instead of being hard coded to 1s here? May be some multiple of nominal 
> latency reported

I originally thought that this would be handled by the PCC code, but 
that just parses the value, and puts it in the pcc_mbox_chan struct. 
Which we only get access to *after* we request the channel in the next 
line here.
But it's only mbox_send_message() that uses the value, so I think we can 
populate that value later on still. And yeah, some multiple of the 
nominal latency sounds reasonable.

Cheers,
Andre

