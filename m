Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242216;
	b=NqmEXLayQbMqHA0VPDpW2qJm+Uo86NhuWBoEiOC2U5H7egCaBo+bW3GVp1z4m9agEnmJ
	 IAmQOFucWbDtPlP3kB7vzUEiUygc79YLhav6mzI7PNVBsS0tKCDa55EXFRtLA0bBS9MbZ
	 MUz2AiUI9z7xl1UyHRblmFuG50CtxnIwH9WOxwdX2X1iD97qBvOXaiNm72n3y1ao829PB
	 Wy587/2mp+ihwQIMG0F99RAxrlrGkgpOFzajgBEutW2Wg/ydw9Aw/maSeHKg/yAa7eZ8I
	 4uoEqZUw9yNuQhJixaUrEjwDtJhML5QZSYmmz9FMC5cPCFHMPOGdH3hP6dOS5iQqaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
	b=wlnMqamA2waoT7+Zwkl4aHEOb+kCkzFYjlPSc4XDx8w9EvKiMRCFmdQe0B8bzfFy2Jqk
	 xQrFbOPALFEYG3qSEhix48OTSvlpQn6aLxBdgJiD4qCPxUfhoRzKFxYgM7LfuARDxsc8/
	 OuHYciY6cWHOfMgk/y87wffxcScJe9LSExfdwOPGvDxBygE6VJFlOUB+nSzuvrs/EyZDO
	 tnHdhFuZB050FTgoiI7dcMIkIv6sJD7q0Kj7oMlCTs2ElL5fB0NzbiEZk7KGeXeVM4M+a
	 JMUM/pYOVKp8NIXGJlaZl4P3oKj0fTJygQyZDePY7m9xq45QRDgUmpbGNt3jZQzrxSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=msfeHy88;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VmCTHo9P;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC060A6F71
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 16:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FC060A6F71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=msfeHy88;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VmCTHo9P
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFKAQ971492
	for <linux-acpi@vger.kernel.org>; Mon, 9 Nov 2026 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=; b=msfeHy88415MBPwc
	L2uACbLQp0TEuRExtyxYzU291teu/v++InscGb4Aaa2Ur6ppwNzx450ymMgkJ6+T
	RsKi8GKr+ln9kS31RG1mwE7HLQ8zS9AkBTfrRvBIp8KaomUIGxjcbXLCcazMAs9t
	IQiA20uJJmBdCDwoT/mRRETRWRxdcF+cGqiUN7XjYq9Siu5kdnHVZgCVgIBcXc5P
	58qz5s4legHs7/U50tGU9KDu+NKv3Ldhtcbc68SZ+oTIE034fBt4Xb7K58F8UT/5
	3l8HcU9tCM+fn3FczPhTZAoOO0DYs/PpWqece//gUUofGWuBUeeGDlkKdyI0H3iv
	EyNxwg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm42mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 16:36:54 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9905fc56b60so926454241.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794242213; x=1794847013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
        b=VmCTHo9P3nq14H22L2oDbfLfwhrGPkp6VEnMTESM3QmN9yZkISASKbnip1cDIwJmcc
         sjg76JJOpSNgENcm2bnxlgHCCYD17jZ8hSHQxbjWxfBOo3TGqvvWXmS58SXeicNUhL7x
         cebL495uTS+qGnYPwbRuMekpiBRWnM/L2Md8xhceG6lRu9FD7Jz5kiDhwN7me89cvu45
         b2E+P5y1RA7YjVF8ET8ehxXXsJU47tY57p3LWCWg/zgoOZIwGtdmJw/+8tfypegcOQqY
         fpRVYKeCuNFztub+JQ0Yw09CHcFFWWuCTxG7FUVK55zm7l0hVAZPvvfMb6rNdMut3c2C
         4VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242213; x=1794847013;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
        b=IafYG7lu4TPGvSonULH98p04KbB5rlT/WI3r3G8GkQFC2eHaqnBocmubyJgVDspDkh
         vCTDhxl2YvR6pz7NCwKaS33MQZRYljkhgayQHVfsSIEIX+0I9y5Z7BHqrLcAe2oBriSN
         YayaG0jBnAv8BO57uFbmKl+8k/iAQ2gZyz51o4qxDW0u/54BdcgZHdpO0nykQkE3AOhE
         K+Xn+T1xY7CUHOhtmoXk1wGmeh7rOIfEX1O5Z4G9ef99Kc0MfTi5MwRvJgzCD6pUKaqN
         XIDrqfrIOuEhMTtenR+drF3J/q1CzGAbUHSoNPp53KkUSZqwwIOF0K1F/ZvNXJ849Xs0
         Ssvg==
