Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E240B11C
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089339; cv=none; b=WN/I/ytpWizRkE7RSMyT6YW2o+75xpGJHOKYTWksjINDPlmbibE3Ddt+VzCkM1eT1pzm4bv/E8W5bYPB2QisHVc6eQW8Vmlpr8ykZi+cFLkSTS2c5eiy/jRhwnzHi0P743LCTgxWgH0eyCdDINvokduWvPtE+onsQrusETqIXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089339; c=relaxed/simple;
	bh=KYDXplaztsx1U000X58CB6h3NVEyy6BQoRPvrsqVwwQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VkHWqBe4OTZagIqqcvMlfN5QPX+FxyV1+t3ZUryAmTueWnzg6y+M4XV/UEOKMiu6ErOHLf5KM81crxgoTRUtswZwX8eUZ80vE7Xfc9sHN7Dkh3JcaVbfWfUEEGHrTXxaVvOXawL2exdXpAKzJZ79OKDTgFl2CWQAUHhCf3kFRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etaI/YDC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ks6hCfez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etaI/YDC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ks6hCfez"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FI3oqo3902346
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 18:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=; b=etaI/YDCQmWknRCE
	xBv21JQs5fAsFM8O93GxtSMa/geJJelFzvr2WbS/KCzhX4uqIpeQ+CVqWniuZVQ5
	IYhvCPycG01kA85eRnTnebhtuDP2xU9SryvWZcBcjgdQ3DWQ5T3zrO7BYoIoeyrL
	fx3oPkQrZwZ0yi1iwl758SKIkiqVB0z61HRLQ/9dXf95l4zxttBZ0+brbk2AtXAF
	qV500+1sJI3MA8Ddy5tsOMPIXX+CmwQ6ASM+bNaW13TiMFiXmmubd5Qg16rZbBZf
	PO3zKahw0ypF4SMHgRuGYCDfVKLUel0RQc2GcSgLZJaaZuBFcQHhm9dcgqTyTIUf
	RFvEcg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3ser3pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 18:35:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939c30aa9a0so203723185a.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792089334; x=1792694134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=;
        b=ks6hCfezklK/Phpl8iXjsl4BMnd4Cj2QOk3ktA5VZfe7+bDA3nQJmOrnJJLY+Y1dB8
         lOOkCX1lR+7Qmnk8Xo/w3r6hYYf0y2qU90dGWcqaWZqOyeH1zQNcaCfvRNpdXcEfl+5F
         YJScdBIUGsyJU0HjRxTFMo6Tguw2bVHrP8aPddKwjum/LeHIu1LRqoW0LOKn7YFtoGQK
         +T2pHTm5qBn2oNCal8J/St9gyL/nfEPim1A5qOxkBiUfvj7oaYCFHwwdEYdkUaJUVesi
         qQ/ezFMRr7TTd9dikfK6Mv/N9rJhwMzTSIUfUBjcWHpxb66tlNOp9dn15v0QsUhtqlsH
         6wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792089334; x=1792694134;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=;
        b=V9/8rF5tQTg35wsnvtoGMdhocPjcAu8q1qV2Gh1mEU+wZea7zihtVoPECc7CybkSlk
         LNZtLZ2Fv/0DRhRz0UrnLlQR621FVGBgJrCKWhNPdXg7XAUML/bM91EX3H227gwjljWc
         gNEy2Yk42VXZbtC6MG8FfJCGYZDJfyMCVzBTJ/t24J9VvVY0h1iM+iJrsvs7vFq5G8dH
         deZSO5gDfQOq/d7O7UvICwuJdCkfV/E1khsw/9SkoqcWKcZcXOVN38aXlAsnMYGYFgg7
         lKyUUoUNEOP0Jcfjs3/xTP6gJUDBEEZVyv7MCRsf1sgetZKVIjSJ77h4KymotBw3T48c
         VVPg==
X-Forwarded-Encrypted: i=1; AKwUvBwqVEurCdpGVyJaz2rnDC/pHEIltPhj/096CPELiIPRjk8AprCLagu8ZgrgSMzYdSc2ZqYTGH97stt4@vger.kernel.org
X-Gm-Message-State: AFq9FYJEGEYf9A/CjSwYcUO9blfsMTMOud8PqWj3+gSUvbhB1An5lV0I
	teAkmXaS39jvZY9U58pF87bn9jsMtz4f+++svqXv2WYYibvRhVii3NZbwDrdgm4BmlHxr+vKs+2
	USpb0tiSbwULa9yVOt9/1yCfk0rQV+Qagb6gpN8qU1pqU3hocRgevcmWWnpmkeG2O
