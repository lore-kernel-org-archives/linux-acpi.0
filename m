Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF43E2AB0
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006462; cv=none; b=mv3sEScBjmwNo/TPwyNNa0E7VfUqkNJVz7Yp7usGjfAfjrf+iXtcO5lxJYRzA3xWObEqS5cabKJGrX5+FDEUNg1f1ImXAk/nijBG5Ih0TUEX9evQopyFURtYe4c8WeC5QnQZwUZlS8Op7o4gg1IhJew2KqqrUZbUMcxp+zEPVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006462; c=relaxed/simple;
	bh=P5D41TPMszDFwmi+9Thary4c+pBWFokKdkq97su8ME4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O2BTU/e7uPK9mdVZ5+Xs6XXjgXA20a1u+pa5cI8nQviFLE/LH67pQ21FOX4BfJ5XmwmzWwhJA9jf0C7VEH+Y8qFdS4L27saz9Yu7h199xBWxKl0IGb6V8poopjHUfWn5dV6esPMEFbyRAOiDqt1uJAqh+m7Ret5fO425CiwbDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZVjn/l52; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SFTNWCyE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVjn/l52";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFTNWCyE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EFMh9h1682634
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 19:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2GnhGY3RzzdOINimVNMXLyuHee2jRbACLoRlBFEYOD8=; b=ZVjn/l52ySIJASmc
	S1EmWypbbfJDMpqIrmkfqn0Sqsl0OvP2UPgJEtAlWbF/McNRVT7zZzPPXKEx2Z4a
	aRGZGkWvuRjKn/bQE2+bMANSVGd+SZuMjC/iZf1s1OyrhHTBwQQtVBF0J6c2cvwC
	xQ2+RJcI4ZLYdPgM+ZfkIlyHBkfeeP0CHh/Tc/g32GFDseTzv512vRfmUFM6EPz8
	J/8EIrrzF5rHR05UfGrKLjlz6YckSFiArBFNTqRRGsLHLEWU2bYtsTR3gomm12ok
	ttjBmTH+CPnFE9jTFMTeJ15GkgMjsb2fPbFTAcwegu8Mso3tGbMgMFGjgCJBHMeN
	ykmfUA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb00yjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 19:34:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53397338004so148407111cf.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792006460; x=1792611260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2GnhGY3RzzdOINimVNMXLyuHee2jRbACLoRlBFEYOD8=;
        b=SFTNWCyEuoiZ2Bm8+RqfNjkWFzEwGs930XLbTL7qSgOBscX/orqzOFS8QSHj5wrXrx
         lwZeQoEv5ixeqzV0th9yJpbRd0a1iUl7ecnn0+L1381VijSmZAmR/mXtsDAvuIj7EXJD
         z8ufN8nPvTdOafuR9TvlvgVbzFd4pdZ6t0YE6Y8CWA1R7h+BMVBwtolQXzLDpXlWe+cX
         WlJgQVKn3yVJ9k2bwDiMp301P6iGkW5S8Ty/a7aDRV3iiDmrV8H1LVc4qrvKe1DxDSBm
         l2+zZv9vGMcJga2+UK3ZnmU+MPX3ff5kGhRYXKnXdFVaM0Tcbsnj6GkVBRu3581CEfLv
         Tsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006460; x=1792611260;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2GnhGY3RzzdOINimVNMXLyuHee2jRbACLoRlBFEYOD8=;
        b=qm3FDcbdyjqf3E1N1l1Nu+9FLaxDRS9Y2j/fqkfwH5wUljxscyG2nziobwsgS9/Kqf
         PRzw6d3JPC96MUn8VU5RzpqB/cbqznsHdL5F+ECNpfMwDDYrp6WTUBudE00x0ipPZs8h
         dLqBusArcxj4vieqXs0CXSoDrrMnXR8cCpFh4Q6JxLRcRx9+sMytBJnB93mSrcil1ytq
         T7Lcya4EN8IgHbVc35ukS8INQkvKQUsmPHnbB9PM5oVYyD51YP1cobBcT3b3AFIBpEdx
         UC73gz/dJsP82HisfG+T3zwbbcDOkPlh59UD4dZgc6wh3zMq1tG0kFFjhXP4xdTTVks8
         qz3A==
X-Forwarded-Encrypted: i=1; AKwUvBwEKItTs99y6aNlmJ53tmMNvIz8P9r+11dZkk1aaipfOJk2/WdWqhRYL8KPcOEKCn9hcKdiosMuR98F@vger.kernel.org
X-Gm-Message-State: AFq9FYLQHp0g39wJJKTE714tFt/J+QyqIDD+MNvYP/lEt0GoiNk4g6as
	yG6TdYQvSF4COSh5heWbLO+Mtp7Hp1hrhuHBPn/CsDs4XB1BMOSy2l67/GcAXk+G9etBPAvGTwI
	qCnAELlY6gaACggnzafNitFJKCEICgX3yzQl3P1Bj+v77jyVzPVonhfcVx0gb1CDk
