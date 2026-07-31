Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B764426405
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501542; cv=none; b=ux9lao5QItTexulYbK2pU0s2Hts1GgLBVBhv8YwvhD5S6TgCUuTl0qC9VyGTQ4qyiPG4e1SKSAZhbfU1/7kTDzqVi8pHksVxGcLzQVZPwOcHq/c7FJscP7cJveRh104JiohfLkh5n/ikAf32MDKwAKLne2gvxsgZi7/6PPBGHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501542; c=relaxed/simple;
	bh=5xWWrc1BZAYdYTyosAKdPlfQTehwP0V1OtriXqDt+x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdReBT7LiTcy5QBLiNzBOh1f0W7V2N3saAvmb1y5EwhaGaOkpmPOAzYNBXfWGWVZWZuQUzrp1u0pmtnjDadZPaiv7LTN5Iqh95W/kQr1UVYEU25ABYWILdo5wQmyGbZE1XVVhB6zFeVrkZhISJL3523jOtui//NfZAizVfrS5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDgFXaXp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LN7jjS30; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDgFXaXp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LN7jjS30"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VCBst63776885
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 12:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OAl7opGUZWQ6EAHGu5DK9XKmGG+VlEVNEE8sAF7wqjY=; b=VDgFXaXpO/K0rrz4
	8udAXp0Jlst4fhUllw9xBsYbQVimA5xLYczFA+xAnPpfa+bVYgTiMIjuQYIvMkrS
	DIlyKYIl7KcBaMSW4j98q+mWK93CAfhigEriXAqAJTmZ6NZSdRNZAgZZYxPnCbk3
	I9DQ2o0VTJ+6v+l6O0LHyUxIpKjWv94cE9H1SLSmunSAez1kKKubc9Gm7HGMfVrQ
	/JvsQhfMrPA2p9K7yPgPhFnzg+itt7eql2v2v7j6D2EjU8v/Dl9X0BTs1TqPgeCY
	I63CCxZL7LqRRCr0HbRRrPe/EuqWmEJChM9n8EzA/R1H6fmSWjb3ne1Kh7pU0c+M
	A0Kqeg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frugh02yy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 12:38:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2557773b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785501538; x=1786106338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAl7opGUZWQ6EAHGu5DK9XKmGG+VlEVNEE8sAF7wqjY=;
        b=LN7jjS302EF1aMWfbytJg1JfBc8a/MIPkjmcaVEaRU+8B1igLmdQ2lbvNka5MeZoXg
         34C78t0NP06iSWyiV2xbZO6BXZuVDka46Iv3oomZUI6I1ssFSa2alZxsR3VJxOzKrZu/
         btTIebRpOuC2LuxJgqnXiJm2mmmy7TV5JtbCDUr+oW7bYp52eP6oWUhCgYPtVXWFNkmQ
         gUs/Zze2xeygo/UGOcV7v0d7+Vw0FTY8m+qjTa7H+ku5C9H4pcG7SJhcBqF6wI7DUNjp
         pS1JXz7Y1AA8FYgm5gjUk6/BShxdfwYJJp8Pws+Yt+GvW63ujwqvssZwnZgnHdKZGQgv
         1rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501538; x=1786106338;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAl7opGUZWQ6EAHGu5DK9XKmGG+VlEVNEE8sAF7wqjY=;
        b=db15hwOK0e2IHgZy0QfvKJVS1OJb4Ux+21Q7KDzJHglnu5Or2PSpKtFYU4sqkLwtKA
         wy478EQoBA9vPEQ/ApjcVtJIt8tnZOWW6sX3cZN78blAm066YPpaP/LzZILCl6JYKVZD
         LCjC+h7A62H9fHT48tt9uXvceW3LZ0GbOoRByL/qumQ8vWZij4kok3XEmjHV5SpLvNyr
         jnqBfssh9yEMUZOgK8kkrNUAg05EiwN2jUJL7+LJZu/c7wJ7ivJN+EfJ0JeiRJ9sI7rh
         lQ1k9rq8LX3RK4z31RKq+5gltlF5AoU0XfKFclzXTyrSXotp0Bu147XfoUjhmIRQ+DyP
         RSkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLnrlJEPLjNi/iu38X92Hyj2SNX84/yjg6YgK1ERuIKYYXLlY4ValCbxYLgzxBmtkI+kE0WUXE61Pb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5bQJnyt7oWUMDoSyVv+ZrPvzLEj7ZFimKoEeD9G2QP3GUwcu
	wMWWLrMC9EzYOZN308ScVHwjR2QKU/qL/9hWw/rr3JvQxj/wclg8w9kWCAHnnu36kHYEB2m2Khy
	H5Z0T6/1vqfOuiyKQ1dM+I9bD16PPS/gb7d8w9oBU8HphpnuXnH/VuH0qq5b0Yri5
