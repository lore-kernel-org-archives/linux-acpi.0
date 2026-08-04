Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD772DB7B8
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823792; cv=none; b=AILKx/S3Ad/mFs8jXADzol2H87fiThYKYkDsgjoKD44JRoIHb2SbvceUz9qsHnNWznKWBNXfvKOTiG3YYbyZZkmDaJKBrR7Nor0EZ+gbR8Fc7i+fcuFQhoaAxgv1/rPyARFyTa3aj25Lv876ixdAkBl0tSUKZOvcbnZWYLa/dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823792; c=relaxed/simple;
	bh=6gCIq1tl4cFRkXlMRhRCn8sFqofRstL0RTvSfONvscU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnv5MF3VcTAOyQjhlOkiBadm9ebt9jh/dHGTa+sMXLJPgJ2Sc3OlKzhWkiA14IqLXEwZhRTih0a3KZZpzkmat8yMfhaz4Dppofv6Am41BQ5YwGOgZnNPtxXMc/TaWcvCqbcL0LNcDJYQRvsRh7/FsONjt1HZSgiFO31TRea1qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyHGemTV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n32TSTOq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyHGemTV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n32TSTOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785823789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyVMRVNWvI1N6tn0c1P1mLOWRR/66FZDJFH7mB5a5fI=;
	b=KyHGemTVOXemAdAiwKJ45S4lEn10yP/ciBkEaYGTFVG9GTjsj90nB7K4rGICK/LS6OyTqj
	POObLJEQycYu9qqDvs+9/Bl1ycnLXAYs9QnqYBBkrRGCh8ew/NVive+bKgP53v5innS9d6
	PnUeJ3P806ccfnLrZ36cQFzeGjoOJnc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-7T9CyJkxMDKCR3HJU67L2w-1; Tue, 04 Aug 2026 02:09:25 -0400
X-MC-Unique: 7T9CyJkxMDKCR3HJU67L2w-1
X-Mimecast-MFC-AGG-ID: 7T9CyJkxMDKCR3HJU67L2w_1785823765
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso4022676b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 23:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785823765; x=1786428565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyVMRVNWvI1N6tn0c1P1mLOWRR/66FZDJFH7mB5a5fI=;
        b=n32TSTOq0UqjpwiBpvFXsMZe1yeP/l+Gvqs6KgDauDMV7aa/T5XxH2oH+b55D1jw2M
         gOOCDhN9nm4uKtmzy1RywDTaE/ey/7iYxt/et1swdnSOdD5U4Y2O5FvipAjRCWdg1C9M
         z40i8ZwYO9RsqghUQ4NZ9vKZ/UsqE9VKQdJyqXgw1F6904KuIHsB+Fm4HrG2cJEV2bou
         Dgzxbo44Fpk6ywv1p4uoAi3dzdh/ayF1qqwyyL4NEVLNqiTjt/GX2SHzchXiPuCbQdS1
         9c0QxUmwEKWedikfOIv5H997WpJrMzHUrfUsOA54VDuxPWPcnKtCkj2IGG6R4bhyj8Rk
         E39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823765; x=1786428565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HyVMRVNWvI1N6tn0c1P1mLOWRR/66FZDJFH7mB5a5fI=;
        b=tPqgZ1dQC64mOTt8kWDrA3vMXT6DzZY5m4S4IbzVNpG7QsS2FPkE2knKtn9NeF1fNC
         U84jH7teMjWwOeNgR+u+tJwaRUz6iIaZKsc3LNXxWSAehjc+tEV2ubpyMq0tX2ju5T7U
         uAbK5G6vAPGcRupC362oFEGr2hFmvS+6782uekOCNn8o7rexCVFNtIbq/ylik/z6kbpF
         NGFjk1YEpSP0JPQNA+AcYYnpaqF97ebqMvSrCBFspz+wCWHYtLbm9oSmyksRw3Qpi3PG
         fzt7QMG5hsfVC/gLlndnbKOxAnEwxJnIedhgWiuNJ+qwH7V8bqCxZTK/BtV4VErB//W+
         zmyQ==
X-Forwarded-Encrypted: i=1; AHgh+RobGtbGY2Yv/oFq5M6Ii9qMcpGnYkM0wh0reDO/PTm+8gR1sPJhG47+xL2ONVI8KIwTWTzFdUZSoeXY@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4+t+K2kt7s6S6xqEbhz0e5EKtx/y2hHqijoEmTqTohCo83nM
	1xBunnU4Am8WDMUfMViES1XUv0QLtIq68Xa8bd0/45CisJogvjWQoau8KR22lQ7SjZSq7K+byva
	k8XJ2AQqx/IUW+XrswhS6+e0vjS3IsidcQSV6JpAd3WYCt2mqef+jSfKrgq6q/hI=
