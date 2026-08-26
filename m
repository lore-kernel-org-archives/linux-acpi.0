Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A5456DED
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766220; cv=none; b=i9IfZ1PCcqpxwoJEElKSGu04OVkghFFOIO6PglOn2C2BVNrRZ5un56W6KTgitZG5jaRpRITTd7xk3RofoXY/2yvsC4NUeQXFjw65YAi9BVB5sGtdZrILtMzXgdsGSaakAZXGwcSnZCVgjnmfnaf7MHxWQ++ePIMPfG2PukksMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766220; c=relaxed/simple;
	bh=IJjJiCRnhG9LWaiQ1b0uPd4CBAmpxMSnp4hk/d5wU3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da38MR8ls0psYndrX1+ibKhQC3gdXAUHBti5Hs8DS+4mPMnf9zAeOsstUCOd0PxMbjvVKYZfZnWqMZnn06Zf/3PdSXmAz9bkqMggoqfJKQWy2Nc076TYuikjeXQPw20LyAhix6HvOrq6uE0/LX7EvWsElK3Bp4VKY8iXaZQexOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5+v/VQa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GN/f2Wk6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5+v/VQa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GN/f2Wk6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHLxgd1044124
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V9WI5J1uTR3UjfvxVm6sCyRfn9y1gV4JDAQn1epUkk=; b=B5+v/VQaiHiUGVJ/
	D9meusciCNg/PXztul72dxRaxJjdanPJWyaEFkPs3HEDqjVXSyP/EF8i3JdQ9ky/
	o5Ir5fHG8V4LU3bWIg6BjkAuSxsmMfE7fdF3O+qeusAySK5qtCRmFwwbY5gLpjt9
	0pO2uZB6pebRArB0QWhDNUBKufR2qPCl1n41l7NBFKc9ZBpkkcvoRwW77fCme7gQ
	fFEtJK4cfRhc8Go3j6f46GaQxJb/xRbl6Oz20vQ9b8659/ijfdcsToBlVTrWqAq3
	SABRTl6f5pxQ8SrJHHiLrIzbNHSy8F9ik3HGMsGw1TpIDBMXAVQTImanKg0Z8ix5
	QmqJnw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwg2xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:43:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1848536a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787766208; x=1788371008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6V9WI5J1uTR3UjfvxVm6sCyRfn9y1gV4JDAQn1epUkk=;
        b=GN/f2Wk6E5yJaaBZWCJgtGVa5jUlk9Rep/ONKXqh7uzZLcbelCpVMC1KSTiWf3mT1d
         GWpiBMC96UNgu4XoJuU4lMHWzFfg+jhGWIULAvzoT0qXEbzjiik1wYy5blP2BduU/XDu
         7Fr8nLxQRs5Jf94oVW7ty3qMI62MmVYPkutTCFAokYBp7B+ND/xuzDouhaxObcLUQLF0
         L70QnWkYvxXwAtqfiSjQgm5R43pG6lx0OQ32+xnpLvOTYWGJUrxMlGIEXegBgxdcINJQ
         aDWTp7Zl5cwILVH/ASMkzcElMiL2XWjAan2FYxdGBOQFsrf0/gWPnQp5rEzJSavQdlIG
         k1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766208; x=1788371008;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6V9WI5J1uTR3UjfvxVm6sCyRfn9y1gV4JDAQn1epUkk=;
        b=lQlbB3uWiXbKzTvqsqb4WJXwGKCWJgBuU//MYHSnkyjGA5IBsGq926LqsMdTsZKKRa
         M17SpsPKzoaseqOr90gN1eidBvV2tt5aAZiabpoItnhzKtF78kQ73thHhrAJfdbDfC4K
         ziZTzDPqMqd8/+FToKI7zG03GGthxK0vwrgOTtV6OLOsr2GXU9b/dzgzx0Ap1SZbCPg0
         +I5WtNE/idYQay1OPt1wvefY0YdNC8vPiuTtsbg47/bDnbbSUn3xnlChNZwHeZR/lJeq
         m7Osj3hBC9EFxa219D22v0pPVEEJB4jE79a1hA7sPimCbYphgsVCcyAjhIabt9wKWdDO
         TnGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpniWLbzMnBgQgsFPBrZt3ozM8F3ud3sf4/v1sDk4dTJ7SG6SVWShb0X9CHzTry1+ditvtYOZ61XvZf@vger.kernel.org