X-Gm-Gg: AR+sD11NFYm4jhYx2uIzZHNgN5i/C86HUv1ou4fgwNmgggvgONfBfd9sVqxdLEqZEaL
	yoFBAOd6+/EY5xFbtGL09aNFWV2X/XXAQnov8wSdi6UmGDx9p8LekSzCoeQS9cKJJftLShnHlEs
	x6nfPapK2CEsUkt6iyYyAWH2OPm8//AcQDWJ3FiC3GRHCIBZUFv9h/rQK9Mx/7nTHrlikwHKyaj
	kvSYMbBCckmp3WPtJbg4wcZoFt+WpUr0KN+AcJUvs0QQONH6LV4TXBMSI1ft857awTdD4h0TM9E
	j8GFe3cBfQENlbRM1qvhSS3Nc14lOBjRPnA4Xg33dbw6iAE7CC5X971sUzAz1MO0OPRNCS1m0yC
	P2whboaQSJO9bpvKvrh6MfQClZeApFkp/Q5HX3TykGmHiF7hKsYgbbb4iWS+CbuXlcGDJSik=
X-Received: by 2002:aa7:8888:0:b0:848:3f91:da7e with SMTP id d2e1a72fcca58-84ed7bd1ed8mr1351600b3a.24.1785501538365;
        Fri, 31 Jul 2026 05:38:58 -0700 (PDT)
X-Received: by 2002:aa7:8888:0:b0:848:3f91:da7e with SMTP id d2e1a72fcca58-84ed7bd1ed8mr1351575b3a.24.1785501537959;
        Fri, 31 Jul 2026 05:38:57 -0700 (PDT)
Received: from [10.133.33.14] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edba4bf90sm433794b3a.0.2026.07.31.05.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:38:57 -0700 (PDT)
Message-ID: <4a0eaf75-9cf0-4a98-84ee-c10442faa646@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 20:38:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] ACPI: CPPC: Skip desired_perf read in
 cppc_get_perf()
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Lifeng Zheng <zhenglifeng1@huawei.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <20260729100245.2628302-3-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260729100245.2628302-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NSBTYWx0ZWRfX62mUqaMtzHLW
 zO+bm65X3BVFn4SVldM3cqsQsJy/a2bFcYbErYvHnFQIRhR3CorwibLPjU8y5A0HlM0dU52dUAD
 NfaPb9uXMBEWE4+QyJhdT6P2boW/m4RqAybzY5LFCZ3UBtrPMGM78VprrFdJZQbv2haIXC79eAt
 Ca1NqfOIVPgf7cEbfkWrmaFNXl3XL5M87BxTFIUM2STkBsX/hEZhFf0QxBx7Ev25yfJsZkpeWfb
 FIZv8szkl/8Tp33ySK9ovEx24Ygu0hgJsAmKochaEx55nA6drc5gAgdzksyRTS/dx35oUK39SlA
 ChdS7RQ94uRBsjZnLWwRkDiLFuUT0K4E5eWSSZfGuGM4OBnAZOZuQsRkUuZT78yUChgWjmiFtAE
 Ei1FLxL1HOf5uXdxnBw47oUomt0cZfYeMcYJdOr4kC3UUgiIgYXfXnFyrtFzOQJcSwT2gEOdks9
 YDJnBJZAZsAvF7imH6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NSBTYWx0ZWRfX6zLZdpR7QDYV
 YPQ+7HSjJT0Sim/F46CRvVOOzkzNWIpz4Wzz10lL8N2Q2uraIeQMsYKdCkx0RhB7V9kmChXotnK
 VgWPr+f+p65HXVj8DwfTSeyjcekYZH0=
X-Authority-Analysis: v=2.4 cv=U+iiy+ru c=1 sm=1 tr=0 ts=6a6c9763 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=A7tf8JFSQkDBtQtIEu4A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: eIFcjMWgsa7_VkYiEnGfXQv9Uew2h-Rw
X-Proofpoint-GUID: eIFcjMWgsa7_VkYiEnGfXQv9Uew2h-Rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310095

On 7/29/2026 6:02 PM, Christian Loehle wrote:
> ACPI 6.6 changed the Optional Attribute of Desired Performance from
> Read/Write to Write. cppc_get_perf() nevertheless reads the register when
> initializing performance controls, even though cppc-cpufreq overwrites the
> value before using it.
> 
> Use the readability check from cppc_get_desired_perf() and leave
> desired_perf zero instead of reading it on ACPI 6.6 or later. Also exclude
> the register from PCC read-command detection so it cannot trigger an
> otherwise unnecessary read command.
> 
> Fixes: 658fa7b1c47a ("ACPI: CPPC: Add cppc_get_perf() API to read performance controls")
> Cc: stable@vger.kernel.org
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/acpi/cppc_acpi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6e5381f8de38..210988d57b71 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1843,6 +1843,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool read_desired_perf = cppc_desired_perf_readable();
>   	int ret = 0, regs_in_pcc = 0;
>   
>   	if (!cpc_desc) {
> @@ -1862,7 +1863,8 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   
>   	/* Are any of the regs PCC ?*/
> -	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
> +	if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
> +	    CPC_IN_PCC(min_perf_reg) ||
>   	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>   	    CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
> @@ -1894,7 +1896,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	}
>   	perf_ctrls->min_perf = min;
>   
> -	if (CPC_SUPPORTED(desired_perf_reg)) {
> +	if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
>   		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
>   		if (ret)
>   			goto out_err;


-- 
Thx and BRs,
Zhongqiu Han
