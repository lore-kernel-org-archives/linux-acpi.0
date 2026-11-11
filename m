Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403179;
	b=QICnNXw//GiUnV1izEqI8vP54IyhVlnHF+4H1vYuXVt/gFnNwnkzRBC42cTtlMfq28in
	 1UZUs3XgkwEW4i0rvqhNc2+IqaAc6JXb938U6coPZoTKXXig+MM3Ll5P8frzZurIx5/fp
	 ANxU+8kSodTVJ3sGkG4m4uVPAlSpqjeMP1gP3I+L5b+79h5bzHdRgInl8x9vfSdLNEU42
	 5P8oflY5yZiL5peGxwykexQ42umHin0ABVMJt3C5pzLmUWS/B7pwfYAz2HOIyZWByFD9n
	 ZPEeUFMTmCpGDTHVY4HeIulCXS2EODkf/ubx4FjR9/pUbopyPyexprGPsbFMUu1FN6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XSLwx4JWXrb44TFN9YjVKJs/9lxbg9iaLEGL8zMJBvw=;
	b=AWFvZiALeSKb1+cb03bEUx4SFN/rTkyNvmtoD8SWdYN0LGoFsyxGjOvUK9pSp5MhKG94
	 5qWxXl6OqZb5sh9Kc9HWcE5Y+787L15FT12Y1x71nQcYZjTuskPLPeKs+VQHhW8Vqz6SU
	 3yjPCpMEUuJS+8pZ4LUqV/jyhonrZagatnzQnnZosZcmIw51pL9UiG8Mws8Jj9TCn03l4
	 CJa2CYbCwNztETw8wVzck3Pmb60xcgzgCyoOg4FxCdZkq0+coU/7reAqo2kV+gaC6IHaX
	 O+i5Fl623mzU2DexRAr+kCkKZEREX7Z2iBFs62KuoKexe3UEXutdvgd17PDRZl9vhdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nUdel8PV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L01FN8xm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33823606A326
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33823606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nUdel8PV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L01FN8xm
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ7Xn1807022
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSLwx4JWXrb44TFN9YjVKJs/9lxbg9iaLEGL8zMJBvw=; b=nUdel8PVYqIl3Gsq
	/j/RTqd7yVEa0MjHJ6v5rYud3wkSYnllQnO9MltQoIaGStS6kHn3GW4u3GRfqNPC
	y4+MElDtsFvBfG3J6M5orv7LPDvrtEWQNyGtigNjlTHMf+U/IUliVGmQrSjTA+ge
	y7e6escSzYO7500HAse/Ob9fd1WOAx6YQ74qqnKvGbi5PFIP6xElHzqjUFXWYkT1
	X18lTfyYFJf6CSUe2AhJgcLpWPn/AhdoY+abaJMZwF3S3r4QUamMlXGCeM9FzM8u
	W0MikvrfB+D9WajReR77NXIL6FBWBer2f1A4S+OKLMXGJYC27SyCY4/GxdVuZwbe
	z/1wfA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj9bw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-947a607ec40so177238485a.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794403177; x=1795007977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSLwx4JWXrb44TFN9YjVKJs/9lxbg9iaLEGL8zMJBvw=;
        b=L01FN8xmollv+4s+ue1VcfUhdPmSKAz6wPNne2jwbmaF3/b3xx1W82Vs3UkO0ULycD
         fBOwseOa735pWY9BdExgtDNZORduR4zSw/QlU65Mx7XzJ22pa9HuaLJx1Y8QEaRlK/qQ
         oqvgAmR2kyXmDp7GgWliSRLaReQJohUFHAwqlDjDwikFWKwToYrQKdrG59HHqHP73aRs
         xXAWA0eNN7gedq+YQmUlc85P3flR2DY7XuRzqJF1jJjeon9RL3wNJv+aFXufVWsF322y
         OXbHM25WxbPTRhgKxLk1vCwURPzv5Bh3ggFGHF8PnNr5lBc3VaIo3XvbA0WdD5WQvm2S
         Km+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403177; x=1795007977;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSLwx4JWXrb44TFN9YjVKJs/9lxbg9iaLEGL8zMJBvw=;
        b=UyRUzs1VZe7+TulONQEoyV0xWI82uhk3YIDXceviYjJCOg8BK4sx4qPBVKDN4iGG7O
         9uvlpAiLuaW0wy68/SKowZvU3+hkflyH7zCJ9kdH/6XFP6kPUnCjA3QHxLR3S9yQv4Ke
         xWiwJGF2Hbhe7j/c3XjE3se0SxxNf5Wiw7dFPq5g32rr9N2C/oDgAczfNsq1hQqepqrm
         QWffxh9MAxpQUNVscC3xyGuinOLFo/7bk3zZQtLDk2agf7sA5CtOaa9fpCn9Pikf6POH
         HvUwdBucJgl7b1Ee92P5fQfiiYHnyW6h7rmTpHjaegIN3EzokPy8kmLAnVEWB1dvl9GS
         ccFg==
