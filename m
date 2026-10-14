Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCC53D0AC
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986434; cv=none; b=F/A7BK08QEX9WUXGiiPK4W3pYpv5iJttTWP5nkHbWfc/kvnpzbB8JM/0Bk48M0VZ7ggxqfrxhd6KfhzNaYp13PgK4HL2rIMmnlmVVI82bb/rpx+44X1QC//xPOsq2Xc69n6RVHisydh8JY0RPJRuZ7wJKk7/rMmEksSlE9CoLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986434; c=relaxed/simple;
	bh=Pxet30TRJQtNsCxEqkZUTERC6HZaIwRxrkW5u9k6X6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sohiBXHKyk0ywxOv2Z7Ld2oGCm0ogmXM+cpo8x7ePJolMMm2NP6v7WqYxCzXcxgP2FtGYbZ29A5I5f6Cl7GWNVGZl5n1+pgnKZ/ENbsDGTGVdFmbzWE6r8ioxKl891+qF6vwLzzb7rUPVREfQuHWG8pThT2aSnofyy7UTZCiTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM88gY/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bxP2T6eG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM88gY/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxP2T6eG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EB5ev33952148
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 14:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=; b=TM88gY/SAkuivGf5
	+yFWFP4405hUK4+veo6xqA8dkTVtPOBN96tlIMpYl66yC4OPDWEYnoW3ostFzXvP
	/QxUnuWc0oekyclc2OdhCRsz5NQpn2pHquNClmYxC8hHJI53iRycdoczS1lXAgZI
	8cRopjdlyX11Dhc+gxJTAmnlJTHA6Cp3dhZGg3sFugbI8Bejo2l7JRCnRlhG7hqS
	9RwcaRNDYCak+N0+yJF/bsoqIDwaXOAOkS1j44CS8KXp7UpUAFQdwmw5tRig80oR
	UJTomABLqeBTPY0zH4J+6r43Lbga/EYLgEjqPjknpgEBuU59+4pW3FR+37AKi2Bi
	l2Re3Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p1wxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 14:00:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ea8067974so1007305985a.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986420; x=1792591220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=bxP2T6eGb7ofCtg+UBAcZ7k+1pNtx7PBmiCy9sZ0SYAbQPH3Ltu6ZunKQkq5RlP8Fq
         hnx+Tx5Nc/xvbZqEzIufOISggeLFbeFCEqA5lZyV230QFWHzojXLXjQMENoN81ic8+dv
         68e/rKsdgpZeIGnGjNIjz9JBvsNmnXUV4YptiXhoemMopQpCsmqF72pKV88WCnXIyows
         HxmC85podpYY/N+9ctSrn6yBhl20CmXWqXgSzQE1Rktx0xbFZVGREjKDYjpCD6ut6YQP
         ii5gLu9Kpe5Wxs035kmZcXAFqYoRyCJXIwJIn9gBHTPjXPo7KsqHKYhlEs/w9oOTBa6z
         zQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986420; x=1792591220;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=KFLu//aBjrNiSILitOdtv4GS0zBq0cE4L1nasN4QX+5AKGmqW+8UJTNw1/B+Cq+ZoJ
         jpPDkj0CfU1Kc4il+sGAkwWxs0m2+0E7DJLeOTBClC97NUMzlI7xY/fjbjwHCCopmbdl
         8FT9bywVVYmmxDNyGaLZg/bdwI/Thbsno9TK5yB5Z3jSEv1BE+A0WcFs1eIbV+pL4NY5
         GBV0DQX13zkXEoSQugbmxoAu9IGybQOZNxY2LrDtEdjfX3Cr8VAK4sM/JZ6e4BLaF1qm
         N1qwofImxKBEK4JgG74A/XICmqGAUkv9HzWr6hEuE8zP+j1BSykMSXU1640I9mdu6vnQ
         tFuw==
X-Forwarded-Encrypted: i=1; AKwUvBxa6M54eSbyKaiQw95OezCqqgrf3CxzmIOps5iRaLPAbv4G1vYKP7WF6pBQzwVO1iA+JeQuCPoesCtt@vger.kernel.org
X-Gm-Message-State: AFq9FYIjWH6FQsQ/P+0htoDT4Yu4luk91i0XKjmCKgpHF8EtmksnGVnq
	pGE/AA3tQgrWo/MqFsu0okjfA26oiFK92W9sLZaNYFCjT4phTd7e00EeP35RVOGkHzERQmmnSLz
	k+AynEGon2Mo9yYQjy/bddYIqiS/nduRNfjup90c+gIRE6FoustxWluvSkaawTR1v
