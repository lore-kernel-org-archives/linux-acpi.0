Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9646F495
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935062; cv=none; b=geFYj4NdXw+qDd0sI5vkONaZxHpQMWmO6TpWqfTO1/iUiGazh4iGOkWLLye1l1C97q/xPVzFUElCgrrlUJF/1SSfFI/05JMheI+kZt2QTf5JhPECoX/6rCkMBi/cpediZOUloMgpVDiDE3nyEHHlRCsR9WzaJKmSE0ObOBcCqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935062; c=relaxed/simple;
	bh=bEf2TdxqrsfETQHTsqCcWujzWjSGMWByaj6TVgxXCMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKeqfAdtUFLbxF+WbzfQ8HI63JjoU4wCSHFVJ8ECNJpz5ahJq6mJgT2zyzRIArPG4ZGM9+3sAnoTnNjEbsSga2Jx8oFEFsE781zwV8LwbaLLmHdziI2JtSoFwHAaRufPjEApEcH/AxIMQeKv+rhDb654y26e7hGoalY/nTf6ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHgzt1cf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kJyuyVs0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHgzt1cf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJyuyVs0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675BvISu2591618
	for <linux-acpi@vger.kernel.org>; Wed, 5 Aug 2026 13:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=; b=dHgzt1cfWHKULlsv
	wZNznNeUUj+QTA2jU2koJnxoYfOrQk6fTQ8eYgR2Bcc/HqssWU1Q5FneXuJKV6Nt
	X6a14+Ox1dVFT/nB3M15SW5l5i2ZMAmU3oQDwPN6dRJT+LU3ZlZzlifl8+/m6lx2
	gV2xoSg767IzpEVjMlncAcNhJ+UOamZTaEvpYbCA/e0TvDsbRdulhJC97KfkGjYf
	D+AflNg7C/gAHawHpLeYiIoY7nqj8lQO1bDVtXonra5nXp3dx4TaMK//ae3lFGGG
	AeND3Jb67jRMoqKk7KiufgQWsTefISdSkYwjfUAIZ/LWlSZB6ZFQbRfoP19nMXnD
	DPydkA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum56cpbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 13:04:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84eccf9d899so1377250b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785935056; x=1786539856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=;
        b=kJyuyVs09PoeHrTVgT3C3As4p9WFdk8Dx9eH8LGE8hgntdEJ0xVOh1CPkbYgXcdHy1
         7Ci0F8jrCTUPtg9jyH9xaEuHD53hTtA1RpOS1ydKZ7ipmM6DISfLJIIw44YN9ier+vPV
         Nrs919AORa7Q/Hgf1k2s/VT/CB8qSstpdFcIB0V/yljNeYxLLjghHeZRZ03Q1CM9dH2M
         dlffANsSdXVoZrobKeWPsV3/9jHJ2z0PK3qSCU6sCvv9/hA50FvYXe3GFAcDu+VIHmEU
         USkpWNXs2dT1ZVfketX7FkUjMudKP3zdXa0Ir93cvzbMiW5bYssu4lLxEuNucco+gLVm
         97Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935056; x=1786539856;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=;
        b=UVHSqvBFh8fX0m2bWkpo/zaA2IZx+IxxCNhNKj73xzIfPF7Un0PXA2I60DoE0hyc7W
         GB1j6lJBAt/J0JnAyNzCoR2ysmf95gafWM9zvpgenRrODsHIiywoibj48OtHVK11TEvb
         E9yGwN9aaDNWzZU3gcf0m358c/vSa+f4gsYO0xVmi91w6+Kp3ddWPd4hjdAlxz3iPcO1
         6BTpuEeECO/wMZqiICyK7KQyqYfnzU/WydI4ONzfjTv5FAlt5TeP/8RywPvBP1xZx5e9
         Q6Dtk/bmjFRl5ak26DNV/0+CxZevMUDzVAMv5DiF/JZx9UGb1drIEQBj0ieMZvk7wj0L
         n8og==
X-Forwarded-Encrypted: i=1; AHgh+RotRBPHIR5Kxhce99zW/wtOwpuIxUVrE00i1Y1i6Zcx1eu2hfu1lQNZPZozjpPa38K9AjO54VnF9BXN@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTwqlXfg37PmQ3ms8NZzFlXavrR45nnZoJmqrAL97fD347ZX+
	ynwGM6OtPZ8whGaqdW8DsNq3Ls1KoonHnwiX9ZK7X4Sqpq+oIrXhe1ILfiSIm6+hu2KEHo5XUlL
	LzLUffvOgG6FOaQv0BioJKC+g3MtdvKn+juLpSpH30eRFlKPz4Wd0v8QZvU/ZWkOj
X-Gm-Gg: AR+sD10iSAmZf70frRhQj8D2LOwZensueNEfawUMnIhJZZZUwywoLXsZAhDI3V3eVDG
	jqKD+4IQy4EL3Oc4NFgEUL3gd5pJ4MchCJF+f5WFRAE+nVnYNTwB56Lnqc45/EDP7IkFFuzmTKR
	SduyASS+lXLVREaqhkHcOQPBivpa23Y1neVWEFwnk/YLu/1/XPrItehmOspj+OB1QCFpZLkUisY
	J9NTG0e1C7WNdHzIN1s5925CMaJc7sjXdKVPsl3q7sDt6VL1XWIi7zArWaBOtOV1Y2Og+pVN7cA
	SczlxPs1av/IAbajjdltpIqViqjSdWzYZgKwEBZKU3cTuazk38+2xNT8vB2ef3jfG5hz8/EAiVW
	UExoi37D0NfNJSQHNX1H6L3vSI9gUpEp7Vvr+DaiW+FLXhrm1g7SsqvmvKvF+V+MCvhcDaja8
