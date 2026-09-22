Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FE554092
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097204; cv=none; b=V5bLvbrDs7T/obg8Vkn/YDSIlqBTNtW07drG+bU3/TYXyEnRztQt5lGNAeZjHJ7yJPKuaFAqk+jONZEyV5UgYwTA5aUxz/LwMbSVWr+IaOf61l59/uurCUvkUOzrMhyDFRKDI2QWenRmfUjQcvRwUaJLRanUkma/alyjiW6SSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097204; c=relaxed/simple;
	bh=PeSjVj51ii3N6XXiFVi4IM2yFGYPdsWwM49MM/CqeEA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LToERXayV9/44UxDHcIAsJZFwNsKPIzT7wszY9/JcXlHqcdISLgjrlZSvinDnf8roWVZXn1O9kXiyiqgg7ruS9xC/FqGaRV+VoPbRNJbn3Hft8wr/gxtJ2yDFAuvnZFakdQcMhUG9i4yRqvgC/fpW70ILv470KDU0xhAG7spZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JpEEia2S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IP5uH8Tw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpEEia2S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IP5uH8Tw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjHFF573084
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K2IRIDdNS11DOys0A/FnPOq+hitSiiWmFYJgBrw+/IM=; b=JpEEia2Srerm2jVP
	LdbQG6fmBVqle6gMaD2nIXHNPf2tBogkHjZlS3x0YBvL60yJvahBG5jKWfB/UtNf
	q+w/wn3P+h4hSeIjNdsdHIHEVMRCNNZkQcZyqZJultx2uPwDkY/94CC1nTxL2EAx
	LTrTVlh3e+lHv8ZE75rQgPsHx7XsRnPdJCVpATJusS6TFLjyShEJBaIKUR159bOo
	fBAykm5XNyP6Gls9GFp3yt6bjOcPxzJqaIAkAwIDeHwvWey6wzTv6YY4ygdwZy7B
	dRBqZ2LRgxVus97iobzZXrF5p0RkdUgJvKKzGJeAGU9/CasxRSfwU9TS78Z5EAbG
	SgPdLQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkjbb76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:13:22 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78f4d6af128so13579137.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790097201; x=1790702001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2IRIDdNS11DOys0A/FnPOq+hitSiiWmFYJgBrw+/IM=;
        b=IP5uH8TwI9cqgm1lP5GmEibZQ9c+ddVCdfARiD340YTpQnPzuvwAO9ooWIUrzH3ud9
         2STBkdvl6y+gKeZ9IPdQncvRJL0XyZt3NSeOCrfGSdsxjqVVlIFPfNH797wZVmcUPuky
         uNeytam4FIWTcM9a5TdCmW0vwa8/Lb7nfrdSMkhQ4LcmBa3ak5/oslYP8B2dO+TLPe4n
         kiPzpejGjinq+SRmHv80EXtM5hmUtwYUQPBdlrxEcrmF5HVK37J8mj5+axGAgqSvBL5z
         Fs7VwwMjvSkN1d8EgaGEDOc9IpK48T3n9ljzVyb1y030kvVYHhwcwkx16gC3svRp3c6U
         ZiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097201; x=1790702001;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2IRIDdNS11DOys0A/FnPOq+hitSiiWmFYJgBrw+/IM=;
        b=UQanMDG8slUhF4f+llPbCY85s+nSjCvugLPzZ6vrN6QKUhXF6Mq75fjFatLxGHXqed
         fJxkPCJYRNpf46AVJ5KAsLtFy0sKcBU797G4/kERdwsjgVzKzVytG6cNYOa0zu6AMoNi
         WczY1G3F2E3b4Uxb6TKww+BSKNEaCdCbaLiREsCMNfECPp9nDEG7FVPiv1FEN10JYjHm
         YaPGJzRBZyhlmIrGPV4/qouZv3zc/o/luN8TLyt64geOShCZtdjj5sCVfFe99gyWDLQe
         PXM2P5PH2WIj+L+RFgM7zMk1O0spV1BkelBBYMJO0VouJyeDZzA5w+yFy9nmMuapzGXe
         Cs4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzb3HRVZ2MDWFYnwayI/hEoH6EHskCb7u6sdi8cRpMjKydCkUlt95jGhDiwZ7kO6bgrZRkJy6+gjd6x@vger.kernel.org
