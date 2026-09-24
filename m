Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3B3DB641;
	Thu, 24 Sep 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263543; cv=none; b=hwAabnHTQDht6acR1vnmtS2P56QAW9lBbdPg2aQwxM6Pm+wdcx8uUVAo86lGJ4eSnY5Spo4Z+iSofCMwMhQ0QemPhR0H6tpV8KB8YvEGAsyhQ2/DXtcDBSSmQFwBLqnjBWk1mnUjMz9CxN6xQcOwCWuAv2kmJ3LR/6WCQNA+8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263543; c=relaxed/simple;
	bh=YmFk6MG1PCYwCNCLNfBa3wxpVwsSj1P1WbxJbFq6Fuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5NhQvZ9lIKOIZi0ZSDR3262O5GU2X3GgAPStNcDDiHkhCL6pZvvUe8TRYzlV/ULPoAIIc4wBrruK8n4yXIY5ojoMXpdkjA6hrKcu8qxMLvSet9y9IK7wG52pRjz/SaLsDfBVgLZiu4+xqaStBOf6Yo5nIbHtNPxnktq14g5wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CgKAqBxV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CgKAqBxV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4697E143D;
	Thu, 24 Sep 2026 08:25:36 -0700 (PDT)
Received: from [10.57.8.50] (unknown [10.57.8.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B3C63F86F;
	Thu, 24 Sep 2026 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790263539; bh=YmFk6MG1PCYwCNCLNfBa3wxpVwsSj1P1WbxJbFq6Fuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgKAqBxVGBLsX+6pGnsvzOcN4jUwfBf7ucdv5JZ0+TkWL+TTTMWSrzkuAV6zlf1B6
	 +AAstRlnp/ga2HJ52Q01muylEUOHqg4zaMcf4R3vxK6/u4lvK6IN1IYT9UX5GtwzK8
	 68KB+nxA8ascSeWu0hJ1J8HJSZBJlMgvkbB/hBUU=
Message-ID: <47e80c81-4f67-406c-8460-45556402db88@arm.com>
Date: Thu, 24 Sep 2026 17:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/14] arm_mpam: add MPAM-Fb MSC firmware access
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
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260911112835.714162-1-andre.przywara@arm.com>
 <20260911112835.714162-11-andre.przywara@arm.com>
 <c46d0d04-fda8-47e4-9f01-498db33c2714@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <c46d0d04-fda8-47e4-9f01-498db33c2714@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

thanks for having a look ;-)

On 9/11/26 17:13, Ben Horgan wrote:
> Hi Andre,
> 
> On 11/09/2026 12:28, Andre Przywara wrote:
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
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
>> ---
>>   drivers/acpi/arm64/mpam.c       |   2 +
>>   drivers/resctrl/Kconfig         |   1 +
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  |  65 ++++++++--
>>   drivers/resctrl/mpam_fb.c       | 211 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  19 +++
>>   include/linux/arm_mpam.h        |   2 +-
>>   7 files changed, 288 insertions(+), 14 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>

[ ... ]
>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 0000000000000..98212f761de38
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -0,0 +1,211 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2024-2026 Arm Ltd.
>> +
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/errno.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/types.h>
>> +
>> +#include <acpi/pcc.h>
>> +#include <asm/mpam.h>
>> +
>> +#include "mpam_internal.h"
>> +
>> +#define MPAM_MSC_TOKEN_MASK		GENMASK_U32(27, 18)
>> +#define MPAM_MSC_PROT_ID_MASK		GENMASK_U32(17, 10)
>> +
>> +#define MPAM_FB_PROTOCOL_ID		0x1a
>> +
>> +#define MPAM_PROTOCOL_VERSION_CMD	0x0
>> +#define MPAM_MSC_READ_CMD		0x4
>> +#define MPAM_MSC_WRITE_CMD		0x5
>> +
>> +#define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
>> +
>> +#define MPAM_FB_SUCCESS		 0
>> +#define MPAM_FB_ERR_NOT_SUPPORTED	-1
>> +#define MPAM_FB_ERR_INVALID_PARAMETERS	-2
>> +#define MPAM_FB_ERR_DENIED		-3
>> +#define MPAM_FB_ERR_NOT_FOUND		-4
>> +#define MPAM_FB_ERR_OUT_OF_RANGE	-5
>> +#define MPAM_FB_ERR_BUSY		-6
>> +#define MPAM_FB_ERR_COMMS_ERROR		-7
>> +#define MPAM_FB_ERR_GENERIC_ERROR	-8
>> +#define MPAM_FB_ERR_HW_ERROR		-9
>> +#define MPAM_FB_ERR_PROTOCOL_ERROR	-10
>> +#define MPAM_FB_ERR_IN_USE		-11
>> +
>> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
>> +
>> +static int mpam_fb_to_linux_errno(int mpam_fb_code)
>> +{
>> +	switch (mpam_fb_code) {
>> +	case MPAM_FB_ERR_NOT_SUPPORTED:
>> +		return -EOPNOTSUPP;
>> +	case MPAM_FB_ERR_INVALID_PARAMETERS:
>> +		return -EINVAL;
>> +	case MPAM_FB_ERR_NOT_FOUND:
>> +		return -ENOENT;
>> +	case MPAM_FB_ERR_OUT_OF_RANGE:
>> +		return -ERANGE;
>> +	case MPAM_FB_ERR_BUSY:
>> +		return -EBUSY;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static void mpam_fb_build_version_message(unsigned int token,
>> +					  void __iomem *msg_buf)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
>> +
>> +	/* .signature is filled by the platform */
>> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
>> +	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
>> +	writel_relaxed(MPAM_PROTOCOL_VERSION_CMD |
>> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
>> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
>> +		       &pcc_shmem->command);
>> +}
>> +
>> +static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
>> +				       void __iomem *msg_buf)
> 
> As we're anticipating that msc_id may be different from msc->id can be use msc_fb_id instead of
> msc_id in this file.

