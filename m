Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487470;
	b=D0KIiWZpSkigbcrdWkXb390FrsnSnFEnyQqSNhHgjYCSKpj1K+F0Dl84xBFF6LxBKJzt
	 UtWunhu8SwnjGSvoRSlHUN/z2wgFbjvdsPZTKiH6C8701h9v7AxSbxKu4x06s1hCkOGDM
	 C6JJYaILRD4BQGtU/FBbfvsWkAh1x/OskF5nxSISJYa753F26bzMhy7FX7im1LDIFdviZ
	 Yxzz5VvxCKovegCXjz3qabwlpkqnucKJ/C5wkD9U6uxKPbuhuqqTCVwr7DXyVsw0hBXRC
	 vsKIGhfniJQFDV3JoeTRMR5tw+RDYl2xUnxkw7EH7YEYAZYPER6kOw+aTjKWKPS/0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487470;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
	b=5XK0fGDWzHBtMRvA17zDTBnD4hc6v3MFFOmg6ODHsoqMOlDTJqs/WjQksu3UKuN0/Xuf
	 iUuPeBQMe/Ge+5R2eQuPE1ZDB5Owqm52allvrQzLw5VnzNSiH3XZzyHvsqSEZfwailOHN
	 3Keyf5aCyOm06h2aHQf1ekk9GnH8NzvFBrob6VcGoupWF4JRXghmeHtSCqxG9+Aq2h6rm
	 trE3PWXwQ8GTx/B8DswAYnkvej/7LQCbGnXhNX6yvcvBAXNnEsXVzsSxll9ht0d/rmPCH
	 qa92kSnmKD7vp2hcSPUzqPIe/pBl71/CMY4sB71lETtxwi+NTrccgywGfppog10GXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVNZUlJR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="CN//bggf";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20E606A321
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD20E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVNZUlJR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CN//bggf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUnEI1629431
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=; b=EVNZUlJRRrUaCrcB
	/JbhhqVCCHzdqixAxcdBYkLaiWK+0ihpKvje+kAyxOgngfHJdBvxbbBjSocVcqcN
	ZICIs58bFXITVRg9yQNzDycA293cZDhYEWK1uBtWPi54IvtD1gK6YOuxw5TrjmLu
	6iWQAZukSBlZ2srV0C42fB7XAw4G3SWlLcTkGkF1M2kDpQZUd86AZW5s4xxhvdPi
	i5Z70HMr2HcDqgedocFyBA++aJkAgjidL4BnDEhyOgoA8mhno/5+LLBZGGmhLGIo
	SiZ/uppAK47Uf0URtW9qlxKvh+LDhs+G2C5Qtvl36lWAWLy8CcfR0SU38LEpY5uQ
	4uBlTQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00e63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91ec6cd898eso81897316d6.3
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 04:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794487468; x=1795092268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
        b=CN//bggfQASZ4hEK+l+rNwAAhDHlZpaws4j+W1fPXGaelqUEzIK3m7Q01mpgRhRmy3
         VWqGbtopa358yF3CWdP5GukkjHnhUELIwMjN28EXC+a9IGOlhU0Yh6cIHqiwsFrXapQP
         L/TYtgmmrt6sg9PhlMPk+/Ht/7BSPweYcbqjHbk/73h3SdWfH5d6AqfP0Dczk/OWPON8
         tNgwp2DuY2uCsSkCcF+cIl/Iz2URlVVYy8vg6ffoqOXQQkZAAkd6DPt5Y4uNjWVmzLOd
         YMePh3fYMW40/6P2cbk8/LhlIpalH7/D1kloAUT7+MabYRbHU4QrjN4nYW2c+R3BTAq+
         vnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487468; x=1795092268;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
        b=KgZ0Hh9jI0eu6kTxWp0yc+3Su3FzC53xjqUM/VEKR8Y1pa1V4YuZQGNWt2I0mLUw7h
         LaDPH9JwvxjRKVZ80qfTrSigBdf4gR+ZQaOWNt73WwEqeWoZyseqnnAvC/XdNrXNE2Ox
         Heq/opM4hAzbqS5VBilA42+W/2Sp3aG1QLw/cHJwEM9ZEYjH/H1nC0D8miDnTNM+Wl2G
         gUknEHtrfLQtWbuUjfXZdbWEZz8YtdQMZ0LOLhOOOLNGPvjeUQXvz1fsrV//EiQY90Vd
         EU/+d+5lAqfeD/z9msthZcrflIP5sTHKq5iNfdiklShwE9bkXlOREBTePlKaylR7Xqbh
         1aXQ==
X-Forwarded-Encrypted: i=1; AL+hErHpaI9zOa63sMNOk+N00UpJWt1AI1JOQak/dYrBLaiDeREXCoL3PHGYfc72b/Z+fs1BJAumSRZbxTGa@vger.kernel.org
X-Gm-Message-State: APuU4Z/j7cqKVuEdM4m8PE8GpMORz/m+UFwqmiAxGE24nZ918bKZNylH
	7rW4XUJ678agkJmu7+YyM9mvjYji0ArDWHDCsdKg5TQHon0p2qXmH5tcHAmdKeixavBYZS5FVLd
	aPnTi5x3NGng3VOMLfg2MhH6JBkLeGhD8qfnCRgzX/2srh+A7tDHLZAJ1BIqhkvc6
