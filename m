Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568F3D349C;
	Wed,  8 Jul 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509672; cv=none; b=CshVpveQNHDHIueMR6oUrjBe9HjshBcCSSzLE0ADT943opD6oapYY0llYAP/oz5axf80GIkczmm5n/dfalgbmYkY4lCA3ua9XbMnxUbfhvGf2IWD/9YvGSERtUCcZDXkcbwnR8hEJ5/kmS+GfLqD5S6hp9ZuiC7qpm4BezCsUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509672; c=relaxed/simple;
	bh=ofXDBqX2zhXuqGmTkjFbTvJlg0nmci3yTREzVjAr8Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otHQePzvYlh0YhmaHo7GB4Sop2siPLaV15GD1bEpD2WBxkhGnPFOrjttaZwFarDHe9Tj+/II9JEAAxiNTgHeRNOfoaaid+lllztRiD3ZvUdiJpV76GL8bAKvhiD6dC8ZIxGM59F3CXMbkErcYBb0Zw4+/34fj4+5fRi6xzVt+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YJzJtghQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YJzJtghQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64EE81E5E;
	Wed,  8 Jul 2026 04:21:05 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEDAB3F85F;
	Wed,  8 Jul 2026 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783509669; bh=ofXDBqX2zhXuqGmTkjFbTvJlg0nmci3yTREzVjAr8Gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YJzJtghQQLqZ2r/Jpgqw93abuomSaZKH61ZKUklXvXws8Yrl69/s+xQUuPCsqkQDK
	 BfsUY/7hAHwrk+3DwdQ0Jdo71KPmkusgxU7GPnPRyW7NK6YIxnZdYTYEYm71vNdU9a
	 utVNXMD3/xHX7TGaVMfldDpN9HkGdqdEOE+LQUEk=
Message-ID: <b72c0ba1-b7c3-4afd-b572-2f6a6eef8642@arm.com>
Date: Wed, 8 Jul 2026 12:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 13/15] arm_mpam: add MPAM-Fb MSC firmware access
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
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-14-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-14-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
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
>  drivers/resctrl/mpam_devices.c  |  27 +++++--
>  drivers/resctrl/mpam_fb.c       | 137 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_fb.h       |  17 ++++
>  drivers/resctrl/mpam_internal.h |  12 +++
>  include/linux/arm_mpam.h        |   2 +-
>  6 files changed, 190 insertions(+), 7 deletions(-)
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
> index 824bc6c97851..b858ff389bff 100644
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
> @@ -181,6 +182,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>  {
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
>  	*res = readl_relaxed(msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -197,9 +201,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
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
> @@ -1127,7 +1134,8 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>  
>  	mpam_mon_sel_lock_held(msc);
>  
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
>  	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> @@ -1475,9 +1483,15 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
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
> @@ -1913,6 +1927,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
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
> index 000000000000..687be6f8a152
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,137 @@
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
> +#define PCC_CHAN_FLAGS_IRQ	BIT(0)


> +#define MPAM_READ_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 3 * sizeof(u32))

How about packed structs for the msgs to avoid the magic numbers?
Something like:
struct mpam_fb_read_msg {
	uint32_t read;
	uint32_t flags;
	uint32_t offset;
} __packed;

> +#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static int mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				      void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +	void __iomem *payload_ofs = msg_buf + sizeof(*pcc_shmem);

What about pcc_shmem->signature?

> +
> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);

Based on the acpi spec, this can be ignored if a platform interrupt is
not set in PCCT global flags. Do we rely on the interrupt?

> +	writel_relaxed(MPAM_READ_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(cpu_to_le32(msc_id), payload_ofs + 0x0);

Why cpu_to_le32() here? writel_relaxed() looks to already do this?


> +	writel_relaxed(0, payload_ofs + 0x4);
> +	writel_relaxed(cpu_to_le32(reg), payload_ofs + 0x8);

Does memcpy_toio() work here to reduce the number of repeated calls to
writel_relaxed()?

> +
> +	return MPAM_READ_MSG_SIZE;
> +}
> +
> +static int mpam_fb_build_write_message(int msc_id, int reg, u32 val,
> +				       unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +	void __iomem *payload_ofs = msg_buf + sizeof(*pcc_shmem);
> +
> +	writel_relaxed(MPAM_WRITE_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(cpu_to_le32(msc_id), payload_ofs + 0x0);
> +	writel_relaxed(0, payload_ofs + 0x4);
> +	writel_relaxed(cpu_to_le32(reg), payload_ofs + 0x8);
> +	writel_relaxed(cpu_to_le32(val), payload_ofs + 0xc);
> +
> +	return MPAM_WRITE_MSG_SIZE;
> +}
> +
> +static int mpam_fb_send_request(struct mpam_msc *msc, u16 reg, u32 *result,
> +				bool is_write)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem;
> +	struct mpam_pcc_chan *pcc_chan = msc->pcc_chan;
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
> +	pcc_shmem = chan->shmem;
> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
> +	status = readl(&pcc_shmem->command);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
> +		return -ETIMEDOUT;
> +
> +	ret = readl(payload_ofs + 0x0);
> +	if (ret < 0)
> +		return ret;

This needs translating from an MPAM-FB error code to a kernel error code.

> +
> +	if (!is_write)
> +		*result = readl(payload_ofs + 0x4);
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
> index 000000000000..45cd572a28ad
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
> +#define PCC_TYPE3_MSG_PAYLOAD_OFS	0x10
> +#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +#define MPAM_FB_MAX_MSG_SIZE	MPAM_WRITE_MSG_SIZE

Duplicates of those in mpam_fb.c

> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);

These 2 declarations can just go in mpam_internal.h and get rid of the
extra header.

Thanks,

Ben

> +
> +#endif
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4616f1283f1a..9e7778534143 100644
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

