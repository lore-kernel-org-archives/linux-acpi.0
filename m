Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403078;
	b=uAgZueYNeIH3hTQ3Zu2WIVZ0OIu1mppkFf81UaWhEqStL64/+VaNTf0twDPC0dw8j35F
	 0kbYLJ4JvEWq0cFvWpyILb5PlYyDnL9Tu8Y8nTrWzoUkbOxgx6eCrllUVL79r92F/3vzg
	 tCUifZQt9C813oZIRPGteX/SLTNF+rhEX2siJwgRv3MZABJ8DMvnQyBwttJql3dJoWGWp
	 uBUUiOam34YZU+xKtxAXR72fz7OnZPOEKxXqFsDM5POTarBLAhQtiNVd/E3n8SLtGE7a9
	 7z7Qe+jwUpAxTsTlWT1S8IJ8uTaIhAfnOjjUNK9q0E2K4SPavMt6zfhaNes/fCbPHlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403078;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NGj0HJYwMLzByuwZ1s2H4bizl1YIeJb7PxkqCWE/g0Q=;
	b=BIfAvuAxidCHSP71nFJhzEk0LhVci6TZKdj3+qQX1hyiazb2XbyejmrW3dkdVSH3opvr
	 HqQJCNMVfkJpD6FiDcHs9P72lXtNFKPqxyz/Gvj9m7fkPqSko3bNmCtl/B8Ir60drOkdi
	 DJuTHPU9XnQd/2GLlBUclQHiHRCJH1DgEWnay6H7rFpZGkhyxkZktdxMIMUibV9Hudmgj
	 SGVNdrnM/3qT/bn4tmSKgGylknWxf+WJ90ELoK4uUWv8ZYYUMBBrYWAqj5rFM84+Bk99R
	 nHMvCgLXeIeFTgZk/HKd92S0BvaghEfcscvYx8SgedSLGxLS0NdhZ8D33bz7tHUS8PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="coB/S3nB";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoBNj24i;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E2606A324
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=coB/S3nB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoBNj24i
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZBRA2288020
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGj0HJYwMLzByuwZ1s2H4bizl1YIeJb7PxkqCWE/g0Q=; b=coB/S3nBGSl4q2Kk
	3wr8HinWmENbWSkl+ktWvEokd0uaXOHZD5r1L4pdmrD9RqOIboijjSGs2RrhBz0g
	k0Yy3AdesaWLHSV9WZ2S8/XT6kVK+7zo/29ILGUm+cGoLkKESh4oG5LicBSgUepG
	gOuGhzT4s+3+UxbmSZxl2J465UjQl5cYVqEA305oYDzxtIgqFOcbKds1lri7KQ5x
	CLjRdMIag+g81XJUgxcHX3h/IBxEKIRzhelxzPdNn9GANkql9BUhuQ6a+5XYgi6M
	rIKRHlWY4d84E6nG8niLy4VIJgJdCNKMMXOtT6wK2Mqo1/1yHXZKgZjEIqr3GHZF
	5yQaMw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9aga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:17:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f62934ef6so724008585a.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794403076; x=1795007876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NGj0HJYwMLzByuwZ1s2H4bizl1YIeJb7PxkqCWE/g0Q=;
        b=YoBNj24iwlNIwzqqcvk39mijS8IzmWURrwX9hjuxeg3MgfhbJEYaj+KzMJkvIg48A1
         nPzmJSotf3uJfCj5Qtt3Ii1u4+CQpd4Pko0Akv7L0ib5sNVMmQGJtSlGnRenxeG4g3eB
         D9CgUG5MYyNij5jHQlH1doWichvNPEupDRNGoaJstWSfYxNLBQ0nsnsaLUI9RmlIMA+5
         rQvFD5BBy5xL5/PPtiCSQfpgjCY7mQ1b8bSBjvviC+Pv9A2R3x03zm4YVVy4bKoCmq7U
         mzI/GLBc1o15DocaOR+qcZ7jdgoHhbS7Hf+GgVqTVCcpHVC5eVBamU7iar4jBFULUPCp
         dA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403076; x=1795007876;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGj0HJYwMLzByuwZ1s2H4bizl1YIeJb7PxkqCWE/g0Q=;
        b=u6Y1+ElaV/lQrPhQxrsj2/6A+MOM7rCEmdHgkIl/tL8mflulgn3uDPyvXvlkJbbqvh
         VstyPk38EJw2aLQ9mBhvNFYH3Z0xucH68ZDw3ibbzns/0YU6Fx0NyxDnruy6huHl22Tn
         xZ+h894aawfjVAEl+q4tm/97KpLTEwiu36pUfeGppRUr1YeGcG1tWnWvKKInVE1Wi7Mh
         bCpPRmhxFBFAkXzUz+77OxyqUmdfNUVv2aD2q6Wl7WdKwYBE41+YMrjEKXBPZqvWcjr5
         KTkG2kw0Xahe9JtPdUoHBhGmlH6TZ+8nDmjvOUek5knidLdYI+h7MHYLhL3ZRe9Xoh82
         iUDw==