X-Gm-Gg: AYBFou0RBGbOfFNfheNwXU9mlEWLyYDKzT4NIBZmcYGui4Vkws65UtgttkGtZfASj4f
	rgx5qz+G36PpBuQUVNy38unCI5j5Lc+/cWD8vvDDGT6hZR0RMQ7nuK2xJgJVxZHVZz5B4KVKVjg
	m6XuxZEIyXK5uKAmrrz0vFbDyazyKnAL1x7rECMQey4RkScwHG+3Vl/iMcbATf5REGBDZuQlDsx
	1+xTg+v8xVMawT4NBmBK1DILfiSflA8MV+/+1RIUUtRAgX+rnlttw8SrFSUW/GpP8emDgoMWi6t
	zbzLDhjhFYW8Qrxv2JQzB3/JKCZQB2FfE7bcZX10leQgTFTUXhRDYoJpdqxYV2VdK5GbmkdSDj7
	d/AoL3gLnXucLYzOByvQcyC+bhvCmverM5QdXjn4wT//qkLYxfIyQjEdtQmd3y6MC3FuNyV51km
	7q79FusdWmxmKFw+1EStYRaEm78K2v2fhIKpuQkHCTs6IRtxdPdElt1QhAsiaooAKJRA==
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846082285a.26.1791986418574;
        Wed, 14 Oct 2026 07:00:18 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846046985a.26.1791986416149;
        Wed, 14 Oct 2026 07:00:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3b3836547bsm73203366b.13.2026.10.14.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:00:15 -0700 (PDT)
Message-ID: <a8d28d1a-5bc4-49a2-8437-18d1ae9d4f51@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:00:14 +0200
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
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        regressions@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
 <20261013210609.8117-1-aliamemis@disroot.org>
 <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
 <20261014133218.94357-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133218.94357-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX1SbVZD0I4fsY
 xTkWxir66iQa5d+UI2pabi7dmmMVquNQy6cHpK7lVzdqrzY7kESj5dffo0kIqleA8iku+8BoL9H
 NXSS5tSz9jDJjC5TElKTsjgHeqS0hnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX6Ac6hojzUfc0
 Q1IjqU/DpyVQeLhtPQBXKdTrlD4WMoQ9ZIyniC7lBHEola2taL2UNNzzxjyUTDPssUn9zgQ7eZl
 hha0cmFgwBEcHpvFqJe0t62T+Ks43w+QHgpCTA218qq3fJMN9P0dpSmbzadXginQ5U8oCku60lq
 71gxB3rDajeD1ms0TvhWvFvEjzCi6A1qwp3XCbmB+ZrBIdHJUj4E0k8pECkRc+xVgsz/p9PO8FJ
 Y3cA/3AeoCkYkqPzfQ8TihrD9uBrl6u0JgOhKDvoO5dmEYjEiRom169MVy9oZHvMo1a8rDGZ6pf
 7OuVyI9DzFFs9tWE9Ip/1Pv+Y+Gx2Uw5ia8SYLL9FN+hgEz+T/HZJL+sHAWIGMLcQ2L979X1ZCQ
 ueErspRkzXIspHqroF7r2PB4cYZvlA==
X-Proofpoint-ORIG-GUID: uMIr_RSwKPr7XRcJrfvfcw_OiS0a1EMW
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf8af4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=uisTf_hR4FytVPXRX4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: uMIr_RSwKPr7XRcJrfvfcw_OiS0a1EMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610140055

Hi,

On 14-Oct-26 15:32, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 12:01:55PM +0200, johannes.goede@oss.qualcomm.com wrote:
>> Can you post a patch series for the code you've for this now ?
> 
> Posted: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/
> 
>> Note I guess you're using LLM to help you with this, that is fine,
>> but can you please manually shorten the commit messages of the patches
>> a bit if they were written by LLM?
> 
> No LLM used here, I just thought the race needed some explanation.  

That is fair, sometimes it can be hard to find the balance between
including enough information and keeping things short and sweet.

> I kept the series short.

Much appreciated, thx.

Regards,

Hans



