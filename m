Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893756328A
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096862; cv=none; b=kEYzKBonHCjGOHegXtYljXyv9XfF8XuF08f8O6A7iUzGToWt7rykzghuUEqHGuei3lelIUWdCy2oSIYQsq594qhL5+m5SHmx6a39ZsPtWGKNj62xDMI59sqEOltIJGNsNmAWKDFNHQldtTu3weR+yX9vx6MBiEBMnUt4lqLqCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096862; c=relaxed/simple;
	bh=P24cVrTDE3gejkgeZtQJhfDgjH+Tw7pMbIPR7fQIkBw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gFGga19MUX+RBcHXxWZxkvNz6Rhrc63/5MJBpB+s03BQVdV+srgfjb4yvCXU8C4w1Myo2wBu0eoX2SDXGNteP848HwoAL+Ko83Y7FT6XGnBYc3UCpKaowE2cu6WLs0dDQZfYUHlmj0XJMAS7HhPYZZHJuO+zJdATXW0U3PfauGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMwqpVbU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RqORNx0b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMwqpVbU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RqORNx0b"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjGvB449454
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mEVOLXoa+gjsMcByQ63ZtiGc4tbs271TKYVwn1olKxU=; b=AMwqpVbUjWqLCqz7
	QJ5OJzhQ4W2qchu4Xipo52vti3owkWXuaIN/LRP4RR/aQl5rGsvGtmc/C6iNe9TC
	MFegspkX8aPNrGS+qHFQPw+V5imG4BRC+NP7Tryyo/tHsO0653MpC8ubt6AU6jQu
	UZwXOwXdB1vKkr5uE8TYDVeKqk4aXA8Mjcie4YNJ1aWbgz/J7JPlDpr7lEHwdJml
	uT2jti3O/TpQQbFIh+y3pFhPBHYRhuKaal4lbnbTv57unMwME5YcY1lKpKIgwFq9
	bh1oORAiEipFKu8KXH+58dU53nfCiPqpX9URVhvL576SapzOC/fdj+C/mxCxefS/
	UmWcyg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjytjjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:07:39 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78350646d7eso1317038137.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790096859; x=1790701659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEVOLXoa+gjsMcByQ63ZtiGc4tbs271TKYVwn1olKxU=;
        b=RqORNx0b+y0PKOEp3HkWtLBMDjaG4BqvsSRIEigUwpedZj2jwVYT0bISxqRM7Lj7fV
         mA40CHz4Yrco6RysGY6JTS6zuRzEgMA8z4gyQEsHLHA0OpOZihULExb/2jxVo4COBfxq
         Js33oACCT+VAywUDmy34WSJWdW+1+zWeNlG7TcXXT8FsfQaXOwOklaDElvJvUNJy3QcB
         tL1/fL3hvIxvQjBgNqRBSZY/8caYDKhnENylgRs9vpWNsNMWiAdPNMdHAT1EPXcwrZxp
         tNHMPTrIJ1Rw+2ivIwIXDAQoAD7H1R41hIeJF54uZi5ZttnT8l7uKnwZ6MMk7YTB61sR
         o4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096859; x=1790701659;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEVOLXoa+gjsMcByQ63ZtiGc4tbs271TKYVwn1olKxU=;
        b=JeFDjUP7Vnzw2+RQWsvWIuKVZvC6CEUvD45LW5L7TrcuSSqrcbgrp2igzvuDjEm7MP
         ug9feYK8Q+o+xMS6d0ftNI7rj/kbRgGpPYVSEx6xj5UqphTpu7Sl8SlFoYFLyES14L6v
         s7cfJ0SdgV72NAyZPh0DRniRy4MzYj2VXAjkf9GtJ/6Lru5fXokz/HsIbtuDBPynUY82
         K04z4l3CbKhk5JTtmOXOHwzPom+4CzZKpNvh8BekQQ2OOuquu6uMlOKoJAJ9PXFXtoBj
         AQn9U8z+44olfY3wILNUl0oZbuHUHdo0uD5hIvES2PNFaUfpSHYdygml0WI7yxB+9yu2
         quTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRHuQUxMoDB1xyMCzTa1rSUt3I//TdBZznw1CK8Wd73fwXA4zuyw4I7rJXa5h2V+u3vJIsEceV9FyX@vger.kernel.org