X-Gm-Gg: AYBFou0sGT0H4nXsZqjpjVY1LWelQh+9ilsMQ2oDk9DtrX/rFpHeE6xAuwE5kFa+rwn
	KpJL1klCq3qYP+a19KGm4n2gqPuTdrj/s87hlE7GELHDLWbbxexMllljr/RKc76eFdAwzhfD1ay
	oxDEmeJMHcKRxNdL0xbpK7wjXMPVLkT5AzF4Kyvi9FMGpwoHHtkUgFn+lOastA9ZhCIDBT/zXk1
	+XNpCHRs01L6o5nmc+JZU46uxL42NxmGG3vW+TafsNq55tGXQHMPAidjaBmsDZ3CEDPXcczyg4u
	yRbQkEbILTKmLSxpYJ3Nkhm/xpoGaxNHqTXdWCT07A/qfTXeC17vBUpKR1ZFnTDi4jY/jah2HMh
	4JxhjPiio7Z9Ldd4=
X-Received: by 2002:ac8:5cd4:0:b0:535:f3e:745d with SMTP id d75a77b69052e-5359fade2a5mr260834191cf.14.1792006459472;
        Wed, 14 Oct 2026 12:34:19 -0700 (PDT)
X-Received: by 2002:ac8:5cd4:0:b0:535:f3e:745d with SMTP id d75a77b69052e-5359fade2a5mr260833941cf.14.1792006458922;
        Wed, 14 Oct 2026 12:34:18 -0700 (PDT)
