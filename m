Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2D347FEC;
	Tue, 28 Jul 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254697; cv=none; b=boTUeGmjrfOM1cpCn+aVdAP6a0V0q0k6irulukkLc4TzIdY6ymFX1pXIIXU/UX+TzBOShaHJ3Zkk02IvRMPcMNJhX3oxxw7PUMuLaXpkN0/K42NNmt9uiCZswxEqusSLYnFtxCMw3Gsnq/bJVukQB9chmq8kxY+Jwg+2Z1Weg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254697; c=relaxed/simple;
	bh=7CgezdQ117KVhyDuU6BXIINPqznPJrVSSeWYj2OVfE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKCPa52iNEWsW/ecspm1EYKvH/JDcjiBHD+np1y1ACRp08IcopiQEYS3JENdDfYWnpfZMuXNFjKGbwM3o1x7yx3GlNp01nEQ1NtSTw6pz1faXjzJwd5TVGs9GpHMWtW8tN5/G0RpIKbB+g3JLItEJdaM6RknaWv/6/WpNNPtXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RNRstlm7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RNRstlm7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14CB169E;
	Tue, 28 Jul 2026 09:04:49 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F3CC3F763;
	Tue, 28 Jul 2026 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254693; bh=7CgezdQ117KVhyDuU6BXIINPqznPJrVSSeWYj2OVfE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RNRstlm7k3LjsJxDMK1NliNUFC6+tNTKVG18Ll3Q+xtf8GegT+TUZX+vV9wkqUkzd
	 WoNo2ZO4Kxb3zZPKpAdKGwC9mngQkce57IZZQs+VhTxpgIRN4/bc0n+C9DIy0y8Pm0
	 ef9K1Rn8gMv/6rHU2OlNNQzaw9xw0rWTF68Cb9KI=
Message-ID: <8d4608b4-f828-44de-b677-79a12a5fcdfa@arm.com>
Date: Tue, 28 Jul 2026 18:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
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
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
 <b9502a40-8075-48fc-8ff1-3ae17741ea73@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <b9502a40-8075-48fc-8ff1-3ae17741ea73@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/24/26 19:08, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/23/26 16:54, Andre Przywara wrote:
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
>>   drivers/resctrl/mpam_devices.c  |  27 ++++-
>>   drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  20 ++++
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 240 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>

[ ... ]

>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 000000000000..ec4bf0dd9182
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2024 Arm Ltd.
>> +
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/errno.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +#include <acpi/pcc.h>
>> +#include <asm/mpam.h>
>> +
>> +#include "mpam_internal.h"
>> +
>> +#define MPAM_FB_PROTOCOL_ID	0x1a
> 
> A new line here would keep the commands separate.

Sure.

>> +#define MPAM_PROTOCOL_VERSION	0x0
> This one needs a _CMD as well.

You got it.

>> +#define MPAM_MSC_ATTRIBUTES_CMD	0x3
>> +#define MPAM_MSC_READ_CMD	0x4
>> +#define MPAM_MSC_WRITE_CMD	0x5
>> +
>> +#define MPAM_FB_ERR_SUCCESS		 0
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
>> +#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
>> +#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
>> +
>> +struct mpam_fb_read_payload {
>> +	u32 msc_id;
>> +	u32 flags;
>> +	u32 reg_offset;
>> +} __packed;
>> +
>> +struct mpam_fb_write_payload {
>> +	u32 msc_id;
>> +	u32 flags;
>> +	u32 reg_offset;
>> +	u32 value;
>> +} __packed;
>> +
>> +#define PCC_CHAN_FLAGS_IRQ	BIT(0)
> 
> Isn't this the same as PCC_CMD_COMPLETION_NOTIFY in include/acpi/pcc.h?

Looks like it, nice, will use that instead.

>> +
>> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
>> +
>> +static void mpam_fb_build_version_message(unsigned int token,
>> +					  void __iomem *msg_buf)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> 
> What's the deal with .signature?

As Sudeep said: it's the platform's (SCP's) responsibility to set it. 
Will add a comment to that affect.

>> +
>> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
> 
> Are you sure it's ok to unconditionally set this irq bit? I know we found out that we do need it set
> sometimes. What does setting it actually based on what the platform does look like?

I guess that depends on the SCP implementation, but I think it always 
needs to set the channel free bit, as it's part of the protocol. This is 
what the PCC code would poll for. The interrupt is just on top. So if we 
set the bit here, and the SCP doesn't support an interrupt, it would 
still work, as the PCC code would poll, regardless of that bit here, 
which it doesn't know about.

Cheers,
Andre.

> 
> Thanks,
> 
> Ben
> 
>> +	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
>> +	writel_relaxed(MPAM_PROTOCOL_VERSION |
>> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
>> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
>> +		       &pcc_shmem->command);
>> +}
>> +
>> +static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
>> +				       void __iomem *msg_buf)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
>> +	struct mpam_fb_read_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
>> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
>> +
>> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
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
>> +	struct mpam_fb_write_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
>> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
>> +
>> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
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
>> +	case MPAM_PROTOCOL_VERSION:
>> +		mpam_fb_build_version_message(token, chan->shmem);
>> +		break;
>> +	}
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
>> index b3a6ed9ed175..e4686ff0ba2e 100644
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
>> @@ -511,6 +523,14 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   #endif /* CONFIG_RESCTRL_FS */
>>   
>> +/* MPAM-Fb Firmware-backed protocol wrappers */
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
>> +
>> +#define MPAM_FB_PROT_HEADER_LEN	sizeof(u32)
>> +#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))
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