X-Forwarded-Encrypted: i=1; AL+hErELQJYg7poSWYLWwCp2Q1ZlTIN61KR0gdclNzvGjI1sj7ek0kn2mWdC+Wmhn/mGAzygMvCextbVOFcW@vger.kernel.org
X-Gm-Message-State: APuU4Z/6sWcQx6VKTgv3C0SOgIl94VOoFsADFjc/v6OC6IGf78LMyJ58
	hT1PmNMJDGZqfTCkAag5fkGi+PnRGuvWi8dMiSp9Zw6GcxrEgEkF3Xbm1lXDmvRlVYa50DC2NDJ
	fm6JQlcqiibLIq4g6xNxNAOMCJHj3qvHExWCsZx0CFQSUzk9TbeWMOeUFfY2JUDxY
X-Gm-Gg: AYBFou14BLatSOThVMbl5PqCod9hkHt7Ojrp7h/j74wLZaYRju3zuwFgcm4GMFyz6J3
	6knD2PFDEZEbz3wEspjqU4n4WeDrvN9YddcU8bDpPKMXSES3TF2J6FwyLszHqDOvof/l0Jz7KL9
	2fbE2acghtscnIsmVz5OfKbpouIHaxS2xTyqo5uOx/VpG8pk3WhyrCWbygfhY2KHdhQ+QWNJlG5
	gxWG6kSVO7+7Mg+BhJQ5PivUrRUV+NNjbY8RsTBNcTMKayYI1leXAv+paCsy45JYCFpCyrqG/O9
	0kRz54qxvJtA8vU5k9YXkqZ92lPDtjY7O5o54inUWe/FnQ1o+ezyN/3AYfpIx15Sh7+yo/Cos0l
	MwmBb4lLkU+sC5FAX5NfcIMFVKJF9gtrsRsNwGrRjTTLaymG16Xx9+/57U6L5n/AU50M9nuF0k4
	I17YBgNyDFz0BojXcV70LkyraFeMZpwxbmeizilbpG8xNAjMDrhDvOB9XfVZVkwnI1pXzJn8Dxu
	4jgXO9gTb69K7SbEQPAmpfsq/UW2UyBX5Uc1e0wpgaI
X-Received: by 2002:a05:620a:4042:b0:93c:c2f4:9182 with SMTP id af79cd13be357-947aff88c6dmr383702385a.20.1794403177211;
        Wed, 11 Nov 2026 05:19:37 -0800 (PST)
X-Received: by 2002:a05:620a:4042:b0:93c:c2f4:9182 with SMTP id af79cd13be357-947aff88c6dmr383695985a.20.1794403176506;
        Wed, 11 Nov 2026 05:19:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56e064sm229943466b.30.2026.11.11.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:19:35 -0800 (PST)
Message-ID: <a72084cb-21b4-43a1-93b0-e3c3ed2859a6@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:19:34 +0100
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
Subject: Re: [PATCH] platform/wmi: Allow wmi module to load when acpi_disabled
 is set