X-Gm-Message-State: AFuF++muaGhIMGTJ6XYMMs/PilkAueCzJ2xG9VGao4bhrJSJpCAeI2oe
	fvNitpZnhdxjfclVYH3qOiFK5BrRmiRuESZx5Y60WTapTkTtkeOHa/I6hSkoyzE50CpTIcoDUr6
	wrB8JIzoAc6PdeHCZ0OMw70Bc3PKiDOob5aqb83xiykIMeNsrNAkh5azXoJ105vAN
X-Gm-Gg: AR+sD13B7DidmGw6UNOlqOx16y3XzfNXSbaivCfkF9t1GsxZfoOAMuY+kcxuANxg4vk
	1SwOrxIdUPSc040XlCPGFoWT15OPPqcj4OYTNPkV/+d6OKNDmQYItwQoiZ4u5L1TziVJEAvoPeT
	ODNMrjFH+YIhbxcKSXirGr3Vti6MgyRYNprenKRN+bw4rhMeLZew8FSwISGrdR9rhUvrWh1c0Jw
	RIxKFd/R1m4k845+C+6xwDHwNG2xbaP+OItpSFdgZa2rKA5aI8yKSxnFbEKW13VFAIJCFZ5TXfb
	6syYiMjiBuDouBN0n1NjR9lEEDIfZcegSys51opOYdXF/47idVFVpbAUT6UMYu0GcSx1vzM/tvX
	bFoCELlXyyjOFmEAKHoJfhhrFBMnQGbFf/VM5qITy2qV5RU0ujvZSGfLAZ5+RnioS7BkeIAFfwU
	D3SHSpoyR9HvhVOrStFw==
X-Received: by 2002:a17:90b:5544:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-3966d403489mr18578267a91.11.1787766208179;
        Wed, 26 Aug 2026 10:43:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5544:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-3966d403489mr18578189a91.11.1787766207732;
        Wed, 26 Aug 2026 10:43:27 -0700 (PDT)
Received: from [10.50.45.102] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm8950241a91.9.2026.08.26.10.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:43:26 -0700 (PDT)
Message-ID: <913fd0bb-6257-48f8-9f04-7df3d44c201e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 23:13:18 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/12] arm_mpam: detect and enable MPAM-Fb PCC support
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
        Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-13-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260807105451.3728284-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2Su3RwbC5aKY-36cku0ptqCz1TwomuyY
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f25c1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=3NjWhugmwSPu7QgOpREA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 2Su3RwbC5aKY-36cku0ptqCz1TwomuyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX9sWC8zmY9iZl
 hG+x4rdkzbAe375d6swrvtjzIDS6m1d2Z+XfEjFDK3ahJWjElLc63aK33fgiajcwhFqOS3aA9Zk
 jbnuTVj1tRC4ugSJmggQgnnjTsFxkO9IPq/GMNR7K8M0OMF+zd5JJ5ryCGxsiMp0CuCncNeMvR0
 d3NJI08rWlHPqtBgS+UU/EIfrM6ub42FDi2qp6cxBmQGt39pbKjeoxuesuRQqIF8hPwT5e4HNth
 702XwmqUUfh3K6u2m61U/YXbm8jgrhRgWV0xJiWMZurG1LY103JI9qk5GoLslt6uaaW6Ljlqy5b
 8Tu+g/IXga/1bqlURysi63w0kIuWwPNipqYXb0QgVea+5Q/+cymwedYuIYgB+K8YT6MujtulS0o
 1oG1HuiFjtM+gK6YxYzahMxMTgyn2itUtYJjFZvw66YAa0vfrLNhrRImQnk+BJviiAO3gOiL4L8
 JWaKVPD8w75MORG7iDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX8JOQ1v/ZfOV3
 8mLb2do9TaYmFog7ornuCXGX4GpIGCYTeRYRKRtE1uMBxRARapOJRaFYkuDoD9hhL8jnF5bcBeD
 9/GifAhKtrxvRMQOqjnw6ntf5oTiKOU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260148



On 8/7/2026 4:24 PM, Andre Przywara wrote:
> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> registers through a firmware interface. This requires a shared memory
> region to hold the message, and a mailbox to trigger the access.
> For ACPI this is wrapped as a PCC channel, described using existing
> ACPI abstractions.
> 
> Add code to parse those PCC table descriptions associated with an MSC,
> and store the parsed information in the MSC struct.
> There can be multiple PCC channels, and each channel can serve multiple
> MSCs, so we need to keep track of the channel usage, using a list and
> a refcount.
> 
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 112 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
>   drivers/resctrl/mpam_internal.h |   2 +
>   3 files changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 4b1382fce2be..4d3f13044b43 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>

