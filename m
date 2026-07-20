Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D83CF682
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536015; cv=none; b=eB4Ihto9ReP72QtR4joDIHd42MYTiPbJurgtDFobE/FFZbwGKV29JNzm8mrKBdq1x+3jcdeW+Mjd4odRj9xzlHBpwGe+eww01G7oHSi0/cQGAL2MoviqHnSzktopHL6Gf6chYW2ZiHHtB3uX824AZc5etWGZNCzF8lrapYbcogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536015; c=relaxed/simple;
	bh=8eypG5MHylE2ZO061/ncPJSrHHenF8L8urfnW57rV1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haMtAFtS6IV83zPM6mI0lxa6NLkeGsCugZVs4ZxkkrtKLk7dhEr0khrkz0VG6kFlOwcdTQ7CkrGg1jYvRDJqVLlwEjlqXZt0KPRvG6GRPlzvbD+qxqqUC61Zmmro0lblnARduVVredyyBU/387UiPpUFbvLi28mJWNXUAEmwzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAGBBbyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hpm+CmdD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAGBBbyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpm+CmdD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rg6j2979977
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uvO1aPOrH9qcru1lsSePrBwTtIjIpNV09myyzyzygPE=; b=pAGBBbywxeysVlas
	GFmdusuG73KvhYxviYX8Z5wyW6s9hRSYaAmg9LiOf92Ov0OqqdsO02WGw3PchPpU
	TpY6T3XzFewSZlvxAq8PpKvp577u9Ncu6+b4d0zwE91w+3xgWe/hLeER0EOe9CnY
	OWQnaVVxKq+gKf+QFdHztSTmDZJ+P6ROMcWpMrc1KBTKB5Y5WO0WqhXn6pv997rb
	F1pZ07DCIV5Is/khy8VVDAtToYrdtD2/wZlH0CkrXBV96UeLhaoYGM8fyPBGIa7/
	gMj4/lKJYwsUXbtGRJvPmPhOVgTrDl8LTYCMqrntb4u3Mzhf4zygTVHdVuczbSAi
	dBbZfg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg03yg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:26:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37f5ea6097cso1412128a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784536013; x=1785140813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvO1aPOrH9qcru1lsSePrBwTtIjIpNV09myyzyzygPE=;
        b=hpm+CmdDaPhMd2oR3TMaWj9pxn5bTarfxcQ2q1WPZSuBnRjxPQQA6WwYygPEVEn/mM
         khIwIQVJSggSwWy41sc558Hg06leovZIO7EkTJJ8X6JgSvYV0UhTxG8AdAGYMS19H3CE
         BGZ2k0HxeqYrJRO1AzgBW2K8/p37Jgzxres9h21vBWr0ylOIM/hcQO49jp4Jq0+15NUm
         iWrAflJSJWJKV/2qHlEC5OellSj2SNY6oj75dem27kq3A6Tqf8+z6zlEumnJaSVZBYbj
         gQtFEfi0Obmz/CN5XX11d+KS8YSIRRC28DSwpfHEOonQaZUUSsoPSNjuXerj2E+lrDjP
         +PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536013; x=1785140813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvO1aPOrH9qcru1lsSePrBwTtIjIpNV09myyzyzygPE=;
        b=nRCwjP54MvvTgOYDF1BuphnAdnd8Tm/8ElIPZtfxeKgVaRZ2HgbJnovYAvIa2RAqGQ
         r3X0qzWxOJ7Kf9EyjK/mVYV1SUqDEFmahlow9jWeZb/2xjxdp/HhvKUnJRD4c+cmqGgO
         yulZLGU3viE4K41C7g6VcJa3QMOPOoQTimu3ihcS1aYG0N256awZDew9IFkCacYczoDi
         AqAd18E9kgYj3ziALadXr2aMvP5dZ2nXaqbaHs8xepBeJANtV1o7a60B+X5N1Xm833DE
         S946zkBczEagJhLTcyd7bmslJLKkyu0Xemw1q/GNif8jH30XnUWL5q6I7cmJTHngNBhO
         U4uw==
