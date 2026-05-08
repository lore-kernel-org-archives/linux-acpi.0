Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DE1419A4;
	Fri,  8 May 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236397; cv=none; b=J9aV0Ft5mj4Vi3ehS1bJ4TRbMh0CLQTY+gBCvHqeMJpa0vTqEThMA+wCrcZ6MKdXs8gvNZ7cGufpU20Z8hqL03sAzchJ5kVfJdOosaw9N9+iJs2FZs2lx06MK+2ABpIjWgB+viFA4/Hedzmuf5quG8aGA8uQpFQNYTs37LoQdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236397; c=relaxed/simple;
	bh=2rjRwbgxWk2zqDopO8bNLDbbapTIUqGGs9iLTtnjs/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS1X1Y12xKkWGPnDBe94emGcWC7zn1fwZtiuPdPWiBJpSUPorrCRhjkMdP5Vr1ShYB4CAPcse10oPdFkd2k8DdEo9fK8EOMwhml5XlldcUoQ24x7OPjXsA8aRVMZKpNO5wklal4GKVhBRYWJ0pHtZlja5s7xWaJBfBnGmvSrcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gF4D2hj/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gF4D2hj/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68A11BCA;
	Fri,  8 May 2026 03:33:09 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5F33F763;
	Fri,  8 May 2026 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778236395; bh=2rjRwbgxWk2zqDopO8bNLDbbapTIUqGGs9iLTtnjs/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gF4D2hj/rJBxBppa8Q6cwakC/jKyDrbN7OziunrawEkMw+dbnvZS+dSOcklMgOVVy
	 74x0Xjg5V9w+1balJ8zfYtjKBTg07vBipgJVqQKU7nvkXg1RpxVdbmavAdJKJGGdNE
	 MHwocufNfmjQf/urJQrIl/PU/dnx0BzcL4K/Kw6I=
