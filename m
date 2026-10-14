Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A25581FC
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991814; cv=none; b=mfoKUeiSQXHC27L8bKdxB2xd2agA+FBN6+VzmGuwbu5EiN/iiRW5YSzabptHsWZFGQT3qK4U4cKPVQaO/20QFgk2VtZmm6jjScsM1ajDQu/tXXMGvp+eEz0KJa+E3nJVYd6L+GeKG6zdIz90GLDYVRGCNWLcWCGLWJ38BV/aZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991814; c=relaxed/simple;
	bh=BDhIdaDKZ9lplDbcye0C+desv6HoQGR8gmQmNwSxBNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FLiEVpXEFPjfw8rrxdqj3EtZhhMneDGRY5bvR6HQAfWG8cH6SdKo38fF30BJTIPV585i51GHgS3Ma1g3pRmORm8ggTRzBOeWduHf0T9A2MyRbfB2Rd+4hurYFlkAipPhCsmvH/2S0IbF2TJu+FYioq94yxTY/TscBYGyxMoZq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jq2VNivX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aChsYQml; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jq2VNivX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aChsYQml"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEb0Hp905391
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 15:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=; b=Jq2VNivXr3uxGVSS
	MTyjKe0JLetyBXmtG3dKPr8Mv5ytFzQ8CaYshGhBD8RUObMdL+Qfo0KWl4YGeZb8
	qBkq1npT0hLsfr8d8exMyjeKAGHJDnWfkV4UjumTHja2ozm+rRopIYU2t1r0IqS9
	Ik28zgkBqH9vO++pbHEdD1y1VfCnL0LsfmoY03OLTOrGJ1PWE30fMZGQk0qa99Lm
	FKAJI605j9r0HiRE4ewKJtWByl6/+UP+OsEPiFbtVPtYigNpCclMlerV7li6KA6h
	ejjs6Nyam98T8r/sIqDI9vUiNKWk5qYMAvN/dgSWPPKeO67vHfol0zY78YbfM0oO
	fCdBgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p29vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 15:30:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso870955485a.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791991806; x=1792596606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=aChsYQmlmMeC3Fg6gfWG4aaew297x14xX1Hh0wIxSUC3P6yjQ/CCjrhEswKrK5fEgD
         jMPYR+/ZjC5GSOt6hxrbaMoun8wRw8lVebIPKpqa9pLuzjr/IXTIy/kSq8Fzazr31rqM
         p7LJpfETqOcyfIkODATlRO6Jy9yYYr0BRZPkDBsPUMQlzLIyrdhUdDrI2pRD1guayq0e
         3z77xhC3lpy1zicUaUAPcO8SNFz7WddZMhvOuZFeqouHfvQyBNOLnYsAhohPdu2d40+1
         pxgUPgneLJ13CQc5VGbENR3vVlO3B5OOmQx0PClCGnCI/2TPHZjqReR+d2Pot8uHhzZ7
         konQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991806; x=1792596606;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=DpsrMkzQzv1R4rXrXS+oHtkE9dSvViEEDJFUAq7BXRKhG8iAllRKcOzs1bsRwEZ+lA
         XsEzf/lPVIbC4GW8YIKbeZdplpYAZYJxW/BxSZG0Kq0N13OitGAMm0U0jEEcFjkGNfyf
         ZOFEaBPlAiMTOSlc3VUXoGlr+pr2E+SyWXqrQyGlTrzAweysqgYfPUpBf5xOh+hFqDlL
         aC5vkon55UW06+JtAMU38omTjpyQoYGDemHnGG5Om7OGn+5LtzEcPza5K4YT/gQbbzpY
         fcaiqG3qteKQA6FsMEXEowityV9la269USHLiGEkD5TZQNx2tie/ZLX7h0RvvboDzspa
         XV+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8X0W8dmTzzVIX9QVWgVE6WMaXFSXWE8vJ+zyNty6ljGPNz+HjJqYC2ZEFdLUyvMPIJ9PIb1axNhzX@vger.kernel.org
X-Gm-Message-State: AFq9FYIYiX0q3JLve+c6VDaitY8qh9Aq0C5UKyHvkC++9X2C/fd439li
	mq7/5DLmqZfejgljMFnTNkKpSicMwpzvscBHBtGvusrnnsZbFAtdh9sHzcW9QWxQGLbsWGv6cdH
	c8kwdgSQv9j1c1JDnXtxTFsrxPNHePqeOYH6xC4YiqUsYjkgHGJp/rbPLsAZ5f2c2