X-Forwarded-Encrypted: i=1; AL+hErHwyK3S3/2lS/nV2cesR+6KSyzlX1ef+smfUDSiuzi+vz14aiP+SuA7EMzjzbmKTll+k7ly40lJLxX/@vger.kernel.org
X-Gm-Message-State: APuU4Z8ra6ubhoaHdIGSY1rpCmacJTSprEbX5R1x6JJbgEs2AGEifKST
	DSkwu9ZR5qe+SHRV3gSHVnEi14E93yCRWCcivPPtoq0YtrZUSoSJX4SN01UPezlRKhQpc34UXsN
	IRWbx7ga+MX7IWXLdx2CMfLo+qdJOfFDCaltXQGeqdFGwcQGYwWK9c6IJuhkEyHiZ
X-Gm-Gg: AYBFou33/jojC4SevXJOvzBgSWukp5VOAiiG2fE73KUi9gJn5ihSvrVxIc9cWN8mIJ9
	aA/6272qkCU0EERl4dMS7IX6epzpYRvk4W+d/qYhaLqCUffccaRXDI9ZCeqOkkBD/NTEcnNYU5A
	RkIan2tnrvVAvBGEkw3t52LeGNBPTKkICp9ejjCIP1M9lBdSSNMq621ff/y3jNtl96lrdPMQ5Dg
	AIvLEB7tjXaYo07sn5QIqBnY9igXOgX4bpy9hJzoFXcPfETDKfdC0frXrBrKkWKOqCR5xzAOpxz
	sNBWEAexAGKrOIcKv6Sgt6z53hDixoztss+mzxoz8Jil+/cwgpTSnyXQJW8k+L+6jwZVEg1784Q
	hQrHyDpBZP0TQiOLaE3rKm8hLuzrzpgeM0qzHPHXOUl3wkmjeu+wqs7EKVOkbnc4nSJB4on94Jh
	YUP4clxgiyzxOtN50rFi8HgSTZyozdU7PwqQ==
X-Received: by 2002:a05:6102:390d:b0:7d2:cdcb:6b4a with SMTP id ada2fe7eead31-7d301120897mr5312137.22.1794242213431;
        Mon, 09 Nov 2026 08:36:53 -0800 (PST)
