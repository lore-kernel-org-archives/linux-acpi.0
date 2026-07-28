Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88B3A16BD
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220045; cv=none; b=MBDuPzOx9wJAw8IuBaimeYTBHcuGjRIWk99qQ3Aoks4QQda3BAb6UAisKtd0mKztGnAzS0gLJTN6/nXIEt5QUoiYW3NwMKUJukTYUQZDPFcViFCLhNq8aM22TBY+4gK2J0hJ5tx4viXVi/zB2OlaXydCRK628iEDLeU31fhboek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220045; c=relaxed/simple;
	bh=f769s/Tl+SvfNB0j0i9myugdiTJak2M+21x55mHlaVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlPox3sDCwcpNQdJILbNJCL47/PiuTJg7grPq/G4AApCaWhjRbOaN5KwFv3Umn1TqrTd6g4AmlOxYQ+yoeNHk0O3ZU9k2ZojLcYIEb82RIyR4mNRUe9fayNDopTH1e/su8chePODXOa9oFZ+++X3TkxFYdovRMZJ+o9WF/2SskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DH1IPd3u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jiP32LvX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DH1IPd3u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jiP32LvX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S40kcl1594079
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 06:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n36bS+3pZHkc3jS0sOVcHIozJRiOsa3RWkEz4fHvpUs=; b=DH1IPd3u166uwuOW
	vahEphe+fRbrAg/Scrz16dt4UYR6RvEscq4L+lQrxOYRfTXCSsjCCNxRr9Cy1IlW
	DO8KvAv5b4OrH0Odv3E2cUiC9s7afXBpblOvKvqJxX8KyC4HP1SnZ91tlhFQQNq5
	mYTGiE8yls+J+OTsPcKcgCtHc7U09UZV2rFoqXOCgHaeBwgFO7oa+J+Wkt+sGvNZ
	UhKTqDKi+gUEfosjDDgWcATqaxZXSvm5sIaRhKs+K38Ij+2geQ1ZIaDK4yY50bmG
	wR443ioCD60UxIl8KtF73olwMSu9kEdt8/o75z61vYZjgnIhlkL9uWjQiNq69ABm
	G4eNNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19gfvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 06:27:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso62851955ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785220041; x=1785824841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n36bS+3pZHkc3jS0sOVcHIozJRiOsa3RWkEz4fHvpUs=;
        b=jiP32LvX4QKj0EMmTMlkUQ8CvS4e3pl+B3rkhEthIP59NG3A2AACrQ2o7lP9BNcmHw
         ZQOL19mNwJ0EGH4sLwK1HsZIJZC0VRkDmG6/d6dnHP7zulValJzyLUvH08T25ChB6yBt
         I8jTgshvg06IyIfGnC4ZTh9cGUr/XP33cauuwxISjK8TIE8thKcCws2SxgU5H/40stWV
         hFIyTIQ9nXqJypHrL//UgL02adxbmma14NAMuiFgcnmUyrVD/qFwLMDte6iGst+eCI5M
         I4E0HKOVRFEdKrrjEIe2EDyuW/JKSL6VQpNiGITFjUtUAAhccLx8j3gOH422r0w9xiPk
         eNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785220041; x=1785824841;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n36bS+3pZHkc3jS0sOVcHIozJRiOsa3RWkEz4fHvpUs=;
        b=glzR29et+/4+diXDujwZyHm3bQ/54UbFPsXVmvNyK/4KOHbp8uM1u7/Ux2QaHHpoE7
         W2s+uA5Mw8+KHN8fNDd0iz/wfPiYmxlfcCOjgOJssuNkRFze6qCfpdIq09ZpZTlGl7/V
         AxKGj8pCM2NSbch5mtmzccmowAMZycp0eO7Svxje5SU50s7S49V55D6MFBvqMBgy1GLv
         7/M4/Yc4ggo2fGAKV5axPwy19GiE+fiDXwvV5wzYP/JUtd0Qn/8aphjAs1DkNOXjMRQT
         lWHJppDY2dNrWgxZy8ZtUvE+kZ2CNfeAXWFqY1nAtfSs5oicnKTFeyAOp09L+Mwn+mAt
         Pc2A==
X-Forwarded-Encrypted: i=1; AHgh+RpX4Xmfc5KEiryxPEHKn3lz4oKA0v4fWVmVobXVjXKM0cPY1TvOwHRpCIfxtXAMFg3bVxi4Iho7THdL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/fXxMIB001Cm9dVI5neZDCEIXaZyl6kdJOx7Qocn7fXtMlm+
	OOti7Wgg8im/Vrg1oeF+IxwB5lPgwdxwF9dtHIvXwp60zTGFynkZYDrvIl+hitEQWwFinxk1h7j
	B7tZCzCqudooKwx//1Tmw5cn0xudIrENASh0lImo++RmgHllaOJT8ldyoIIS5c1TJ
X-Gm-Gg: AR+sD13fWdRAvd/RksWacYip5AH649roBWbCiw6q9opaECCIxKRa1DZQUo2TSaJLUK4
	VCtHsnATL66IOGRj9lECJTnlQ23R+nnj/mHciHSF8HFVIpnvv/Zo/jjsqfSDQRSOrCxs6dITflj
	wSapMMXCXTruSr6tJl/COo5rq9XROZCJYJUVuMJSVY0akKep2Mnn8qPJfPsrs8OCsbNbBGFjesY
	RUbN1yBIyK807edWqSr48JuMOHsbEhaLvQW6gP4GDO+j+W9ir60obEWiyE3bxj1YV/i4kww86v+
	jAnNZdEuPGFuL0WIC3rC7/TSpXz8cRggmA/aGcW6m95q6ARkRCNiTMiqkQCUdjtHjIlab91JdyP
	b6V0OEVOi7fq7qyH6BXNzVEsyv0JK1q/Z
