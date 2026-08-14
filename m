Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9345A285
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705560; cv=none; b=uWQLcbR5+FNm8YkMRp8GI2oFcIEWFP/C5cdJjhAIz097poZwSDD4bJJZmDzYAfdRQgIS0/HMi/mCEwX5NJGaJY6yCWOD3IM34ZNOtnIlgDXPRmM+R9dojjmeMyuj6tYvPrxbi/ZCUR9FbXp9VXIfoF4Zk4YjbO2zGlCcC9XN+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705560; c=relaxed/simple;
	bh=lQiwtEw+WmNvc0x52h0zqnqLcKUxwahwqFQPQSJ3WaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDdNnZrcrcQPZ02TeooCm3ks1aE/97Wrd+HkCWDhIQOzoD2xbfhlqcxOBii9KyHYzaAnhBd7SsKR7dIG9lXDeXw1WAGAd3YqRAESagZDlyax8NLXenuq7SWTZLxECcYuD9BS3GDj3SdJcuBoksRkbC6vJBCUL1zjym/iNn0le2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILqFP6yl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F5AH2H9C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILqFP6yl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5AH2H9C"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbe321993039
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 11:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ia1fHRv7KxysZi8styKWTgvHgU/DCGpe4M+1Zoj2WWY=; b=ILqFP6ylJr7VzIbT
	tSkA0buIgwtlKF/80Goe/TbopBfSp7EOXM0DN8fyuE6oc6h0CwK2LXW3yU6u/zAZ
	AKm6YTQfVvqJbENLGKQa7Acay2XZUPKi2/Qs4fUPAzIIMCYRzdE49iM58MU1Yg6Q
	XsdXoBImxWT+K4Dy9aJA4Ca4BCqsfAfhkSgQVb0UIEPKBF+F+mrKg7q1+mgXQSGe
	4Gq9O9zQem4A61tneWNlHEl3m/HaoclHBqrF8iq+E95EeKMryv1Fc08LPUqqHIS5
	r4oDRTbJbhJHn5pj2HQpNX1K/s6yp1SfrJGzOb8XTK5Do5H5Gp8NVn+cuYVnGr9o
	9exrng==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1nugtnxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 11:05:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbeaf07a7f1so118548a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786705551; x=1787310351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ia1fHRv7KxysZi8styKWTgvHgU/DCGpe4M+1Zoj2WWY=;
        b=F5AH2H9CTmu4qD6iyRZu/U8SMMEX/dFrAsG+HW9nLaCmebhUW2PTfzVyjUD3T4Vch+
         twKAsAlWUUZnMOYgJOJ2oXaxKkRBvaL0+clFLqRWmXzKSCH+sYptsbQoC1z12YzGofPO
         ByzBu7f3A3oHnxPx6GK8IzcfWKXuWjRmRSjhANbG+RX3pflWx0PNV1mo0Fyke1bhOaoT
         LaR62Qz4wENFC3w2UinLVbVTwHaIs5S6Q2lwpnvYUto3EaV6OqGYZKU8YnDYKbnfzSW6
         XKlK/jexW29eqGLiJnYCCaBbb0gLSoSf2/8lS8Za6soUti22ms3ss5eD5RH1hQSbu0yA
         SomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705551; x=1787310351;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ia1fHRv7KxysZi8styKWTgvHgU/DCGpe4M+1Zoj2WWY=;
        b=anhgpAaC0FS7WnwFkak3QW2DX0bIyvorpVirBLCK21QM6VqWxJPKumRGZGJ1C6hkxc
         fS5wSz9V58SBFnq2gdmmXCvTCIK1MGcSyI1QpU5Q+xkCckNVjTRMG8ezDZC7ltYWeJl3
         M7jyBb2uUKqaOI2qDXw7PS6tGNdHPNv1QwjrMxzgI0oG+3FBOO+21Wmazb7WzTjOM4+q
         xMveRl7rq/AclpChpOp7Jwii926TzvbjMegawNvID0LpL1a68PwD6MV/zEG0zkbRWqmf
         NWpJZJUKxIhxrDbiN/xiFiVVec+CBpiMGqAsJVdO2sMvaVlX7TNZSfjuvCW+SnB7XnLm
         secw==
X-Forwarded-Encrypted: i=1; AHgh+RoThWVJq6U1ISsNZNYl89Y8bMl2RaCxXBzObBKBHZxqjFOq5nf4KzJ8PcVM5Zv2jntXuFOn1EMZhdBH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXGx/bUvUeI99FbWWfUi2PdmzxAE/3mNmUxKNihXJko6Gkd0N
	Z48xEzVI9lZbhOAPr/JsYxp/17iy2b8QZBmEccaliZqAnBEVLeCND3HptnW+OEYp1xBTuKlF9FP
	BVf5u4L7vML6DQgnNvAx62Uj5I4GjLFZeUQyuSGlYeWHlTb4AyTzqks1/+OY2OwF4
X-Gm-Gg: AR+sD113FjzuR8PZrJ2ZVZamrSYntO+CdzeMcPMgUr+BJd9gOmV1FKYa8YNQLpqAuna
	vKDSWBQEKtPA10fn3Xl5qAvkzerLHDvBDdrUkAdksZbFwF3S5gJXlNZJc92phwNIVvdthivvdnD
	ugM0dhbOlfJc0hjne2VqMKj2fFTcRx+Ys/P+lT2sU4zdM0tcGWRxPdXqoDQNEzxWvgxxTURYWj0
	E31p/dQkSPPXyPAcyAo1cmESnWcKx+mLCxJIk9n/xknXwz0sB98Xsnrz4V3aoTyeZtE9rlzdpS7
	H0KgdqUKWqZqslwwPGfV2orXSKinCsET4UhEcHPls/rjmN4moCbUmf4zUWpqcKvjOXZvIMSWXXe
	qkXDDz1cCd5pHRmDUKO0YGaxBBOla5A==