X-Gm-Gg: AYBFou29oByfjzfvTtfhuo2vv22Vtw26TlbO30qw5DaHe17NQOlQ9JCU1eCaSqgW1Io
	Gu2+lVEsSM/4ffLCNbTxeLhhf+AqHMm/QGyHoKbQwj+YVOnUIPIrgF3jmWH+YggOLa+32BHTydT
	tABupzNDk3edEZ+QHkXflzLcPHsLbd0P+zF7I3ZstgE/kOWxK7aHRbeCnf0htbeBd6/9KmCyRPY
	LmbPoKTwE3kp+b77GfXH0VzqcfiiAk+YFkGqyO3egKJpFBwCkDF/Q84n8zCQvYoiEr+VOKfyvuj
	p6CiJbO3Aa3JYsylBnRB56rlXTjIBz8FDDES9ZGl17mpdExhN7Qvp57RJwr/i9LWHLyvr6m8n+n
	fb3wVpZv5dAa4NcfcAKrmTn8hVjGJeZyrrPucDcuJGUbPIT9PwgAi96KbsPIpe/c1IA==
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id af79cd13be357-93ebd29a3b1mr3089708785a.64.1792089334007;
        Thu, 15 Oct 2026 11:35:34 -0700 (PDT)
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id af79cd13be357-93ebd29a3b1mr3089703385a.64.1792089333389;
        Thu, 15 Oct 2026 11:35:33 -0700 (PDT)
