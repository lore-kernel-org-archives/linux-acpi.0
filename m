Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA548989D
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825397; cv=none; b=acI4yMcbGuj3TIyJbPxfmujx7tIPODDr9T5IihATedWPGGBMyLBn3SgRpzf71BtWv5atg10ZtXR1XjU64mzqYbTd8dGwJb0ERGdEFqFqcY0Pja+1Q1KDvmSHlaQn7DEXyv5rmDQSnZVXBoQTn33q4Nrl1ZHPPIKUKS6V17NDj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825397; c=relaxed/simple;
	bh=VKrPnCQF/oj+DNY2YnnSgniR0WdIYKBO2tVtCXLxK9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDVQuIK7xgCWkpbRg1ICHKXuL/MUUTGOgKo2E4+2Ls9xJHYfwo3ot/Rs0/R4WUGndR3h2cf/RcGYNggdoXb2HHVZHZhHcVtZFgeY09Llc8pVmz2UT/p0ROo22/s4vuF3NjkMI5E80t2C2C9TnilmnnKB+Cxt/VxdqVzy2hWgnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5HbNDvQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBF6mO/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5HbNDvQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBF6mO/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785825394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yP8yO/BRENtBx+IwrJFj34waJ33MmACcGPTviE5xVwE=;
	b=d5HbNDvQYi5lI/KG4g4DT7CFaPJY/xDn1JaYnvbfTiIRUTxD/xKItB5jrr98uqZ4akqSr3
	Q98aNtnj3pwUXQdBWqZzs3l1dfcjELxSdrtJbazeLAI01Mm9OkMEqty6ntO3wQMSbbEaGy
	Ph60waBbOhS7Ma6g/+EJVnecF66oR7g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-WoNvP9KoPaOl_VAS6Gcidg-1; Tue, 04 Aug 2026 02:36:23 -0400
X-MC-Unique: WoNvP9KoPaOl_VAS6Gcidg-1
X-Mimecast-MFC-AGG-ID: WoNvP9KoPaOl_VAS6Gcidg_1785825382
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc5faecf01so82633655ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785825382; x=1786430182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP8yO/BRENtBx+IwrJFj34waJ33MmACcGPTviE5xVwE=;
        b=UBF6mO/9o/xocZUeNJkMPPt7K1QJL/O+DMYRepQcp223gg5xwEICCN8O/5lFed7LOI
         3xocxdiEM7aGluL0ww9iAkbCMxedbzBZIEYg0wfSYCeMDsTSOoTH4OwROkFWn1UqvU1k
         CTQwDxt5Nr7n4pM8+ec5uB3eKh6NsXAiIGkXuJrfUC/ye2YimJZJgsdrbAvAzrsYanDx
         4e8gAH0JYxSMfeH+VesKIB9PwqMEdvGHjvcrL+1MUbg4NbS4Ij7QKFGpJll+NjSuBVHw
         KzxUQhHKeb+CPgkhtWfKZv7XW1qJ1Wid41tKNfbBox54uuM+KIDULtPJEwYyisZ2+76k
         2tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785825382; x=1786430182;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yP8yO/BRENtBx+IwrJFj34waJ33MmACcGPTviE5xVwE=;
        b=T1n1iID2+vN6dGT9fTAioL2qAaRB5F3opK7XX8/WaHkKabjZ4L4BQ7KB65YMKCTsnT
         z7+9Re3H7s2+lYArarmU4ykkUnq/KJsBnXXiQCHprDR2LfZsqkI3k6WC4+UX3cPBuawT
         fkbfAsxEPtoHu8z22woJ9jWUq6Ztwu59JYx+gaja7c2cxcgidniD3s8wiMzDqotaJ3ae
         fchOv7cT1iUZFIxMJhEHWQeL9IG2UVucMgQyL41ioopSL/EyoDv9esW63P64+C+lZMyK
         cPY7K+yd3Y+gBu85neI4xMd5oFyMxf2jNMUpSVwOaFRW6te6XIR7QrLTDq0Shfa342wO
         mJ/A==
X-Forwarded-Encrypted: i=1; AHgh+Roll3QJ5Ew4GDZQVHSEQ2dZDp1J7BUWuZDyC9YJShKVGJ0+Iy1MO6IvB84QGPJxmlimjaZbknfpIvYK@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2KFHwcPy02/O7TvBqQBLt+YHo8L89qsEbE8U2X6DmhaQEcQX
	GKuRFGJf0aONIEWA1uYjUib/V9BAv6iD6DS+reIXlDOuOhRqattCGmHA4fcmWUT0sbD1RiF2WzZ
	vdCdiYQwe+mON0xMjtmcOd090cxC88OyT/pBRZdW7tnm6sF0P2ZWYdpkX2m7CVPM=
X-Gm-Gg: AR+sD11D94Nuc+NzmfhH0IpffKzHn+tPiB1cFndF5yZ8aOjmCQNrXJzxbMNuOkw9vRW
	eSjE/z4wysZP1cP53sP/QdII4/ltsdZ3qujmqzm06hUGdsyoQzxIL0U3IqA3BJSm4e/s5XGb5Nt
	fMoh/dsQIl8l1b0iSySdCTaZj/s9HlajMkruN5ZiQoWlkvrLw+17ew7/qO/2OwmqCoia6yNfkYG
	jXT9yGXviLTz8xFn6m7LACL7kv1MUA8Lz+B+ebikl7H67YQ74XcfK7ANoxRhzHWXTLAsOMvoOsN
	4ckbZfP0MDJ/nhczwYbO6QZamDNP6qv6/FMYXp36BQTZ0immfr4O1p8QpnofN4ohg+b5KyjSIwk
	Q8nbnCA2hz9FLipSuBazY0sIJ/LOoGHig4YEBCaCcKgk=
X-Received: by 2002:a17:903:3810:b0:2cf:b23a:3e6e with SMTP id d9443c01a7336-2d0524740cfmr132333465ad.40.1785825382402;
        Mon, 03 Aug 2026 23:36:22 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2cf:b23a:3e6e with SMTP id d9443c01a7336-2d0524740cfmr132333335ad.40.1785825381970;
        Mon, 03 Aug 2026 23:36:21 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4fb5f4sm503705ad.84.2026.08.03.23.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:36:21 -0700 (PDT)
Message-ID: <ac199749-e90a-4077-9fef-c7b3adff71c9@redhat.com>
Date: Tue, 4 Aug 2026 16:36:08 +1000
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

[...]

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

Why we're not using GENMASK_U32() since the operand the message is 32-bits dwords? :-)

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

static inline void writel_relaxed(u32 value, volatile void __iomem *addr) { ...}

The input value would be 'unsigned long', which is converted to 'u32'. If  GENMASK_U32()
is used to define MPAM_MSC_TOKEN_MASK and MPAM_MSC_PROT_ID_MASK, the unexpected conversion
can be avoided.

Thanks,
Gavin

