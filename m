Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D27391E51
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253204; cv=none; b=lFPRbzEZdqFTBAGF9RutxZZe/BSuQtu0X4vkH0MtqvTImb7zOxCokYPOVsvVYkSLX9R2OAkER+LwZ56cLQiQxEu6lwTw2SG+HEQTiJ401QYss1ZnN1jue5jWI1yavt3HAJkwKbyZDq5NIMjduGJIzym7kmBFepxbcHDu0B67GO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253204; c=relaxed/simple;
	bh=lwN1MwVG4PyX3cM79mV8sU6kpbDpiMrRuAdutC2BaOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEW3cNqg5XZYGZ2XayCMUAxTDqb8d2ZHvhMzMcmpVhAxrr88TncheuN0K97U7vwARn5qsBpuqbX/kTCai8GELdwU8V9SoX9sybQnRTRxdIy+Eyiyjcsm05I6Zzg55cPchwmpDc3bkEUkUaGU7Sr5hYRscPFBSCO56gKsD1OGVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx4aDMYI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bcSVouGb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx4aDMYI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcSVouGb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDFCCU588772
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=; b=Gx4aDMYIqARYD4Pe
	266DP0cghVQ3x+6RfeQxVpA++XSXASwMCZyiOlXvjpXc0kXvpLisEVBXI6G53FPN
	2jH3yda/CdH+EeXbuibHjk0khP91476PP+e2Ndwtq6tk8gQHsg0E6K2GQVuzgCjX
	afrxE7gfP3cfd5ZIFu6/boNFtHj10cwnolNszGH2uKSkPy+f21z24UyRyYdzuvc1
	6tSMaUhvQMP3ry553Aw1rLKK4DlDQ+7RVRstvhp6ha/2fy8nJ4ZQYHtIK7xHUV0Q
	ROKpdx/mFIim/7L2w1/caYxmykfcfs9TXUh888pi93GoaNFHVlR5GP1t+qf3K8Jo
	zhAoWA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se16w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 16:06:42 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf08dc2fc8so78417137.0
        for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792253201; x=1792858001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=;
        b=bcSVouGbUCaVyWtMhwBDzpfvr30g7DzdecEsUlrDQjoIDNJyLpE/pLqDgguedr6VHN
         MRU7KdTXUnhZFQQ9h47M4LO0YynK5c79QX0z/Y45lAX0TlyFrHuQ80qWFsU8TeoxY2bj
         br0kENLMrJZwfIT2L1Q1D6HTFTP1AtZL39E1UK8GL4BkG/jI9xT5arQbJZmejiNfCvdj
         Np/XeXV+hKaa3/Tnt+UGo185xwKoTsvisSV2LkI/CZ0fKjmMNMF1LCoNYBH6Ohm0xkzF
         Tm6jw20HdFPHQbE5qSH06Y5nfQUoNXC6uG8w5ozCV9el8vOAux34HFI0zUhx6dyIjzQA
         LRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253201; x=1792858001;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=;
        b=AOcIYM83yzZd8scxaHeydq+FaieAcytyTcGODUFMDbR95+MkaK3MDpZFb28U0jFJ9W
         NnAeQwlVr7M+Wtxy34Xv0OyO6jx2tDhcfMwkT7meqO5M/Vx5vRIRfepBdtixxqtcEnYb
         FMI1pekPUzl6iEsfPpDXNE1IpxCs4m2SZ5UOT4V/Z2p/VlcaJRCVyH48n0D1Q/uNXX6P
         8rCqkaWLzWjOIwsvWjF0nsn4sUpiHLxO+GGq8EyLvLla92jBTv1h38PG6DT7zI3fXgZG
         nwUme7HZNjF4/kefH96mBkkm206Txgs75OVOO1kyKU47kRFGVuqFRwSEX845gSulcKe3
         hjgA==
X-Forwarded-Encrypted: i=1; AKwUvByBsN0T8QmDeZM/XUU0TYdbkZZiNDcdP2lgOlkC4Hp+GPPH92Wub71Ma/MTNEH8uBKtpnUy/firozbj@vger.kernel.org
X-Gm-Message-State: AFq9FYIK6/o/LeJQEbUB5eXOq6VlV1h6U5YgES8ft0mebw2BBlWzJe9q
	QZpESHgzgiLZeS73Gpbpe66qDlMO1tr67JTdG2ex4UYm2EjGQb+n8LGI7/4s53xvsYXCZYHwUKP
	xN/8hKSc+1WdExyriGMB3TUwO4eyE4zkVqT/wHXYeWVpS+wYxHjWZFq8SpwzY8vA6
X-Gm-Gg: AYBFou3klfPJGzLRVE1R0W2OxMCgJtBzZwdfNjtZHw2ZIcg6nmMX46QWZ0MigmPmLVY
	HRouxaYxbhir43tPNNSyRN/K+cRsw+4S+1GUvrJiys57VZWCe3cMCHVMYPgVX75Wh+6NNZ2KB8X
	4vrekK/fYfLN+1JtrtRTVFUq5k+3HZiw9ZXS8u5MDLYO2eHcWJEXEzG9M5M1vTzveS6F2u2GrpT
	t86ZpYkHsW3+D1QDbYc3XGe6250yJDdySU6cBY0gE5aRq8Uh209dxyBdq+cFpGVSOU/jHNQW9zK
	U9DKYAbofdCPpOemIgnPS+Mxa2A2Q7fGXQQxaJ6zP+rR9bjHi8U9CDi7uX3tYHXSYc2ZH7OnvI2
	GFhfDKFdTcKg+x6DCJU1QzYcuO4qktZcqEn99hX+JlICBdPA3bNkX1IOA0oH6eVk32Ua/c/XjxC
	bDvnyi4wXXrkJcGc9OppqZqV2r818RdVQS40+kIX/1fGALmO5VMiYR36TFrVEmCwoX1w==
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr721523137.31.1792253201283;
        Sat, 17 Oct 2026 09:06:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr721518137.31.1792253200767;
        Sat, 17 Oct 2026 09:06:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1e9da2sm2126373a12.31.2026.10.17.09.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 09:06:39 -0700 (PDT)