X-Gm-Gg: AYBFou12mwzNBIisD38pupXXnGpyr37uEfFWHI1zSixxJQXMQlooFEsdmQOi+4lv46t
	H3Wc+qShohWeBnc6H1AJfuCWltj64Etmg2TIW1Fq8yH73Z/qo0+k1JtJOx1NRJv+fLpjnW4m/sl
	5FUpP0CzmC7815enUGPnB9ZLdPraYR0E4zQGNxPCuWaeDRuDCnNHvqJkvHohu4or5psGrTZuxLw
	wdQ6MFq995GeJt3c/Ja3GqmvUXYHWxWKfTd6WSIGCNEt0uggisa3yNnE+yxQz66Ff30ElBRCPHC
	4WZMDWMImTGj0F6ePzS9NZ9Kgvk2Po3fY305bh/0t/WJwTWFyxrOckLyemJCm0QSs6C9/O8mmzK
	O9N/eX4E64dSmGK5cwYnsq70y39DF4Pdpzn/M65qjLGNfqzVPqodkcgLVK33MM0pUMK6hY8TlA3
	Ci1ODL6lWlcKDA65uAW3/RYnp0+27lF8o0SlgZsY4M0o/OxaARu4y1V9/glsNvEzJ/OB6hRtXU0
	kjBTVyvZwWBucDC6CZ+RKM1ua8uJqrLALqKLl6VC1I=
X-Received: by 2002:a05:620a:1a09:b0:945:d852:15fb with SMTP id af79cd13be357-947b000a75fmr860384685a.69.1794487468329;
        Thu, 12 Nov 2026 04:44:28 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:945:d852:15fb with SMTP id af79cd13be357-947b000a75fmr860375185a.69.1794487467038;
        Thu, 12 Nov 2026 04:44:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593b5esm342166066b.34.2026.11.12.04.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:44:26 -0800 (PST)
Message-ID: <132d4e81-93f6-41a1-a3d8-e6d6e43e14ed@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 13:44:25 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/1] mmc: sdio: Set
 acpi_device.power.flags.ignore_parent flag on sdio_func companion
To: Luka Gejak <luka.gejak@linux.dev>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
 <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
 <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
Content-Language: en-US, nl
In-Reply-To: <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX/eZDJz3TWzxD
 Wto9PF402fkBTNrLlLHsV3Zch/6i3CvIcCgdDUiHF4JPACPP2uwFqP6pp5TxxrSU7Sg5Xs+wCip
 vxPHzJuNacDY1iOaCL3usrtIrr/Rp8h0QeHp8Ida6QSdT0hVKnjcC1CRGHOLKy0++hJOwYx1yJO
 5k7ZkCk9o2JJfHCmvRXArRXHrzXV3YusVwRdfzs08tvzOMpBUyBx+6Kd342q+dQTLtJ6ryGPGxI
 qPOlygUg/sJJX3MrM9KYaWwbWkPm/2wwax5+aoF7n1K2Tae0eECJjxq3vgrmWZWDqKb2O+eUtlN
 d6M5C1piWvcLk96Nj/Ks1SgUXF39x+OsP/bfdK1+rjHRBsaPrROqiYlTjJ/BDZLQ64I7cQJOGzW
 W8ctkXo+ADlzW/tomDbyGZAzDkHmPAp3Xx6SM4YtfNzVaLoe0B6QHyGOwPWO+Ib8R2EjWvbDynq
 e1kKPgUtiuOam9N+/Aw==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5b4ac cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=QWvNHL0soY4QXwqiDp0A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX47uUnRrMnFK8
 bkfjHBzKyJbVI1P+0hCj6prAfVI/iasdMJezips2jSFa/0Rl0/gQtd/ph8uuLQO2EYp2DFPoMw0
 WIZ98MtRh7CX7Ymmr00n1yYofkirXuM=
X-Proofpoint-GUID: 98fVpvoLnSyse3Cpp5oaC93tYuT0exEz
X-Proofpoint-ORIG-GUID: 98fVpvoLnSyse3Cpp5oaC93tYuT0exEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050

Hi,

On 12-Nov-26 13:32, Luka Gejak wrote:
> Hi Hans,
> 
> Thanks for the v2, it looks good to me.
> 
> On November 12, 2026 1:02:04 PM GMT+01:00, Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
> 
>> @@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
>>       ret = device_add(&func->dev);
>>       if (ret == 0)
>>               sdio_func_set_present(func);
>> +     else
>> +             sdio_acpi_clear_handle(func);
> 
> This clear seems redundant, since on any sdio_add_func() failure
> mmc_attach_sdio() ends up in sdio_remove_func(), which clears the flag
> again. It is harmless though, and I don't think it is worth a respin.

You're right, I missed that. Let me do a v3 with this dropped.

> The commit message has a few typos:
> 
>         looses -> loses
>         safe todo -> safe to do
>         wills -> will
>         inline with -> in line with

I'll also fix these up for v3.

> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Thx.

Regards,

Hans


