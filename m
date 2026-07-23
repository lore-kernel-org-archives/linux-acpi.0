Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BD421227;
	Thu, 23 Jul 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816540; cv=none; b=EEWRECifWpP2ZD4gcU5d9kXfXV58kq+8PJjPKmPF0Dd1UYrvqbaCbGR8lb0n8slqzxWaAZCfBMO8itjoz6DjuKA8nX4ZN4d4jf6fj/CnQduskrEzp2x3lWbKaaa9nqJ2biiLUMI5m7OD5Fmn+w7fVrOeiPGmBodAZLZeTvSGGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816540; c=relaxed/simple;
	bh=ZCqx8MSVps/+951UNVfzTb9X0CZwGFa9c4Y6yMpxaow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeUbRGqtLf2mVAXVDBd618TZknEVanls7J4diHUs59DKFSZejOfe/8IZlfpQLOiRlllIXSMq/nGt/IRrTy5jANc7BLnk3/5o3G+M4cECHGxZHoMF5LtLwCpvbdqU7UDcdZfBxMm/Nb/V5TTOFcVfRxYVtpwor1RCutGFZO4HQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VobslA3x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VobslA3x"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F77176B;
	Thu, 23 Jul 2026 07:22:09 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01E603F59E;
	Thu, 23 Jul 2026 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784816533; bh=ZCqx8MSVps/+951UNVfzTb9X0CZwGFa9c4Y6yMpxaow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VobslA3xYWPE8RNDGVTKkwJF9nD4FHjRBnu96bGk/7iBTyJwRkUlTa8fddVfU9Orz
	 R2m4cWgNOUWksD+4R2k2hDZtWPkTmxdQWVFWY36Qa/yElYZzqvbMNPg2uhxywDrmZF
	 3dZWi3xYOHQgkiqwKwkzu51K8PEr5+IAObY52rE4=
Message-ID: <37469c95-cb8b-41e9-9667-e59a324d483d@arm.com>
Date: Thu, 23 Jul 2026 15:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 14/16] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
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
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260710144520.917375-15-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,


