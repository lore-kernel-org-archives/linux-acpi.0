Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371076;
	b=fASNrSfZjEHS/HwqWY9BxChQm0idzNcPaZWW5jL7Sdf+ydRD8IV8zvCzN7BUzvX6rKAG
	 xd7vT/jmUCEqd/MwHo4dJ42xNPgRMcmdeVbpNGhFkq3JIRVAkPdD9TRdAUN+2xtLwPjwE
	 5qgVeZQINhpqr3LGUPuYO7K4tlPsB93t32JNbQetD6OHwb2I3n0K//pDO9dFI5ii4O2mq
	 KDVxy5BpfqAg5+snHulE2HEoAEI9zMJZm8XUVUkrprvB1ZFdQ4ToOXtHcNw3JnQxtD+p9
	 umFGV8qKyeFuhz797svgHyENkG00AuD5SZvjv4snPZjQ9Ebju5bT+bSFFf+BISpxIOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371076;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
	b=K1Eq3iZquA8uCYIBxu0BEZUXbi9YdXT90QDocdoZSD7V8MYnbv0e3pa03iHsWQgAaxah
	 wWtrEWwv9T2tcPD1YPYwgtagApb7BCGG9Bsdv7bNrjtCHWlONiWnx3Joti5Jkv9/EFNVL
	 9MtMKYosZrjFIzKrCOuidz/IxaG0/hz71uTIT31EioRQkvxix5lZDcml9e6evT7lcm+EF
	 xfJH4jKsT2bQLtldhwhqbc1RHhmeGFpL5VWJ1jkG5m28vzAVAO9B/GsorFnAL3VzABKJI
	 IR2w0emOHxosg3lsHcC0a6UVjQD1IGhkeW8d40VrSRQRuOTEnLVOvPMDafXgIe+UIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PWrhjmw6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="g53d/L4+";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267C606A327
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 04:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7267C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PWrhjmw6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g53d/L4+
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1t25S898399
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 04:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=; b=PWrhjmw6cWiAIUOR
	nBxnNT8cuBsNpQspycxSw3FhkVArCWOtiHpP+9QEaHqPVqHRw70dmX8aqaQBfAU0
	iSZxnMb8TrjLC/4nDBbKGnK3AuWxMYxp/htIhqnJ0WPfiVKtiQmOeqdKPVdVIiG/
	xXFBynvSMycO/H+NV76X1knr0B/Z/bOoj5VbzxoDPswFl86HCta+EBWmnWRjdhFp
	5jbZ11CqvfgCOHpaScsXW1LiLxTyGMltVDkk0Z9uvbT3XvGaT2FhyhoroHACNgTP
	K19gk9CdvMLJ7fBQp7lQdwxkgTgoj1+MXoxYqPw8gxcaOxGxLbwI1+qxXcmwZoWF
	94PuSA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufv94w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 04:24:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05b68f851so2184700b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 20:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794371075; x=1794975875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
        b=g53d/L4+RGl2Wb2GgCTc/4kf6IH79alfY7m7YcSOmGU/12MMQnQCZG8abz+p+IHPLd
         ZN+wph10O8FB97tlScX8BPIiUDBxA+4w8T50DINoRR3riumt147KmOZbHBcPvEcwSXEo
         KxJviEGhhLGgbkiOvoDE0HQOIkNSbOZGn2LIS7Yd0yp8ZvfS5MYV8qwzPBGWHylSrsqk
         ukek0/KNJtykyETChz/MFfFnpoyis5FI757ZMW3ZzLtvLNLeAf/evKlaeOfPlreos+de
         Bg9OqLUNp8acrCUumyBI/+GmzVFYi2730RnTBu594psuwRDMcRq/au2dRhnFghDSai34
         pxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794371075; x=1794975875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
        b=s6buqA7316GlhXZicjBub/tl6fDA5VuIODXv+E2jAX1xqTRug1/87zUadHMWGKQFXJ
         mV27Fj+6HDxWcdISvX7d+Tiq7X/XUQ3iichoDjP/30w90g9Bnuz/k3zZ3dTD9hnpybCk
         SEtlBn9DjzqlxwJEuDa6BXIHCNEQDF/tTK06UHOKJ25XZPpG9LIjI6ulVPq5ai3DCWzo
         bUd9ORJgI2Li4BQ2vRaFK+fC5HTY6VHatakxT/mu+9SYoY6Xq+vyKSABTM+aY7/J9Zze
         z/aCQ1IQFz1V2MVn8goLiZ2qxhjRh2tNK8O2c7tK5r7re4ksI+b/hYXyWoAIPVegTXS1
         Ty7Q==
