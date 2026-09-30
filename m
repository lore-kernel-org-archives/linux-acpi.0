Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB94FD26F;
	Wed, 30 Sep 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784896; cv=none; b=A1nO/4g+JDR4YX4QMRDCFewNCDWSJbCfOoBPECH5iLwhdgADUAK1eNLtnwENZ5IelNy4RXQM/sgfrtzaB/sZN+udUWHJuMRSb0vAlA1fIad3zzCn/ukrZy1RaX/FKh1qieHNT4mU6UaIxbodx3vUNNMhCeo3DSgDIZVONlBupEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784896; c=relaxed/simple;
	bh=s4DU8B6yxVcCztQCOnSKENzFkmZy+pQk/UV73jzs+jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVFI9if8mJOv1m5++KgvkIBsW6G5pw3HrPjqg+H6LnZ8odb86iFPcMMl4aH7PMNqklTPRD0fdgFCCalvlejClcl5JqdMMe7/k1J361ja67apep5MS66ghgCYyliWG51UhAoEKgLILgq+e+wnMFTI+U2lK6nEL3tnPaBUUGyCQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mv/Wvv3Z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mv/Wvv3Z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBB04497;
	Wed, 30 Sep 2026 09:14:42 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620983F85F;
	Wed, 30 Sep 2026 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790784886; bh=s4DU8B6yxVcCztQCOnSKENzFkmZy+pQk/UV73jzs+jU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mv/Wvv3ZuNtFfgD40e6nYI2x0BfWzE0xySzNWfh6FTenqSWYEHVb7+8HsRyPrJKSQ
	 585j7WgYSoimeOKB9x6wT47UYPyBHuNg3bdeSTvALmfoM8+7LqSCq7enD9Tf0CJopF
	 /EXUf0m2huvpX7l13uNMuZxpFUlkdmb1WYq0PJCg=
Message-ID: <d28a243d-73bf-499a-a0a2-aa15f306a25b@arm.com>
Date: Wed, 30 Sep 2026 17:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/13] arm_mpam: add MPAM-Fb MSC firmware access
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
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260924152739.2865510-1-andre.przywara@arm.com>
 <20260924152739.2865510-12-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260924152739.2865510-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 24/09/2026 16:27, Andre Przywara wrote:
> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> 
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
> (simple) SCMI message generation, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
> ---
>  drivers/acpi/arm64/mpam.c       |   6 +-
>  drivers/resctrl/Kconfig         |   1 +
>  drivers/resctrl/Makefile        |   2 +-
>  drivers/resctrl/mpam_devices.c  |  65 ++++++++--
>  drivers/resctrl/mpam_fb.c       | 212 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  19 +++
>  include/linux/arm_mpam.h        |   2 +-
>  7 files changed, 291 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/resctrl/mpam_fb.c
> 
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 84963a20c3e78..c57bd367922b7 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>  	struct platform_device *pdev __free(platform_device_put) =
>  		platform_device_alloc("mpam_msc", tbl_msc->identifier);
>  	int next_res = 0, next_prop = 0, err;
> -	/* pcc, nrdy, affinity and a sentinel */
> -	struct property_entry props[4] = { 0 };
> +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> +	struct property_entry props[5] = { 0 };
>  	/* mmio, 2xirq, no sentinel. */
>  	struct resource res[3] = { 0 };
>  	struct acpi_device *companion;
> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>  	} else if (iface == MPAM_IFACE_PCC) {
>  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>  							tbl_msc->base_address);
> +		props[next_prop++] = PROPERTY_ENTRY_U32("mpam-fb-msc-id",
> +							tbl_msc->identifier);
>  	}
>  
>  	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 672abea3b03cc..9591d792736e5 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -2,6 +2,7 @@ menuconfig ARM64_MPAM_DRIVER
>  	bool "MPAM driver"
>  	depends on ARM64 && ARM64_MPAM
>  	select ACPI_MPAM if ACPI
> +	select MAILBOX
>  	help
>  	  Memory System Resource Partitioning and Monitoring (MPAM) driver for
>  	  System IP, e.g. caches and memory controllers.
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8f..097c036724e97 100644
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
> index 4c548ec1bd7be..90161696aada0 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -12,6 +12,7 @@
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/device.h>
> +#include <linux/errname.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
>  #include <linux/interrupt.h>
> @@ -82,6 +83,21 @@ static DECLARE_WORK(mpam_broken_work, &mpam_disable);
>  
>  /* When mpam is disabled, the printed reason to aid debugging */
>  static char *mpam_disable_reason;
> +static int mpam_disable_errno;
> +static int mpam_disable_mpam_fb_err;
> +
> +void mpam_fb_disable_mpam(int err, int mpam_fb_err)
> +{
> +	/* Prevent repeated calls when mpam_disable() does MSC accesses. */
> +	if (!mpam_is_enabled())
> +		return;
> +
> +	mpam_disable_errno = err;
> +	mpam_disable_mpam_fb_err = mpam_fb_err;
> +
> +	mpam_disable_reason = "MPAM-Fb error";
> +	schedule_work(&mpam_broken_work);
> +}
>  
>  /*
>   * Whether resctrl has been setup. Used by cpuhp in preference to
> @@ -179,8 +195,11 @@ static void mpam_assert_partid_sizes_fixed(void)
>  
>  static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>  {
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  	*res = readl_relaxed(msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -197,9 +216,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>  
>  static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_write_request(msc, reg, val);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	writel_relaxed(val, msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -1143,8 +1165,11 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>  
>  	mpam_mon_sel_lock_held(msc);
>  
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					       &msc->accessibility));
> +	}
>  
>  	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>  	if (ret)
> @@ -1178,8 +1203,11 @@ static int mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>  
>  	mpam_mon_sel_lock_held(msc);
>  
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					       &msc->accessibility));
> +	}
>  
>  	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
>  	if (ret)
> @@ -1490,11 +1518,16 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			arg->ris = ris;
>  
> -			err = smp_call_function_any(&msc->accessibility,
> -						    __ris_msmon_read, arg,
> -						    true);
> -			if (!err && arg->err)
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				err = smp_call_function_any(&msc->accessibility,
> +							    __ris_msmon_read,
> +							    arg, true);
> +				if (!err)
> +					err = arg->err;
> +			} else {
> +				__ris_msmon_read(arg);
>  				err = arg->err;
> +			}
>  
>  			/*
>  			 * Save one error to be returned to the caller, but
> @@ -1977,6 +2010,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
>  
>  static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
>  {
> +	if (msc->iface != MPAM_IFACE_MMIO)
> +		return fn(arg);
> +
>  	lockdep_assert_irqs_enabled();
>  	lockdep_assert_cpus_held();
>  	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> @@ -3102,7 +3138,12 @@ void mpam_disable(struct work_struct *ignored)
>  	mutex_unlock(&mpam_list_lock);
>  	mpam_free_garbage();
>  
> -	pr_err_once("MPAM disabled due to %s\n", mpam_disable_reason);
> +	if (mpam_disable_errno || mpam_disable_mpam_fb_err)
> +		pr_err_once("MPAM disabled due to %s: %s, MPAM-Fb error %d\n",
> +			    mpam_disable_reason, errname(mpam_disable_errno),
> +			    mpam_disable_mpam_fb_err);
> +	else
> +		pr_err_once("MPAM disabled due to %s\n", mpam_disable_reason);
>  }
>  
>  /*
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 0000000000000..8298fcedd2be7
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024-2026 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +#include <asm/mpam.h>
> +
> +#include "mpam_internal.h"
> +
> +#define MPAM_MSC_TOKEN_MASK		GENMASK_U32(27, 18)
> +#define MPAM_MSC_PROT_ID_MASK		GENMASK_U32(17, 10)
> +
> +#define MPAM_FB_PROTOCOL_ID		0x1a
> +
> +#define MPAM_PROTOCOL_VERSION_CMD	0x0
> +#define MPAM_MSC_READ_CMD		0x4
> +#define MPAM_MSC_WRITE_CMD		0x5
> +
> +#define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
> +
> +#define MPAM_FB_SUCCESS		 0
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
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static int mpam_fb_to_linux_errno(int mpam_fb_code)
> +{
> +	switch (mpam_fb_code) {
> +	case MPAM_FB_ERR_NOT_SUPPORTED:
> +		return -EOPNOTSUPP;
> +	case MPAM_FB_ERR_INVALID_PARAMETERS:
> +		return -EINVAL;
> +	case MPAM_FB_ERR_NOT_FOUND:
> +		return -ENOENT;
> +	case MPAM_FB_ERR_OUT_OF_RANGE:
> +		return -ERANGE;
> +	case MPAM_FB_ERR_BUSY:
> +		return -EBUSY;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void mpam_fb_build_version_message(unsigned int token,
> +					  void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
> +	writel_relaxed(MPAM_PROTOCOL_VERSION_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +}
> +
> +static void mpam_fb_build_read_message(int msc_fb_id, int reg,
> +				       unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_read_payload {
> +		u32 msc_fb_id;
> +		u32 flags;
> +		u32 reg_offset;
> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(msg_size, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_fb_id, &payload->msc_fb_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +}
> +
> +static void mpam_fb_build_write_message(int msc_fb_id, int reg, u32 val,
> +					unsigned int token,
> +					void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_write_payload {
> +		u32 msc_fb_id;
> +		u32 flags;
> +		u32 reg_offset;
> +		u32 value;
> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(msg_size, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_fb_id, &payload->msc_fb_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +	writel_relaxed(val, &payload->value);
> +}
> +
> +static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_fb_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct mpam_pcc_chan *pcc_chan;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	int mpam_fb_err = 0;
> +	u32 status;
> +	int ret;
> +
> +	pcc_chan = msc->pcc_chan;
> +	if (!pcc_chan)
> +		return -ENODEV;
> +> +	chan = pcc_chan->pcc_chan;
> +
> +	/* prune token to fit into the 10 bits inside the command register */
> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
> +
> +	mutex_lock(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_PROTOCOL_VERSION_CMD:
> +		mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		mpam_fb_build_read_message(msc_fb_id, reg, token, chan->shmem);
> +		break;
> +	case MPAM_MSC_WRITE_CMD:
> +		mpam_fb_build_write_message(msc_fb_id, reg, *result,
> +					    token, chan->shmem);
> +		break;
> +	default:
> +		dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
> +			mpam_fb_command);
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	pcc_shmem = chan->shmem;
> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
> +	status = readl(&pcc_shmem->command);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token) {
> +		ret = -ETIMEDOUT;

Any error code not listed in rdtgroup_mondata_show() can be swallowed by resctrl when reading
monitors and it will end up showing an invalid value to the user. I saw 0.

""	
	if (rr.err == -EIO)
		seq_puts(m, "Error\n");
	else if (rr.err == -EINVAL)
		seq_puts(m, "Unavailable\n");
	else if (rr.err == -ENOENT)
		seq_puts(m, "Unassigned\n");
	else if (evt->is_floating_point)
		print_event_value(m, evt->binary_bits, rr.val);
	else
		seq_printf(m, "%llu\n", rr.val);"

""

Triggering an -ETIMEDOUT response from mpam_fb_send_request() after 5000 requests I see:

/sys/fs/resctrl$ while cat mon_data/mon_L3_01/mbm_total_bytes; do :; done
45273792
[...]
252762048
256527040
0
Unavailable
Unavailable
Unavailable
cat: mon_data/mon_L3_01/mbm_total_bytes: No such file or directory

If, instead of -ETIMEDOUT, the error code return is changed to -EIO I see:

4950622336
[...]
4954631104
4958864064
Error
Unavailable
Unavailable
Unavailable
cat: mon_data/mon_L3_01/mbm_total_bytes: No such file or directory

For now, we probably want to just return -EIO on any error in mpam_fb_send_request() and then we can
update the resctrl code to accept more error values.

On another fs/resctrl note, if monitor values are read for a control group then mon_event_count()
reads for the control group and any child monitor groups. If any of the reads succeed then it
purposely discards any other errors. This means that incorrect and non-increasing monitor reads are
possible. This isn't desirable but is existing behaviour and can be fixed later.

Thanks,

Ben


> +		goto out_err;
> +	}
> +
> +	mpam_fb_err = readl(payload_ofs + 0x0);
> +	if (mpam_fb_err < 0) {
> +		ret = mpam_fb_to_linux_errno(mpam_fb_err);
> +		goto out_err;
> +	}
> +
> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
> +		*result = readl(payload_ofs + 0x4);
> +
> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
> +
> +	return 0;
> +
> +out_err:
> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
> +
> +	mpam_fb_disable_mpam(ret, mpam_fb_err);
> +
> +	return ret;
> +}
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
> +{
> +	return mpam_fb_send_request(msc, msc->fb_id, reg, result,
> +				    MPAM_MSC_READ_CMD);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc, msc->fb_id, reg, &value,
> +				    MPAM_MSC_WRITE_CMD);
> +}
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 58f7523bc087b..99057d6abee1e 100644
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
> +	struct kref		refcount;
> +	int			subspace_id;
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
> +	int			fb_id;
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
>  	bool			has_extd_esr;
> @@ -493,6 +505,9 @@ extern u8 mpam_pmg_max;
>  void mpam_enable(struct work_struct *work);
>  void mpam_disable(struct work_struct *work);
>  
> +/* helper function to call from outside mpam_devices.c */
> +void mpam_fb_disable_mpam(int err, int mpam_fb_err);
> +
>  /* Reset all the RIS in a class under cpus_read_lock() */
>  int mpam_reset_class_locked(struct mpam_class *class);
>  
> @@ -520,6 +535,10 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>  static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>  #endif /* CONFIG_RESCTRL_FS */
>  
> +/* MPAM-Fb Firmware-backed protocol wrappers */
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +
>  /*
>   * MPAM MSCs have the following register layout. See:
>   * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index f92a36187a527..002f56e153626 100644
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