X-Forwarded-Encrypted: i=1; AL+hErFGypEwIyJb+xdG/Bv8tFFNjXivhV7OnK40kJRrFBe/nDFic8eXfuu39HxF3ETNDjrCTNM3jobRebis@vger.kernel.org
X-Gm-Message-State: APuU4Z8kgGxdqDraA+Owie4qL5UFLuqzIPiyoVeVg1kpi0WjHjd4vp3Z
	LvB2FK7tGu4VhpUheMmXepB/UfTycrdnjCGaVygli2ErzjyA6k2ezRdGFYZRCqQJoYnGhentdij
	3mB7TknMRl38GorZ/XJ5hYBiLHCjTmQX6kSvCcniViHhypY0oNnxaXnuIRq39Qk4J
X-Gm-Gg: AYBFou1GJW0crqVKEJuEC931FtGOYdNGejFZjBmxc9+oO/q1F44HV0P2YA2P3Xgimwp
	0PFkmco6jwY8tXzasZM4xlupbhZTOA22zyxR3VFw3wytc99m0hm4hYC9QdPMpZ2tpvi5WXCggo1
	P7oLv7G5uR9B/SwaJr0MXK7wZ/HUDJIwjkRpMM4FuCpDni2nSzIbB0HwkDJ24fAVISvUG7w6TMP
	u78dT82ILXSHVlmO/2GXYCUbulZ7ZRj5dR5nFAsl9xs9umLgsp+5RRhEQpI7BnsqMRghyJRftIN
	IN+S1hf2acVTlARIb63PO4ZG2aRwnaoV99sAxfgzB2rf9zwBrg+86fBImpJLtkWFH0XEuQcHlU2
	oBgi7SkL77Tcrmsb/4Jl5d1yPKW0k9LDS2zZQw1oB1RV0SDpXd1MECWg1qY2XNeorpepCtftHbZ
	1MU4zvUNptcNtCJQ7Y1wA5csPlrYxXh8JIWcNEGEEzoCHsxky/5Ag8j9j0XEmlJMP8q8haXtR5O
	G8gNThAXPljiXmgdUwNcECiflK1BJfj6dVWPq1Uojm4
X-Received: by 2002:a05:620a:2796:b0:93c:a40d:e3cf with SMTP id af79cd13be357-947afcd6115mr362251085a.1.1794403075696;
        Wed, 11 Nov 2026 05:17:55 -0800 (PST)
X-Received: by 2002:a05:620a:2796:b0:93c:a40d:e3cf with SMTP id af79cd13be357-947afcd6115mr362244685a.1.1794403075158;
        Wed, 11 Nov 2026 05:17:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a57085fsm233201266b.22.2026.11.11.05.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:17:53 -0800 (PST)
Message-ID: <38b7e73d-71a8-49dd-85c7-7cc496c57c8c@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:17:52 +0100
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
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] platform/wmi: Allow consumers to load without ACPI
To: Armin Wolf <W_Armin@gmx.de>, Han Gao <gaohan@iscas.ac.cn>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261110-wmi-no-acpi-v1-1-eebea07db551@iscas.ac.cn>
 <c9a078c9-3b95-47ce-86b1-feefe65a6eaf@gmx.de>