Received: from [10.100.0.2] ([187.14.53.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536128240a6sm4865511cf.26.2026.10.14.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:34:18 -0700 (PDT)
Message-ID: <35eb7d07-3b21-44fd-8055-9005cdd4bb82@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, regressions@lists.linux.dev,
        Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
 <b64b8092-93d7-4873-a55f-422b8e70cc04@oss.qualcomm.com>
 <CAJZ5v0j4xiDYBGA0LsUq4esJCzYBXjsmmXb1ZJvLcUZqDp+yuQ@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0j4xiDYBGA0LsUq4esJCzYBXjsmmXb1ZJvLcUZqDp+yuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfd93c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=nR5e2CNZUcRYUIBrilOkzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=cwUVlSfaqmp_W9nHBhMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfX0fNdlXjBl82f
 VrcQcak4gyaOYSCxz0rVOVKlqviZSQ72qOtKELVuslmhExinRt/9Dh5ddnhHQzY/EZOWQJVkAvL
 LjRo5jj0okuAS83HF77KD5hzbChsalI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfX8QT+uSkKa+D3
 DNGhFN2rm3HaHFFXsGrXFMfr07B7Uwpn2yqBTzhI1yOztWPa5AmOnIKivkpWkMRSU6pgHlezRSR
 PEsDyPFBnKXmrukgVlo9tAxgO3YLHx2UruWkbCpKSukb3/9YQlJFbLQ7KMKqbCGj6HM/kaa7X/i
 mxnblPohAUx7AJZhDInR25kDNxOURwH2oaVT5CJbRM9wQZZslC2tTeNi+K8X6Bvv+1JRbvq3rb9
 XE5LE+XOcKIOpZvcjuSYV0p8ctC62x6I7ZgEN8Rx/PmOOZUcUrdznf6wVDiDwR7XN0XhrykVSSY
 eMsFaWXzJP6qtNYMmFfLePwsYYcEp2UOn9OHplp6S/s7CcX9k2p3uiTabnXVkM+JY7TKwdEncpU
 g/8t4aDqrBksMUe78QUMywmZHjxXYx4b6NMzFIEWGEIyJUcCseKMuhdQnDrYO5Qd9abjQ8z86hP
 pA2JbpvVVZ8atpNvWvg==
X-Proofpoint-ORIG-GUID: te-Na-DXjRcPwjr9NsMK-HaBFczudhWY
X-Proofpoint-GUID: te-Na-DXjRcPwjr9NsMK-HaBFczudhWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140077

Hi,

On 14-Oct-26 17:06, Rafael J. Wysocki (Intel) wrote:
> Hi Hans,
> 
> On Wed, Oct 14, 2026 at 11:58 AM <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 13-Oct-26 19:20, Rafael J. Wysocki (Intel) wrote:
>>> Hi Hans,
>>>
>>> On Tue, Oct 13, 2026 at 3:36 PM <johannes.goede@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
>>>>> On Tue, Oct 13, 2026 at 11:33 AM <johannes.goede@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 13-Oct-26 00:46, Ali Ahmet Memiş wrote:
>>>>>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
>>>>>>> and resume them earlier"), thermal zones are resumed from dpm_complete(),
>>>>>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
>>>>>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
>>>>>>> page selector (HIID) without taking the BATM mutex used by the battery
>>>>>>> methods. ACPICA releases the interpreter lock around EC accesses
>>>>>>
>>>>>> I'm wondering if this "ACPICA releases the interpreter lock around EC
>>>>>> accesses" is not the real problem here.
>>>>>
>>>>> Yes, it most likely is.
>>>>>
>>>>> What actually happens is that ACPICA drops the interpreter lock and
>>>>> the namespace lock in several cases listed in the
>>>>> acpi_ex_exit_interpreter() documentation comment, the majority of
>>>>> which involve having to wait.
>>>>>
>>>>> The bottom line though is that the interpreter and namespace locks
>>>>> cannot be expected to be held throughout AML evaluation because it is
>>>>> not known in advance if any of the cases in question will appear.
>>>>>
>>>>>> Recently I've learned / heard
>>>>>> from a trusted source that Windows ACPI subsystem is very much single
>>>>>> threaded. So it is nice that ACPI has these mutexes and other stuff
>>>>>> to support multi-threading but as long as Windows ACPI interpreter is
>>>>>> not multi-threaded I think we may need to consider to copy Windows
>>>>>> behavior.
>>>>>
>>>>> This is also my conclusion, at least to some extent.
>>>>>
>>>>> The problem with it though is that in some cases parallel evaluation
>>>>> of AML is actually useful.  For example, say two PCI devices are
>>>>> powered up at the same time and AML waits for each of them.  The async
>>>>> suspend/resume aligns those waits to take place simultaneously instead
>>>>> of serializing them which allows some time to be saved.
>>>>>
>>>>>> So maybe the EC accesses should keep the interpreter lock locked during
>>>>>> EC accesses.
>>>>>
>>>>> The problem here is that it is hard to say in advance whether or not
>>>>> _BIX or _BST will access the EC and whether or not that will clash
>>>>> with _TMP evaluation for a seemingly unrelated thermal zone.
>>>>>
>>>>>> And even go further and maybe we need to introduce a big-acpi-lock,
>>>>>> which I guess the interpreter lock more or less is? And just serialize
>>>>>> all ACPI accesses since most ACPI tables clearly do not handle
>>>>>> multi-threaded access to ACPI methods well ?
>>>>>
>>>>> I would be inclined to do so except for device power management
>>>>> methods, that is _ON, _OFF, and _PSx, that are not the problematic
>>>>> ones, at least as far as I know.
>>>>
>>>> That sounds like a reasonable compromise which should fix both
>>>> this case as well as help with bko221065 .
>>>>
>>>>>> Another example of multi-threaded ACPI calls causing problems is:
>>>>>>
>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=221065
>>>>>
>>>>> Right.
>>>>>
>>>>> So I guess the idea would be to add locking to acpi_evaluate_object()?
>>>>
>>>> Yes that seems like a nice single point of entry to do this where
>>>> all the various helpers eventually end up.
>>>
>>> That, of course, would require updating ACPICA code and I'm not sure
>>> if doing it upstream is useful.  For example, if some hosts already
>>> use locking around acpi_evaluate_object(), this modification won't
>>> help them and it will certainly be a change in behavior.
>>>
>>> This means that we'll likely end up with a Linux-specific divergence
>>> from the upstream which can be lived with, but it won't be nice.
>>
>> Ah, I see.
>>
>>>>> An alternative might be to introduce an "exclusive" variant of
>>>>> acpi_evaluate_object() with built-in locking and use it in the cases
>>>>> that are known-problematic.
>>>>
>>>> So here we have _TMP and _BIX / _BST and in bko221065 we have
>>>> a bunch of again batteyr methods + UCSI racing. I'm afraid if
>>>> we add something like acpi_evaluate_object_exclusive() we'll end
>>>> up eventually using that almost everywhere.
>>>
>>> While I think that your concern is valid, this can be done without
>>> touching the ACPICA code at all.
>>
>> Not needing to touch ACPICA is a valid concern. So I agree lets go
>> with a wrapper for paths which we know need to be serialized for now.
>>
>> And then add that around the battery methods + _TMP + UCSI methods
>> for starters I guess ?
> 
> Yes.
> 
>> ###
>>
>> Should we also stop releasing the interpreter lock in the EC code?
> 
> Which EC code do you mean in particular?

I meant the event-handling code, but I forgot the unlock is
actually in the ACPICA core, not in the Linux code.

Anyways I think this is nicely covered by Ali's latest series:

https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/

Regards,

Hans