X-Gm-Message-State: AFuF++kYoF+mjEndS6c1w6DitSDnSa5a6YBYonoQnl8MgCUsfbH73pzR
	NOL5aSFkBPGbh0scYbGhewcehP+AZQ81YU9bO06LvQ6QsOKWy8l8C3ctJShHDQnaGoiQ8F5l0DP
	XWg6oTOwNCj/ieUwU2p22B3kCJ5W6IAGvFj0ruXLumDzN747ka6LZXFm67Mu8tmE1
X-Gm-Gg: AYBFou3ew3YYRrYMyCDqjZQ/le6dvkGfYN/a2qsVtnf0OJfYZbxnP/EDUF6kHgfzyAt
	0+Whcvc2HWHyqmdXQdKhMoxSNN/AuNgUyTYVj7QnF6e93mXC58MOV25oq6MJX8LxIheclKooEAk
	7sFGDY2IDzk4GXvCSllg1JZ5drLqXoo97xdx1KuT0AGSYPMcC52c0NW/vsh/a3MeC2l2qyjYsrH
	lHWjZZq9/MXWuWfjxqpSn9b2gYMDK3DmY4DcJ/fcf17tTsqBZpRwPcirxBQK3NkJ3nUEx47nXXm
	kBHz4h8WcROehGsT14MHRe1iLwbUhDxLH04VMO6WApcxwSlKBMFR9+AUhlkzFgKR712cZ/TiBM7
	B1xQg/1QGTvpNb9RvI1PuMWM5OquogXCJrvsEbSCGSdVvtYnqjFH1mE5v/Iy2TExbcfZD7YOtXr
	sfxg/3MfrFczlDtJ+cHLqAOt6pbaJ8G5Q3ifZTMtRtRd1FKAmXOV5Yr38uyniS++h8+Cs=
X-Received: by 2002:a05:6102:6312:10b0:7ab:9152:1c6e with SMTP id ada2fe7eead31-7ab91616786mr1910903137.27.1790096859256;
        Tue, 22 Sep 2026 10:07:39 -0700 (PDT)
X-Received: by 2002:a05:6102:6312:10b0:7ab:9152:1c6e with SMTP id ada2fe7eead31-7ab91616786mr1910873137.27.1790096858820;
        Tue, 22 Sep 2026 10:07:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aad4dc0c8sm657066b.9.2026.09.22.10.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:07:37 -0700 (PDT)
Message-ID: <533be9c3-be2a-428d-9b59-11f68562764f@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:07:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC 2/2] ACPI: scan: Handle _DEP for thermal devices
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
 <20260919124605.12429-3-johannes.goede@oss.qualcomm.com>
 <CAJZ5v0j3yWe5+xUxbwJZSWq-Ap_Bz-hj025c-tFwni9M-1FhzA@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0j3yWe5+xUxbwJZSWq-Ap_Bz-hj025c-tFwni9M-1FhzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zrPLRiQ1_VHJ-36xv_Ddm1v0eksf-P5w
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2b5db cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=y3apbOyhxJoPbcnPkA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX7rfz9cBInTH0
 r011UXP24D0Rdiqb3ygHIfwjzApeD8FBwVo3505QyDOSkbwsqa9Bb5UJBqjac94slM4zGbEwwWb
 zbULnj5oftiEVurDxP7iu6OnDqByfxuig5qvmtFN29TOEQPF3E9npLnixnTr+DDEDsYkio4kONq
 yaqHiIro6t4pbMKA4qFkvvIEYjFZ0tqQjqEef8dI89AHzMAmacMxTAVf+LE0TLFKWYxuvWmeRAP
 qUM3vdid4RTBS4VKmQsivCGq2JtqEd+VToBAJLOI5tLvZMW6k9adUKyMGruesemLbsEwcCpox9I
 GF7MhdCX0huHIaOusCkybyyuzFRogde9KSwoex7APZ1lqlpqfiOAhNjB2KSVQBFlbh1oPe/6Dz+
 j0zODc7v90rY91Ymti8s8tdGYE3BoOO0o6D+JhPzf3762ozUJ5YeyUQXtBwABzSfaF47yoyGZLF
 j5YpH10BxGv4v/BrQRw==
