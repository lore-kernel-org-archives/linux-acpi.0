Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB833246EC;
	Thu, 21 May 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379501; cv=none; b=kxUixftaaRNCw6UGDUOOmWPPi04VBxhmwK2tlIUIONBA20cNGB6ELUNRPKcFhj1GuXmEaUNFj30jSkmULovVQYO7rBytUHAfuGTofKtBOUXizF+JvQxML7wN6hix0kyWa4vDSgyYbwIObYxpV4uluLx0YBNDpI6O7fayXI2tbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379501; c=relaxed/simple;
	bh=WrS7fUya0tB6RvYKPlX4u1Tgmf4rlpi3+sFsH/ZRSiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf/FnRn9T1RVGeSBSO+QBuIrnH6D+BLcAKgkdXY60Lp8gTOhaNlstKdNMrxVbraz5H+Klh+fttAKp/BChhIlxWPVTvgD6bB3sJskjwJnLjQEvD70BvflXy7s6GNK5SGzGSNVSwRw2aR1ghwsQ0TUxJSVECmgt7CS+PtB116s7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=trXtDEBh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="trXtDEBh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070B327DC;
	Thu, 21 May 2026 09:04:54 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5746F3F85F;
	Thu, 21 May 2026 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779379499; bh=WrS7fUya0tB6RvYKPlX4u1Tgmf4rlpi3+sFsH/ZRSiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=trXtDEBhxsLogmubRZ5go2fZdcja2PICflKOjlf7cuyxhtNmTeczOd8o2EYHQLoCf
	 /fVl1ys0J6bNpE9xgZdwOHtp0IIZP4o4VD+jPwpz8jNSsTVsVCdQyho3IN5OE2rZ5y
	 BYQLaSzeDj31a293zLownVRWmL6jhLIxtFbHuNSA=
Message-ID: <88ed47c1-f84f-4aac-8ec7-ffe87a2a8138@arm.com>
Date: Thu, 21 May 2026 18:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm_mpam: detect and enable MPAM-Fb PCC support
To: Niyas Sait <niyas.sait@arm.com>
Cc: ben.horgan@arm.com, catalin.marinas@arm.com, fenghuay@nvidia.com,
 guohanjun@huawei.com, james.morse@arm.com, jic23@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, rafael@kernel.org, reinette.chatre@intel.com,
 sudeep.holla@kernel.org, will@kernel.org
References: <20260429141339.3171205-6-andre.przywara@arm.com>
 <20260518111422.3269965-1-niyas.sait@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260518111422.3269965-1-niyas.sait@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niyas,

On 5/18/26 13:14, Niyas Sait wrote:
> Hi Andre,
> 
> On Wed, Apr 29, 2026 at 04:13:39PM +0200, Andre Przywara wrote:
> 
>> +		msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
>> +							 pcc_subspace_id);
>> +		if (IS_ERR(msc->pcc_chan)) {
>> +			pr_err("Failed to request MSC PCC channel\n");
>> +			return (void *)msc->pcc_chan;
>> +		}
>> +
>> +		if (msc->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
>> +			pr_err("MPAM-Fb PCC channel size too small.\n");
>> +			pcc_mbox_free_channel(msc->pcc_chan);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
> 
> I think this allocates one PCC channel per MSC instance.
> 
> MPAM-Fb spec. allows MPAM manager to support multiple MSCs and does not

Ouch, that's right, the MSC ID parameter in the protocol would be pretty 
pointless otherwise ;-)
I guess me testing with just one MSC kind of hides this problem ;-)

> require seperate channels per MSC. Each MSC is targeted via its msc_id
> in the MPAM_MSC_READ/WRITE commands.
> 
> So for systems where multiple MSC nodes point to the same PCC subspace,
> should we share one pcc_mbox_chan and serialize requests through it?

I think we serialise already, because we have this pcc_chan_lock. This 
makes sure that each access is done in isolation. But on the setup side 
we need to indeed make sure to share an already allocated channel, which 
required some code changes.

Thanks for pointing this out!

Cheers,
Andre

