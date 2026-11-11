Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403151;
	b=BVYhWROi9aDg9JLRP11MxP1BLJTpCqgjW/uaiJhSTOrJEodBgBT97nAtaC+n3ts0khMN
	 SKlWxmIj4DuRBFQ5w4L0AaprJ+4SJ4SXU1g/j1TM31oSzuHkq3tFKNuCt8QiRRZFVAvl2
	 7pUldPYKTcFhqTLoeX+QzRDOdB9RCV2hwROEeGsoxIoSlMnyy8cnd6TFe8MAlTCaAScYF
	 IgcUKpSXNBm14tz2My9it9Gf6m6CReFnFq1quzRAyeikr2b+Qsuq+fsIPS/aawwEO5gw1
	 dJlGBu8WFwAmh43ME5iEkHNZSFpNv2YLg6ABWdRnfQyCdEalXYW56edSVDmqqJwKHPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403151;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Wq0x5a4mY8xB9yKVASur7KflnAB98WTg4FjBdau/vd4=;
	b=mDaE/cXFqW6KwM+fliKOd+3B5FjZcGJEIWzeM9x7MjffbRot1F6axiYIL5DRYNolPJ7c
	 CHwGE4ekR0NS4wRQnKWfZI7SBE6HnqW6uazduNnyv94Cj8p6IznfTZncZB3E6n1f+4EGv
	 z8xQhx8lZ71/AcAtqY8why0VkXRy6toJYg95dzsYzXdXiArnTxqpg0N1bDdWtaTHlBR2R
	 gp2tnHMHzIbX3i8UiLDiRmxXy3kWzV3DfYbHlM7Y+RzrFhbib3jVosRfaKEOMcTt5lQNq
	 acqjD6iFUaorAHNj68q+wk2M/wUjT3MD8g6an280pqVjOfqFVqU4hC1UmJXEnDQGm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mQpqHWPm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HAA7ldxD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D2606A324
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07D2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mQpqHWPm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HAA7ldxD
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYqmQ2286472
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wq0x5a4mY8xB9yKVASur7KflnAB98WTg4FjBdau/vd4=; b=mQpqHWPmMGcnsiWf
	hpO1cKg+Jtxp/uwmr3icseUD75KSQGBoZgTj+xRXcYgJjR9yrckym1UxN1U767Rz
	Y0cjFwgFiJj7RnFB/zhSiI0OsZZn6rsMxWcUFDLYrMlmmSX3sq+nvZhrHf5G9Sq2
	ivV+L+8RA5D5qCptz8SAyO+Jm04QZwE9HE2Gh2myiEWRxTPy/hTOc09Hry7LqCLf
	Go/4nhCBvtSSe0LfKZ83Y+eRuKaWYad5aiaKOTx3yFtDIv0AAZ/DoWt5Da+qb3Zn
	Aq7xTfxQEC1qT0LtzsoCnaiNCiIY7Pjt7yz9tQ51dHfpp/tjCRLG8Ug0uAkQgptf
	OK/bTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9amb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 13:19:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so805875985a.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794403149; x=1795007949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wq0x5a4mY8xB9yKVASur7KflnAB98WTg4FjBdau/vd4=;
        b=HAA7ldxDaAof0ShezcR7fGz2sJQjVpywtFtxwqRDX6dsmrcfn6lPDuAt1ZKqM8qy0e
         TfeJ60XxN0JEKjV+gO4uqXc9PLSBx0k8Kjbegtk0QILSNjEoPSQdN6PHi9RIlf+nL/dn
         foAvOXoTaeNWQ4awothtI6FgnDmlVDpYeAbRqs6HcjBmlv3QKxr7XfULX8Yj/TLWqit/
         NeAIKz+R0NMEMcknIniezAeNqpbtllTa5gwh+RfaOqjupRONlKc3qO24IYDUmKIzMpei
         /w9Lffz4KijxpGVnvGO6ex7u6XlRGA8a4ipuBZUKRIX8pWc8VM5gfmtL9mTqHxw9ZRae
         an0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403149; x=1795007949;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wq0x5a4mY8xB9yKVASur7KflnAB98WTg4FjBdau/vd4=;
        b=WqHljIkipt573yu/8qsBBt+offmjdXzoSY7mPV92LgFanuzfC/HrSZAIKXHQPpLTxe
         PRgl5nBRyebXRLPHLGMLA9jz9dmls56BSs5RM65LVf4KkOfs5q/9rUU6nCycQjVif0NQ
         J2jD754b4KVn10ysk1SA+B59TDJX2ctpP92n66mDTW4GDP6F7NO+dOhkQljgQaL5x/HF
         dYsPvxuIyQL1m7WssTRqXnuBkUDycPmAkpeymbinAusO/ApTHg+R++tP39RPJzQM1+CM
         XClJfFMItKsYZYOn/uiymlOhc+PBhRs3LPN1JjmF5VNSwr4o08NCcI+Q1woUcGqSowAw
         ZbKg==