Message-ID: <4665b4b6-1af7-46a7-bb86-68e9817b1eea@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 18:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag
 on sdio_func companion
To: Ulf Hansson <ulfh@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: me0S89cAFosG4RH9mk81IT7WRxkV_ylh
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad39d12 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=mvwfG5SEgSwQCSBJfY0A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: me0S89cAFosG4RH9mk81IT7WRxkV_ylh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX84nmYutpNGIl
 681r1n+qeTLuPdughVmoBXdzcWOy3kZcAkonScic8Nm+lXKphF9XaX50OT8SZD6bJlcA6uSLYiF
 tTshtifFcehhSVL4ThgP4PdmVq/YW/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX+PFyAM84WdNJ
 3RN1HYgDV06nEtMxUEnwlOi4E6cQzvYIjMxPXpEYlDZrzT1xgsPVpp/xMNF6cYWSwU6pp3nnXZz
 nT1pkMDB+krphhTs0le1/18PDuV6W691BYzpG0KcBg5l7IWm1KGshH+NiCtJcLN0Dh9BagefEgv
 x6hjBYaTc4lCXrn+IFcpRqI8uyamfVPP2u2LccY3K/KHBR0NZ/KuzIdUn0zjV7FyYChryDSr1xy
 2FWGQNFxL2tFhnH18dHr0MliduyEGfxeKncvNKATnPpDIhNOzFYdn+fEIZBpkaOph2C38rRTFhd
 9q+RtASoP7g2LB8a+W4EF38k8F5lnIXWi+UB7ldQBeI1ZFCtp+4yTwysYwSfkNC2qpe2mwNimJM
 ECzfn6sEHtYRnyXmd2WICCsx7BhKQ7wKXlCZfsN9/kfkdh+pgrXuNJvQ78qp7GyksabPyxypb9i
 +wM0MBxAhem8VPgl96w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170064

Hi All,

On 17-Oct-26 18:04, Hans de Goede wrote:
> Many MMC host drivers call pm_suspend_ignore_children() which allows
> to keep MMC cards and SDIO-functions on while the host is suspended.
> 
> For SDIO functions which are in the ACPI power-domain this causes a race
> where the host may end up runtime-suspended before the driver for a SDIO
> function loads and probes it. When the probe() looses this race this causes
> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
> code with e.g. the following error:
> 
>  ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
> 
> Busses using pm_suspend_ignore_children() for their children should set
> acpi_device.power.flags.ignore_parent on the ACPI companion device of
> their children to avoid this.
> 
> This is safe todo because drivers for sdio_func devices should always
> call sdio_claim_host() before doing any IO and that runtime-resumes
> the host.
> 
> Add the missing setting of the acpi_device.power.flags.ignore_parent flag
> to fix probing of SDIO functions sometimes failing on ACPI systems with
> the error mentioned above.
> 
> Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
> companion device wills stay around after removing the sdio_func device. To
> make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
> also make it actually clear the companion pointer on the sdio_func device.
> Technically this clearing is not really necessary since the sdio_func
> device will go away shortly afterwards anyways.
> 
> Closes: https://github.com/MocLG/rtw/issues/2/
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

2 remarks:

1. This is a resend with Ulf's email address fixed
2. This patch makes the ignore_children / ignore_parent handling
   identical to how the SPI and I2C busses are handling this.

Regards,

Hans



> ---
>  drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 4b07098c33c3..fa1d300211d3 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -373,11 +373,27 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
>  {
>  	struct mmc_host *host = func->card->host;
>  	u64 addr = ((u64)host->slotno << 16) | func->num;
> +	struct acpi_device *adev;
>  
>  	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
> +	adev = ACPI_COMPANION(&func->dev);
> +	if (adev)
> +		adev->power.flags.ignore_parent = true;
> +}
> +
> +static void sdio_acpi_clear_handle(struct sdio_func *func)
> +{
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(&func->dev);
> +	if (adev) {
> +		adev->power.flags.ignore_parent = false;
> +		ACPI_COMPANION_SET(&func->dev, NULL);
> +	}
>  }
>  #else
>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>  #endif
>  
>  static void sdio_set_of_node(struct sdio_func *func)
> @@ -402,6 +418,8 @@ int sdio_add_func(struct sdio_func *func)
>  	ret = device_add(&func->dev);
>  	if (ret == 0)
>  		sdio_func_set_present(func);
> +	else
> +		sdio_acpi_clear_handle(func);
>  
>  	return ret;
>  }
> @@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> +	sdio_acpi_clear_handle(func);
> +
>  	if (sdio_func_present(func))
>  		device_del(&func->dev);
>  

