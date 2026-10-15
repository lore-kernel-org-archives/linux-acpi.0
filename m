Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713C3EAC75
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069997; cv=none; b=jHvQeNcPn2oIPEnbkqOEgcrgPGP2jSRBBC0tldYmPfX0CxzzvDp8E15kHb7ws60M+coXxohIYEABEdzVpvJbfABvKqhNvHki/OzZI++QMS79FXiL1LBN00k9aX8N9m20uWoX1l/+PH4ZmiszEiFj+PMyekSPSHwkUNZ+jJ++2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069997; c=relaxed/simple;
	bh=qhwosOUFEn40xQ8xFJW/TeqPHN2EC2c9BkQeLwTb0ac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVvyvqVqJalVFS4tVVwf6McomT61CQ2Nx9wsBgLKEXqb1KTmiourcJ30PloM+jOwZyh/SdI/9YsVbZEt0+fLTP9wPRLjEKa4D/KQk8micEZBesqHyxRtEwq3aBUtm4zwcIREdjrifCfQ6Nmg+dv0aWDXXOlDSkYmUbAqi1gybmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrbgjqHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZNZr7dO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrbgjqHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZNZr7dO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jScd2809286
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=; b=nrbgjqHy43VPixes
	GMy+iRjepgiRo8XgnGN5CqmL+kk3Xhq501X/tx1YTUhmuyWQtxOhxRnbKveBM8vk
	Qrypbr3eC7ILnQFKoexVYXVEFjyaQLOqFOD5QjVpqYLB3efdmnyrNOWOD1x5CG7n
	BkGV1G1kPvytGjmSFyD4q9UCA5duKoioRjUJY/qfljoOLkSL1ScCUAPLOngqKIzG
	IqzR32sQDvxrUbGKWzpN+u2wBD5gU6+FbXt0UUZSZLxdHcOWUCFZ6/i0bXuiOGFm
	IXuLo0ekpbxtsUDFbHjHfy/CwGpL5YAy0fFtR4S9XqVXpYrEPYGZ/QzPG31w4W4u
	zA9YuA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54tr6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:13:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ecdc701a2so197983585a.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069994; x=1792674794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=eZNZr7dOYQ2GDTlAQ20g1AXXoQ3k2bwQbplYz2L6/qls7aPY+Kh5sFzHW/CNiMGJ9K
         uLV9VCjJ/yBG/uQr87DofVh7nI/vximi/XLnRXyTC96LhxTz82sTkMBRq2s6DSxir1YH
         P3IW2cU6lh3TUSwUcdz/JagHZ5UMMwx0k6Pv19syoIijcyQq8eMmG6/xumIAQuP0dZ2z
         34jknSfHleul5M0CK35hn4eqShx3mxofAJmsOWcx9W2YWsF2tLW5hWhf7gJa3ZyeEBBE
         3MTOGU2i3ng0pTXf7nTuZPrkZgRsq79RtmNXJpZIqJ5JHUzsmsixYwHyfT27jcsosS4g
         pXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069994; x=1792674794;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=yILNKJV/vDji+15kghzdz3oo49kDrRpJvFIcLfdgoaxD5AcP4pgnULXE22wEoXo0K8
         akqO+IHAz+IY/KlRIg0+XuIqbaE4GQ9tyAuO9OdpDfLKcu4Vl3csPlwOmvy1lVL1wTpJ
         hLlF6Xg7aggqI3i2OjfsrHKxGH5n1NWNOlg8Yu+amDciWUEVsGnPrs5/A+M2XGIuXOHo
         Fz0yeyFhXKWBC1+MCVGd+39+AuU2nzoOH+CVU0dOhGn22OydX2gL9l7kUmKUKfKaKe4p
         QzgMnYkIg3WAKArMM/x7jTXx2erhkY+cSFxx/B+H65Cnod2ekKgCZDEjilSn7bDfNm5+
         wSTA==
X-Forwarded-Encrypted: i=1; AKwUvBzMo8NJd746cWLhGTT7g2jhUZ4pUDM22lmp3dpV2NwrLCZ+SIF1xLY6nNbHZ267W38nXO7QtVplWx7j@vger.kernel.org
X-Gm-Message-State: AFq9FYLjoGFaAqHxAN79vC/haklScHfMHmIv3BVCcOY25lNwPKa7O4up
	ropaToUKF2io17Zr2T87V+dyNdRmilRI7yTllx9vyldCvRsrkxFS66DrEN08aCqospAW+TH53gp
	Z78kSNTje5MjRV+bkzKlvMEv789NSqRwaQNDJo0CHb4HZIIkQngPzn3oiA4NWHzZD