X-Forwarded-Encrypted: i=1; AHgh+Rqklu1dx2j1nxktYSbSXZnLojTH+OyrLmBjnqA3XsaXQxeKpa6E0qR5e97g7A8vxlSzNcsRm1XSosAI@vger.kernel.org
X-Gm-Message-State: AOJu0YxIitbWT+SqF4RVb2Do7k6j1IUhVEB1CshRjtLxkWu9XrM5gGFD
	d0timGl+TlF8+wmxQumm1AkGyXqu/JCy5DQkSxEOZ6cBv0nEuv+N+Kupxw7HkIhkTbDj7XTiAtx
	gDlJCuSvFFyP/0s0a47UFENkcRjwVyJ04+1638xdFu0aA+TfJEuG0uiqWHsKlrcuH
X-Gm-Gg: AfdE7clhJeMKK03fM1D/cUuaKq8fVQvwPjpF7rZ9g7o6VaMMqu/RxHH1Ll3kLTYwzWA
	Nstu3aqeDEWL1g0vh4uvCCMXKHD08hun3gky+z4PITy7Eeq/wB3nfnf9klfHPfnIB3fQoG3KQcn
	nNEmZ57uNH0qeJzLZh0ac5Z0AR7366dMlCGro+RCbV5MGwZSv438QYyEh71BqopVjVFAWJVCxbP
	HRTfJYa/cFTE/4k+P+XVo1z3qnsVzFkb11eMcocnYS6gc3fZXepyKpqIOzTYveOV3gcimvQbFwa
	Rs/uwjewxFH7rHDj90whe5dgBb6gk4tvBhoJ8kJMOw3uFVWtDfQUFBlyDlMZJTOupdd3/BTbfhW
	tOXbu+SzQQ9HQMW5FkgS8MJAdvTwtZQ==
X-Received: by 2002:a17:90b:a48:b0:38e:6a7c:abbc with SMTP id 98e67ed59e1d1-38e6a7cacfbmr3818806a91.3.1784536012805;
        Mon, 20 Jul 2026 01:26:52 -0700 (PDT)
X-Received: by 2002:a17:90b:a48:b0:38e:6a7c:abbc with SMTP id 98e67ed59e1d1-38e6a7cacfbmr3818774a91.3.1784536012350;
        Mon, 20 Jul 2026 01:26:52 -0700 (PDT)
Received: from [10.92.208.175] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9c5fsm5437015a91.10.2026.07.20.01.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 01:26:51 -0700 (PDT)
Message-ID: <89f07e36-ac7e-4895-8d2f-5c509c6eabdb@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 13:56:44 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
To: Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@alien8.de>
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, zhuo.song@linux.alibaba.com,
        oliver.yang@linux.alibaba.com, James Morse <james.morse@arm.com>,
        Rob Herring <robh@kernel.org>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
 <20260708024131.GCak242z-9YE2xL6q0@fat_crate.local>
 <ak6HPmosSUleJFYU@arm.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <ak6HPmosSUleJFYU@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX+F49RIeCbGme
 fBbFZoNy6PAIKfQ6AidLlSb7KMMn+gYD0ZPLOF7DI8coO4pIet78pGZ9hbB9kLaYt8gO6/cUl0/
 cyv9Ozc9k5HomMTvAmQCOofcrfH/24g=
X-Proofpoint-GUID: 852bScEuc-Ods8LvSDLl5bTuQDRGGmv4
X-Proofpoint-ORIG-GUID: 852bScEuc-Ods8LvSDLl5bTuQDRGGmv4
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5ddbcd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jnGYlY96OlQ6c1eOmxQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX1HvEu2/9LJ5P
 //zzFhCL3KSnrW223qKsN50yIUEDtJPaB5J0yXZvOVTad18pMFZXTMT0bgKUAryHlBuObHyXJ4W
 huU2Lup4OCmZZE0w2fuiySCvHP6mjGnv96Y+W6ZlIDLy0Pi1WCQ7Iheglmy2zVu+tV9nDfrXmcL
 egfCGUymKmxfCB2YJCqZZX8oePHDsOwEDHfeSxQcniARZrh5T0Vx10KJezQHaZNux5J+Kt9nzNx
 GN75W3CA/sc5CVyUlwEYuKW8E/iBMvZ5cEH/cpSqUBut5oA0JDitRoLXKEKqYqu1ypCu5u57en9
 qiofW0L75m6tKAH1Q5BmoCOUIMZoXdDhvt22tI9XCbaZEVN8LLdVBUVqXQgFsSZpbbLP/i7r/ji
 EMmk4nXjMQ/0NgRKa4qR8X5czcF4uTjaP+1+xNJNnbqPnU76D60rrCTi9/zaew5Ar2A3ni7e67y
 VklYsaUD+0rKPLCwfsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200092