X-Gm-Gg: AR+sD120oFKNR4nEl0S7SR9Lf3ZwEVkz2gMR5xdZF5T5lHWuEt2P7rVZTUty6xFhRwk
	ag/GoBGua5OMbaCqtM8quj7hDIctfEaLvSfcGK1OletU8QXtLcyoatRNpiyJNbTgR6ZKLo6dRW5
	K0rdAMjjV6NDmUnmmV0yaKCcWMeirP7mxivoPgdkFnAzfR/qmiZSUPK7FxgY3E6RwU+p9+IM5e4
	YcBU1JaUqzrnB1NszB+N1NaQFdjmmowhm6Cl9QRK5z1x/PffXbIr9zCpfJSLc7nY0/ZyLdMYAgw
	ipwW58+P8LoH6rS92q481fUXSIbWbw2aLYl0sos033IX2409+517dwuNblE1M+BxJb15JRDrNL3
	H2aOU6E7Yy2qXZvW6+IPEmoV4aQExq1nIzBM0dGcTZyk=
X-Received: by 2002:a05:6a00:3d51:b0:847:83bd:6671 with SMTP id d2e1a72fcca58-84ee4840812mr11560601b3a.19.1785823764685;
        Mon, 03 Aug 2026 23:09:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d51:b0:847:83bd:6671 with SMTP id d2e1a72fcca58-84ee4840812mr11560561b3a.19.1785823764076;
        Mon, 03 Aug 2026 23:09:24 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57a9esm4666927b3a.19.2026.08.03.23.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:09:23 -0700 (PDT)
Message-ID: <76e572a4-a8fb-42d0-8503-9f227005d790@redhat.com>
Date: Tue, 4 Aug 2026 16:09:13 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-10-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andre,

On 8/1/26 3:03 AM, Andre Przywara wrote:
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
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com>
> ---
>   drivers/resctrl/Makefile        |   2 +-
>   drivers/resctrl/mpam_devices.c  |  57 +++++++--
>   drivers/resctrl/mpam_fb.c       | 209 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  18 +++
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 275 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 