Received: from [192.168.1.35] (85-147-213-205.cable.dynamic.v4.ziggo.nl. [85.147.213.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3fd83464a7sm63267966b.76.2026.10.15.11.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 11:35:32 -0700 (PDT)
Message-ID: <33a935e1-1417-455c-8776-59ccd04230cb@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 20:35:29 +0200
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
 <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
 <db52af80e3d52f16a609071db79a29e012f4fcd9.camel@rong.moe>
Content-Language: en-US, nl
In-Reply-To: <db52af80e3d52f16a609071db79a29e012f4fcd9.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nFGcPytdUUqghWO5n9OkPFQ0nwvTLIY4
X-Proofpoint-GUID: nFGcPytdUUqghWO5n9OkPFQ0nwvTLIY4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NCBTYWx0ZWRfX1fEYJG/l1OW/
 vnow49xiVVPtka3c42e3GlKeMZ2j9OWdHB0icjX+/cQc0P8Vwv79FU5QowGkdLzc+nIscDNbbpb
 pfI4TmSfqq9XPjrbguKccxJ4hGitUvI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NCBTYWx0ZWRfXx8RNBqYujODu
 M6Gq7SNcbC+IsVFc5Zyxzyn0UZrpebQl+dZRL9lnIJCyTLvsFoTMphyjlrGhn6kEwxkvwhXa1mf
 8gTQsT27plkACtA2W2I+KKL263pUV1h92osm8G3IA/IBE7IlVrcjGIfFPmRjCEwVOVJVUX5AWGA
 jdR0fz+6oh/JDfpFik7h6lEpE5sCOEiS7S/HNLkSvNQafEM3izZgnk2qIYcuae4Guya7wdhkljg
 XSowguyzwU4VFUOL2LU+XFpSpZzwcqSEqaHs8BoL26IenpqTOQf9Hhm7rAB9X4hXqpB9DYc0caE
 f7TBkTuvnawIcXEiuMKBHQs3Bxs2Bb3fI4SRoeaneuwM/fze/F1U3u099fAR7PZQdwZmGMssGP7
 vHvIUK/gUCex4wePu1IVQL6A7sLJ0tMQoRIze9DKBTTnuIxFoVT3O700WebYbcJ+YbM7GASZWtP
 eC3tv2+guwpdioxzKhg==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad11cf6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Y5s2KDXI4nyRj/ULHr3D4g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Wruc98bIDj3zykDVo-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150074

Hi,

On 15-Oct-26 15:48, Rong Zhang wrote:
> Hi Hans,
> 
> On Thu, 2026-10-15 at 15:13 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 15-Oct-26 13:45, Rong Zhang wrote:
>>> Hi Ali,
>>>
>>> Thanks for working on this!
>>>
>>> The series is generally in a good shape. I just have a few minor
>>> comments.
>>>
>>> On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memiş wrote:
>>>> As discussed in [1], add exclusive variants of acpi_evaluate_object()
>>>> and acpi_evaluate_integer() and use them for the battery methods and
>>>> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>>>>
>>>> UCSI (bko221065) is not converted.  
>>>>
>>>
>>> Please leave a link to the bko bug, so that readers don't need to
>>> assemble the link themselves.
>>>
>>>> There the contention is on a
>>>
>>> After carefully auditing the ASL code again, I've just found the root
>>> cause of the mutex acquisition timeout.
>>>
>>> It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
>>> "Serialized" causes an ABBA deadlock:
>>>
>>> Thread 1 (battery)                         Thread 2 (ideapad-laptop)
>>> -----------------------------------------  ---------------------------------------
>>> serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>>> evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>>>   acquire ECMT [A]
>>>   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.RDER [B]
>>>   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RDER
>>>     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
>>>
>>> That's why merging battery notifications significantly reduced the
>>> frequency of mutex acquisition timeout.
>>>
>>>> firmware AML mutex that _Qxx EC queries also take, which a wrapper
>>>> around acpi_evaluate_object() cannot cover, and Rong's notification
>>>> merging in 7.3 already reduces it on the battery side.
>>>
>>> Lock contention is not the root cause, and EC queries and UCSI _DSM are
>>> just innocent victims of the ABBA deadlock.
>>
>> Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
>> on \_SB.PCI0.LPC0.EC0.RDER taking it (1), 
>>
> 
> I guess the intent of holding ECMT in _BIX was to prevent race conditions
> in multi-threaded interpreters. IOW, the firmware authors probably took
> multi-threaded interpreter into their consideration.
> 
>         If ((Acquire (^^PCI0.LPC0.EC0.ECMT, 0x2000) == 0x00))
>         {
>             If (((^^PCI0.LPC0.EC0.BTDV && ^^PCI0.LPC0.EC0.BTFC) && ^^PCI0.LPC0.EC0.BTDC))
>             {
>                 BPK1 [0x01] = 0x00
>                 Local0 = ^^PCI0.LPC0.EC0.BTDC /* \_SB_.PCI0.LPC0.EC0_.BTDC */
>                 Local0 *= 0x0A
>                 BPK1 [0x02] = Local0
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 BPK1 [0x03] = Local0
>                 BPK1 [0x05] = ^^PCI0.LPC0.EC0.BTDV /* \_SB_.PCI0.LPC0.EC0_.BTDV */
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 Local0 *= 0x0A
>                 Divide (Local0, 0x64, Local1, Local2)
>                 BPK1 [0x06] = Local2
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 Local0 *= 0x02
>                 Divide (Local0, 0x64, Local1, Local2)
>                 BPK1 [0x07] = Local2
>                 BPK1 [0x08] = ^^PCI0.LPC0.EC0.BTCC /* \_SB_.PCI0.LPC0.EC0_.BTCC */
>                 BPK1 [0x09] = 0x251C
>             }
> 
>             BPK1 [0x10] = ToString (^^PCI0.LPC0.EC0.RDIF (0x01), Ones)
>             ToDecimalString (^^PCI0.LPC0.EC0.BTSN, Local0)
>             BPK1 [0x11] = ToBuffer (Local0)
>             BPK1 [0x12] = ToString (^^PCI0.LPC0.EC0.RDIF (0x02), Ones)
>             BPK1 [0x13] = ToString (^^PCI0.LPC0.EC0.RDIF (0x03), Ones)
>             Release (^^PCI0.LPC0.EC0.ECMT)
>         }
> 
>> this means that not just
>> the ideapad-laptop GBMD method call but anything calling
>> \_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
>> Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?
> 
> I checked all code paths with ECMT involved, and concluded a call graph
> with all faulty methods:
> 
>                       ideapad-laptop
>                             |
>                             v
>    battery                 GBMD
>      |                      |
>      v                      v
>    _BIX -> ECMT -> RDIF -> RDER -> ECMT
>                     ^       ^
>                     |       |
>     +---------------+-------+
>     |
>    GSBI -> ECMT -> SMTE/SMTF -> ECMT
> 
> GSBI: \_SB.PCI0.LPC0.EC0.VPC0.GSBI
> SMTE: \_SB.PCI0.LPC0.EC0.VPC0.SMTE
> SMTF: \_SB.PCI0.LPC0.EC0.VPC0.SMTF
> 
> All methods in the graph are never called by any method or driver that is
> not in the graph.
> 
> So battery and ideapad-laptop are the only drivers that could potentially
> trigger the ABBA deadlock.

Great, thank you for checking this.

Given the above I agree with Rafael to drop the EC query and UCSI
patches for the time being.

Regards,

Hans


