Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F9388E43
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297806; cv=none; b=eywdE2+dJnzgCg+++r4bhu8h7kcasysZkRT5eHjcOq0bmalLPn8rAJ3CmvlJLKsyjE3/iievrNKjB4MlX6ufam3w8TGtEM5Ja/8M3uvvliGu+3sGIWoLUYeIb/oas/8zMCMPCff9OBOWmmfqxO/davqVlu9zT3C9Nt2jCFoYAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297806; c=relaxed/simple;
	bh=LBr3NTXV2yzRBMXWtpv4voFp79Ly8C77AyFyjo5ZLXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffSH7WeJv9yVAVKtK8Iv9jy3cDU2MTpLzCpoK9uFsTymFy27qvur8hptRfZrFytUIOVrJgHJl+HfsKzqus6V3YfXIWup4vF4O+NqFg8zM8vL6TMXdG/kr4Okj2C316LxT/2ucngsIRa4T9NdXLvyJKb4K+vQ3+o/V2klQrhOyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X38jvpwl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kBhJjQ/6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X38jvpwl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBhJjQ/6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T1GulJ089004
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 04:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=; b=X38jvpwlqZa8S7V4
	p8TRh/D78I/Rq21eC8E83wUet2XhBqTE8HLatZo+SHukS5U7VgLpDSQ4sMOqElCc
	7L+w/Ipq4CHl80RLNWp+aUCPTTwSV+5A5Kfc0DSi/R3iob0rHWvA9uaa+xygahRP
	nY7SZUj1qX68xORtEj2g4dN1ezOuMuG50bqMWirhbKp2j96e34K0uORi7e5liJtE
	7bD+5ausUh0h+EF7lyAgRioACAH6E+4H5Yks65IAwkIYlwWT56yeBmPtpm+uIUaq
	5ib2wdu6Aoe16ZNuKbBXHLzFN2W5DTX1qQfLcGBlzRcNGIMakq5Z2kKWtumhIFAx
	KdzS/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpvd3ku7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 04:03:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so8051515ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 21:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785297804; x=1785902604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=;
        b=kBhJjQ/6LOJpkBC4bnQca+gKYs86sBB2cpVOe3N/YGyG/uyY1vEV3ieU2vG7J4/9Xh
         0myYCkzOR+ImJPXkdryYnmTVC5udCFxUSMBJD/XLU7XIYlHveTlPCn5gxInyRaDwvxxy
         klpuWofLaC5Mxs91eMN17ADVXlvylwaUJi8YjLd5zrH062Aqwv4QIlOWMMwPPTGux9ww
         4hnOWOFsmjRWim8dOb0LQBHF1TeipxPFUzYpEK/EfdL70pga+DeHgl80tjY9vmxL8fep
         rjO4i7n7KiKY/TJV8qkuAgE3vhQEaTbhrJyWbQHF67taJQxlQBH7Iw5y3xiShvD+smk6
         Xq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785297804; x=1785902604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=;
        b=KHGp6Hak2R/sLDrW/M0Ujxot3/j1Ykkst/FjTZWieSdZx+9u9xpm/kYeTm5j6DFXA2
         p6aBOCDllOSaaJtVxtfc5zrTJnFKDfZW8+6HkRlEbUTvu1jvzJKfk0MeLIk8rZ/s6TjM
         rH6RHRxVXEsntZLONWnGmnn2P83hnFhkW53ZTTkiv9YjSuhUaO3hM117c8UxUi0QC7/H
         Eep3V4AjeAOAimcaARJNaNrpR6o/kTf1dDTYbuSq6JDchnsjfxRUZuhKJUC0En0ztb5r
         H9ySRl3bmCrKv975vx1Ue5S3ag8v98TzOaS+ozp9sCgNDbVQ8zTJY8SvynIsDTxCbncH
         24sQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtXarXXHW4HrL5ZPKBm9eqc9kJLJBaOgJtUKuDTt9qLHrZSSXqKYa4NH6CogM24CCe0MTsiw0ItqfK@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyC7LFGYxZzq4Gq4eV2Usc5Cpeupe2Ob0AjOVChu/LQ1pU8JI
	RSp3fC8b7BdntZs0X21VpWLoicKs6O75nop6zhDs11kvoD5ac6PJ6AQCIOF3p0liLTwzzQnNNOP
	1WYDT8TjLgoDSvst/0q0zT1zq+2AQ+6Nz+l/jrWa7KxJtOeaDT1vpUCawzyYxbQSL
