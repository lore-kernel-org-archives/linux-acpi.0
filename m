Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA253D9DC7
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503978; cv=none; b=W7LJVCCQeGp8U1/uB9H1JtvYXUIIKDqcNVqUg5G5yo9iW6WKYe63a4Mqt055XXzTdHDEJRD4p2oSEzsZ8wJMr7O7WqP6MiJGF7KDtzTscfNx3lN7twd9vr8/V3QCaDPYG4nPmLH4nQDnrS6kt0cgq2sJ2jz1s0dGKEnegeybnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503978; c=relaxed/simple;
	bh=y+k2tmA3AEeuawLtjK6YaKQMDLUQK7s5pYRNpvTxvxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvwRFCXxZzgjOc381T8/xRdO2JNNSnwOvYEuVrYIibYg9Sme1Neli4da1BtPbHojNwHr+/85BRfRQ6++5AB9uZxx5ZvXjwevjhcerODBTV/cU49bjhVf6il31WCWJOf3r0r9I7v1FWl/JbDk/pqpzm3RTOqdJRMXD02qziQuz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxhbQlVM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dhCwZEUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxhbQlVM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhCwZEUY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBcuaa4185513
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0Mun1VjjKe+4byymE3nXMjIFjv7bfSIr2iO5qPxz7U=; b=YxhbQlVMAvbwz4k2
	W306HGssLonS3dDQ0HLVAAMCrrovTDxTOaAHhtudlM5qYkXHpNe1J2D5DxJyp5hk
	iE6Jw755jeVdf+DWYenQxEQ2XO8Q0GUu/iDHIbxf8gNUgd0fzFBlDqxs4/ngO48i
	UybmwSqfbDxCI52m+t/djV2qEQSi5P7OA5MfXCXAyisIdomg+gzPoYS+NOyyfJLs
	EqGtlc1E/zXoIpQ1te6JdjHGdnuipWGxFCoO7J0wxITV+KAka+i98BCKoHmRLE0G
	PmMKhz1oJCg6ktYkihGjhjSDDjRHDm0Rk3zcoTI3DlZUG6t8fihvtnyxVJkQzAj4
	kpnrkw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru130cva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:19:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1510158a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785503975; x=1786108775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0Mun1VjjKe+4byymE3nXMjIFjv7bfSIr2iO5qPxz7U=;
        b=dhCwZEUYG5oaYVFC5VEfBSH8sWOAcB9s2nlwGO/vOWL8qaU5N7q1yTHRGoShioQoej
         6+KkvJney6Nf6p2GuJpYY1WOnfrmDwj/G5bTbwrmGGw7vVCm8wdzOVuDljZibkp4voqz
         ewvAdhNnSWj31paPbTF798cEdNAwrQoQwgJ3WQFO2EaRcE6kW4LO1y4oHIMLEI5UeU8X
         3a/RajDO16QAjFZaB7sy5Vd+GCFC3n7BGPHhdx8mPZfVtTv2G4lcSbQed5U0vJFD3IKL
         VDyCA3hY47goqqnGYA9cTrYrvjeMAfUP3A4uXmlzSe4Lj/JNzrU1NjeYRSL2Z4npHOg0
         v5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503975; x=1786108775;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0Mun1VjjKe+4byymE3nXMjIFjv7bfSIr2iO5qPxz7U=;
        b=pklHPipz8mGo4cG+ddVllnvBfqvZHIGmWfHPmurZ8zC/I1tuMXbZ3Efg2HQSFg0O/b
         4klO9A2dn8Q0g2jQ1GwRw5413n5m3nf1TckFbJbc9e9t1NJ7APav08uYifyqUE2rgria
         EhK2tnXeZ2nDg+pfKloG5XxYTDKp+Z1sH8Fsy877WmMvPLcW8lN0yuYLlxl7SjAmcW9R
         Vi2xCk8Ba9ZLuvtamYWpxTFxSD6VjTiPm7g5KgjfOnl3TRDNFJo4Md1D86FcINCzcM9c
         4eFXqvpCnYNGnZYOKU8bu0wVfZTm+cS99UTgGHs9q+rxlVoPxU6XfBF9NMsryB3gsG0l
         5gDA==
X-Forwarded-Encrypted: i=1; AHgh+RoL75oJALxnLcboxvVoBKiZ2/HIBWChczAgm/BoxDHv5qZBekeIfwgaHKdhm+B5bA2cl2yWKaxp8zz1@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwZ1QnaLeaZRt8+sZGPxp/e5cEBNwTu/VTkIeQEPgT3wUYcyV
	k2Yz2JtiboVCfjtu84xV4uL+0ZTnjZR8MB6anSwKnXupUn/RI3l8nRxmdKh9Hrcirl2XzsP03UL
	hQSXiIkRa7LGg21wttUeF+NIcmnmEnwaCtavBzRyB8lzas0EAOnff9UyFf6eWm/qy
X-Gm-Gg: AR+sD11juv9ym2Gh753NAr8gQOiLX713CNkFsH5n4RgVfBaj0BUVgn5OhrE1AIxIhvH
	lpKwFsGreY0GW0JMxXcJAy/eVs/pM94SzFL2/XxX7cN9P+HHCNtiF+w62ovk4nbrKFb+mruPA03
	o61bck3gpYWLBhVPGS8eC7k3BeBaUV8H48nxcQIT29JQZNpBTLz4yvRyuLt9n16jKqlEh3dB1j5
	at926sv0XL8aSRCxpGHurrepNYLy+ssJBCuzqQBKkh/kbl5VNgzoH4HwAiAyVxgL9IAhawP/baZ
	s6+GAulKoJ5XvByh0E1Pb5dxjdxvbg0lZcHEet+/G7yInipfCPe5Fdia4gRMYqZmlmBq01AJzLr
	gpvBmyjykJ+YtN+KUHxEH91DPY27TzmBHm3+hEkjGRGtj31rZXq+PcszhrcIXtQIypUaBQRg=