With the following nitpicks addressed if they're making sense and
another respin is needed.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..097c036724e9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -1,5 +1,5 @@
>   obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> -mpam-y						+= mpam_devices.o
> +mpam-y						+= mpam_devices.o mpam_fb.o
>   mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>   
>   ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 11d053dbdfd0..ea08c12f717a 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -83,6 +83,21 @@ static DECLARE_WORK(mpam_broken_work, &mpam_disable);
>   /* When mpam is disabled, the printed reason to aid debugging */
>   static char *mpam_disable_reason;
>   
> +void mpam_fb_disable_mpam(int err, int mpam_fb_err)
> +{
> +	static char mpam_fb_reason[64];
> +
> +	/* Prevent repeated calls when mpam_disable() does MSC accesses. */
> +	if (!mpam_is_enabled())
> +		return;
> +
> +	snprintf(mpam_fb_reason, sizeof(mpam_fb_reason),
> +		 "MPAM-Fb error %d, kernel error %d", mpam_fb_err, err);
> +
> +	mpam_disable_reason = mpam_fb_reason;
> +	schedule_work(&mpam_broken_work);
> +}
> +
>   /*
>    * Whether resctrl has been setup. Used by cpuhp in preference to
>    * mpam_is_enabled(). The disable call after an error interrupt makes
> @@ -179,8 +194,11 @@ static void mpam_assert_partid_sizes_fixed(void)
>   
>   static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>   {
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   	*res = readl_relaxed(msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -197,9 +215,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>   
>   static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>   {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_write_request(msc, reg, val);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>   	writel_relaxed(val, msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -1141,8 +1162,11 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>   
>   	mpam_mon_sel_lock_held(msc);
>   
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					       &msc->accessibility));
> +	}
>   
>   	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>   	if (ret)
> @@ -1176,8 +1200,11 @@ static int mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>   
>   	mpam_mon_sel_lock_held(msc);
>   
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					       &msc->accessibility));
> +	}
>   
>   	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
>   	if (ret)
> @@ -1490,11 +1517,16 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>   					 srcu_read_lock_held(&mpam_srcu)) {
>   			arg->ris = ris;
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
>   				err = arg->err;
> +			}
>   
>   			/*
>   			 * Save one error to be returned to the caller, but
> @@ -1970,6 +2002,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
>   
>   static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
>   {
> +	if (msc->iface != MPAM_IFACE_MMIO)
> +		return fn(arg);
> +
>   	lockdep_assert_irqs_enabled();
>   	lockdep_assert_cpus_held();
>   	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..61a91c6cec0a
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024-2026 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +#include <asm/mpam.h>
> +
> +#include "mpam_internal.h"
> +
> +#define MPAM_FB_PROTOCOL_ID		0x1a
> +
> +#define MPAM_PROTOCOL_VERSION_CMD	0x0
> +#define MPAM_MSC_ATTRIBUTES_CMD		0x3
> +#define MPAM_MSC_READ_CMD		0x4
> +#define MPAM_MSC_WRITE_CMD		0x5
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
> +#define MPAM_MSC_PROT_ID_MASK		GENMASK(17, 10)
> +#define MPAM_MSC_TOKEN_MASK		GENMASK(27, 18)
> +

Readers usually check the layout from MSB to LSB, so we would define
those fields in that sequence. Besides, I would move those two
definiitions before MPAM_FB_ERR_SUCCESS because MPAM_MSC_PROT_ID_MASK
is strongly relevant to MPAM_FB_PROTOCOL_ID.

MPAM_MSC_ATTRIBUTES_CMD isn't used, I would drop it. MPAM_FB_ERR_SUCCESS
would be MPAM_FB_SUCCESS because it's not an error.


   #define MPAM_MSC_TOKEN_MASK          GENMASK(27, 18)
   #define MPAM_PROT_ID_MASK            GENMASK(17, 10)

   #define MPAM_FB_PROTOCOL_ID		0x1a

   #define MPAM_PROTOCOL_VERSION_CMD	0x0
   #define MPAM_MSC_READ_CMD		0x4
   #define MPAM_MSC_WRITE_CMD		0x5

   #define MPAM_FB_PROT_HEADER_LEN       sizeof(u32)

   #define MPAM_FB_SUCCESS		 0
   #define MPAM_FB_ERR_NOT_SUPPORTED     -1
          :

> +#define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
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
> +static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_read_payload {
> +		u32 msc_id;
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
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +}
> +
> +static void mpam_fb_build_write_message(int msc_id, int reg, u32 val,
> +					unsigned int token,
> +					void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_write_payload {
> +		u32 msc_id;
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
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +	writel_relaxed(val, &payload->value);
> +}
> +
> +static int mpam_fb_translate_error_code(int mpam_fb_code)
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

SDEI has similar function. We may follow the convention by renaming this
to:

static int mpam_to_linux_errno(int error_code)
{
	switch (error_code) {
	   :
	}
}

> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	int mpam_fb_err = 0;
> +	u32 status;
> +	int ret;
> +
> +	if (!pcc_chan)
> +		return -ENODEV;
> +
> +	chan = pcc_chan->pcc_chan;
> +
> +	/* prune token to fit into the 10 bits inside the command register */
> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
> +
> +	mutex_lock(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_MSC_WRITE_CMD:
> +		mpam_fb_build_write_message(msc_id, reg, *result,
> +					    token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
> +		break;
> +	case MPAM_PROTOCOL_VERSION_CMD:
> +		mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	default:
> +		dev_err(pcc_chan->pcc_cl.dev, "unsupported MPAM-Fb command %d\n",
> +			mpam_fb_command);
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +

Maybe worthywhile to keep the cases sorted upon the command values:

	switch (mpam_fb_command) {
	case MPAM_PROTOCOL_VERSION_CMD:
              :
         case MPAM_MSC_READ_CMD:
              :
         case MPAM_MSC_WRITE_CMD:
              :
         default:
              :
         }

> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	pcc_shmem = chan->shmem;
> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
> +	status = readl(&pcc_shmem->command);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token) {
> +		ret = -ETIMEDOUT;
> +		goto out_err;
> +	}
> +
> +	mpam_fb_err = readl(payload_ofs + 0x0);
> +	if (mpam_fb_err < 0) {
> +		ret = mpam_fb_translate_error_code(mpam_fb_err);
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
> +	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, result,
> +				    MPAM_MSC_READ_CMD);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, &value,
> +				    MPAM_MSC_WRITE_CMD);
> +}
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 6121cd126510..f13a79a84c58 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -11,6 +11,7 @@
>   #include <linux/io.h>
>   #include <linux/jump_label.h>
>   #include <linux/llist.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
>   #include <linux/resctrl.h>
>   #include <linux/spinlock.h>
> @@ -57,6 +58,15 @@ struct mpam_garbage {
>   	struct platform_device	*pdev;
>   };
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
>   struct mpam_msc {
>   	/* member of mpam_all_msc */
>   	struct list_head	all_msc_list;
> @@ -66,6 +76,7 @@ struct mpam_msc {
>   
>   	/* Not modified after mpam_is_enabled() becomes true */
>   	enum mpam_msc_iface	iface;
> +	struct mpam_pcc_chan	*pcc_chan;
>   	u32			nrdy_usec;
>   	cpumask_t		accessibility;
>   	bool			has_extd_esr;
> @@ -484,6 +495,9 @@ extern u8 mpam_pmg_max;
>   void mpam_enable(struct work_struct *work);
>   void mpam_disable(struct work_struct *work);
>   
> +/* helper function to call from outside mpam_devices.c */
> +void mpam_fb_disable_mpam(int err, int mpam_fb_err);
> +
>   /* Reset all the RIS in a class under cpus_read_lock() */
>   void mpam_reset_class_locked(struct mpam_class *class);
>   
> @@ -511,6 +525,10 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>   #endif /* CONFIG_RESCTRL_FS */
>   
> +/* MPAM-Fb Firmware-backed protocol wrappers */
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +
>   /*
>    * MPAM MSCs have the following register layout. See:
>    * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index f92a36187a52..002f56e15362 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -12,7 +12,7 @@ struct mpam_msc;
>   
>   enum mpam_msc_iface {
>   	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> -	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +	MPAM_IFACE_PCC,		/* using the MPAM-Fb firmware redirection */
>   };
>   
>   enum mpam_class_types {

Thanks,
Gavin