Message-ID: <53bb22b8-c968-4643-9db0-2586b335f66b@arm.com>
Date: Fri, 8 May 2026 11:33:12 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 3/5] arm_mpam: add MPAM-Fb MSC firmware access support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-4-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260429141339.3171205-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 4/29/26 15:13, Andre Przywara wrote:
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
>  drivers/resctrl/mpam_devices.c  |  16 +++-
>  drivers/resctrl/mpam_fb.c       | 158 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_fb.h       |  17 ++++
>  drivers/resctrl/mpam_internal.h |   5 +
>  include/linux/arm_mpam.h        |   2 +-
>  6 files changed, 196 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/resctrl/mpam_fb.c
>  create mode 100644 drivers/resctrl/mpam_fb.h
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
> index 3be09b0c46ae..90b49bfd5caa 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -28,6 +28,7 @@
>  #include <linux/workqueue.h>
>  
>  #include "mpam_internal.h"
> +#include "mpam_fb.h"
>  
>  /* Values for the T241 errata workaround */
>  #define T241_CHIPS_MAX			4
> @@ -175,6 +176,13 @@ static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>  {
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC) {
> +		u32 ret;
> +
> +		mpam_fb_send_read_request(msc, reg, &ret);
> +		return ret;

On failure, aren't we returning ret while it's still uninitialized?

In general, we need some strategy for handling errors. Are errors rare and serious enough
that we can just disable mpam on error, or can we, while keeping any state correct, propagate
the error up to the user interface?

Thanks,

Ben

> +	}
> +
>  	return readl_relaxed(msc->mapped_hwpage + reg);
>  }
>  
> @@ -188,10 +196,14 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>  
>  static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> -	writel_relaxed(val, msc->mapped_hwpage + reg);
> +	if (msc->iface == MPAM_IFACE_PCC) {
> +		mpam_fb_send_write_request(msc, reg, val);
> +	} else {
> +		WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
> +		writel_relaxed(val, msc->mapped_hwpage + reg);
> +	}
>  }
>  
>  static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..bfb5798c74b0
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/iopoll.h>
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
> +#include "mpam_fb.h"
> +
> +#define MPAM_FB_PROTOCOL_ID	0x1a
> +#define MPAM_MSC_ATTRIBUTES_CMD	0x3
> +#define MPAM_MSC_READ_CMD	0x4
> +#define MPAM_MSC_WRITE_CMD	0x5
> +
> +#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
> +#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
> +
> +#define SCMI_CHAN_RSVD_OFS	0x00
> +#define SCMI_CHAN_STATUS_OFS	0x04
> +#define SCMI_CHAN_STATUS_FREE_BIT	BIT(0)
> +#define SCMI_CHAN_FLAGS_OFS	0x10
> +#define SCMI_CHAN_FLAGS_IRQ		BIT(0)
> +#define SCMI_MSG_LENGTH_OFS	0x14
> +#define SCMI_MSG_HEADER_OFS	0x18
> +#define SCMI_MSG_PAYLOAD_OFS	0x1c
> +
> +#define MPAM_READ_MSG_SIZE	(SCMI_MSG_PAYLOAD_OFS + 3 * sizeof(u32))
> +#define MPAM_WRITE_MSG_SIZE	(SCMI_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static int mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				      void __iomem *msg_buf)
> +{
> +	writel_relaxed(SCMI_CHAN_FLAGS_IRQ, msg_buf + SCMI_CHAN_FLAGS_OFS);
> +	writel_relaxed(MPAM_READ_MSG_SIZE, msg_buf + SCMI_MSG_LENGTH_OFS);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       msg_buf + SCMI_MSG_HEADER_OFS);
> +
> +	writel_relaxed(cpu_to_le32(msc_id), msg_buf + SCMI_MSG_PAYLOAD_OFS);
> +	writel_relaxed(0, msg_buf + SCMI_MSG_PAYLOAD_OFS + 0x4);
> +	writel_relaxed(cpu_to_le32(reg), msg_buf + SCMI_MSG_PAYLOAD_OFS + 0x8);
> +
> +	return MPAM_READ_MSG_SIZE;
> +}
> +
> +static int mpam_fb_build_write_message(int msc_id, int reg, u32 val,
> +				       unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	writel_relaxed(MPAM_WRITE_MSG_SIZE, msg_buf + SCMI_MSG_LENGTH_OFS);
> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       msg_buf + SCMI_MSG_HEADER_OFS);
> +
> +	writel_relaxed(cpu_to_le32(msc_id), msg_buf + SCMI_MSG_PAYLOAD_OFS);
> +	writel_relaxed(0, msg_buf + SCMI_MSG_PAYLOAD_OFS + 0x4);
> +	writel_relaxed(cpu_to_le32(reg), msg_buf + SCMI_MSG_PAYLOAD_OFS + 0x8);
> +	writel_relaxed(cpu_to_le32(val), msg_buf + SCMI_MSG_PAYLOAD_OFS + 0xc);
> +
> +	return MPAM_WRITE_MSG_SIZE;
> +}
> +
> +#define SCMI_CHANNEL_FREE	true
> +#define SCMI_CHANNEL_BUSY	false
> +static int mpam_fb_wait_for_channel(struct pcc_mbox_chan *chan,
> +				    bool free)
> +{
> +	u32 status = free ? SCMI_CHAN_STATUS_FREE_BIT : 0;
> +	u32 val;
> +
> +	/*
> +	 * The channel should really be free always at this point, as we take
> +	 * a lock for every read or write request. Check the free bit anyway,
> +	 * for good measure and to catch corner cases.
> +	 */
> +	return readl_poll_timeout(chan->shmem + SCMI_CHAN_STATUS_OFS, val,
> +				  (val & SCMI_CHAN_STATUS_FREE_BIT) == status,
> +				  1, 10000);
> +}
> +
> +static int mpam_fb_send_request(struct mpam_msc *msc, u16 reg, u32 *result,
> +				bool is_write)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct pcc_mbox_chan *chan = msc->pcc_chan;
> +	u32 status;
> +	int ret;
> +
> +	guard(mutex)(&msc->pcc_chan_lock);
> +	ret = mpam_fb_wait_for_channel(chan, SCMI_CHANNEL_FREE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Clear error bit and mark the channel as belonging to the callee */
> +	writel(0, chan->shmem + SCMI_CHAN_STATUS_OFS);
> +
> +	if (is_write)
> +		ret = mpam_fb_build_write_message(msc->mpam_fb_msc_id, reg,
> +						  *result, token, chan->shmem);
> +	else
> +		ret = mpam_fb_build_read_message(msc->mpam_fb_msc_id, reg,
> +						 token, chan->shmem);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mpam_fb_wait_for_channel(chan, SCMI_CHANNEL_FREE);
> +	if (ret)
> +		return ret;
> +
> +	status = readl(chan->shmem + SCMI_MSG_HEADER_OFS);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
> +		return -ETIMEDOUT;
> +
> +	ret = readl(chan->shmem + SCMI_MSG_PAYLOAD_OFS + 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!is_write)
> +		*result = readl(chan->shmem + SCMI_MSG_PAYLOAD_OFS + 0x4);
> +
> +	return 0;
> +}
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
> +{
> +	return mpam_fb_send_request(msc, reg, result, false);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc, reg, &value, true);
> +}
> diff --git a/drivers/resctrl/mpam_fb.h b/drivers/resctrl/mpam_fb.h
> new file mode 100644
> index 000000000000..c3d1a239e16f
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2024-2025 Arm Ltd.
> +
> +#ifndef MPAM_FB_H_
> +#define MPAM_FB_H_
> +
> +#include <linux/types.h>
> +#include "mpam_internal.h"
> +
> +#define SCMI_MSG_PAYLOAD_OFS	0x1c
> +#define MPAM_WRITE_MSG_SIZE	(SCMI_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +#define MPAM_FB_MAX_MSG_SIZE	MPAM_WRITE_MSG_SIZE
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +
> +#endif
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 80213af10a64..3f524cd4fc81 100644
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
> @@ -66,6 +67,10 @@ struct mpam_msc {
>  
>  	/* Not modified after mpam_is_enabled() becomes true */
>  	enum mpam_msc_iface	iface;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	struct mutex		pcc_chan_lock; /* only one message at a time */
> +	int			mpam_fb_msc_id;	/* in its own name space */
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
>  	bool			has_extd_esr;
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

