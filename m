Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01381FC101;
	Thu, 30 Jul 2026 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416092; cv=none; b=U3wMvMOmQBE6IgT2MCWhyLoyV3YaPxDb8tY2nhzGlWXzi1KDWkN7gAHsHqBiWzxKMk3dyFYhpm7O6D7m0dSIJsZrZ5YV/c+gZW47cKLPEabBaDdQgZesqJXcyKY8iTzxBw2M/YqAOeFPlzM07SgiNGgPnTWI08GlznU1IsfTHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416092; c=relaxed/simple;
	bh=m/tRGUrIaJo1gPHNCa8dnjK9j+dBKwJ7krErT2oQ6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9iDkUn3g8e+txwvPZ3qA0uO8dCkE6Eul7za0tVI01DfMA9aY7GoNaq+kQZvnZVJ1OX3dkZZWxrB+zw4IdHaReUZXQ/khZ7V9fBjRcohpe3VoVulJNt4COiCCEJPybFwkS7Ko0xMIisemxGaAWXcMLeNMLbH5otUqzXQHg3fBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bE5T29qk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bE5T29qk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19FFA1684;
	Thu, 30 Jul 2026 05:54:45 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F334C3F86F;
	Thu, 30 Jul 2026 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785416089; bh=m/tRGUrIaJo1gPHNCa8dnjK9j+dBKwJ7krErT2oQ6a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bE5T29qkS76RnrCw+OxH/pPEKcKJvFbsUD+DukTPKpzNq/zevovXTjBX2R6DRS7xm
	 7AmC7THjz2iyEZBDEv/5YvldBHGRuYk9li03WFZp+5z6DrHmN9FpZ512jv/BuBUjVH
	 Httr9pt/ygimTc6Nv1MUfiNbQPXDR23mk8iEzxAI=
Message-ID: <e8a86895-5ebb-45fe-b6ae-97f45793dba3@arm.com>
Date: Thu, 30 Jul 2026 14:54:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-9-andre.przywara@arm.com>
 <f26fde3c-3772-454b-b70c-176b3efaf02c@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <f26fde3c-3772-454b-b70c-176b3efaf02c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/29/26 18:10, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/29/26 14:41, Andre Przywara wrote:
>> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
>> alternative way of accessing the "Memory System Components" (MSC) in an
>> MPAM enabled system.
>>
>> Normally the MSCs are MMIO mapped, but in some implementations this
>> might not be possible (MSC located outside of the local socket, MSC
>> mapped secure-only) or desirable (direct MMIO access too slow or needs
>> to be mediated through a control processor). MPAM-fb standardises a
>> protocol to abstract MSC accesses, building on the SCMI protocol.
>>
>> Add functions that do an MSC read or write access by redirecting the
>> request through a firmware interface. For now this done via an ACPI
>> PCC shared memory and mailbox combination.
>>
>> Since the protocol used is only a small subset of the full SCMI spec,
>> and the SCMI protocol has no full ACPI support anyway, open-code the
>> (simple) SCMI message generation, for just the fields we need.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  |  52 ++++++--
>>   drivers/resctrl/mpam_fb.c       | 214 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  22 ++++
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 279 insertions(+), 13 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>
>> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
>> index 4f6d0e81f9b8..097c036724e9 100644
>> --- a/drivers/resctrl/Makefile
>> +++ b/drivers/resctrl/Makefile
>> @@ -1,5 +1,5 @@
>>   obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
>> -mpam-y						+= mpam_devices.o
>> +mpam-y						+= mpam_devices.o mpam_fb.o
>>   mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>>   
>>   ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index f6910ab3bbc2..abe1e628928f 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -83,6 +83,16 @@ static DECLARE_WORK(mpam_broken_work, &mpam_disable);
>>   /* When mpam is disabled, the printed reason to aid debugging */
>>   static char *mpam_disable_reason;
>>   
>> +void mpam_fb_disable_mpam(int err)
>> +{
>> +	static char mpam_fb_reason[32];
>> +
>> +	snprintf(mpam_fb_reason, sizeof(mpam_fb_reason), "MPAM-Fb error %d",
>> +		 err);
>> +	mpam_disable_reason = mpam_fb_reason;
>> +	schedule_work(&mpam_broken_work);
>> +}
>> +
> 
> [...]
> 
>> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
>> +				u16 reg, u32 *result, int mpam_fb_command)
>> +{
>> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
>> +	struct pcc_mbox_chan *chan;
>> +	void __iomem *payload_ofs;
>> +	u32 status;
>> +	int ret;
>> +
>> +	if (!pcc_chan)
>> +		return -ENODEV;
>> +
>> +	chan = pcc_chan->pcc_chan;
>> +
>> +	/* prune token to fit into the 10 bits inside the command register */
>> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
>> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
>> +
>> +	guard(mutex)(&pcc_chan->pcc_chan_lock);
>> +
>> +	switch (mpam_fb_command) {
>> +	case MPAM_MSC_WRITE_CMD:
>> +		mpam_fb_build_write_message(msc_id, reg, *result,
>> +					    token, chan->shmem);
>> +		break;
>> +	case MPAM_MSC_READ_CMD:
>> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
>> +		break;
>> +	case MPAM_PROTOCOL_VERSION_CMD:
>> +		mpam_fb_build_version_message(token, chan->shmem);
>> +		break;
>> +	default:
>> +		dev_err(pcc_chan->pcc_cl.dev, "unsupported MPAM-Fb command %d\n",
>> +			mpam_fb_command);
>> +		ret = -EINVAL;
>> +		goto out_err;
>> +	}
>> +
>> +	ret = mbox_send_message(chan->mchan, NULL);
>> +	if (ret < 0)
>> +		goto out_err;
>> +
>> +	pcc_shmem = chan->shmem;
>> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
>> +	status = readl(&pcc_shmem->command);
>> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token) {
>> +		ret = -ETIMEDOUT;
>> +
>> +		goto out_err;
>> +	}
>> +
>> +	ret = readl(payload_ofs + 0x0);
>> +	if (ret < 0) {
>> +		switch (ret) {
>> +		case MPAM_FB_ERR_NOT_SUPPORTED:
>> +			ret = -EOPNOTSUPP;
>> +			break;
>> +		case MPAM_FB_ERR_INVALID_PARAMETERS:
>> +			ret = -EINVAL;
>> +			break;
>> +		case MPAM_FB_ERR_NOT_FOUND:
>> +			ret = -ENOENT;
>> +			break;
>> +		case MPAM_FB_ERR_OUT_OF_RANGE:
>> +			ret = -ERANGE;
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +		}
>> +
>> +		goto out_err;
>> +	}
>> +
>> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
>> +		*result = readl(payload_ofs + 0x4);
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	mpam_fb_disable_mpam(ret);
> 
> Given that the 'ret' here is just used to create the log message we could provide more information
> just by indicating if we timed out waiting for firmware response or by giving the mpam_fb error code.

I see what you mean. It gets a bit nasty in the details, since 
mpam_disable_reason is just a pointer, so putting arbitrary strings of 
unknown length into that message is a bit involved. I changed that now 
to also pass the untranslated error value here, so both numbers are 
printed in the logs.
If we still feel like it, we can improve on this later, I think.

Cheers,
Andre
