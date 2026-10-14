Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F720526ABD
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985517; cv=none; b=ulJIFjz/pZ3PUUubGbqi+PgkC5XIi0UGxoKatMu0X3/WRYNDs+hWpUS5FM6IWGhk0ZFt9VajvuTnUK8PBoNmqT6l4Gpf4XsPqcV1wLRM7LMnssbLaIyuymdDsKXm4afb3tJZvo3lglnlrUzbyKS/xvcsjs5gq9pHtxonqZkawGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985517; c=relaxed/simple;
	bh=2eik+EK4C3BWVrmrUDhcQ5ZFi8ccW6MMSJf+dkVWE3Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iS1KKl9wg/RtLmEM7o6Am1Pm6koxOWRhcDtJDCoIMPDPeXI4PvSCx0iRGBeP6scbCdE7MmRyoZU91rZPGmM33JbeD/w0F/TdciWU8YqI6M3q58h4EUHsJEgkdW6NfBV7BaVgPJjJMWRyXAIATUXGUae5BrKP11DHiQwprUgTngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3ll0JsS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fC3A7r/k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3ll0JsS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fC3A7r/k"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBLv4n2516033
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=; b=I3ll0JsSee5/pLf+
	2iYXqQIqlF7Y7lwhqeVFo1CcwbvlO5l3Da68kuTYdockb9wNlgD/Gzl4AwJ7w7g8
	LH6W9LXMK/zhMGVLowNUNDeZH40ab6HSn301YcVDGWXJTtPlqByhl8GfpUf3J7PB
	UvFdhLF7Sr4oVHA7TnbjqEXHavDlVMfOSjyM24XdNTcmh7k03is4mWa/oiBlRYNO
	6ZpvJ+TI7QuPB2Z+C8vuTNTLXpAZhkXyFBZzrXgSKRp7iQd5z0vf5+NlkcW4XRGr
	0JtPSKLNFdI+w/99NpZz1IyIZwNQKFXYJLTDN45OdJYcCRKMlPsXrYfLs9ztYlku
	tEZYCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4709tks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:45:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so839625485a.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985514; x=1792590314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=;
        b=fC3A7r/kvLE6iohODWVYXB1/X6gnPNXDtxLLrV3lgkI78GKoOdFR/xYo7grZZ7pTcu
         zewkdt9hpyByrlISk2nhS7yHPTjs8wLe7SdiPu50JuMt/xu59QhyYg8SS75mM8tGUAL3
         lWPQO0454X9P9SZUq1kR6D3IzKIgFR1Peq1BVBiopeYhsQhDrjyhmzP6huQiPYKmzizn
         ig+C95JrYSV6uPeIuh4Oe2sCvRJA12WKwt3uU5LP/DzPUDoqkeUEnGCdFtRESJ8KK3Rx
         AdQoZuAK0mJWs6QRLugn7Zl5fu9jOsC4IdEaMAKbIOJrAu8/e8Y2y8BWMjSJGwFFGEBT
         Yo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985514; x=1792590314;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=;
        b=vW/Nx9IAx96i51dXpHFtbsxaMcPFW/pOGITYjbd9IiDQunRwtViv2FzpffKvh3uGlm
         0b7vnbaDwgCgIXx3DT/lOw8NuHj72swjwfxTPBtKVHBHtJdnxkiRuJggraHfMJe7gufY
         sJ9NVem2QW32qwe8ULtxUl94Y5Vl/CqRcfeFxeZfW7a8zwos7aO89yDg3c0IHVa7qySq
         mlumkP5gEFCBzrWDj7klpmw5381DFbsbaWqtRtCre8J/U9TIfDC/6fXMvWJWjoez/45W
         AiwOqGwkse/3cUJSX/MMaFEideArxcaLWC6Af2o3+9eU/MoSgQEil89lDGqTI3mYXYpJ
         vapw==
X-Forwarded-Encrypted: i=1; AKwUvByFR3kvb2XLg73funABmAlho5uHHnC3xjAMbY16Mf9q++M1QixpmaVQbncJMc4LkY46LM3wGMlyKVQX@vger.kernel.org
X-Gm-Message-State: AFq9FYLMsPlSESfMevkHhgU+My+6DxjdK1NiFHZTxEgpIWaMr5j+yxAT
	CHb8Kb3wqQSeqsu94PDtie0DTEUcqvZIs2AIAQLC81nZvm40leb3N3XFNt5wHBuga+IkAYSaw69
	gIdd621jQaOEuaj2AZnmWlK3t7oimL5n6T9w10RjPZbI8omqzDnnxfUV2qjKHz5up