X-Received: by 2002:a05:6102:390d:b0:7d2:cdcb:6b4a with SMTP id ada2fe7eead31-7d301120897mr5297137.22.1794242212750;
        Mon, 09 Nov 2026 08:36:52 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8ebe:809e:5980:89b4? ([2a05:6e02:1041:c10:8ebe:809e:5980:89b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9a9ffsm11476601f8f.30.2026.11.09.08.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:36:51 -0800 (PST)
Message-ID: <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:36:50 +0100
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
Subject: Re: [PATCH v3 0/4] Make platform profiles firmware independent
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)"
 <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX6TWkj7hvt7q1
 UYhrhVgHbwgRzhVAZfdwwg0cUfELQdAOLXNk/2Fz53V5d9zMds4OkymUrRBn6nBfpdik/iIx729
 +LRyzglrtw3J1jJklwpH0u5iQV4QlGc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX9z1h48cjXYOs
 r6Mv3E0OjCVfhu2KU15YyokOob1EmnBuz47Tl+DxgZne9DU7ts+JQRAYNqds+s/ealjv0X+EtRC
 qI8dcjrOv2wPfdoPPAfIDEmq7ls9VU7G7Re1us9f/0paGLMLu61ebqzItpsOF6kWH8DGpjWXv2G
 1Dz3db0EWT2v+aky0htTfbGAKEI9DJJTDGXXf/oMLcJt2151wQuPU4tUTk1GTKU0ArSb8gWf6pm
 yyIbatHYvfRuqTPkLVVYM09oAnHua0soU/LNlnsB/7CeCfo5G7QvPIAnCLTe1iHlAp1R0lGvPai
 P40hVhs7I/Uxr95E6efeKr48xqR+pwQZWPsPuf/7GTbYHNrESBBE6r0g1tjvS3vre7d1ZZuQape
 93Y9h0q4LonBKxE3QgViEvColpGSyxZi2XFOheEO3MUklL3zFvhGWp+hREcjndsAIptLl80zw7+
 ZP1xOsKi8AbVfLIt83A==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1f6a6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=I2DTqkVBWxGU35LqPC4A:9
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: TzSFxJEqakI18WXLkklocCscp0Up2AaQ
X-Proofpoint-ORIG-GUID: TzSFxJEqakI18WXLkklocCscp0Up2AaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066


Hi,

sashiko validated this series

Is there any other comments for these changes I should take care of ?


On 10/25/26 00:34, Daniel Lezcano wrote:
> Make platform profile selection independent of ACPI firmware.
> 
> The provider API already uses struct device, profile enums and callbacks;
> it does not require an ACPI handle or firmware node. However, the core is
> built under drivers/acpi/, its Kconfig symbol depends implicitly on ACPI,
> and initialization fails when ACPI is disabled, preventing non-ACPI
> providers from using the existing firmware-independent class interface.
> 
> This series moves the core to drivers/platform/profile/ and introduces
> CONFIG_PLATFORM_PROFILE, updating all existing provider selectors. It
> retains the tristate configuration and platform_profile module name.
> Firmware-specific discovery and profile operations remain with providers.
> The core can also be selected directly through its Kconfig prompt.
> 
> An optional ACPI adapter obtains the legacy sysfs kobject and is linked
> into the same module. The generic core contains no ACPI types or symbols
> and initializes without ACPI support or with ACPI disabled at boot.
> The existing /sys/firmware/acpi/platform_profile and
> /sys/firmware/acpi/platform_profile_choices attributes remain available
> on active ACPI systems.
> 
> CONFIG_PLATFORM_PROFILE_LEGACY controls the backwards-compatible aggregate
> sysfs interface. It defaults to enabled to preserve existing userspace.
> Disabling it omits the legacy sysfs callbacks and ACPI adapter while
> retaining class devices and kernel profile cycling. New userspace should
> discover and control individual class devices instead.
> The interface is deprecated, with removal intended after the 2028 LTS
> kernel once userspace migration is complete. A shared pr_notice_once()
> warns on legacy attribute access rather than on merely loading the core.
> The default remains enabled while userspace adopts released class-device
> support; this series does not claim that ecosystem migration is complete.
> 
> The existing firmware-independent interface remains:
> 
>    /sys/class/platform-profile/platform-profile-X/name
>    /sys/class/platform-profile/platform-profile-X/choices
>    /sys/class/platform-profile/platform-profile-X/profile
> 
> Non-ACPI userspace controls providers individually through these class
> devices. Aggregate selection remains available through the legacy ACPI
> attributes, and aggregate profile cycling remains available to kernel
> callers. No new sysfs directory or userspace ABI is introduced.
> 
> The original first patch, "Separate handler locking from sysfs lifetime",
> fixing the handler access race and sysfs teardown locking issue, has been
> sent separately as a standalone v3 fix. It is not included in this series.
> The base tree used here already contains that fix.
> 
> Patch 1 extracts the core and initializes it before built-in consumers.
> Patch 2 completes class-device notifications and registration cleanup.
> Patch 3 documents firmware-independent profile selection through class
> devices. Patch 4 makes the legacy ACPI aggregate sysfs interface optional
> and documents its deprecation.
> 
> Validation performed during development (before this rebase):
> 
>    - ARM64 built-in core with CONFIG_ACPI=n: W=1 build and sparse.
>    - x86 modular core with CONFIG_ACPI=y: W=1 object build and sparse.
>      Both CONFIG_PLATFORM_PROFILE_LEGACY=y and =n are covered.
>    - Full x86 kernel link and QEMU boot with lockdep and list debugging,
>      with active ACPI and with acpi=off.
>    - Firmware-less providers exercising common and hidden choices,
>      profile reads/writes, invalid input, mixed profiles, cycling,
>      partial callback failures and POLLPRI on the class and legacy ACPI
>      interfaces. With acpi=off, class get/set, notifications and kernel
>      cycling are exercised. Both runs check that no new aggregate sysfs
>      directory is created.
>    - Concurrent sysfs I/O with two persistent providers while a third
>      provider is registered and removed 200 times, last-provider attribute
>      removal and repeated provider module reloads.
>    - QEMU with active ACPI and CONFIG_PLATFORM_PROFILE_LEGACY=n: verify
>      the legacy attributes are absent, class get/set and notifications
>      work, and kernel cycling and registration/removal stress pass.
> 
> The provider API and profile names are unchanged. Aggregate writes retain
> their sequential, non-transactional behavior: a failing callback does not
> roll back providers already updated.
> 
> Changes in v3:
>    - Send the original first patch fixing the handler access race and
>      sysfs lifetime locking separately as a standalone v3 fix, including
>      the requested profile_lock protection comment and Fixes tag.
>    - Reduce this series to the four remaining patches and renumber them.
>    - Rebase the remaining changes onto the current base, which already
>      contains the separately submitted locking fix.
> 
> Changes in v2:
>    - Add the Fixes tag to patch 1 and explain how the mutex-guard conversion
>      reintroduced the teardown deadlock previously fixed in 041142d7d252,
>      and how class-device support subsequently extended the affected paths.
>    - Drop the proposed /sys/kernel/platform_profile/ aggregate interface
>      and its ABI documentation. Use the existing firmware-independent
>      /sys/class/platform-profile/platform-profile-X/ devices instead.
>    - Preserve aggregate selection through the legacy ACPI attributes and
>      retain internal aggregation for kernel profile cycling.
>    - Refocus patch 3 on class-device notifications for direct writes and
>      restoring aggregate visibility after failed registration.
>    - Update the Kconfig help and documentation to describe the existing
>      class interface and distinguish it from ACPI aggregate selection.
>    - Revalidate class controls and notifications with acpi=off, legacy
>      aggregation with ACPI active, and the absence of a new aggregate ABI.
>    - Add CONFIG_PLATFORM_PROFILE_LEGACY (default y) to make legacy aggregate
>      sysfs code optional, independently of class devices and kernel cycling.
>    - Mark the legacy ABI deprecated and describe removal after the 2028 LTS
>      kernel, conditional on userspace migration. Emit one shared notice on
>      legacy attribute access; retain the enabled default during migration.
>    - Move the legacy ACPI ABI documentation from testing/ to obsolete/,
>      document the replacement class attributes and update MAINTAINERS.
> 
> Changes in v1:
>    - Initial series extracting the core from ACPI, separating handler
>      locking from sysfs lifetime operations and retaining the legacy ABI.
>    - Proposed a firmware-neutral aggregate sysfs interface alongside the
>      existing per-provider class devices (removed in v2).
> 
> Daniel Lezcano (4):
>    platform profile: Extract the core from ACPI
>    platform profile: Complete class notifications and registration
>      cleanup
>    platform profile: Document firmware-independent profile selection
>    platform profile: Make legacy ACPI aggregate interface optional
> 
>   .../sysfs-platform_profile                    |  12 ++
>   .../ABI/testing/sysfs-class-platform-profile  |   2 +-
>   .../userspace-api/sysfs-platform_profile.rst  |  55 ++++++--
>   MAINTAINERS                                   |   5 +
>   drivers/acpi/Kconfig                          |   3 -
>   drivers/acpi/Makefile                         |   1 -
>   drivers/cpufreq/Kconfig.x86                   |   2 +-
>   drivers/platform/Kconfig                      |  35 +++++
>   drivers/platform/Makefile                     |   2 +
>   drivers/platform/profile/Makefile             |   5 +
>   drivers/platform/profile/acpi.c               |  15 +++
>   .../profile/core.c}                           | 122 ++++++++++++++----
>   drivers/platform/profile/profile.h            |  17 +++
>   drivers/platform/surface/Kconfig              |   6 +-
>   drivers/platform/x86/Kconfig                  |  10 +-
>   drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
>   drivers/platform/x86/dell/Kconfig             |   4 +-
>   drivers/platform/x86/hp/Kconfig               |   2 +-
>   drivers/platform/x86/lenovo/Kconfig           |   6 +-
>   drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
>   include/linux/platform_profile.h              |   3 +
>   21 files changed, 255 insertions(+), 56 deletions(-)
>   rename Documentation/ABI/{testing => obsolete}/sysfs-platform_profile (70%)
>   create mode 100644 drivers/platform/profile/Makefile
>   create mode 100644 drivers/platform/profile/acpi.c
>   rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (88%)
>   create mode 100644 drivers/platform/profile/profile.h
> 
> 
> base-commit: 8244dc8f69f0e73cb1789355260b7d68bf5494e7

