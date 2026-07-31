Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95297423160
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494797; cv=none; b=cnFcwbwiHIWpWVKU7huiQHElNGBF/YmkKJz3mHxsQwMexRYOaHKvLLIsKfErrJViLFchL/mV+2BIFyEjpzKg0LtzgPQjm2uGbc2GrYaGU8uuAeActMNZvTAvFbmjL+9H4kxbpKht1to6NjwMrPuLIAFj7LxjB+KJAW3bFvqLfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494797; c=relaxed/simple;
	bh=IZ2X45wy/6LrlCQkp7fWb1WsJmiS+Quwix8tlD46trA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpQ4weisdERP0DoKJ/tAQQiFf1eyKAeznZl+XhBA6hE4kPnEdT469K2Ol+WSdSQ+GTp01wWsTAkp2SzME7dr0jaisdiIq9p0M/2+d63XvCwV0mYBuEimn5LQaQp3WTy66hFLmcIGMil6oQl21NsDuRdM4Bt2S2SEXCmUaEbaWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uo83vnaO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alq9iov8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uo83vnaO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alq9iov8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VACEvO3992383
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 10:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KDhExrHeIFWZX2/YvP+j3GkI4e9jjJH2h27LucJDBtI=; b=Uo83vnaOlb53JtZi
	Llam4mNHZlA83RC+gnjzJaoUiy1kaNr4eLeEoQHP68eJS0vyW51JtGbNX3Rxy7yC
	wHnwFo6ZzchPRC1Vo9iQQFTtjp5BnA03OasTHBStMyWzDaezxqbPNpo389xMwZHY
	lg9x4zPwWSkZ6lVVvcATZRE+0dSyzjUOTKxCs+F8wzjcHSuxq0bO+bC4VGzJHhaM
	T2sTCCP5eAq9250xUPVQZ8bkpIktrvlG3II+HfVPZih+J3UKpKEMULItAEqLak07
	EJnt/rvLpOUddgtgpffjbL0afuojuo+x1T+Z9rmOjVXQyIVm96X4dgrsTuVM5j41
	sIBIIQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsgv85ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 10:46:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacf17c7e0so10539265ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494782; x=1786099582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDhExrHeIFWZX2/YvP+j3GkI4e9jjJH2h27LucJDBtI=;
        b=alq9iov8lUeWlBB+C720PEFZElzUdp4Ng9c0mxJcJI8iQfzPgwVZ57uJYdyiHWNKvf
         zWd6eXHZ1QUv/ZahYmHAJoIYSgVN8iO6VjZtSucqAzxCes2Sbp0ag1O6IO2MyAWecdWw
         nybrwdA23DYBBuRlsn/56NWRkhe7Y+KYtlBUAt9OdvPnYSofuk+RjIfr+m/skZ63l6H+
         Q7F+uYgI28FsWa7NpVAghz6/gzCVp3VFIMHQvprpiEBwkRJ4hsDobZI/oxgbFAnDq1VZ
         /bCVKoDKb2TyEgkxy0d0pcJN8RwIe2Za4T5BSxhPtz11o21BfpNUn+rASYjl7r7rTvfw
         7rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494782; x=1786099582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDhExrHeIFWZX2/YvP+j3GkI4e9jjJH2h27LucJDBtI=;
        b=Jo6cZakJ1M9kkJuoFL0it4HlChZlPWLnEI04jmi6WBpccVFXhj99B+vboGaJW5ypO9
         5TfTvMc9SnXjQZG+XLcGK5mdVXRB86GmJKTHY7ui6mSd+q1q1Pt2p9p8XZpaOCPcFdKJ
         QvXdhlFhyR6VPnauOrpKlw07+GtmX/nGpTDri/M+TlWVLsCD/sYLCOUvaGNF5tGSOMsH
         cEhHpJk5PcFMx1hdJFtUFmLvysZ1acbJie3um1f+D17KjvSDRraKopZGOw89C2cWtb5T
         7IUesOnYcTobOytIOS3g/42j+ZC3K8SFHIk5o03pT7VC6amY+4hsdM3cYHkyvqmz24IR
         Vf8w==
X-Forwarded-Encrypted: i=1; AHgh+RrvURIcAPZq3rRGhg3WSh5WWoHGM/LnHtnUZ0eKMud2dssiCa4WdoBZA7aKAFyZ77VCN7cSXaQw8l80@vger.kernel.org
X-Gm-Message-State: AOJu0YxbV4T6klR2jDVBOoCTFAiN2IvGsD6d7K2V00aMuXCMRCLnhiB4
	l2Z5aWkGJONBgbRnQwA5OWC+vZHIPFecoPyI0Btxbw8KO5F3MX47sME9DD+n7GawfPUbXJx74Bt
	x2Dx9pCaK4ID1RoN1fcnb+Rsmlyg8+tWbTMyfFf7uq7NIIm3ImZiEKbvZCfPcsaDm