Yes, that's a good idea, changed that.

Cheers,
Andre

>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
>> +	struct mpam_fb_read_payload {
>> +		u32 msc_id;
>> +		u32 flags;
>> +		u32 reg_offset;
>> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
>> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
>> +
>> +	/* .signature is filled by the platform */
>> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
>> +	writel_relaxed(msg_size, &pcc_shmem->length);
>> +	writel_relaxed(MPAM_MSC_READ_CMD |
>> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
>> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
>> +		       &pcc_shmem->command);
>> +
>> +	writel_relaxed(msc_id, &payload->msc_id);
>> +	writel_relaxed(0, &payload->flags);
>> +	writel_relaxed(reg, &payload->reg_offset);
>> +}
>> +
>> +static void mpam_fb_build_write_message(int msc_id, int reg, u32 val,
>> +					unsigned int token,
>> +					void __iomem *msg_buf)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
>> +	struct mpam_fb_write_payload {
>> +		u32 msc_id;
>> +		u32 flags;
>> +		u32 reg_offset;
>> +		u32 value;
>> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
>> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
>> +
>> +	/* .signature is filled by the platform */
>> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
>> +	writel_relaxed(msg_size, &pcc_shmem->length);
>> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
>> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
>> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
>> +		       &pcc_shmem->command);
>> +
>> +	writel_relaxed(msc_id, &payload->msc_id);
>> +	writel_relaxed(0, &payload->flags);
>> +	writel_relaxed(reg, &payload->reg_offset);
>> +	writel_relaxed(val, &payload->value);
>> +}
>> +
>> +static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_id,
>> +				u16 reg, u32 *result, int mpam_fb_command)
>> +{
>> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
>> +	struct mpam_pcc_chan *pcc_chan;
>> +	struct pcc_mbox_chan *chan;
>> +	void __iomem *payload_ofs;
>> +	int mpam_fb_err = 0;
>> +	u32 status;
>> +	int ret;
>> +
>> +	pcc_chan = msc->pcc_chan;
>> +	if (!pcc_chan)
>> +		return -ENODEV;
>> +
>> +	chan = pcc_chan->pcc_chan;
>> +
>> +	/* prune token to fit into the 10 bits inside the command register */
>> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
>> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
>> +
>> +	mutex_lock(&pcc_chan->pcc_chan_lock);
>> +
>> +	switch (mpam_fb_command) {
>> +	case MPAM_PROTOCOL_VERSION_CMD:
>> +		mpam_fb_build_version_message(token, chan->shmem);
>> +		break;
>> +	case MPAM_MSC_READ_CMD:
>> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
>> +		break;
>> +	case MPAM_MSC_WRITE_CMD:
>> +		mpam_fb_build_write_message(msc_id, reg, *result,
>> +					    token, chan->shmem);
>> +		break;
>> +	default:
>> +		dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
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
>> +		goto out_err;
>> +	}
>> +
>> +	mpam_fb_err = readl(payload_ofs + 0x0);
>> +	if (mpam_fb_err < 0) {
>> +		ret = mpam_fb_to_linux_errno(mpam_fb_err);
>> +		goto out_err;
>> +	}
>> +
>> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
>> +		*result = readl(payload_ofs + 0x4);
>> +
>> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
>> +
>> +	mpam_fb_disable_mpam(ret, mpam_fb_err);
>> +
>> +	return ret;
>> +}
>> +
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
>> +{
>> +	return mpam_fb_send_request(msc, msc->mpam_fb_msc_id, reg, result,
>> +				    MPAM_MSC_READ_CMD);
>> +}
>> +
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>> +{
>> +	return mpam_fb_send_request(msc, msc->mpam_fb_msc_id, reg, &value,
>> +				    MPAM_MSC_WRITE_CMD);
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 2414598100140..e5a2804facd2d 100644
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
>> +	int			mpam_fb_msc_id;
>>   	u32			nrdy_usec;
>>   	cpumask_t		accessibility;
>>   	bool			has_extd_esr;
>> @@ -493,6 +505,9 @@ extern u8 mpam_pmg_max;
>>   void mpam_enable(struct work_struct *work);
>>   void mpam_disable(struct work_struct *work);
>>   
>> +/* helper function to call from outside mpam_devices.c */
>> +void mpam_fb_disable_mpam(int err, int mpam_fb_err);
>> +
>>   /* Reset all the RIS in a class under cpus_read_lock() */
>>   void mpam_reset_class_locked(struct mpam_class *class);
>>   
>> @@ -520,6 +535,10 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   #endif /* CONFIG_RESCTRL_FS */
>>   
>> +/* MPAM-Fb Firmware-backed protocol wrappers */
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>> +
>>   /*
>>    * MPAM MSCs have the following register layout. See:
>>    * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
>> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
>> index f92a36187a527..002f56e153626 100644
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