X-Gm-Message-State: AFuF++nu/2YKUNFMLZKjeaivk9Bp99n5p2c2SzRSCzgAIHJAtpR1AB4g
	HLJEOkXacsu6cWsFjBNUCbVmuDvZAk3sSBAXz5gLeH66674FYjQ9xrclLq6q+SeQH0V1AgV9WE7
	eWHtfF5nHNopPNUSFpWcBIvmCSEbH8pohhFrGoGFHMF70qhjAPFIMYlG/yurrKOxD
X-Gm-Gg: AYBFou1MCwLQoozhhTqrzPiVJCDBwxIb6zwNbCDFGwYRHKWzAd0MYWLQEq56S7lhMef
	Kj11eqBSLofxt5H9Y/mKI//LsmihsP5Jpe5g9HF+wmMB/waT4Lj+xXrK8siiupQSIB4Dw+Jg8Md
	JNmpXgaTV7Injwh+CcBAEWZGQQBUtY/tQKxDeL5PiRyHsTTtIeZm+EoOhul4mv/MRPRKiu/Ykq0
	KVrRTbH1RSqw4b0LPpWAS2yQ5I2mmoPm9QWRi2otTtKptwfplGmQd3AHmALIgFfpz7l5EuxqMhE
	DPRmp9Y3HfzN2VD4bw93MGJfUnD7fK3ffROulHaWv7HanhEqdCzm54//L13GUJMB+TdNQBlfLwG
	s3MFoWposdAl+LR+xxfRj2qbEIsDfFuCAlFsNW8WBRqWboU7re0Jp61jrRYIN28SvSy6THRoLCd
	mI/dugUn2KQXdxTM1h+kkVi2DSEzu8STp8F+yq0J6VIWb5u0Qgph8M2xUAlgdomwBvq90=
X-Received: by 2002:a05:6102:148c:b0:7a7:19aa:f0cf with SMTP id ada2fe7eead31-7a719aaf74fmr6342316137.28.1790097201037;
        Tue, 22 Sep 2026 10:13:21 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7a7:19aa:f0cf with SMTP id ada2fe7eead31-7a719aaf74fmr6342274137.28.1790097200607;
        Tue, 22 Sep 2026 10:13:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aad5bd191sm444866b.19.2026.09.22.10.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:13:17 -0700 (PDT)
Message-ID: <f464eb1f-42f7-4e6b-a0e7-a549fc58fc6c@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Skip acpi_scan_dep_init() for processor
 devices
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
 <20260919124605.12429-2-johannes.goede@oss.qualcomm.com>
 <CAJZ5v0g3WvT9jUkpaAtFOk+DttCU1JrrUBRzokFwSffnJvjHzQ@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0g3WvT9jUkpaAtFOk+DttCU1JrrUBRzokFwSffnJvjHzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bNECyq2HgsG82wmOx0cIBitdg958YOlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MSBTYWx0ZWRfX17/oUjhW/RQv
 49AnHYKqBgB87u5Bzp+wrEW2XPx1POKEG5vLtXnozR8vEOfhGpcf0mfqTI1ckkDKhZnsmuRw9aE
 cZGi2m2xLnqNU8LIv97YMrsjdj1grfJIICSnJs8/J+LUIISW/Ud2I+YbLM+YODVNttgAlheglMu
 cQeHCqgcPZCba5JaTztSJQPsR3kfJAhlnyb9/rcoNRJmtYwWP6upsmwiNMBUQmkNgMdG8zXWg7J
 mb9l305qtZOt44hoy8Eyu7pg1iELjeo4tKygk8d+B+m34I+iltAaxAOGZefCTyHLXsFMh8eSQCW
 gsnJclm6L2yETYpzXbKD4RBTRdAVKEAikTi8DLuNWEiWyLa4gOKQRRCSYlZ/tAk23j6Cv99Z5r0
 CRcBHzZDPSZpfgsITclBhMpZfg3ZL91e7VGWTLvQZLNNl55BIOT2ks82NJ/Mb02OdhAGHbtzS1U
 Ao6N3/7LH2BS02QccZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MSBTYWx0ZWRfX4P3a1y4JKycc
 iiqrJeNc3Cv3aYmsMW34+2ZkRD+HZHdPBTVI8lRzEwBngM6BGviE8Shbt2oPhHwtlPcwlXvVHFj
 dY+50uY6aHADv7uUphAQX+FLI3Zbe/w=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab2b732 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kyv5j5zW8QAy7E4G8ckA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: bNECyq2HgsG82wmOx0cIBitdg958YOlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220251

