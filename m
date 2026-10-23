Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749587;
	b=WbR6Hf82deXF78vuRIuKa84X0Mt0y9gJwnahEpwWz3p26EAfn2XChrJSnwbGT8H5zmqk
	 2luKD5QqTQNTiVKVHIuzLmrLUbC6x7e1phmIJ12MfkLbcRlELrOyUKlnSdy7MCsIDsav0
	 KtPKE4TlCzVEaD+zLCxq/a9w1ahUjFIQ9+qfU29SVV0O5KzNPvwwR0uldObMDjONcFQuS
	 2Spv5QIISFNfZnsbf1G9bDW0p4kh8UzI+deJCkhnl8lz8LQgqTHeBY93A4Kc6vi8gUJ0y
	 xNk8pUorMQd9bcFMDvNYMqhgTEsYECe1Aan9rq52LdTkn6K09NGksPC1gwg1VIg2FuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749587;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YkRpJaDqco6LEFQuZ/pvK2bkmZohErX1p+9QknBbkno=;
	b=Q6ygJAjjQ2rYQmKhzaal4JZ9VMKjsbo16SqgVQ95tOdGOoJsyI+24y2SnrV8OieRVowU
	 zADD0dWqShI/77ugUh6xOwi1Nd68Bgi4JiktB3qQdRwM9TBzw+ROQkb2HEpe4NExsTScr
	 qC4u4+FTlH7oyTC+1S+vOMCQpekiFQ8RoTCQxxQX33KXT5TkOH6tBXIU8LPwBbnw8jIJV
	 Fmc6Idsfkf0NiRkuFw4Ph9mUS1jS0juDSHoXsuKD7HYlYfJb44FI2YKai4MZYBXCSUrrP
	 LdunAftdKUbCZ5+Rg8YBaeXkI91Q3psBRisnFess5lOyCvinBF7YBS0weBq0JDqDp7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p456WRBa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N9F5mQnN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CF606A31A
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 09:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p456WRBa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N9F5mQnN
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9ws3154219
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YkRpJaDqco6LEFQuZ/pvK2bkmZohErX1p+9QknBbkno=; b=p456WRBatilPuf4q
	Qk7dmM1hggU8GIPT3UdtqPgDeVAKsyEy7Boyd6T7XE4xTrPXliRMwZpRncIWzy4a
	miMYRtZ0bWuB0qmdwHxRxJso4p10Dq5aH53AAEgNg4Q7dxbqWSt1Bbpek5/4uFkW
	M0YT/VBvMKCd+Z1DWEeBGGPMxsy7ThcrrV4pbpCO2omD6J6gWehCH/P576F33gfy
	aV066oawhIAQzNPZ4mq0ULu5t5+bflI0tNb2jKsLUs2Q/g04+xxzAIsTE4x0Tx93
	pBkrb7XkRUfS4n33mgWSAEUWb6VLPeNj73WUJddBwUEE0mwXpAYNTTtFjLTcYMNZ
	WQzLWQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrb3df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 09:59:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-361c38aa269so88951eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792749585; x=1793354385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkRpJaDqco6LEFQuZ/pvK2bkmZohErX1p+9QknBbkno=;
        b=N9F5mQnNa/3/IFIBmN+1lMUndZcenMaHvjn/HawvUOG3kWfXkoCce0kRpgsUwPCwQq
         6394vBG71qs3XrqBKxYZhBzJkg7p/uaohclbGiH7mk/Z9xrUKMEKsSdVd0zNAYvM/rO9
         PclTwrpFBR/SbaoHk5Z4NmtUffq0mKkXrKqXv0rEfZ7Wwr8jG5dmEKvgZvaekKS7SXcE
         rUiwlxjn0DQT66fQQpVWgeFRl4JMP+pfuGWMDB2TbFO0UENE0tZLgn+FzKZDUOyrTXDi
         1+uLONAhuUo+YikJNcXMsAqeVZYa2c7eNCaGu8gYQNpT54EUgYZxX1M0VQLuz5MLVCcD
         +GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749585; x=1793354385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkRpJaDqco6LEFQuZ/pvK2bkmZohErX1p+9QknBbkno=;
        b=zEwZgHHpAdxNhQcjKE5NvEcUbSlZE8LQWY+On9P/HPyxPOml/Su+BkYJwmA+xpczZ8
         pzf3USSkt7SFzV8fEt/kc7h6oEnr3PYY6cS5TUlVqNSIRgTv6hzDdu37Nrj3kLTXCKlE
         Nd39pykMYYymtvg5TpuGXex6i2/x0XNKDhKjVbp++i5OZn+Fwhck1gG4lzrDvrHAbFo2
         hGugy6sfA2u5DRHN66lUiz9Jk9v+FTIh1u+sICERsPBnmpJhoybq39UjEDUwLhuhjdAg
         dA3eawJWCDdm/U9Jax5Rv/vXWqdft86vKXpu5E7yFDXzsmhgjrkBUcxR+TPoNa4rV7gP
         cZTw==