X-Proofpoint-ORIG-GUID: zrPLRiQ1_VHJ-36xv_Ddm1v0eksf-P5w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX5xW2dZk7x1iq
 AtpFRRTYogAw0FoHsZYXPM5F+Zk6T/DzNxGUpxcRAUDsUhxlGbMwj+0S3dw179JGlbFXGDsYgr6
 5ZuSZUGWvEfdIEP5r183YKwCVm2pSbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220250

Hi,

On 22-Sep-26 15:35, Rafael J. Wysocki (Intel) wrote:
> On Sat, Sep 19, 2026 at 2:46 PM Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Add _DEP handling for thermal devices. Just like with normal devices this
> 
> I'd say "thermal zone devices" because that's what it really is about
> and s/normal/other/.
> 
>> will only delay enumeration for devices with dependencies on devices
>> which are in the acpi_honor_dep_ids[] list.
>>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/acpi/scan.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 38ac6c470a9f..af2bd6cc51b8 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1874,7 +1874,7 @@ static int acpi_add_single_object(struct acpi_device **child,
>>
>>         acpi_init_device_object(device, handle, type, acpi_device_release);
>>
>> -       if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
>> +       if ((type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_THERMAL) && dep_init) {
>>                 mutex_lock(&acpi_dep_list_lock);
>>                 /*
>>                  * Hold the lock until the acpi_tie_acpi_dev() call
>> @@ -2074,7 +2074,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
>>
>>  u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
>>
>> -static u32 acpi_scan_check_dep(acpi_handle handle)
>> +static u32 acpi_scan_check_dep(acpi_handle handle, acpi_object_type acpi_type)
> 
> I'd rather pass a bool as a second arg, that is
> 
> static u32 acpi_scan_check_dep(acpi_handle handle, bool check_hid)
> 
>>  {
>>         struct acpi_handle_list dep_devices;
>>         u32 count = 0;
>> @@ -2094,7 +2094,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>>          * 2. ACPI nodes describing USB ports.
>>          * Still, checking for _HID catches more then just these cases ...
>>          */
>> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
>> +       if (!acpi_has_method(handle, "_DEP") ||
>> +           (acpi_type == ACPI_TYPE_DEVICE && !acpi_has_method(handle, "_HID")))
> 
> so this becomes
> 
>            (check_hid && !acpi_has_method(handle, "_HID")))
> 
>>                 return count;
>>
>>         if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
>> @@ -2134,7 +2135,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
>>                         acpi_mipi_check_crs_csi2(handle);
>>
>>                         /* Bail out if there are dependencies. */
>> -                       if (acpi_scan_check_dep(handle) > 0) {
>> +                       if (acpi_scan_check_dep(handle, acpi_type) > 0) {
> 
> and this becomes
> 
>                        if (acpi_scan_check_dep(handle, true) > 0) {
> 
>>                                 /*
>>                                  * The entire CSI-2 connection graph needs to be
>>                                  * extracted before any drivers or scan handlers
>> @@ -2160,6 +2161,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
>>                 break;
>>
>>         case ACPI_TYPE_THERMAL:
>> +               /* Bail out if there are dependencies. */
> 
> Perhaps "unmet dependencies"?

Ack to all the above and thank you for the in depth review of this
RFC patch.

Note atm there are no consumers for this patch since there are
no HIDs that thermal-zones are known to depend on in
the acpi_honor_dep_ids[] list.

So unless you want to take this upstream in preparation of any
such acpi_honor_dep_ids[] list entries showing up in the future,
this patch is not intended to go upstream for now.

Which leaves me to the question do you want a v2 RFC for
the archives with your comments addressed?

This is relevant for your review of patch 1/2, since your
requested changes there clash with this patch.

Regards,

Hans


> 
>> +               if (first_pass && acpi_scan_check_dep(handle, acpi_type) > 0)
> 
>                if (first_pass && acpi_scan_check_dep(handle, false) > 0)
> 
>> +                       return AE_CTRL_DEPTH;
>> +
>>                 type = ACPI_BUS_TYPE_THERMAL;
>>                 break;
>>
>> --