X-Gm-Gg: AR+sD11xBtG9vY+wJXcA7GabimSHRj8CuchXw4nEBWnLFQZXcocsoLG302ofPm90d7M
	bc/FlWOC0hllOeUQBvVFX2dFVUJjZzq5DBqJE7aM/LRehWXNJxDIRHBGP/Tx+gYnJ7BdPW9T2P6
	mvXflqIlLHqwDIhL0PPKQP6Li1FW6w0mgW1Ca2iGwOHArfTaZKBlLI5kWtPzVrB8X9bOMx3XSGL
	M/6N9cg/g2RJ4GV13jfQbNJbpTTr1KG9gdKepwrit2++zqLfq1k4WZUS3nvlelI29Dju/j//3Ib
	8NQARI+ADNzxAJlwuYhDzts8ZETyTsmXpKNr2kLpwgekmnN0G50RKRkxwyV4gyHH+TAQe6CQQAD
	Wp6IVd+SGX6dl+XAHy30ceD5wk1lEiu6urrueyAubdwRT8P2GhqADNUfVJ5/ilDhL/+Tvm0s=
X-Received: by 2002:a17:902:e888:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d046da3a52mr15287035ad.14.1785494781439;
        Fri, 31 Jul 2026 03:46:21 -0700 (PDT)
X-Received: by 2002:a17:902:e888:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d046da3a52mr15286805ad.14.1785494780869;
        Fri, 31 Jul 2026 03:46:20 -0700 (PDT)
Received: from [10.133.33.24] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae99af1sm3870155ad.33.2026.07.31.03.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 03:46:20 -0700 (PDT)
Message-ID: <5fd20dee-9091-488a-9956-ac8a0ae1d34f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 18:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
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
 <20260729100245.2628302-2-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260729100245.2628302-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 21pvTEMtRv45mygQlzRCkuU5sJkv4Puc
X-Proofpoint-ORIG-GUID: 21pvTEMtRv45mygQlzRCkuU5sJkv4Puc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4MSBTYWx0ZWRfX83VHACCM3qqY
 Xa3hvJT4lqAJcCj8DYWKqqGtxPA8g7M1osw+518d+lUg+XeyIs+YWV0P8zp2VnL7Pw83GSBX37Y
 zrHa+lN4P1XqcTAmCbA4GiNL60VIgq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4MSBTYWx0ZWRfX2n8wwMr3B8pu
 aTWcrFBos8EqI0o3+syaCI7WPyyUVDAbR2HGcmTVjW5dD7Fbt0+SFP/uyHM9/svQAMWJfeMAVxq
 wLh7Qi7sffyrZyTh+987sAbIW7nU8zBF3Lpnu7V2VP1ZhCdg8vQfsdrdIjDiQQftnloMHpPMOLX
 h+xJvn/ox9mM6WaIZaZJRdNgJcN3/0aYFDPh9Jl6wldoqQyCFmMWkKFWUzMIuC2NE4Lg7p2cs2n
 TD8V65/yUToVp1WJ3yFk+DHWhzajqBo9j0Hurwhn2leaJ3i3y4AWBCvK960978JpmCZdJtpClcf
 LWEPos3G6g0bI4UUkCD5ezQYPr3l05iIDt+wqTTduVZ7e1Wq1qTOVr5ThL268sD75xOBP0don77
 APcgzFQko7ojXAdbGDRFK82nZCdhztjr+z5ormmlmGFu8WgArDvjseGSQONPRhZCxaP3j2dnFBt
 ZZ/PFw8381+Z44+nozg==
X-Authority-Analysis: v=2.4 cv=ApfeGu9P c=1 sm=1 tr=0 ts=6a6c7cfe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=dw0t6H4-AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=2S39LSILdImzXHVMeYEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=wVJa4CU9-Z26yuRAZDil:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310081

On 7/29/2026 6:02 PM, Christian Loehle wrote:
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
> 
> The fallback was added for platforms on which Desired Performance reflects
> delivered performance. ACPI 6.6 defines the register as write-only, so
> invoking that workaround on an ACPI 6.6 or later platform would require an
> invalid register read.
> 
> Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. Its caller
> already handles an error by using the cached desired-performance value.
> When checking the FADT minor revision, mask off its upper errata-generation
> bits and compare only the specification minor version.
> 
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")

Hi Christian,
Please feel free to correct me if there is any misunderstanding.

ACPI 6.6 was released on 05/13/2025:
https://uefi.org/sites/default/files/resources/ACPI_Spec_6.6.pdf

And the fixes tag commit c47195631960 was committed on 09/29/2024.

Would this be considered an adaptation rather than a regression fix?


With the Fixes tag confirmed/fixed:
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..6e5381f8de38 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>   	return cpc_write(cpu, reg, val);
>   }
>   
> +static bool cppc_desired_perf_readable(void)
> +{
> +	u8 minor_revision = acpi_gbl_FADT.minor_revision & 0x0f;
> +
> +	return acpi_gbl_FADT.header.revision < 6 ||
> +	       (acpi_gbl_FADT.header.revision == 6 && minor_revision < 6);
> +}
> +
>   /**
>    * cppc_get_desired_perf - Get the desired performance register value.
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
> +	if (!cppc_desired_perf_readable())
> +		return -EOPNOTSUPP;
> +
>   	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);


-- 
Thx and BRs,
Zhongqiu Han