X-Gm-Message-State: AFq9FYIzKEEq3tJ28lx5SA+epsJmkSI5XGEs17f5MEsc3u0F9et5o4am
	3PwtaLKq7jSVPayBdMBTkd/R7rabURQpDD4jhYYkMZ0ixyL4i0U52o3WCnXxunN8NEozqulFvcx
	5JFd3XXrMm0PnxX/+6c/UyXm3ke3iNkc9lKjJnveRNqAgkllVSuMArErawH/VsaFJ
X-Gm-Gg: AYBFou0MG3HkrhXoWKHae4Cpneg33aE8U48joQUhHTQaCRjLlKUpauHFB/30M8syehh
	Gp3P8drH8AndFkXNFfChBIJdGeShTOPTE0hyWRozzXDsiJCBwPRaoT28K5/Xcs82bIr5qHSyslm
	kTZU9eziL1Jy6iN7tKU+xRjBoyfyXP/q+GhjocNxn0LcTkbyf2cBySXi+DHVy2M6ULiV6P200c4
	ekGBJr6AifjRSt5v9rsSZvHy8OoQ/mhJWaRuXxqUTUGVs4k6h3LWrG5bUiNF+JQtLovacpuWv5s
	SN2RE+aU3nnZ8aRTSCxaxfJGBc/aTCxZqPBYf6Qc8gGt98jJpYQvpaKw0c8tobFknBacnqsRij3
	7gTn3RINZJHQWiIbTRB6sHCLHBlHjKA==
X-Received: by 2002:a05:693c:829b:20b0:351:7883:bf47 with SMTP id 5a478bee46e88-369d8faf9a5mr4566193eec.0.1792749584936;
        Fri, 23 Oct 2026 02:59:44 -0700 (PDT)
X-Received: by 2002:a05:693c:829b:20b0:351:7883:bf47 with SMTP id 5a478bee46e88-369d8faf9a5mr4566138eec.0.1792749584342;
        Fri, 23 Oct 2026 02:59:44 -0700 (PDT)
Received: from [10.217.217.64] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm7499288eec.5.2026.10.23.02.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 02:59:43 -0700 (PDT)
Message-ID: <01b1b1bd-2848-482e-af8b-8fab037c7a04@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:29:35 +0530
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] arm64: ras: Add probe/remove for arm64_ras
 driver