Hi,

On 22-Sep-26 17:32, Rafael J. Wysocki (Intel) wrote:
> On Sat, Sep 19, 2026 at 2:46 PM Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
>>
>> acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
>> the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
>> never contain any deps for that device, making the acpi_scan_dep_init()
>> call a no-op.
>>
>> Make acpi_add_single_object() only call acpi_scan_dep_init() for devices
>> with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().
>>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/acpi/scan.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 40bbf9e322c2..38ac6c470a9f 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1873,25 +1873,26 @@ static int acpi_add_single_object(struct acpi_device **child,
>>                 return -ENOMEM;
>>
>>         acpi_init_device_object(device, handle, type, acpi_device_release);
>> +
>> +       if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
>> +               mutex_lock(&acpi_dep_list_lock);
>> +               /*
>> +                * Hold the lock until the acpi_tie_acpi_dev() call
>> +                * below to prevent concurrent acpi_scan_clear_dep()
>> +                * from deleting a dependency list entry without
>> +                * updating dep_unmet for the device.
>> +                */
>> +               release_dep_lock = true;
>> +               acpi_scan_dep_init(device);
>> +       }
>> +
> 
> Instead of doing the above, I'd prefer to add a type ==
> ACPI_BUS_TYPE_DEVICE check to the dep_init check below:

I can do that and that works if we just drop the RFC 2/2 patch from
this series from consideration for now.

The reason was done the way it is done, is because we should not
call acpi_scan_init_status(device) for thermal-zone devices while
in the RFC 2/2 patch we do want to call acpi_scan_dep_init() for
thermal-zone devices.

So just making this 2 separate if blocks, each with their own
condition without nesting, makes things easier and it also moves
the comment about acpi_scan_init_status() directly above that call,
where as atm the comment sits above the whole if and then there is
this intermediate comment:

>>         /*
>>          * Getting the status is delayed till here so that we can call
>>          * acpi_bus_get_status() and use its quirk handling.  Note that
>>          * this must be done before the get power-/wakeup_dev-flags calls.
>>          */
>> -       if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {

before the actual acpi_scan_init_status() call which the higher up
comment is about.

So IMHO the result of splitting this into 2 ifs results in more
readable code. And it makes life easier if the conditions under
which to call acpi_scan_dep_init() vs acpi_scan_init_status()
diverge further from one another.

With all that said. I'm happy to make the requested change for v2,
which leads to less churn / code moving around.

Please let me know how you want to proceed with this.

Regards,

Hans





>> -               if (dep_init) {
> 
>                if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
> 
>                        mutex_lock(&acpi_dep_list_lock);
>                        /*
>                         * Hold the lock until the acpi_tie_acpi_dev() call
>                         * below to prevent concurrent acpi_scan_clear_dep()
>                         * from deleting a dependency list entry without
>                         * updating dep_unmet for the device.
>                         */
>                        release_dep_lock = true;
>                        acpi_scan_dep_init(device);
>                }
>                acpi_scan_init_status(device);
>        }
> 
>>         acpi_bus_get_power_flags(device);
>>         acpi_bus_get_wakeup_device_flags(device);
>> --