X-Received: by 2002:aa7:8681:0:b0:850:a86b:6ce1 with SMTP id d2e1a72fcca58-850a86b8ac4mr1694183b3a.0.1786705551322;
        Fri, 14 Aug 2026 04:05:51 -0700 (PDT)
X-Received: by 2002:aa7:8681:0:b0:850:a86b:6ce1 with SMTP id d2e1a72fcca58-850a86b8ac4mr1694141b3a.0.1786705550748;
        Fri, 14 Aug 2026 04:05:50 -0700 (PDT)
Received: from [10.92.210.190] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d01f300sm312585b3a.18.2026.08.14.04.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:05:50 -0700 (PDT)
Message-ID: <3d8101b2-558b-48e0-badd-a8e439c74dd0@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 16:35:43 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
 <f6443353-b3c5-4922-a98a-1292db381ca7@oss.qualcomm.com>
 <20260728-determined-lorikeet-from-tartarus-cf124e@quoll>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20260728-determined-lorikeet-from-tartarus-cf124e@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfXwkqt6QTvTYQf
 NzTybeAPm5LdvcV6UyPxSGxJ7oC9VKAecemqVRbZPsuflIhPQke9hdHKKGU7A01lS97psbmqd+b
 yNzMgKQdR4zoxd1eO9T9hy0dlA9S+w8UFxKki0QP583jyNGJxySe6PJdIj2WQv1ACVeGr6Ypbou
 c6Zg9jybGXpRIznQ/S2Xv+KCTmsdO6p2sDYNLBT3CWcmC3/1tOQdb1bHfh5GwqTHIDQPtfJiPCm
 4BLXXe4Ie42VXtPyrHLytCAeG8pf2Tl2/sQhrOsEzL/n721R95FsZVQSqKtSsdLCHtnpS/lGSWr
 6Zr00uTecYNUY7RddkuQouNDLXKNsCixOPSDsCfGg6SyHZaKPCZuhQnWdV+c8EZylW/P+LY9tQz
 8RjMjU8y1nlzmXi7VVarqCqAR+wW6FBZInoKKx8KPXIGTthiSfzXPCRpU/UatWvXRh3sDMtfr+n
 SiL5WisQ2PNlBoOKrxg==
X-Authority-Analysis: v=2.4 cv=drfrzVg4 c=1 sm=1 tr=0 ts=6a7ef690 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3LPT6PZN0yckniG3iNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: TpljMagGOcJxDwxhpe_5dzKQXH8nDTlX
X-Proofpoint-GUID: TpljMagGOcJxDwxhpe_5dzKQXH8nDTlX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX2FpK9uJ75wqg
 xpBTLIFtHdkYfOvK80ai7SzXScQCtZWdgg+PmtXrRie1Nu17uZeQMKUcismJIt+7oMtWq3/fCYw
 7wY0O+rIkfMSs2NKgD8xNwmAw/Zid1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140083

Hello Krzysztof, Trilok,

On 7/28/2026 2:17 PM, Krzysztof Kozlowski wrote:
> On Mon, Jul 27, 2026 at 01:51:08PM -0700, Trilok Soni wrote:
>> On 7/20/2026 1:19 AM, Umang Chheda wrote:
>>> new file mode 100644
>>> index 000000000000..c2f4e1f8243e
>>> --- /dev/null
>>> +++ b/include/dt-bindings/arm/arm-ras.h
>>> @@ -0,0 +1,11 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +
>>> +#ifndef _DT_BINDINGS_ARM_RAS_H
>>> +#define _DT_BINDINGS_ARM_RAS_H
>>> +
>>> +/* arm,group-format - error record group register window page size */
>>> +#define ARM_RAS_GROUP_4K		0	/* 4 KiB,  1 ERRGSR  */
>>> +#define ARM_RAS_GROUP_16K		1	/* 16 KiB, 4 ERRGSRs */
>>> +#define ARM_RAS_GROUP_64K		2	/* 64 KiB, 14 ERRGSRs */
>>
>> Do you want me to have different DT for 4k and 16k and 64k? This is not a right approach. 
>>
> 
> Is this page size or register window page size? If the latter, why would
> device registers be a binding?

Thanks for the review. To clarify both points:

On "page size" vs "register window page size":
The comment in arm-ras.h is misleading — I will fix it. It is neither a
memory page size nor a kernel page granularity. The 4K/16K/64K values
refer to the three fixed error record group register window layouts
defined by the ARM RAS architecture specification. The naming comes from
the ARM spec itself which uses these sizes to describe the three
possible layouts of the MMIO window. I will update the comment to make
this clear.

On "why would device registers be a binding":
This is a static hardware property — it describes which of the three
fixed register layouts the hardware block implements, and it is not
self-discoverable at runtime. There is no register within the window
that encodes the layout. The driver needs it upfront to:

- Determine the correct ioremap size
- Know how many ERRGSR registers to scan
- Know the array length for arm,record-impl and arm,status-reporting

I will also fix the misleading comment in arm-ras.h from "register
window page size" to "error record group register window layout" in v3.


> 
> Best regards,
> Krzysztof
> 

Thanks,
Umang
