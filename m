Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453753;
	b=GuQH84g4hBs36Md5slAGG37wbN0i8Ee7GuXWc2uDwo1STaNNyRLjFkvE0fkDsC81cO0g
	 8sqpj7RWe9igy/GxICZtsVWx1XkDsjZQrk4aAto04Zg6JYc9UbiaRPY34uorZ7UB3szo8
	 Ll258JhfRATeXJ9idEHlSNaAYw2NbIh0GrOZHyLqu8LrePBcEDHdxQJJPA7QX1l+qo4OI
	 jJrZO+vdxsMYgz81xKpTOxc2MzpRm3IVs4X+YS11LU5VLhmFlnWE+TplYy4jJXKTU+5J0
	 wOM2Azpln65N76o6SVCghbkzHxm1N8yjDuURc2aQLxp/E20RHxYJs1El0iL0Y94o+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
	b=i1gdN30Xl6BcOIoIs+iiDpVwBu8WwLHHSms27C83hvheu1Kboob8XIWOqqZ7ktpN56Dh
	 5W0/9/fsgvZUVQdxIgup9Zq19Mc1qhAFLgzFYOumz2wE6FXpgISClIC1VhQUHb7VHkMAS
	 vXHvqOBobVzM/9sRoJ+U+DCZ7jHeFHy9rxrXwpYcSQxUICw+qRxcceqHYdgY9lgo4mH39
	 hQmuG7YMtl5jkmzpL9maKyRWHbJTOfafEvolnRdwVjeTu+oQo0jKP3s+8hiVz4l6Og3le
	 TP8cJKuFPxEwl84a8l44zAYLlepVd6oOuDfkg7OUvrN5Nfj8Ew58VQeksYfYohuIIfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CA606A321
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZWvE3607573
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=; b=LOpIkJFk1qcw9dNR
	IGn4sA5UCOtmAyOLiqsLJomBSihf4tRG/wVsCktehqAKlkuNZgtYphQhJjW6Y110
	kTG5YWTTru2Y4kr1/8Qaz2fJNsQUA5m5Ka/oMwTdFZcaTTHwgtDbyWShJX3YM2kD
	EmjFp/er0dKt0SxCLGtWua47LlVvaLI2blykILXXkO3UwS+VXzUWZRxAMyr0kUAL
	D2ZraxIHHVBA5T54djHiEvNFaJ4a29MejhkgHnvgHbDKd2hHf1ktkpCFc9c1JW8w
	HlSYTbk1ggYxW2ytlV2rCexQSaEEvjbUKJ7IAbCnqhsZMIW4j1I8fuadDWk7094Z
	MUoEtQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawn718-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb5375cd68so34538515ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794453750; x=1795058550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=YfcOO+8b58GCURpz5PXBLv24Uv1uH24sUAtfEyQOlUc9OwlPaHxRxUSu2Wb/xdKsDw
         9nNqgW7xq0qxgqaMr2Wbnrv2lxWwKO4qCJVKmNAeaWhLXOGKsyLr2FO3tqwiyEMcAKtF
         eopnhJ2XDhlR/ff9EIlREaT/fP6MarfDEOyZpQsDkJyCbP5b5QTm1G2QanAcyDn6yL7u
         0qFRl5AhkJ0RAI9Wh563lPvd12X53SiZRpjEphQr471LwLTDeEKjlyJMstJfqPSTjrJF
         KTU8mWBvJpuhlrCtzB3cY0UePYFekSC+EjfzsbCf/ghfk3y3qXlpZsicnvGR3fXBghZJ
         RL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453750; x=1795058550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=fq/l67TsrQ2L2RRmNGliJYZifwu2f/XlJiu5xuSrPq171EK+g2oY9UxzQrzM8YcHTy
         C9pdodCbsD02dE+EMaxsbnMRfgLiaMPbxJ4LeDWhbgMwKDTZ8NWhEK8Vfp7OG8XRsQQ6
         BTWIz7fYWpJSNky0Tkzxm0Ngcaei6VhPCVL9oxe6+6mF/iJurQ3+qxeSCVU1a0FehRJv
         i/W9afOUg2j5MF8MuviDQTtVa8a4MDO3Li9t+76Jnt+B/9JZcFflMekxiiP/mBGs0zsh
         ENnJ2CkIFiz0W0Gblw0ZooFDYZpX4IHXOS0f9XnYgX43Lyqk7n+Ut4KCrwmvOgu66k4t
         eN1A==
