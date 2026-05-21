Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA82C08BB;
	Thu, 21 May 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378884; cv=none; b=ToTHT8XhVV1oxR3EQ4byvk0Y/BW+F0fWWhPQSQynWgtu+imdsehmlqEGdqKAmxppcaAolFGZPRHrFO82Xm16Ld5pn1fTzRbMZnDPID4L9PQpMBuy9JZ8K3glkzNssOhUf3dzi2JrWuOk0H3F7Qxgg7jXu6N+fEc54dbhPw2JxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378884; c=relaxed/simple;
	bh=JE99UdEVTQAKsmSUBY2hhUODDQi/V7DmJiCJiajrofU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBfa3yHxk6UIzVIzNm9DwczJPYsRiPHf/tn/yQf0yPjJz7xKhg6llq1p3p5zsjeTJGxQrYpC/9PFI3jtwk9fpN9mrw/8U6NIGjT4HAHTISjgbqvVzpuc3ohIl+QUCDudZ1jW58dfcIBq6jAOcaEpB3HyFEBgFhz/YV+P4xA2gAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BLRZL/y5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BLRZL/y5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489E72BCB;
	Thu, 21 May 2026 08:54:37 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065FE3F632;
	Thu, 21 May 2026 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779378882; bh=JE99UdEVTQAKsmSUBY2hhUODDQi/V7DmJiCJiajrofU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BLRZL/y5+wvuKc8RMp4XImNwsHiVW75wZC2GaB+C0EdfOOugurafrAioJ+1xT+qRY
	 N5F2CcagfjvBqbHMbetZmETnTtyNdC6TJ9vbqePl+8FmKRj/xbrbQdLw9BYzpmrx+F
	 HNjLGyZZ1+OjkRLsyNhjC6NaM3G4SGQjUIWq64Xk=
Message-ID: <bd1edbb2-5b0a-4dfa-ba84-4626f79acb7c@arm.com>
Date: Thu, 21 May 2026 17:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm_mpam: add MPAM-Fb MSC firmware access support
To: Niyas Sait <niyas.sait@arm.com>
Cc: ben.horgan@arm.com, catalin.marinas@arm.com, fenghuay@nvidia.com,
 guohanjun@huawei.com, james.morse@arm.com, jic23@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, rafael@kernel.org, reinette.chatre@intel.com,
 sudeep.holla@kernel.org, will@kernel.org
References: <20260429141339.3171205-4-andre.przywara@arm.com>
 <20260518085237.3259344-1-niyas.sait@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260518085237.3259344-1-niyas.sait@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niyas,

many thanks for replying on the list!

On 5/18/26 10:52, Niyas Sait wrote:
> Hi Andre,
> 
> On Wed, Apr 29, 2026 at 04:13:37PM +0200, Andre Przywara wrote:
> 
>> +#define SCMI_CHAN_FLAGS_OFS	0x10
>> +#define SCMI_CHAN_FLAGS_IRQ		BIT(0)
>> +#define SCMI_MSG_LENGTH_OFS	0x14
>> +#define SCMI_MSG_HEADER_OFS	0x18
>> +#define SCMI_MSG_PAYLOAD_OFS	0x1c
> 
> I think this will not work for the ACPI PCC Type 3 MPAM Fb path.

Ah yes, I was confused about the offsets, and since I also provided the 
firmware side in my very crude test setup, this matches, courtesy of me 
making the same mistake on both sides ;-)

> 
> SCMI shared memory transport layout and ACPI Extended PCC subspace
> shared memory layout use different offsets for the flags, length, command,
> and payload fields.
> 
> For Extended PCC subspace, the layout is:
> 
> Flags   @ 0x04
> Length  @ 0x08
> Command @ 0x0c
> Payload @ 0x10
> 
> SCMI shared memory layout uses:
> 
> Flags   @ 0x10
> Length  @ 0x14
> Command @ 0x18
> Payload @ 0x1c
> 
> You will need to use the extended PCC subspace layout for the ACPI path.

Ah yes, I now see that I actually used a PCC subspace type 2 layout, 
which explains some parts of my confusion, I guess.

So I changed that now: as you show above, there is just an offset, but 
the relevant fields magically match otherwise. Since there is no SCMI 
support in the code base at the moment, I can just change the offsets, 
and deal with SCMI later.

> 
>> +static int mpam_fb_wait_for_channel(struct pcc_mbox_chan *chan,
>> +				    bool free)
>> +{
>> +	u32 status = free ? SCMI_CHAN_STATUS_FREE_BIT : 0;
>> +	u32 val;
>> +
>> +	/*
>> +	 * The channel should really be free always at this point, as we take
>> +	 * a lock for every read or write request. Check the free bit anyway,
>> +	 * for good measure and to catch corner cases.
>> +	 */
>> +	return readl_poll_timeout(chan->shmem + SCMI_CHAN_STATUS_OFS, val,
>> +				  (val & SCMI_CHAN_STATUS_FREE_BIT) == status,
>> +				  1, 10000);
>> +}
> 
> This also assumes SCMI channel status completion semantics in shared memory.
> For PCC Type 3 transport, completion should follow PCC Type 3 completion mechanisms.

Ah, this is a very good point. As mention, I was staring at type 2 in 
the ACPI spec. The PCC type 3 semantics is effectively very similar, or 
at least can made to be, by just putting the right bits into the PCCT 
table. The nice thing is that the Linux PCC code already handles the 
channel negotiation, as part of the mailbox abstraction, so by just 
populating the right fields in the PCCT table, I get the same semantics 
on the device side, and can drop the whole channel ownership negotiation 
from the MPAM code.

I now did one trick to simplify this: I kept the shared memory area 
using the SCMI layout, so with the payload starting at offset 0x1c. In 
the PCCT table I add 0xc to the beginning of the SRAM area, and give 
that as the base address. This makes the SCP side always see the same 
layout, at least for the relevant bits. Then I tell PCCT that the 
command update register is at offset 0x4 of SRAM (so *before* the PCCT 
shared mem area), which is exactly the location of the SCMI channel 
ownership bit. To me that looks like it should work with SCMI and PCC 
alike, maybe with some little tweaks on the SCP side.

With those changes it works for me now using type 3. I will send a v2 in 
due time, once I address all the other outstanding issues.

Many thanks for the heads up on this one!

Cheers,
Andre