X-Forwarded-Encrypted: i=1; AL+hErEucpJNAjzIfYHuTPlxZcMNZi0Gfloc1crqQHm34aO6ET9NbeTug/eTI2ZYlgJiNhvo5YfbNRB9Plyr@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZuzRlPtzhl1s1J5M/x2VTZuntVNYp2RUiTlErRnDeIn0QM+iO
	qPq5COuS7ZXFDon0ykkgKDczwKIo4Fz4l5Db/GOmjs3q99tmf7ql5TI9M2ZkzmkInKb+/3S2ni6
	Zt1T8zULWs9lz2N0nKbMdeiD2kA4v/h7bNW1RX3+0Q7CcMB4gGghYLQ4E3kUWGUkZfWVItw27+O
	E=
X-Gm-Gg: AYBFou1aWZr6OJf1BvCRXTXTgpSGeJG5izyqqA4Pzl0XHU11j/q+EALB2RoksDlBFTD
	9m8FlCc2Av5lStXfbygIa+1eIAJjnmIg2OIW8OOFZvPoam8LV7ayG+chscvGSnSGsivjpLjIyoY
	Yy5i5m0eQ0FXtBQdSL0Hp2gzvcFqFHJXNFBFwou1XCwTUVd1nyp/KIO9sQVG2c3jHHNnrW7WEnB
	cQn7xpPZJJA2YxdTEU6eZo4B9cOJKcJc4+9k9doaUzC+/wW2wqzuSjO7VPml8Ikto3KWrgYlRm5
	5bp1839nqkuPdhSZnx2t/P34aOErX3l1JPdii4laYIq0WTZs+hmYjiBTi/y1izP0ok5nkUAM5FG
	XVpNswY2D0bD09pYNyOFycbh5qJ/gdEVMFpH9nzNu0uooY0/MWtafLKy5C5R5JIg1DJqMZ8Im34
	41ZuuKYgGLZwj8+UrK9xPvAFJbp+6C+cqA
X-Received: by 2002:a05:6a21:7010:b0:3e2:3392:53f4 with SMTP id adf61e73a8af0-3f2fda98bb2mr939333637.18.1794371074773;
        Tue, 10 Nov 2026 20:24:34 -0800 (PST)
X-Received: by 2002:a05:6a21:7010:b0:3e2:3392:53f4 with SMTP id adf61e73a8af0-3f2fda98bb2mr939310637.18.1794371074260;
        Tue, 10 Nov 2026 20:24:34 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaad41578sm1712051b3a.32.2026.11.10.20.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 20:24:33 -0800 (PST)
Message-ID: <cbd2aee7-95ae-4d30-8458-b7da2910867f@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:24:29 +0800
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
Subject: Re: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration
 of function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
To: kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        jelle@vdwaa.nl,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <202611111027.YYwIlIDB-lkp@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <202611111027.YYwIlIDB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z8lfjje-sxd2pCooCGZHjrACXPoqveLa
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af3ee03 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8
 a=Q1K4HTE4AAAA:8 a=O2upucybYjXuBVFjdQwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=v8M4KpxsNpHYtUgu9mhN:22
X-Proofpoint-ORIG-GUID: Z8lfjje-sxd2pCooCGZHjrACXPoqveLa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxNyBTYWx0ZWRfX/Y9hH/kD3+1H
 LYkRhJAcTLOU1DBjYDD6HJ6qtUsBi91Ulhy0Wng8tsnQmNU5qmrzS6XllRThj15HVw8puh/AMUN
 Bgk33Vb7BPHbKZ8cietXU2C/JVVRZ44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxNyBTYWx0ZWRfX6wZS/auMERg+
 9vo1Y7m6yZ679NdQyKYKmPYdA98xlE0Esxso9VswE1Hl8cjT0SOfsJLcu/MNRrCcSBlL38s3f2j
 rfa/FB7VP4lDkhKt39PFga+hfS4WmJAYkuicJswqitnV0G+LyMXZPVUwF+NVPGl6qOJEa3M6/so
 as+fXKML2Hwp9XM4OX7hTHb8O2iS8/rqbSfjIRn/6l5OSgyaAhF+9FdjQDJPoqRVX9vyHHEGiIT
 S7wYdoYE2WPlfibfPS0CXfbXnv6FiddXDyW2/qXqa5XDwcLgcYeA7MFh3WCHiu04y2bFAQo/lZc
 ruL7phnL2Qb19Q/WiNakKX1KmDCVu+XaZQHhoG0vsEjQ98v4zkmL1o94HpiIHlz+pzM1WncXDkm
 D1CBjyoZOXUPXT39t2419lj+nKtR2Kk5ATdmyVIKtyFRo7TiyWDMcSpX2DvvOAZ7ntUNZxIHiol
 a6PF1JKHVc8kbEh0Bfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110017

