Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C942BE80;
	Thu, 30 Jul 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414505; cv=none; b=ItACkwzQ2QkXBsiG1fxasz0DY4qAyOD4iGDzSRRaM95roHCo4oW50X8qhtSc8CukHV9RkrG1Go+Ps/uc7XOKmn7jlz97Sfc283g0FhUk+kQNv4WptRRqI1Q5dEkvABwG4MBnmzzbuJc/V68rXCfb4UzFlwVxOWOZMY93SGloce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414505; c=relaxed/simple;
	bh=ce4amSfeO5ddQ3+gJrnw/HXGToqlKSsEg2RqxIiD9ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyFXiDDnClqawePwvPBjQ/TcIAFpDVqN8tkfenXWTWT7g2cSqA1reAl+lneaZO+J5lWvJUp5wbPObliGfJGq7mLgDsp4uj7F6DmKMa6+Ow2DEFJcpCv8w+cimirzp21oPHn6Bsne9UoP/rQZ1CZrd946sOYrm3agjuXJnkpKUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tWXA7mGH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tWXA7mGH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F2A1684;
	Thu, 30 Jul 2026 05:28:19 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7173F86F;
	Thu, 30 Jul 2026 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785414503; bh=ce4amSfeO5ddQ3+gJrnw/HXGToqlKSsEg2RqxIiD9ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tWXA7mGHifOfLkLmdMqruX2twXxjpZPtD4VSAJQZWg0GDE4zSBv6JCBirXzfDVC1k
	 aeou9Z3ikQ1exLGecSvWgAChFXglXHr1oXW1vIHwNYEkfQL2KoTZmNQfcFSlLjfyx/
	 E+d2wcUBe25Q3CU74AvRFgsVMRBpQejhUOi6drWA=
Message-ID: <158b744b-9edc-4bf0-8e7d-f8c00f90cf8b@arm.com>
Date: Thu, 30 Jul 2026 14:28:19 +0200
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
 <7e58cb7f-f789-4939-b35e-1aba5bbca53f@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <7e58cb7f-f789-4939-b35e-1aba5bbca53f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/30/26 12:59, Ben Horgan wrote:
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

[ ... ]

>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 000000000000..dbe984241b0d
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c

[ ... ]

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
> 
> As sashiko pointed out (strangely on its comments for patch 10) it's best to use mutex_lock() and
> mutex_unlock() in this function now that we have lots of gotos here. As per the guidance in
> include/linux/cleanup.h.

Ah, indeed, I didn't make it to the very end of this comment ;-)
Fixed.

Cheers,
Andre

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
>> +
>> +	return ret;
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
>> +				   0, &version, MPAM_PROTOCOL_VERSION_CMD);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return version;
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 2b81b6b0bf4e..a2193e7df57c 100644
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
>> +	struct kref		refcount;
>> +	int			subspace_id;
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
>> @@ -484,6 +496,9 @@ extern u8 mpam_pmg_max;
>>   void mpam_enable(struct work_struct *work);
>>   void mpam_disable(struct work_struct *work);
>>   
>> +/* helper function to call from outside mpam_devices.c */
>> +void mpam_fb_disable_mpam(int err);
>> +
>>   /* Reset all the RIS in a class under cpus_read_lock() */
>>   void mpam_reset_class_locked(struct mpam_class *class);
>>   
>> @@ -511,6 +526,13 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   #endif /* CONFIG_RESCTRL_FS */
>>   
>> +/* MPAM-Fb Firmware-backed protocol wrappers */
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
>> +
>> +#define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
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