X-Forwarded-Encrypted: i=1; AL+hErFq868eBDEcSnze48IsGBM1jJoXu+Skz4VwMLYtAozoVXEHOfTjfZLV6YJCpm7DjdOdofSEmt0Q43WC@vger.kernel.org
X-Gm-Message-State: APuU4Z+kOqci9mrDryZ3PX40Ddonc5ShTJ4yJARtuPkaNbesYpaYDVUZ
	3CaU79RBrWdk00z+4xhVXWlF/sE0tjjZ4DqpEVxPEZryM86AtexiKMpZWvlyDC3mWM2telhX4Py
	4L7zNiX4NdUacS/dLzGlPUksgFVoPksZPuY0pG75CppZTo1t12Ppkm3KMsOny/JOf
X-Gm-Gg: AYBFou19Qv9Zz4BeTGBOa2WIiBVz7V8b0NHVsSffGy28DSLAZ0HLNMc5QGE9oHP6BsQ
	D6/NDfUnJx72mUdubo+9jzlHNXGbg+xFeSJcqkvSpaaQYGzGdGlF59C0N5Vb2IIlvQIIt+XXHD0
	/1IDqym6za7zuMNoNPpGZDYfff/IZzJqZrrrKEwMfnCmQAvRL09RLo/159vscR70ekv8hwUr3DW
	E6DpghEdQv4XSyYsSHE1nvySCYh3sVLlL7v7ty8JQnLWYzBOVdu+pXRkfaWjR8dD5sJpUY2qCpe
	XiG044pIJC8uH4894v3rFECawQ5O54RYGnbpjC4cT6dNlN7tbsyMt5ITWOPfxBM2sgj+22An/3/
	CJCLvTqAzWUKHYrXEa892QryN0mUqqchgulUCdnl2AJoiEk2lLdru0BjX0vp3uGKi88uopKlrGV
	gaSXaXKBiyJWs71IAhbTZpPz7TABf7ENMLu05yqhUfftz7nADdv4AVQi8yoTvcZbnE9kefGBRvp
	vgiDbpEjoO7GAkTfjpKCqhbnFEeW7hNOuMuG7VU9gNX
X-Received: by 2002:a05:620a:294c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-947b0051f3emr367305685a.68.1794403148783;
        Wed, 11 Nov 2026 05:19:08 -0800 (PST)
X-Received: by 2002:a05:620a:294c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-947b0051f3emr367299885a.68.1794403148297;
        Wed, 11 Nov 2026 05:19:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823caasm2343467a12.1.2026.11.11.05.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:19:06 -0800 (PST)
Message-ID: <c55d221b-4c1a-4b7c-b91e-dd89a12e0675@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:19:04 +0100
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
X-Proofpoint-GUID: FI2zEZLAOhKbiRuvD_m4jNjRJ3fJQgxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX8QRHQx1EIlSp
 DfpT5SGYhd/8voYoa2I4eNoV42uCFoiflsBS9O1C/VmC0qVhbYbfnzyAycSbGamY+lGjPDMl6BL
 N3+dNIvpXrfa0HioUmY7A/KxKoBqlA/+vetfhwF6OXRMGqxPUB469Dzsk0sUE5F0cI22//CeRdJ
 VfRdsfVUvVgu8jbWk405Mul2sHJACxTNzLeQ/hFUNOSzwIn1oiUGPj62/gXm9oSJZj90FMyiGn0
 2d9x2c5IDPu9gvhgEuRANc461SnNPLKWugqBqfH78o4WZxGiy/PA0kwknxu9uE/x/Z3qgUGEUjn
 TFreuyaR6sVpx3i2IrVkgjWh4sA9npAWPAp3KJXtHSOZ4h8hpl/nAKlyQ5nqhogbaW2PBiRBBbC
 3MuGmAuKBWmavtuSOcJH5T97hRllpCENfSTnSzjzr6khJU+eM1ewtxFeg3w600zp76P7GWFUc2n
 gDXF77uHLSKjShLf+7w==
X-Proofpoint-ORIG-GUID: FI2zEZLAOhKbiRuvD_m4jNjRJ3fJQgxm
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af46b4d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=gDy9M4QhnISp6OFiptMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfXzfnIKqF52Ofd
 r6nq8e9/bu3BhPZAyUsG3sCf2vO3mqoWSqGYHZVsOPaQ95K+VVVUZ6CJ50mWWHz7c2xNv+zMTZl
 Gq0E84S/jPMe7qMeZbmW3oJI1lSYWL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052

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