X-Received: by 2002:a05:6a00:2e11:b0:845:4888:74c5 with SMTP id d2e1a72fcca58-84f2e01746dmr7039479b3a.23.1785935056256;
        Wed, 05 Aug 2026 06:04:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e11:b0:845:4888:74c5 with SMTP id d2e1a72fcca58-84f2e01746dmr7039396b3a.23.1785935055669;
        Wed, 05 Aug 2026 06:04:15 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2c6145sm831463b3a.12.2026.08.05.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 06:04:15 -0700 (PDT)
Message-ID: <1a89f834-93f3-4741-9979-39570af397af@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 21:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Avoid unnecessary reads for full-width
 writes
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Lifeng Zheng <zhenglifeng1@huawei.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20260803210527.1285229-1-christian.loehle@arm.com>
 <20260803210527.1285229-2-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260803210527.1285229-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX+6KaQdZlQeut
 +0JNfX7untvxE0ZGVGPtqxyO+MEKQoqtqutF6Efd2TXNZjTq6NPNvUxEFZCqeuNNjYLGZ5ZXB6+
 kbjaSF2qVA53RYHhVmSeEARs2NSEhT6goOb3Jnt1vqpEu82mI2fWjKcVnAlZDf+l0CwQD7WpQpV
 r9lcWSriMuMU6zoOrgIMW0EeOoVQ0BLUE5cT1fJUCP/zay6DoMvAeGI+64WFqyJAHZIERJqW/7O
 ijJgRqBdTz6mvFtnYZNrM00XJhdjg9wpUug40+zgaSatOOPZGhMDy3JcRCSVtdFBSAVVzk6jc+E
 dvFOx5cQR37WBpjDKgNT6NOQhBDHrXR6vMoyjR2/aQ/0Nx+rbyx5sZvqbjT1eRQ878QMt44Z+gK
 PZbDqh4H3XholPjKPEj8HrxM2Mj1M6Pv+/Ph+RG8cAA4xGrTxcQRmpISfDcufc8vninmQvVJiZd
 +Hpw9IGmnYqNu5ePG8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX6yZZl9SPRwHU
 KbNqyoIxI3EL9/YEb/YiBdMvfa6+COLGboZm4XsoNKtTyl1Vactsw1V1ouZoCnqz9DgTs7qFSbU
 1Alh3VU/ekjzCtqgssENVbhh27qhUO0=
X-Proofpoint-GUID: oXuPRFrWA7sgFKbMNj6v5N2bJ-bOkSfl
X-Proofpoint-ORIG-GUID: oXuPRFrWA7sgFKbMNj6v5N2bJ-bOkSfl
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a7334d1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=CXDJWAA9LoG17zI0-BsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050105

On 8/4/2026 5:05 AM, Christian Loehle wrote:
> SystemMemory GAS entries may describe a field within a wider access
> unit, so cpc_write() reads the access unit before updating the field to
> preserve the surrounding bits. It also does this when the field covers
> the complete access unit.
> 
> When the bit offset is zero and the register bit width equals the
> resolved access width, the previous value cannot affect the result. Skip
> the MMIO read and mask operation in that case. Retain rmw_lock because
> another entry in the same _CPC package may share the access unit.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Nice optimization. Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..9b8d68b44ea9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1162,25 +1162,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   			return -ENODEV;
>   		}
>   
> +		/*
> +		 * Only partial fields need the previous contents to preserve bits
> +		 * outside the field. Keep serializing full-width writes because
> +		 * another _CPC entry may share the access unit and require RMW.
> +		 */
>   		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
> -		switch (size) {
> -		case 8:
> -			prev_val = readb_relaxed(vaddr);
> -			break;
> -		case 16:
> -			prev_val = readw_relaxed(vaddr);
> -			break;
> -		case 32:
> -			prev_val = readl_relaxed(vaddr);
> -			break;
> -		case 64:
> -			prev_val = readq_relaxed(vaddr);
> -			break;
> -		default:
> -			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
> -			return -EFAULT;
> +
> +		if (reg->bit_offset || reg->bit_width != size) {
> +			switch (size) {
> +			case 8:
> +				prev_val = readb_relaxed(vaddr);
> +				break;
> +			case 16:
> +				prev_val = readw_relaxed(vaddr);
> +				break;
> +			case 32:
> +				prev_val = readl_relaxed(vaddr);
> +				break;
> +			case 64:
> +				prev_val = readq_relaxed(vaddr);
> +				break;
> +			default:
> +				raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock,
> +							   flags);
> +				return -EFAULT;
> +			}
> +			val = MASK_VAL_WRITE(reg, prev_val, val);
>   		}
> -		val = MASK_VAL_WRITE(reg, prev_val, val);
>   	}
>   
>   	switch (size) {


-- 
Thx and BRs,
Zhongqiu Han