To: Armin Wolf <W_Armin@gmx.de>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Han Gao
 <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXx7Z5FY4RuLT7
 YKHzGYdebiK2Y0J0EbORtKFuM79Y8HKoHHwTSnuL7+zDbZw3h8EeSMOhabFreBqp5Z+ibZrzZz+
 Y95ATrVYR53S62KMZA3Hbgrfn1xaWPg=
X-Proofpoint-ORIG-GUID: Bp4G4_ewSvZKRMp8Q0LIaQQcs827WR6D
X-Proofpoint-GUID: Bp4G4_ewSvZKRMp8Q0LIaQQcs827WR6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXwwdNa9vVdm5g
 xEdL6sbJYd2RMR3cNzqbykcKUKODi3GJLXuFdftxjPTQxctJkDDc42irOa3Ni8QcFqSUyQyQcP/
 4uQHR/TOjPwlBk2clpZCuV+rK2dIjzeL03L4OB1a3cG+b0YCg80C0rmV31hoKQK6rfCepjupMuJ
 +BYekfrCz+cftYTh04b0B0N4IEumWyChKzFqPVZHxMpRYDmxju9Dn8f4eBD/pz0qH9LM+kWVsBW
 qGVPUOedxZGizQWpH+/08Wp1Nw1FMxrTQ/hQP03sC6FJpGMZsScLqXP9wWigluuIhGRvwS8or2u
 NB1hAJLkQ7RR6jFLJnYP2tE8D/G14mrQUvVat+1gitSqxy6sYP4gpCzRB1ckhL7mKQSbD18YO0X
 lUxHA8AzJ8A2uNBtyuR0800YNUhFBsPkG3VVYAS8XQfsCvwaZcZI2wa00sGitxwODTztkFbYwTR
 Obf1yVuIT6jW9AsjeCw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af46b6a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gDy9M4QhnISp6OFiptMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

Hi,

On 11-Nov-26 14:16, Hans de Goede wrote:
> The core wmi module provides symbols which may be used by other modules.
> These other modules may still function when acpi_disabled is set, but
> the current behavior of acpi_wmi_init() returning -ENODEV when it is set
> causes loading these modules to fail because the wmi module these depend
> on fails to load with -ENODEV.
> 
> One example of this is booting a kernel with both DT and ACPI/WMI support
> on an arm64 systems with devicetree which will lead to acpi_disabled being
> set. Trying to load the amdgpu module will fail in this case because it
> uses symbols from the drivers/acpi/video module which in turn uses symbols
> from the wmi module. Note the video module itself already contains handling
> to still load when acpi_disables is set for similar reasons.
> 
> Fix this by allowing the wmi module to still load and also register
> the class and bus instances since some exported functions like
> wmi_driver_register() rely on these being valid.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Note there is an earlier submitted version of a similar patch here:

https://lore.kernel.org/platform-driver-x86/20261110-wmi-no-acpi-v1-1-eebea07db551@iscas.ac.cn/

I developed this patch independently in parallel.

Regards,

Hans



> ---
>  drivers/platform/wmi/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index 529825dcfbfe..412f2e23b01d 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -1573,9 +1573,6 @@ static int __init acpi_wmi_init(void)
>  {
>  	int error;
>  
> -	if (acpi_disabled)
> -		return -ENODEV;
> -
>  	error = class_register(&wmi_bus_class);
>  	if (error)
>  		return error;
> @@ -1584,6 +1581,9 @@ static int __init acpi_wmi_init(void)
>  	if (error)
>  		goto err_unreg_class;
>  
> +	if (acpi_disabled)
> +		return 0;
> +
>  	error = platform_driver_register(&acpi_wmi_driver);
>  	if (error) {
>  		pr_err("Error loading mapper\n");
> @@ -1603,7 +1603,8 @@ static int __init acpi_wmi_init(void)
>  
>  static void __exit acpi_wmi_exit(void)
>  {
> -	platform_driver_unregister(&acpi_wmi_driver);
> +	if (!acpi_disabled)
> +		platform_driver_unregister(&acpi_wmi_driver);
>  	bus_unregister(&wmi_bus_type);
>  	class_unregister(&wmi_bus_class);
>  }