Hello All/Catalin,

On 7/8/2026 10:52 PM, Catalin Marinas wrote:
> On Tue, Jul 07, 2026 at 07:41:31PM -0700, Borislav Petkov wrote:
>> On Tue, Jun 02, 2026 at 03:15:23PM +0800, Ruidong Tian wrote:
>>>  Documentation/ABI/testing/debugfs-arm64-ras |   87 ++
>>>  MAINTAINERS                                 |   11 +
>>>  arch/arm64/include/asm/ras.h                |   99 ++
>>>  drivers/acpi/arm64/Kconfig                  |   10 +
>>>  drivers/acpi/arm64/Makefile                 |    1 +
>>>  drivers/acpi/arm64/aest.c                   |  423 ++++++++
>>>  drivers/ras/Kconfig                         |    1 +
>>>  drivers/ras/Makefile                        |    1 +
>>>  drivers/ras/arm64/Kconfig                   |   16 +
>>>  drivers/ras/arm64/Makefile                  |    9 +
>>>  drivers/ras/arm64/ras-cmn.c                 |  479 +++++++++
>>>  drivers/ras/arm64/ras-core.c                | 1026 +++++++++++++++++++
>>>  drivers/ras/arm64/ras-inject.c              |  130 +++
>>>  drivers/ras/arm64/ras-storm.c               |  198 ++++
>>>  drivers/ras/arm64/ras-sysfs.c               |  319 ++++++
>>>  drivers/ras/arm64/ras.h                     |  374 +++++++
>>>  drivers/ras/debugfs.c                       |    3 +-
>>>  drivers/ras/ras.c                           |    3 +
>>>  include/linux/acpi_aest.h                   |   36 +
>>>  include/linux/cpuhotplug.h                  |    1 +
>>>  include/linux/ras.h                         |   10 +
>>>  include/ras/ras_event.h                     |   79 ++
>>>  22 files changed, 3315 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/ABI/testing/debugfs-arm64-ras
>>>  create mode 100644 arch/arm64/include/asm/ras.h
>>>  create mode 100644 drivers/acpi/arm64/aest.c
>>>  create mode 100644 drivers/ras/arm64/Kconfig
>>>  create mode 100644 drivers/ras/arm64/Makefile
>>>  create mode 100644 drivers/ras/arm64/ras-cmn.c
>>>  create mode 100644 drivers/ras/arm64/ras-core.c
>>>  create mode 100644 drivers/ras/arm64/ras-inject.c
>>>  create mode 100644 drivers/ras/arm64/ras-storm.c
>>>  create mode 100644 drivers/ras/arm64/ras-sysfs.c
> [...]
>> But that's still not that important - what is even more important is who from
>> ARM is going to review and maintain this? I can take a look at the generic
>> bits so that the RAS stuff coexists fine in drivers/ras/ but I'd need an ARM
>> person to take care of this.
>>
>> There are enough on Cc so let's see if anyone moves.
> 
> I will volunteer James Morse (he doesn't know yet) as the Arm RAS
> expert. He's away this week, hopefully can have a look when he gets
> back. For the ACPI bits, we have Lorenzo, Hanjun, Sudeep who should be
> able to review.
> 
> Adding Rob Herring as well who's been giving some feedback on the DT
> counterpart:
> 
> https://lore.kernel.org/all/20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com/
> 
> I have some vague recollection James wanting to start with something
> simpler like EDAC and do DT first but I may be wrong or things could
> have changed since. So, let's wait for James to comment.
> 

JYFI, I have v2 [1] of DT front-end support for ARM RAS.
https://lore.kernel.org/lkml/20260720081954.1858180-1-umang.chheda@oss.qualcomm.com/

Thanks,
Umang