X-Gm-Gg: AYBFou3RedzHKX199QaRAXjdR7FEZOfAjczzRE6DOOmm2hhKH1NS/UPVhuwFuHEVn7m
	S8BKdxR5c+W5J15q5IfIqjMQlSiBaC/IjTgdcDjd7aTSwe2GQcS6DpWSfI36E+pQ286UibhBVN0
	458De/S7Sl7ojG9SXAwbKVirp6608nZkZDoL7+et6pNCD0DinDouu0Uae2yHW4QoCIMzscTDCvv
	E+SGDIwKldqSFCs89iRp8iLvdLuY3K5pM7nO+S8Zn6gg6XCiHG2UvAS5Jl3mNyTlocsMM92tx+p
	2JU3k4CUl0rcE4WM6bjPCAAxogMYzdtJTKj6tlHtv5PYN7kE0yBbcFcxjsfmMgRYjeEjF/G+A1V
	mqFMvL9JR+S4J42Ao/vdu9+UyW14jXlSGSSRqVHY6+Wi9rBtmjmRGemvLXTvoZvBiYMS+cETv4c
	MfqWqdSPm5hn20YBKbzqolW4ottZCqMApSJH8FJ9qzxULF3j7IZanYMRGIQfdP0Q+iBEQ=
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493797685a.55.1791991806168;
        Wed, 14 Oct 2026 08:30:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493791485a.55.1791991805667;
        Wed, 14 Oct 2026 08:30:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203762b86sm1331732a12.3.2026.10.14.08.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:30:02 -0700 (PDT)
Message-ID: <8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 17:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014150537.121547-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX30lmpNNvstqJ
 RtcLd/BLKFC4CUr7nmGzRCxQjWcRCiVZ2ZNW3aYYYgRenWCbEuLGsWCwE5z07mcNdvQj5xL7ncj
 NlOzKJ80yGrPbXJ3arheD4Zd343d33o=
X-Proofpoint-ORIG-GUID: T9AjSIYYHCRpX06n_HQt1C82hbWLZWUM
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfa003 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=iUgqFhfxAQh3BSJQTYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX0/UHYZPm5oOQ
 /SWOTsqHO2PsAk09mMkr83PAKQXK9gCdKaoF2FOCIiImVqFglKY85KPAi8IxiOY0jIKx+xxxUTZ
 iug/Kh0UkyKsLtwM3fLimz++xbpYprpdLPnF/axHNsbjBOD0sk8L2MZJkMHOpnLRfWwjjyVOnSz
 biZEtPr2kcO6/6abRqEUWVgbv6izxkOG+bumurmHF9wsTYnG58Sh7Ky9DUUnunPsuRM8WTPtzFB
 FjwqvImqUrIYcFb8zdx5nxT+akIvnV4g4PQecg8ySodi0ltjGXWtoJ1fli08S1fRsuW60HShkON
 UTxri1Yqm3F8QN2cbEvO4W3lWMhFtDGyBrTzXkwjoezf2ngCL2IbjlLVWlXb6NooNG3cGR1MSoU
 NYKU3h57mHHIhBkWjmL+FdSPJbE51ueYxjbMLmuoqWigvQb9Xi477kbt2emcgyidt3q59sEh5Ss
 SLdR2miXqcYvwEqlRUg==
X-Proofpoint-GUID: T9AjSIYYHCRpX06n_HQt1C82hbWLZWUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140061

Hi,

On 14-Oct-26 17:05, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
>> Hmm, I wonder if we should export the lock added in patch 1/3 and
>> then also take that in the ACPI EC interrupt handler ?
>>
>> The ACPI code already uses a threaded IRQ handler for both EC GPIO
>> IRQs and GPEs so sleeping in the handler should be ok.
> 
> Sleeping is fine, but the interrupt handler completes the EC
> transactions, so taking the lock there would deadlock an exclusive
> _BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
> are evaluated, works though.

Ack, doing it there sounds good to me.

> With the brightness key queries also
> running the \GTST copy, 283 of 891 _BST reads were broken without it
> and 0 of 804 with it.

Nice :)
>> I'm just thinking that if we're going to do this it would be nice to
>> cover the bko221065 UCSI case too.
> 
> UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
> from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
> their 1 s timeout behind GBMD/SBMC until the ideapad methods were
> exclusive too.
> 
>> Note this is something which can be done on top of this set.
> 
> I can send a series on top of this one for the EC queries, UCSI and
> ideapad if that sounds good.

That sounds great, thank you so much for looking into this.

We should probably ask the reporters of bko221065 to test
the 2 series combined and see if this finally closes that issue
for real.

Regards,

Hans