X-Gm-Gg: AYBFou175vg+Mg1SsEplbrZ89Jb47mvSTlDmpwFOgUL2J4+z9qXCwyxtwKGJcp02zmV
	oe7PYZoWrty2OGhelXPIZ3OvMGYBs25GpA9gEY+h4sVWU8izIVacWcFuFqfAiVdXCIXkNF8weAH
	RVBG0TPjK9vRPKt900IWKRZGLheLBLxjeT2xNKeRODUGqoVk7mJc71DuSR7v3Lt4nDF2JfZ+faZ
	uQ4wUZBOdp12k5ukT/+Qgktp73kOi/eWs3w1mWJA3BDZBQrXlkzbWI/qrZx1PDawDTJaPmmJB49
	fCg/GL+u7VpYs3Vq6Z1TPPVQtyntpFGg4GY3XzOp2zPloqzQFlnsix7BV3lGXLAO/kTc2J6Qq1Y
	rozuj+5jdyxht15WcvIt0EzY8B7X5dFrUqMYBdxJN4xfXJQIXzd+3pQFsJwZVexkLrP3Nb7rqH5
	i185SG6Z9kf8GeqKS435BXNmzqmq5Z9hVpo61ovLYVwuu5YDMvMngFQ4PW1S03b+Kv5A==
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034316585a.55.1792069993800;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034309285a.55.1792069993247;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388cfe6sm2456350a12.28.2026.10.15.06.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:13:12 -0700 (PDT)
Message-ID: <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:13:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: Rong Zhang <i@rong.moe>,
        =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?=
 <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Content-Language: en-US, nl
In-Reply-To: <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0d16a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Qb4wfcSRRCwKSm2dVBkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX69VjEVmlLoZC
 E3TvJV1BuHwAT5pfpIN2pk9H8SIQcGobDtC23e/E7341AW+p+i0fcUxExbElfQaP9YVBq+NQpXd
 GQ600jD6siURHnYMobfGreg7U3uz4kKzrn9mlMdTTtAtJ21IHoXVn3cc5Jn8DtJqcgwGhrEK0iT
 ht13hZUqIqOGDCjjcv0fjQQIohRhawV2gSFbxHFA9RLEBzvwUc5N+YrT9blSREPCAcHRuSVcASe
 oSJQQ6OR7J1xsDp69ozl70H2of01Q20OwQ9RUQLZykB13/FZRmIo3re59iY74K4RTs0ghtOo61G
 L1IbL0ela/muOiqKWZdCowsNhFyhV9sFEV1svOmCXsr+84hDoCpgju/Rla8qinelBBzG6+cHUDk
 o0dzdXcHKLafH9jLnAjMIRlb/DT2rNwaMtLKJGd0i0E4sy4cPIMmg+IAfkSYehReBPdCuI6yZtM
 JXXGT+Bs4wA7KYNDXtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfXzl6YgyJ7VgLp
 h+ysb5HUspdyZ8OtYnmyj+yOyuPWwoUn9tFMUKD+57DUniovhGU3DPB6fBacI+KknFFjEH6wfEX
 ZIfSivxO4JeH8SKlzU1GdorGujk5ZTs=
X-Proofpoint-GUID: YNtmAr2Ug3IMwzV-ok0JI8qlFFKay6i5
X-Proofpoint-ORIG-GUID: YNtmAr2Ug3IMwzV-ok0JI8qlFFKay6i5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150052

Hi,

On 15-Oct-26 13:45, Rong Zhang wrote:
> Hi Ali,
> 
> Thanks for working on this!
> 
> The series is generally in a good shape. I just have a few minor
> comments.
> 
> On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memiş wrote:
>> As discussed in [1], add exclusive variants of acpi_evaluate_object()
>> and acpi_evaluate_integer() and use them for the battery methods and
>> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>>
>> UCSI (bko221065) is not converted.  
>>
> 
> Please leave a link to the bko bug, so that readers don't need to
> assemble the link themselves.
> 
>> There the contention is on a
> 
> After carefully auditing the ASL code again, I've just found the root
> cause of the mutex acquisition timeout.
> 
> It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
> "Serialized" causes an ABBA deadlock:
> 
> Thread 1 (battery)                         Thread 2 (ideapad-laptop)
> -----------------------------------------  ---------------------------------------
> serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC0.GBMD
> evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>   acquire ECMT [A]
>   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.RDER [B]
>   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RDER
>     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
> 
> That's why merging battery notifications significantly reduced the
> frequency of mutex acquisition timeout.
> 
>> firmware AML mutex that _Qxx EC queries also take, which a wrapper
>> around acpi_evaluate_object() cannot cover, and Rong's notification
>> merging in 7.3 already reduces it on the battery side.
> 
> Lock contention is not the root cause, and EC queries and UCSI _DSM are
> just innocent victims of the ABBA deadlock.

Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
on \_SB.PCI0.LPC0.EC0.RDER taking it (1), this means that not just
the ideapad-laptop GBMD method call but anything calling
\_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?

Regards,

Hans


1) I guess ACPI mutexes may be taken nested from the same thread