To: Ruidong Tian <tianruidong@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
 <20260602071540.3711528-3-tianruidong@linux.alibaba.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20260602071540.3711528-3-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jmnGJwobxdMaoxuFhLiHVeP4BB_ITkG4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX6Wl/CqJfO1r2
 i0LKJzlDpCK+hLa/Z6z88G2zwCPq98IbnfNU9HGhbkkW8mhqNeUR0Vg3p+KiZwp/xVuhq9WL6vx
 4pS9d5T/TzEAzwxg/5htJfg8vw73S14=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb3011 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=49fVXzMj59YXLoLGRmgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX/j9EkskLgxZn
 laMebjmGtyv9jES9aKsD4EyoJ4J16NhYUAzlH454vP+WB6tDQ0Lk9sFJZ6zXU3dYDhxZVQp2cZ3
 6zEW86aMxSrDHz+lG9KZeNx/mKXhE0H01N7MZMAvfj09hZJQcRfP0njGR3EFJSw2GH/DHxFNjPe
 FzUrnyJ78e1IzC/7NK08aism52ikf3/TtZHCZ76z5RXxzbs5J9ZO6eg1VOqLcZgTVYNoUz4x+Fw
 U+AkInFLSdmPK1ODTQg5QTu4d0S/2W2TUZ6poO49hWX2tzTfWxigAPDujRkG8bLB7HF5HHO7tmU
 FVct3/wV0jpc0KaUrYUZ3hznukL99PLt/4d1C1H+s2aA3ANmQlXpv+PgSKg2REFmDiEwgXE53xE
 W2HxcZXUFwkUSpfWLqNNNMkHTKR7ZJRtw4wRJtYeskuloZ1OvZM7v6DxKiN8X+ALdG+HYPzNLRh
 /aQfYl2dv8vFW0b1Opw==
X-Proofpoint-ORIG-GUID: jmnGJwobxdMaoxuFhLiHVeP4BB_ITkG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

Hello Ruidong,

On 6/2/2026 12:45 PM, Ruidong Tian wrote:
> Introduce the back-end platform driver that binds to the devices
> created by the AEST front-end. Driver input is taken exclusively from
> fwnode properties, so the same probe path serves any future front-end
> (DT, hand-rolled) without conditional code.
> 
> The probe builds two layers of state:
> 
>   - struct ras_node:   one AEST error source
>   - struct ras_record: one error record inside a node
> 
> This split mirrors the hardware: a node owns the shared MMIO/ERRGSR
> window and policy, while records are the unit at which errors are
> reported, masked and polled. Later patches plug interrupts, decoding,
> storm mitigation and userspace ABI onto these two objects without
> touching the front-end.
> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
[...]

> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_ARM64_RAS_DRIVER) 	+= arm64_ras.o
> +
> +arm64_ras-y		:= ras-core.o
> diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
> new file mode 100644
> index 000000000000..b5448f4a841f
> --- /dev/null
> +++ b/drivers/ras/arm64/ras-core.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Error Source Table Support
> + *
> + * Copyright (c) 2025, Alibaba Group.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/ras.h>
> +
> +#include "ras.h"
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "arm64_ras: " fmt
> +
> +static const char *const ras_node_name[] = {
> +	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
> +	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
> +	[ACPI_AEST_SMMU_ERROR_NODE] = "smmu",
> +	[ACPI_AEST_VENDOR_ERROR_NODE] = "vendor",
> +	[ACPI_AEST_GIC_ERROR_NODE] = "gic",
> +	[ACPI_AEST_PCIE_ERROR_NODE] = "pcie",
> +	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
> +};

Now that the ARM RAS core framework is shared by both ACPI and DT
platforms, should we consider dropping the "ACPI_AEST" naming in the
common code and replacing it with a more generic prefix maybe something
like "ARM_RAS" ?

[...]
> +
> +const struct ras_group ras_group_config[] = {
> +	[ACPI_AEST_NODE_GROUP_FORMAT_4K] = {
> +		.errgsr_num = ERXGROUP_4K_ERRGSR_NUM,
> +		.size = ERXGROUP_4K_SIZE,
> +		.errgsr_offset = ERXGROUP_4K_OFFSET,
> +	},
> +	[ACPI_AEST_NODE_GROUP_FORMAT_16K] = {
> +		.errgsr_num = ERXGROUP_16K_ERRGSR_NUM,
> +		.size = ERXGROUP_16K_SIZE,
> +		.errgsr_offset = ERXGROUP_16K_OFFSET,
> +	},
> +	[ACPI_AEST_NODE_GROUP_FORMAT_64K] = {
> +		.errgsr_num = ERXGROUP_64K_ERRGSR_NUM,
> +		.size = ERXGROUP_64K_SIZE,
> +		.errgsr_offset = ERXGROUP_64K_OFFSET,
> +	},
> +};
> +
Thanks,
Umang