X-Received: by 2002:a17:903:160c:b0:2ca:bba:b35c with SMTP id d9443c01a7336-2d015c37989mr12687085ad.31.1785220040845;
        Mon, 27 Jul 2026 23:27:20 -0700 (PDT)
X-Received: by 2002:a17:903:160c:b0:2ca:bba:b35c with SMTP id d9443c01a7336-2d015c37989mr12686795ad.31.1785220040270;
        Mon, 27 Jul 2026 23:27:20 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.199.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81dcb3sm45962225ad.82.2026.07.27.23.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:27:19 -0700 (PDT)
Message-ID: <8daee801-ec05-4206-8816-ef7a5d527f98@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 11:57:12 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Andre Przywara <andre.przywara@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260723155454.1760823-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a684bc9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=PO1FP6gy+OYP9C5qPHjZag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=8eIDnr76gOUAJy6mN_MA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1NyBTYWx0ZWRfX9MQgIy97fLuo
 inugpLPgb3YQ4nYgsYHrnjTHQDcmhYkIIBL/H2Q3OmJBnEZQIhSyUGQ9dpgvoJK6uOyyh2tEUL6
 a9R6fs5LEqAO4pLXK9xc5TuyyuZ7Th28iHmkn4ld1RXrdeze7NrZpVwVm/8LDcpG3VZOPJwL3oh
 Xmc8POFSNlCX7q5eWHjEaxjGgG8QgjjfTvsQ8i6t5pooBkqqGA8if+QhLr+PvJY1e1o0eOXdeR0
 mKlDHKvhu/aZFgp0AHWjdIe/W6T4IUSWXArjw2n7pR/Ki9TTT/2Mpy+yMX6ItMdQTCwVvSZshgm
 MFlppROsJvZIVKseQapEgroc26pMvzMfCJIXeXnumwhIr09hlBUkHpfqU5mGZVP33kbtSSRt9xz
 GC2ehPpqIZn3QbpYTPgB8D+1vNkx5sAuQ8MG4AdN2QnCZDfMOAzAYEx0Xpm8UVExIsukL+B7qeH
 w6s8qQdKFu7El69XSYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1NyBTYWx0ZWRfX+fskieSCC0vG
 slO9DuK+yy/bIpVrOr3ofn487prTRXmwlzbi4gqJ9RL6HYoVuY47h+XcoMmfr/tIy2mN9A1Vf8G
 AquzOlW0R96ATWaB9tRUDfUQRQcd87M=
X-Proofpoint-GUID: HG51agyu-q4n0KDHfMWU3KLQa-ym_HJK
X-Proofpoint-ORIG-GUID: HG51agyu-q4n0KDHfMWU3KLQa-ym_HJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280057

Hi Andre,

On 7/23/2026 9:24 PM, Andre Przywara wrote:
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
> ---
>   drivers/resctrl/Makefile        |   2 +-
>   drivers/resctrl/mpam_devices.c  |  27 ++++-
>   drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  20 ++++
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 240 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 
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
> index e2cb884eacf4..b8108ed4b32c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -181,6 +181,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>   {
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
>   	*res = readl_relaxed(msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -197,9 +200,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>   
>   static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>   {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_write_request(msc, reg, val);
> +
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>   	writel_relaxed(val, msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -1136,7 +1142,8 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>   
>   	mpam_mon_sel_lock_held(msc);
>   
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
>   	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> @@ -1485,11 +1492,16 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
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
> @@ -1916,6 +1928,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
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
> index 000000000000..ec4bf0dd9182
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.
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
> +struct mpam_fb_read_payload {
> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +} __packed;
> +
> +struct mpam_fb_write_payload {
> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +	u32 value;
> +} __packed;
> +
> +#define PCC_CHAN_FLAGS_IRQ	BIT(0)
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static void mpam_fb_build_version_message(unsigned int token,
> +					  void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +
> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
> +	writel_relaxed(MPAM_PROTOCOL_VERSION |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +}
> +
> +static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_read_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
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
> +	struct mpam_fb_write_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
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
> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
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
> +	/* prune token to fit into the 10 bits inside the command register */
> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
> +
> +	guard(mutex)(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_MSC_WRITE_CMD:
> +		mpam_fb_build_write_message(msc_id, reg, *result,
> +					    token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
> +		break;
> +	case MPAM_PROTOCOL_VERSION:
> +		mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	}

The switch here has no default case. If an unrecognised command value is
passed (in future), it maybe safer and future proof to have a default case?

     default:
         return -EINVAL; ?> +
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
> index b3a6ed9ed175..e4686ff0ba2e 100644
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
> @@ -66,6 +76,8 @@ struct mpam_msc {
>   
>   	/* Not modified after mpam_is_enabled() becomes true */
>   	enum mpam_msc_iface	iface;
> +	struct mpam_pcc_chan	*pcc_chan;
> +	int			mpam_fb_msc_id;	/* in its own name space */
>   	u32			nrdy_usec;
>   	cpumask_t		accessibility;
>   	bool			has_extd_esr;
> @@ -511,6 +523,14 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>   #endif /* CONFIG_RESCTRL_FS */
>   
> +/* MPAM-Fb Firmware-backed protocol wrappers */
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
> +
> +#define MPAM_FB_PROT_HEADER_LEN	sizeof(u32)
> +#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))
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

Best Regards,
Srivathsa