X-Forwarded-Encrypted: i=1; AL+hErE9cqtHfsQwk/gdfIFMxllIftSVai+hGaBHPUHzMVaJGe44OoTalQjMV5dQYyphMyhgKMN4MXqHCRta@vger.kernel.org
X-Gm-Message-State: APuU4Z/EN9hPOqQ3DEH/BBMpM+bTjBu91LWymv6RsN/e1Ly4tMyMsHT/
	C8yIf77j2IGAPHaf7XIyxklrlsOH3Rsdwm9iZkPUkmi08znPkW0pJX02Ix7TZrYluzJpjXhn8Md
	rW3H5d91pjFyGJ81VCN72K3TrQebZvEKD28pPfcn5XtbEMA6sNfxpMALlx381Gw9V
X-Gm-Gg: AYBFou3vLwBec2E2uF51LPgAdILcoSU7SBJi6KfmkMAKeBUfdKRCSlbp5LHQdrGsibt
	tX2oEGBbg1hpmtW4sSlqB5Hymc7HQD61BkjG83Aa0oH5TInnb1heKGbgy6jd6X55tAtdWXGZob3
	fr4lPot7jx8c1f+VgIL0KdSwr+OIEyXzZjQDPXQaEMSYsBcjGWJPAsiSuzKk1Q+zR0nmNpoI0RM
	embA11vMxUO8l2tegK9X6DPUNazGB0O4MtlmveT7domEHsU2rgg5OiYNdT7EzvKEN6Ho9qBnUvm
	pmzB3MRl8q+4z24A4DvgpUZmynewGnKuS33QDAhvsXAszrIo1rZrTYWlYH0pTFaXA0sm6JtQmO3
	rG7ACjkEnB8AyPVytptE4YcDSOlCod940L2levHA/O47mS0pVnzpB4Sf8n4lcuniivu+bjzNi3C
	DNlVjc8DaJq7xhtf6PWGM8d1frbESE5wx/wYp1uX8+GsXP3w==
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38209005ad.54.1794453750547;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38208695ad.54.1794453750048;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dfb58dsm26134275ad.66.2026.11.11.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 19:22:29 -0800 (PST)
Message-ID: <acd476e0-fb24-4f11-b917-c4e86f86171a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:22:16 +0800
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
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
To: Pavel Popov <pavel.e.popov@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfXwXGcFejUAMM4
 ZClw9BWIvHGMrsqOjuQTqPgzdOgKrKppM+jwwGmsHyO45v+z0iqsx/DoQ/g+w5g4AIbq7XFLOAx
 ikPtfj5mI+LdpnWU1HTKxz7WiZQ/bB8=
X-Proofpoint-ORIG-GUID: I_PGI-xgljlI2INf5_JNSS-m_O9BMrZk
X-Proofpoint-GUID: I_PGI-xgljlI2INf5_JNSS-m_O9BMrZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfXx6W1+CQCPIuB
 qLA6GpiYXERDodlxxA1afJ2ALwpOM6Z7ZSrtr2zEAAPDUSlFTx/CdyyBS22DM+sMr1d6hbx3JmR
 JNQnRaTqLfBIN34UjnLAnvWNH52Cl0pcEQ4Y0QH2M2aJ9XSSVqbrjmFjMMxhcwNgi1uzrIQreSA
 tPNRbSZH8XUk5LyMXE1x5BbjUfBt/P3OxyOSpGNWvL7woQh6PBAAV1ZQcSfLB6VshiMRMCcOWfK
 plTDNZkkQ9qvSvNNA7F1Z3teUwF4WbclhpGrdXPbS/0Sgw3P+F8V9jIkIO/rPM+LKPkv3VPY/nt
 Oo3XtMhht/sURzRprF0vr1Sntkyr46ZJWeON74dg6Tt+10p5s8g62212DUH3dZp1/ghehgbd4/u
 VJOIVFlCI8UvhIYGLyEn9Bab7zHOEWayjqm+b1u4X2J9onTtwxX5ylNIqiSDt+Jm7BY7lQD6u7I
 2GYaxgvm3MR5CT8fH3w==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af530f7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=L27Nr_72VT4YvYD4_PkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120013

On 11/12/2026 7:48 AM, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.


Yeah, this patch strictly depends on [1] (series patch 1/3) being in
mainline first; otherwise non-x86 builds break.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>   drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
> index 2ca8f1aaf2e..0e33865f9d3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -6,6 +6,8 @@
>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    */
>   
> +#include <asm/cpu_device_id.h>
> +
>   #include "cpufreq_governor.h"
>   
>   struct od_policy_dbs_info {
> @@ -26,8 +28,6 @@ struct od_dbs_tuners {
>   };
>   
>   #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -
>   /*
>    * Not all CPUs want IO time to be accounted as busy; this depends on
>    * how efficient idling at a higher frequency/voltage is.


-- 
Thx and BRs,
Zhongqiu Han