On 11/11/2026 10:33 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
> commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'acpi-battery' into bleeding-edge
> config: x86_64-randconfig-1011-20261111 (https://download.01.org/0day-ci/archive/20261111/202611111027.YYwIlIDB-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111027.YYwIlIDB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611111027.YYwIlIDB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/platform/x86/acer-wmi-battery.c: In function 'acer_wmi_battery_probe':
>>> drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration of function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_register'? [-Wimplicit-function-declaration]
>       292 |         return devm_battery_hook_register(&data->wdev->dev, &data->hook);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                acpi_battery_hook_register


I took a quick look at this merge-ordering problem:

devm_battery_hook_register() gained two new callers in v7.4-rc1 while
the rename was still pending:

Old API (devm_battery_hook_register) users:

   c72dd9994952 ("platform/x86: add Acer battery control driver")
     committed:  2026-09-18
     file:       drivers/platform/x86/acer-wmi-battery.c
     branch:     platform-drivers-x86 -> mainline v7.4-rc1

   929433336e0a ("platform/x86: hp-wmi: add charge_behaviour support for 
Spectre 8C15/8C17")
     committed:  2026-10-14
     file:       drivers/platform/x86/hp/hp-wmi.c
     branch:     platform-drivers-x86 -> mainline v7.4-rc1

New API (devm_acpi_battery_hook_register):

   c27a6fd6b403 ("ACPI: battery: add acpi_ prefix to the battery hook
API")
     committed:  2026-11-10
     branch:     linux-pm bleeding-edge (via the acpi-battery branch,
                 based on v7.3-rc2)

(Please note that the robot only reported acer-wmi-battery. The hp-wmi
should fail the same way when CONFIG_HP_WMI is enabled)


> 
> 
> vim +292 drivers/platform/x86/acer-wmi-battery.c
> 
> c72dd9994952eb Jelle van der Waa 2026-09-13  275
> c72dd9994952eb Jelle van der Waa 2026-09-13  276  static int acer_wmi_battery_probe(struct wmi_device *wdev, const void *context)
> c72dd9994952eb Jelle van der Waa 2026-09-13  277  {
> c72dd9994952eb Jelle van der Waa 2026-09-13  278  	struct acer_wmi_battery_data *data;
> c72dd9994952eb Jelle van der Waa 2026-09-13  279
> 4dd10fbbeb9c33 Kees Cook         2026-10-28  280  	data = devm_kzalloc_obj(&wdev->dev, *data);
> c72dd9994952eb Jelle van der Waa 2026-09-13  281  	if (!data)
> c72dd9994952eb Jelle van der Waa 2026-09-13  282  		return -ENOMEM;
> c72dd9994952eb Jelle van der Waa 2026-09-13  283
> c72dd9994952eb Jelle van der Waa 2026-09-13  284  	dev_set_drvdata(&wdev->dev, data);
> c72dd9994952eb Jelle van der Waa 2026-09-13  285  	data->wdev = wdev;
> c72dd9994952eb Jelle van der Waa 2026-09-13  286  	data->battery_ext = health_mode ? &acer_wmi_battery_extension_v2
> c72dd9994952eb Jelle van der Waa 2026-09-13  287  					: &acer_wmi_battery_extension_v1;
> c72dd9994952eb Jelle van der Waa 2026-09-13  288  	data->hook.name = "Acer Battery Extension";
> c72dd9994952eb Jelle van der Waa 2026-09-13  289  	data->hook.add_battery = acer_battery_add;
> c72dd9994952eb Jelle van der Waa 2026-09-13  290  	data->hook.remove_battery = acer_battery_remove;
> c72dd9994952eb Jelle van der Waa 2026-09-13  291
> c72dd9994952eb Jelle van der Waa 2026-09-13 @292  	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> c72dd9994952eb Jelle van der Waa 2026-09-13  293  }
> c72dd9994952eb Jelle van der Waa 2026-09-13  294
> 
> :::::: The code at line 292 was first introduced by commit
> :::::: c72dd9994952eb09442827caecb945474ae3072b platform/x86: add Acer battery control driver
> 
> :::::: TO: Jelle van der Waa <jelle@vdwaa.nl>
> :::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Thx and BRs,
Zhongqiu Han