On 7/10/26 15:45, Andre Przywara wrote:
> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> SCMI message generation and handshake, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/Makefile        |   2 +-
>  drivers/resctrl/mpam_devices.c  |  26 +++-
>  drivers/resctrl/mpam_fb.c       | 208 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  20 +++
>  include/linux/arm_mpam.h        |   2 +-
>  5 files changed, 251 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/resctrl/mpam_fb.c
> 
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..097c036724e9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> -mpam-y						+= mpam_devices.o
> +mpam-y						+= mpam_devices.o mpam_fb.o
>  mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>  
>  ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index ca73029654b6..4d3e642486d4 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -181,6 +181,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>  {
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
>  	*res = readl_relaxed(msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -197,9 +200,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>  
>  static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_write_request(msc, reg, val);
> +
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	writel_relaxed(val, msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -1133,7 +1139,8 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>  
>  	mpam_mon_sel_lock_held(msc);
>  
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
>  	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> @@ -1481,9 +1488,15 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			arg->ris = ris;
>  
> -			err = smp_call_function_any(&msc->accessibility,
> -						    __ris_msmon_read, arg,
> -						    true);
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				err = smp_call_function_any(&msc->accessibility,
> +							    __ris_msmon_read,
> +							    arg, true);
> +			} else {
> +				__ris_msmon_read(arg);
> +				err = 0;
> +			}
> +
>  			if (!err && arg->err)
>  				err = arg->err;
>  
> @@ -1922,6 +1935,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
>  
>  static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
>  {
> +	if (msc->iface != MPAM_IFACE_MMIO)
> +		return fn(arg);
> +
>  	lockdep_assert_irqs_enabled();
>  	lockdep_assert_cpus_held();
>  	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..7d7409910f28
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/processor.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +
> +#include <asm/mpam.h>
> +
> +#include "mpam_internal.h"
> +
> +#define MPAM_FB_PROTOCOL_ID	0x1a
> +#define MPAM_PROTOCOL_VERSION	0x0
> +#define MPAM_MSC_ATTRIBUTES_CMD	0x3
> +#define MPAM_MSC_READ_CMD	0x4
> +#define MPAM_MSC_WRITE_CMD	0x5
> +
> +#define MPAM_FB_ERR_SUCCESS		 0
> +#define MPAM_FB_ERR_NOT_SUPPORTED	-1
> +#define MPAM_FB_ERR_INVALID_PARAMETERS	-2
> +#define MPAM_FB_ERR_DENIED		-3
> +#define MPAM_FB_ERR_NOT_FOUND		-4
> +#define MPAM_FB_ERR_OUT_OF_RANGE	-5
> +#define MPAM_FB_ERR_BUSY		-6
> +#define MPAM_FB_ERR_COMMS_ERROR		-7
> +#define MPAM_FB_ERR_GENERIC_ERROR	-8
> +#define MPAM_FB_ERR_HW_ERROR		-9
> +#define MPAM_FB_ERR_PROTOCOL_ERROR	-10
> +#define MPAM_FB_ERR_IN_USE		-11
> +
> +#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
> +#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
> +
> +struct mpam_fb_access_payload {
> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +	u32 value;
> +} __packed;
> +
> +#define PCC_CHAN_FLAGS_IRQ	BIT(0)
> +#define MPAM_VERSION_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS)
> +#define MPAM_READ_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 3 * sizeof(u32))
> +#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static int mpam_fb_build_version_message(unsigned int token,
> +					 void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;

I should have occurred to me earlier but I've just put this series through sparse and there are
quite a few "incorrect type" warnings generated in mpam_fb.c.

For example:

 ../drivers/resctrl/mpam_fb.c:66:61: warning: incorrect type in initializer (different address spaces)
../drivers/resctrl/mpam_fb.c:66:61:    expected struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem
../drivers/resctrl/mpam_fb.c:66:61:    got void [noderef] __iomem *msg_buf

Thanks,

Ben

> +
> +	writel_relaxed(0, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_VERSION_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_PROTOCOL_VERSION |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	return MPAM_VERSION_MSG_SIZE;
> +}
> +
> +static int mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				      void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +	struct mpam_fb_access_payload *payload = msg_buf + sizeof(*pcc_shmem);
> +
> +	writel_relaxed(0, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_READ_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +
> +	return MPAM_READ_MSG_SIZE;
> +}
> +
> +static int mpam_fb_build_write_message(int msc_id, int reg, u32 val,
> +				       unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +	struct mpam_fb_access_payload *payload = msg_buf + sizeof(*pcc_shmem);
> +
> +	writel_relaxed(0, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_WRITE_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +	writel_relaxed(val, &payload->value);
> +
> +	return MPAM_WRITE_MSG_SIZE;
> +}
> +
> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	u32 status;
> +	int ret;
> +
> +	if (!pcc_chan)
> +		return -ENODEV;
> +
> +	chan = pcc_chan->pcc_chan;
> +
> +	guard(mutex)(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_MSC_WRITE_CMD:
> +		ret = mpam_fb_build_write_message(msc_id, reg, *result,
> +						  token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		ret = mpam_fb_build_read_message(msc_id, reg,
> +						 token, chan->shmem);
> +		break;
> +	case MPAM_PROTOCOL_VERSION:
> +		ret = mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	pcc_shmem = chan->shmem;
> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
> +	status = readl(&pcc_shmem->command);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
> +		return -ETIMEDOUT;
> +
> +	ret = readl(payload_ofs + 0x0);
> +	if (ret < 0) {
> +		switch (ret) {
> +		case MPAM_FB_ERR_NOT_SUPPORTED:
> +			return -EOPNOTSUPP;
> +		case MPAM_FB_ERR_INVALID_PARAMETERS:
> +			return -EINVAL;
> +		case MPAM_FB_ERR_NOT_FOUND:
> +			return -ENOENT;
> +		case MPAM_FB_ERR_OUT_OF_RANGE:
> +			return -ERANGE;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
> +		*result = readl(payload_ofs + 0x4);
> +
> +	return 0;
> +}
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
> +{
> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +				    reg, result, MPAM_MSC_READ_CMD);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +				    reg, &value, MPAM_MSC_WRITE_CMD);
> +}
> +
> +int mpam_fb_get_protocol_version(struct mpam_msc *msc)
> +{
> +	u32 version;
> +	int ret;
> +
> +	ret = mpam_fb_send_request(msc->pcc_chan, 0,
> +				   0, &version, MPAM_PROTOCOL_VERSION);
> +	if (ret)
> +		return ret;
> +
> +	return version;
> +}
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 7b6e0df904f8..c3c4ddb4a561 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/jump_label.h>
>  #include <linux/llist.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
>  #include <linux/resctrl.h>
>  #include <linux/spinlock.h>
> @@ -57,6 +58,15 @@ struct mpam_garbage {
>  	struct platform_device	*pdev;
>  };
>  
> +struct mpam_pcc_chan {
> +	struct list_head	pcc_chans;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	struct mutex		pcc_chan_lock; /* only one message at a time */
> +	int			subspace_id;
> +	int			refcount;
> +};
> +
>  struct mpam_msc {
>  	/* member of mpam_all_msc */
>  	struct list_head	all_msc_list;
> @@ -66,6 +76,8 @@ struct mpam_msc {
>  
>  	/* Not modified after mpam_is_enabled() becomes true */
>  	enum mpam_msc_iface	iface;
> +	struct mpam_pcc_chan	*pcc_chan;
> +	int			mpam_fb_msc_id;	/* in its own name space */
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
>  	bool			has_extd_esr;
> @@ -501,6 +513,14 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>  static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>  #endif /* CONFIG_RESCTRL_FS */
>  
> +/* MPAM-Fb Firmware-backed protocol wrappers */
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
> +
> +#define PCC_TYPE3_MSG_PAYLOAD_OFS	0x10
> +#define MPAM_FB_MAX_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +
>  /*
>   * MPAM MSCs have the following register layout. See:
>   * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index f92a36187a52..002f56e15362 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -12,7 +12,7 @@ struct mpam_msc;
>  
>  enum mpam_msc_iface {
>  	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> -	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +	MPAM_IFACE_PCC,		/* using the MPAM-Fb firmware redirection */
>  };
>  
>  enum mpam_class_types {