X-Gm-Gg: AR+sD13ihoKjqh6EtwWHXC2qpYpZF/5M5Ye8zn6QWsJ4beIMmnvkhgYzSSk38O0lRq9
	eMV1mbnIY3Z+27OSBpRXRKemfYNKkWdtx6sTfbTUzAHHQA76Dj/TIPRpbmcjcvj9QjTyRpbQwUM
	MRdVa0Ka08SVxFd1Z6PS//Tc0VWIyg/TuJKI8go9LYZVn5lzMcJsXUfAfYZ73yqX0hlWwoRL9PD
	0lweU8hLbgP7ZalfTLB7C6RjXXa+pcQ8dBjnvYZWsxxT1Pi3FcLFAJOadDln1g/Q7RFgYQCk0/y
	BB5ZlPj8eXtanT+q/0Wm2z3RAyibH1m3hhATezLCZdOI93DryMtj6o643xEbwhDT/tjq3ZjAL67
	Ps9VuJWHDPXIF6wbDSriBpdc0i/75t7Yb+6CE11deEgml9KNxnA4R4WjOCbK6Um67qd+I4Po=
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr7837565ad.18.1785297803431;
        Tue, 28 Jul 2026 21:03:23 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr7837035ad.18.1785297802623;
        Tue, 28 Jul 2026 21:03:22 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15199sm4667385ad.17.2026.07.28.21.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 21:03:22 -0700 (PDT)
Message-ID: <1c655514-4595-4d3e-bc87-09e4f8415f3f@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 12:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Gate desired performance getter on ACPI <6.6
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
References: <20260728160538.2574100-1-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260728160538.2574100-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAyOSBTYWx0ZWRfX0uHpJLBhKCpy
 7U+hgqQ5sxscixGUQPef89Hr4fQZP0ptkDjVbAyn4KZ0yCoOPCgu+9actyjYTBT+y/BgI1gFA2Z
 do79BrBfWyVWjWE5HyoFVL9xuHASa/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAyOSBTYWx0ZWRfX1NkoWtYJHl9e
 YN0BeyC2FEiRd1m8O/kF69uHKn0140oS+hPFupW9m0mdTg0w3Cv0E7aHD1c/SxPYt8+kjby//w7
 4V0dYPiB3Zt+move43td2rMz9Ytpzj/k6mV5lnGoPYV7LW7WuuCmZei7+PH4zUiPSokb6hAMq3M
 vA8uuugjQJzXVVUszwv6xwb6WHYZ38/GyafY13rkILYT9Gvxkf/hhTSQotvdOchlPHIn0LyeQUt
 //FqWEK3qTtHE8F0KHoW6NC10ZTLZ5yP7hNy/j2Ip6bH+etugwkhyvHsgKaQeSA97UgDjZDPU84
 7iR/UuvhRXquPsBbQnh7ixUitrsAHplK28w0D4NfSDlIpepEylr4UAdrmgx4Guww5nUuDivEPMB
 8VH+GBU9UG49gm54ZjokWgMKHI4NWaaJIsA3G1hpdzJjpPWUC/rwjqDqu8huJGG8UUjh+JgrU8o
 GYwgdmbd+tmcrO3zAvQ==
X-Authority-Analysis: v=2.4 cv=SqegLvO0 c=1 sm=1 tr=0 ts=6a697b8c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=-CsNd9vw6T3jYN4hrYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cOf0dcqLuLyijutA_UEhucGSSFOUGVlX
X-Proofpoint-GUID: cOf0dcqLuLyijutA_UEhucGSSFOUGVlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290029

Hello Christian,
Thanks for the patch.

On 7/29/2026 12:05 AM, Christian Loehle wrote:
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
> 
> ACPI 6.6 changed the register's Optional Attribute from Read/Write to
> Write. The existing cppc-cpufreq error path now falls back to its
> cached OSPM request on ACPI >=6.6.
> The original (and existing) workaround was for a specific HiSilicon
> platform which isn't expected to report >=6.6.
> 
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")

missing S-o-b? 🙂

> ---
>   drivers/acpi/cppc_acpi.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..218fdea09c1c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1321,10 +1321,17 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>    * @cpunum: CPU from which to get desired performance.
>    * @desired_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
> + * errno otherwise.
>    */
>   int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> +	/* ACPI 6.6 no longer specifies Desired Performance as readable. */
> +	if (acpi_gbl_FADT.header.revision > 6 ||
> +	    (acpi_gbl_FADT.header.revision == 6 &&
> +	     acpi_gbl_FADT.minor_revision >= 6))
> +		return -EOPNOTSUPP;
> +

Just for context, a separate topic: it seems that cppc_get_perf() also
performs such a read. However, the value is subsequently overwritten in
cppc_cpufreq_cpu_init(). Since this all takes place during
initialization, it should be harmless. But It might be worth cleaning
this up as well, in case reading a write-only register leads to
potential undefined behavior?

>   	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);


-- 
Thx and BRs,
Zhongqiu Han