X-Received: by 2002:a05:6a00:b47:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84ed6ef121fmr1862392b3a.34.1785503974923;
        Fri, 31 Jul 2026 06:19:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:b47:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84ed6ef121fmr1862366b3a.34.1785503974492;
        Fri, 31 Jul 2026 06:19:34 -0700 (PDT)
Received: from [10.133.33.60] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm449580b3a.30.2026.07.31.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:19:34 -0700 (PDT)
Message-ID: <d78e2efb-c0fe-49bf-83b4-b681095adad4@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 21:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] ACPI: CPPC: Stop reading desired_perf in
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <20260729100245.2628302-4-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260729100245.2628302-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMSBTYWx0ZWRfX+w3zuWA19/Xk
 oysFSqXWr3qiWUEMTT71811oFydbZtkMdWiYzTIQunPSRJsPFJKCA7T8xQyVt08Xf8SGofDr4Xq
 JkboLt5qtXSVAFHiT9R+flfQlxM6zNM=
X-Proofpoint-GUID: fgjAiqRAAY6hQzbhM6EtRR6QN5s5fQT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMSBTYWx0ZWRfXyQLbFI35PEBG
 YBo5OelmaGvenI4/n/a0KjNh+pQitu5mUp9rzeF/Y1SlZLTioz80T70kvXSk7ZmIfWNgXEcuqOB
 CZtxHbh04OVaDuVq93s6jWxb+BZgMBd3R153YrNK4VOl5EXyBineGxlwN2s82PRgUd8i+rsGR+O
 4osunM0/8e6ObDQGAAFucGr38FCJbMhzYLjCt82mSkQvuYiCRQ/8dKRnj0t9M6nt1a+4hGK2kxV
 uv3Sqzufx6WzkTnC/D/fTDVIjSZdzjPA3B718hyFnEy0CynwM9dTJwS4eBmfnWJIOeRWEFFDlDg
 jmPljLK2DmP84D4F5kFjXuDYXqqTz+GVl53CohKkLAYxkbsGKGYhEndHkNOCqr9catDCTuhTzR2
 UpOXvSW2EPaRxG1IhMKkzoa7sLLkHJjK+2BrqkbVESTdt7pRcbVJnlMbbZZ57QCrf7CTGTfrlFk
 mUEjQxUi8EOPW1mKmoQ==
X-Proofpoint-ORIG-GUID: fgjAiqRAAY6hQzbhM6EtRR6QN5s5fQT7
X-Authority-Analysis: v=2.4 cv=CYI4Irrl c=1 sm=1 tr=0 ts=6a6ca0e7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=It08kXP3PLQ7WbTW8E4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310101

On 7/29/2026 6:02 PM, Christian Loehle wrote:
> cppc_get_perf() has one in-tree caller, cppc_cpufreq_get_cpu_data().
> It uses the function to preserve existing controls before writing them, but
> overwrites desired_perf with highest_perf before the first cppc_set_perf().
> Consequently, the current Desired Performance value is not consumed.
> 
> Remove the Desired Performance read from this aggregate getter and
> document that the field is returned as zero.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 210988d57b71..8ce2033ba993 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1828,22 +1828,22 @@ int cppc_set_enable(int cpu, bool enable)
>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>   
>   /**
> - * cppc_get_perf - Get a CPU's performance controls.
> + * cppc_get_perf - Get a CPU's readable performance controls.

Small nit: is this also applicable to ACPI <6.6?

>    * @cpu: CPU for which to get performance controls.
>    * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>    *
> + * Desired Performance is not read and is returned as 0.

Likewise.

> + *
>    * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>    */
>   int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> -	struct cpc_register_resource *desired_perf_reg,
> -				     *min_perf_reg, *max_perf_reg,
> +	struct cpc_register_resource *min_perf_reg, *max_perf_reg,
>   				     *energy_perf_reg, *auto_sel_reg;
> -	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
> +	u64 min = 0, max = 0, energy_perf = 0, auto_sel = 0;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
> -	bool read_desired_perf = cppc_desired_perf_readable();
>   	int ret = 0, regs_in_pcc = 0;
>   
>   	if (!cpc_desc) {
> @@ -1856,16 +1856,14 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   		return -EINVAL;
>   	}
>   
> -	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>   	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>   	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>   	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>   	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   
>   	/* Are any of the regs PCC ?*/
> -	if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
> -	    CPC_IN_PCC(min_perf_reg) ||
> -	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
> +	if (CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg) ||
> +	    CPC_IN_PCC(energy_perf_reg) ||
>   	    CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
>   			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> @@ -1896,12 +1894,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	}
>   	perf_ctrls->min_perf = min;
>   
> -	if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
> -		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
> -		if (ret)
> -			goto out_err;
> -	}
> -	perf_ctrls->desired_perf = desired_perf;
> +	perf_ctrls->desired_perf = 0;
>   
>   	if (CPC_SUPPORTED(energy_perf_reg)) {
>   		ret = cpc_read(cpu, energy_perf_reg, &energy_perf);

This is an exported API, I'm not sure whether this would break any out
of-tree users, but I don't think compatibility concerns for out-of-tree
users should weigh heavily in this case.

Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

-- 
Thx and BRs,
Zhongqiu Han
