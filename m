Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1F3F7899;
	Wed, 22 Jul 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739452; cv=none; b=jK/NAjCGqi7xsV5WR3t9B1uSHPCXaQq4XvejkrRou+nNYFqwlygPJLbldF5wX/MTQxi8vu2i4R04RWKKJJTPM1zx86I+CYhy2GkMumUJGJrOMV8EgXHTNB7vZ5C1om/45M2cmY4tpOUWlBcLO9u1gey2oRPtbPVmcETrGiMVuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739452; c=relaxed/simple;
	bh=89rxrucrxjzgj1aXXruDju15cxQ7ViY2HScZnUbY+Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHhZeBJV3kDhhwVnNvivQbDjuJWYrLGdiZRdoUiYjjoXm42aCaa1TwDNN11cKh/YGgFXyi5+/WXh31DKx/Q03iTlcQNEOwwyYEq5yFTio1FKQVXL9cz67h8SixdzTvUqbTv9WVBeYvWUtw7Rq/85lO/mHSH9M1/sqF2f3lVUUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qvxQGply; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qvxQGply"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305341595;
	Wed, 22 Jul 2026 09:57:25 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56B513F59E;
	Wed, 22 Jul 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784739449; bh=89rxrucrxjzgj1aXXruDju15cxQ7ViY2HScZnUbY+Us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvxQGplyMWJ84m/QGsKMKGDaXMfvYIJ26QHQqruZwOZ6xtxOWQcxeFK1HcWCY4Gy2
	 gZZgXXVEGmkuwXJs6zAuv3UDj3NeSO5OHERNhVgvvfQIZm1YgWKuJNEgGLcMnbLa2N
	 XC5MaqmIkUxeVtU7Zf8mvFkFjf9zfzWZLNBnC1f0=
Message-ID: <8ac6cb78-07cf-4bba-ab70-a26476ad637c@arm.com>
Date: Wed, 22 Jul 2026 18:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] arm_mpam: add MPAM-Fb MSC firmware access
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-15-andre.przywara@arm.com>
 <2947c85a-572d-41f9-a45f-0b9691a98276@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <2947c85a-572d-41f9-a45f-0b9691a98276@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/15/26 18:17, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/10/26 15:45, Andre Przywara wrote:
>> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
>> alternative way of accessing the "Memory System Components" (MSC) in an
>> MPAM enabled system.
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
>> SCMI message generation and handshake, for just the fields we need.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  |  26 +++-
>>   drivers/resctrl/mpam_fb.c       | 208 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  20 +++
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 251 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>

[ ... ]

>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 000000000000..7d7409910f28
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -0,0 +1,208 @@

[ ... ]

>> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
>> +				u16 reg, u32 *result, int mpam_fb_command)
>> +{
>> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
>> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem;
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
>> +	guard(mutex)(&pcc_chan->pcc_chan_lock);
>> +
>> +	switch (mpam_fb_command) {
>> +	case MPAM_MSC_WRITE_CMD:
>> +		ret = mpam_fb_build_write_message(msc_id, reg, *result,
>> +						  token, chan->shmem);
>> +		break;
>> +	case MPAM_MSC_READ_CMD:
>> +		ret = mpam_fb_build_read_message(msc_id, reg,
>> +						 token, chan->shmem);
>> +		break;
>> +	case MPAM_PROTOCOL_VERSION:
>> +		ret = mpam_fb_build_version_message(token, chan->shmem);
>> +		break;
>> +	}
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = mbox_send_message(chan->mchan, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pcc_shmem = chan->shmem;
>> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
>> +	status = readl(&pcc_shmem->command);
>> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
>> +		return -ETIMEDOUT;
>> +
>> +	ret = readl(payload_ofs + 0x0);
>> +	if (ret < 0) {
>> +		switch (ret) {
>> +		case MPAM_FB_ERR_NOT_SUPPORTED:
>> +			return -EOPNOTSUPP;
>> +		case MPAM_FB_ERR_INVALID_PARAMETERS:
>> +			return -EINVAL;
>> +		case MPAM_FB_ERR_NOT_FOUND:
>> +			return -ENOENT;
>> +		case MPAM_FB_ERR_OUT_OF_RANGE:
>> +			return -ERANGE;
> 
> Does it make sense to have individual translations for any of the other errors? Which one do you
> think is most likely?

I don't think it's really that useful. For most errors there is no good 
mapping between MPAM-Fb and the generic Linux error codes, and when they 
are propagated up it's unclear what they mean, really.
I wonder if we should print or log the original error code, but 
otherwise not sweat it to find a perfect match for every MPAM-Fb code.

Cheers,
Andre

> 
> Thanks,
> 
> Ben
> 
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
>> +		*result = readl(payload_ofs + 0x4);
>> +
>> +	return 0;
>> +}
>> +
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
>> +{
>> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
>> +				    reg, result, MPAM_MSC_READ_CMD);
>> +}
>> +
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>> +{
>> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
>> +				    reg, &value, MPAM_MSC_WRITE_CMD);
>> +}
>> +
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc)
>> +{
>> +	u32 version;
>> +	int ret;
>> +
>> +	ret = mpam_fb_send_request(msc->pcc_chan, 0,
>> +				   0, &version, MPAM_PROTOCOL_VERSION);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return version;
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 7b6e0df904f8..c3c4ddb4a561 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/io.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/llist.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>>   #include <linux/resctrl.h>
>>   #include <linux/spinlock.h>
>> @@ -57,6 +58,15 @@ struct mpam_garbage {
>>   	struct platform_device	*pdev;
>>   };
>>   
>> +struct mpam_pcc_chan {
>> +	struct list_head	pcc_chans;
>> +	struct mbox_client	pcc_cl;
>> +	struct pcc_mbox_chan	*pcc_chan;
>> +	struct mutex		pcc_chan_lock; /* only one message at a time */
>> +	int			subspace_id;
>> +	int			refcount;
>> +};
>> +
>>   struct mpam_msc {
>>   	/* member of mpam_all_msc */
>>   	struct list_head	all_msc_list;
>> @@ -66,6 +76,8 @@ struct mpam_msc {
>>   
>>   	/* Not modified after mpam_is_enabled() becomes true */
>>   	enum mpam_msc_iface	iface;
>> +	struct mpam_pcc_chan	*pcc_chan;
>> +	int			mpam_fb_msc_id;	/* in its own name space */
>>   	u32			nrdy_usec;
>>   	cpumask_t		accessibility;
>>   	bool			has_extd_esr;
>> @@ -501,6 +513,14 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   #endif /* CONFIG_RESCTRL_FS */
>>   
>> +/* MPAM-Fb Firmware-backed protocol wrappers */
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
>> +
>> +#define PCC_TYPE3_MSG_PAYLOAD_OFS	0x10
>> +#define MPAM_FB_MAX_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
>> +
>>   /*
>>    * MPAM MSCs have the following register layout. See:
>>    * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
>> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
>> index f92a36187a52..002f56e15362 100644
>> --- a/include/linux/arm_mpam.h
>> +++ b/include/linux/arm_mpam.h
>> @@ -12,7 +12,7 @@ struct mpam_msc;
>>   
>>   enum mpam_msc_iface {
>>   	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
>> -	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
>> +	MPAM_IFACE_PCC,		/* using the MPAM-Fb firmware redirection */
>>   };
>>   
>>   enum mpam_class_types {
> 