Content-Language: en-US, nl
In-Reply-To: <c9a078c9-3b95-47ce-86b1-feefe65a6eaf@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LLGF4SR9qn-dIg2kjJhS8GNcRLXWB5xT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX9Cm6I7Afq9CK
 v1ZjDOzC6GvuqQkbw15Y5GNqOeG6+UDBHwit71m5B1hF+RPmA2tViiOPk2psbWt+7vtg8NJmWZs
 e6k+14oyMCoqOrDwBekid+k0+rV+N9WmO+O3/Vz0VqFyXNl3HbLqHgilREUp1Ah8pJ04qtchu06
 8vwqhgUCvHbeQ5XahTw8PNKEISbLJFGwofk3gijsGQ73pm8sFW7nXKKT2qI2ov7vsVpZiptHua9
 eE1M0C7KfV/NCmyRWKfJVKOWRuXxPcw1aLFORpTgWf/nB9qLPbrLvwtAzwI51KlcRK4Gv1zxRXM
 b8aVOAjgapmUapHJXplt2uLGtv9VgZiYrUDFrO5DQi8t8M2mGWixBvHxJCrkeTNIf5eFjlALqea
 JNbJ/ykptBM/Fk5GXDm1wNX3gAI3c66IQ0csR4lwYrLs+z5P5giYxKaUstuHUz/dbfIPJ445Wyx
 X+b0c0ZzUmbJI9bR0Og==
X-Proofpoint-ORIG-GUID: LLGF4SR9qn-dIg2kjJhS8GNcRLXWB5xT
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af46b04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9ttZ_nxh5X5bo92EjBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX77fJPov/aXi1
 C2hugS/T/b10z9MQnCLkUVRw8lXSBK0Q5OhJwuBqbirQfVFKGFvp6VEu3/S7FxJQxpwhbwJtF19
 a/l7qA7Db4vufBeKEDNbiCsXS1suopo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052

Hi,

On 10-Nov-26 14:57, Armin Wolf wrote:
> Am 10.11.26 um 14:43 schrieb Han Gao:
>> Since commit 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from
>> nvidia_wmi_ec_supported()"), the ACPI video module uses WMI on all
>> architectures. When ACPI is disabled, e.g. on a devicetree boot,
>> acpi_wmi_init() returns -ENODEV, so the wmi module fails to load and so
>> do video, amdgpu and radeon, which depend on it.
>>
>> Return 0 without registering the WMI bus instead. The exported helpers
>> then report that no WMI device exists. Skip the teardown on module exit
>> accordingly.
> 
> AFAIK wmi_find_device_by_guid() requires that the WMI bus type is initialized, so we should not skip bus_register(). I wonder whether we really need to check acpi_disabled after all, because the platform driver will not bind anyway if ACPI support is disabled.

I developed the same patch in parallel to the original submitter, but did
not get around to submitting this upstream yet.

I just submitted my version, which does keep the bus registration here:

https://lore.kernel.org/platform-driver-x86/20261111131613.6290-1-johannes.goede@oss.qualcomm.com/

Regards,

Hans






> 
> Thanks,
> Armin Wolf
> 
>> Fixes: 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()")
>> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>> ---
>> Tested on a HiFive Premier P550 booted with devicetree and an RX550,
>> with ACPI_WMI, ACPI_VIDEO and DRM_AMDGPU built as modules. Without
>> this patch, wmi fails to load and so do video and amdgpu. With it,
>> wmi, video and amdgpu load and the RX550 is initialized.
>> ---
>>   drivers/platform/wmi/core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
>> index a99da9b7039d787ce3c1e0ece74ffbd79fafd3f7..6668789904a903c8d4e7810976f4e485d7a1b32a 100644
>> --- a/drivers/platform/wmi/core.c
>> +++ b/drivers/platform/wmi/core.c
>> @@ -1598,8 +1598,9 @@ static int __init acpi_wmi_init(void)
>>   {
>>       int error;
>>   +    /* ACPI video still needs the exported helpers when ACPI is disabled. */
>>       if (acpi_disabled)
>> -        return -ENODEV;
>> +        return 0;
>>         error = class_register(&wmi_bus_class);
>>       if (error)
>> @@ -1628,6 +1629,9 @@ static int __init acpi_wmi_init(void)
>>     static void __exit acpi_wmi_exit(void)
>>   {
>> +    if (acpi_disabled)
>> +        return;
>> +
>>       platform_driver_unregister(&acpi_wmi_driver);
>>       bus_unregister(&wmi_bus_type);
>>       class_unregister(&wmi_bus_class);
>>
>> ---
>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>> change-id: 20261110-wmi-no-acpi-159a4cf19580
>>
>> Best regards,
> 