X-Gm-Gg: AYBFou3pFrRtHqvF/kwsEqzEkSR64Ayfzt+4jPC1/YN+bur6Uz7PZKHxkKF1BXGG6O7
	sWbc+RFkOvpZSZw0IAlq6w/Iis8zIPm/fzMk3mL1ETKa4JUnZ/J+rlExxp0EdLgjXCV/XcvgKL9
	UjoMw1uyi8xhgygBJ0YTmAMwwBn4kIWcQ/iqCZDyYAWNafpz8kcYnXHrClu4fCta1ltJFvS19q9
	9ylTql6wNiAyXOEhuAkwNG2O4EWzWFGnSKQ1dDZHL6Jluphw1W3w3Y0SStmm8uPiGEtYA+KBHNo
	d3oPtiTbL0+nOYGJFY3DT9XllRz5lfztZO1fYPV7S4+W4E3wvCASvoLaWzbtyWlElC6urB0RhMr
	vp1IbdxGxSHWpkzdVZ+zZ+hW4VWUSYmgLej9RdFjbatDqVFjomjERvHOASAG3WL7HhmLR7ujSH9
	UJZeDQFzvJb/odYxyugtxfztvvde/h59DLwzfJ7+nCk2vama677t/emn3t+Tp8muQxgg==
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2514967285a.59.1791985514099;
        Wed, 14 Oct 2026 06:45:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2514960385a.59.1791985513405;
        Wed, 14 Oct 2026 06:45:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac924dsm721471166b.70.2026.10.14.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:45:12 -0700 (PDT)
Message-ID: <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014132703.93355-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX422DnGmDknk0
 YeQ8tVBj+uIFumdxgS40a3V8UBOnYylR12cHgVU9UPGJxj8Uwlu803klxQfAfINWj9hsOIaFIB3
 dabp0Gd6AuCFcvkX4XMBLf6NgnO/7M6uXTBRgFDvahNU9zjzlvG1CALnOPm2BaVS1z7TNTkOV2U
 xbiWfdtdCDgMhaHdYNtBZZO3bWZFJkZH7QS4MAIZU9zVyl5QZJa7kJvYvRLWH4EMQZDZSGjvspN
 xElsGOJ1cV62m6cagrQ5z0AOC3MXS1rvoZLKxjynNarwZJDEGRjIxhT6NXyipZVcEAlizBKjDsf
 2kWGOM+Zs5rWkNE/Vl5HkudIdXXSVYnTKK5qKx5PdPAteVequTsTplELne+EFtBsglmS3Nn3hRS
 /e13gRU77R5EetPFKHSeqohoI81FqToa1ajKFDVzWJzgtztzJ0oWJrbKNpi+SMR+Ijf8yahB+xj
 6AHOSvG1gqAfAA9C2hA==
X-Proofpoint-GUID: KbrOcfUUAgUA2mCyDsJakX66Drgfalpn
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acf876a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=jSlZZTkqHIX6knNQi3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: KbrOcfUUAgUA2mCyDsJakX66Drgfalpn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfXwXLc+JIRH0BR
 EwDrU74/I2bNApB1UrGOoEkxNDKYGETIt4WauFRvEskAbgq0hWC0ZKdwUB/W9hoN+qFLSIy1z25
 0UFDuuD7AgVixZIQWs8UyMXoOr+a1tw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140054

Hi,

On 14-Oct-26 15:26, Ali Ahmet Memiş wrote:
> As discussed in [1], add exclusive variants of acpi_evaluate_object()
> and acpi_evaluate_integer() and use them for the battery methods and
> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.

Thank you for your work on this!

> UCSI (bko221065) is not converted.  There the contention is on a
> firmware AML mutex that _Qxx EC queries also take, which a wrapper
> around acpi_evaluate_object() cannot cover, and Rong's notification
> merging in 7.3 already reduces it on the battery side.

Hmm, I wonder if we should export the lock added in patch 1/3 and
then also take that in the ACPI EC interrupt handler ?

The ACPI code already uses a threaded IRQ handler for both EC GPIO
IRQs and GPEs so sleeping in the handler should be ok.

Note this is something which can be done on top of this set. I'm just
thinking that if we're going to do this it would be nice to cover
the bko221065 UCSI case too. Rong's notification changes do not fix
the race, they just make it a bit harder to hit, but users are still
hitting it just less frequent.

Regards,

Hans





> 
> [1] https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/
> 
> Ali Ahmet Memiş (3):
>   ACPI: utils: Add exclusive AML evaluation helpers
>   ACPI: battery: Evaluate battery methods exclusively
>   thermal: intel: int340x: Evaluate _TMP exclusively
> 
>  drivers/acpi/battery.c                        | 17 +++---
>  drivers/acpi/utils.c                          | 56 +++++++++++++++++--
>  .../int340x_thermal/int340x_thermal_zone.c    |  3 +-
>  include/acpi/acpi_bus.h                       |  8 +++
>  4 files changed, 71 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

