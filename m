Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563534;
	b=Kt+SjFDOUktxJACGBeOp9Qd7arG+DtkSDdUvr1Av+bk0zhZS0OvHap28CimWLTq0qARk
	 e5VXHKw+eW79IaMpI13uiYTg8cbTiBGwcvndQG9VgtQW6RXw+jKdd2AamJxmTVA3xSxxm
	 vBQPz9155dJaQA3Q75FYI+irVGVm0sWCTglIpX/fSxMqMXKIl7ocgawN8AXdogBYSAYIE
	 /+cFZJuHPaFZooiMYx6TVe2uOGsaaxD1KA2XEo0PIS18ES/VwOLXuzaGbrlMmHi8XfM6D
	 WSGYCJ/hrkoDqjNALQLBAYxSKpYyQBcuGDYrazDsAsSgt0lS5XZO2WsiN+ZeTL74cSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563534;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
	b=MmVIyuFS/FwlpEJXI4GUrOofy+S7egAxFkZkk0/Dvw5bJyFllFPC9Lc4D3ukQVpSm9cv
	 uOGH6+zJ5jxr8lDSB+wEECEEl3hX/VALHLTKjdwPriL+h9sjGSabQ8PJ31MLSCpCUJbd8
	 B5TnbvQ5yCeepqX14gSmCg9Zkdkcjy7shzb34LPHJ7YIJ5VjR96URu9k/6PUMifuK2pOx
	 nMzokUa6J/OBmg10Ja8NE+L1mSBUxVljh42cSSnXyn1BWq26nSSpjPV5TPpSBPl3Fp9BJ
	 eZglGNW50VBTwkQK8H+lpIJNB6uoYsOAqkVKYGUhf3+cPQPTVtSgcIZ6VYxM77KE2Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PA5TPt4A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBlgxb+y;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D8606A321
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 09:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PA5TPt4A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBlgxb+y
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VH5n3653112
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 09:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=; b=PA5TPt4AiyN2M7qR
	6qlpPBiRG9Srj2CvMMY/VGmmN3bvgLGTbWUkKCBRi132sc+aKVL6XR0pdoNSsAzc
	9UcJM8+o4QU2gDmaSxM/CK2e4o3m7/SHHPzxIlBGxtdzRnxbyESSjwfxwmF7jayI
	VexIfz9ABCtz8Xzm1tNj2kSEY32njRA9uWenbAjrPYtaroL0+TSHCsZBDNahQkOK
	O9rslZ4EXNMc3D0xWDU7pK3mhqAmc2LEFTotucyQTy2rbBW3fsvVLpYxJ7JReHoe
	eejX3P3gJkMDm23rXWIGRkFCwcFDo/YGbkhXXmGhkFRgRoF7mWvrhPxbHuhOLnTk
	C3hakw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwafqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 09:52:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94958b50eadso20918585a.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794563532; x=1795168332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
        b=bBlgxb+ythUFOa/5NUKa1DMYkYlmt+dTUsy0owJ7bOHzTw3MRgu9V9SF3A7ErFd0H6
         Jxqr3n5iPCOJv2xNGra+Fc9LHtCTgmOeiVbkK12USlqjQcm18p+k1TXedjIuhCd3MkS9
         acwKGFnjHZkDPdGVBD3JZR+nxx1x8gptvFwe7QqZ677E1Xk7mGpFSipbiJrucTuKXmis
         pyGEesFmP8Oq7Z+fiircEEptUMko54LD5l6HvvX3PRdjYMen20cKpxLl4kpu5Ma9iEfm
         4LLN5hiHDX6d2XuKsiO+uLJdV/Up/keu3vfe9DlAsL3oJxR5rrT8YZZ66dDXpyZujV5x
         i6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563532; x=1795168332;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
        b=zhxeGbsFN8n/rzndolwP/0/+iFoGrqX9K5OpUiyHMOT3/nVWmYoo1Nqnzy/mYTIqby
         HXvtSFyR2DzSIHxL1LuCdNriftYxDt1rpdh/u0bZ6kauVAvhrdF/eHtmdE0O4JyKUz2a
         GfF9sEolg3qpog3pd/2ggRsZDX74F7/q8bQgjuXzCyocztUTleTm6im52ekmdfRAiHCc
         qDEbveujjN93LgnsvV7feZzeHyx87wVB/iDPnRPtqqYtB923NbisGH/9rY1H+EiQzFVS
         lCIIgFZAUt2oAA0tgzSGP5HyNIqEDAn5KoreCo0PVO8o95Q4Amf4ddCktIGQ6LorMI/M
         FxAg==
X-Forwarded-Encrypted: i=1; AL+hErHSuG9+yqUmND1cEqkiORRpOVQTivDdjsadjb3orrBOWiMN62V2GVnAfK0h9gYcG/l8jYjdoKq9T3w6@vger.kernel.org
X-Gm-Message-State: APuU4Z8DO1uIjxB4dpLMmYDFoRy/l5eXX62CVPdONOwWg4uyrAaS/ZEt
	FE+P7npMNkHFLOf9X330ZH85DWaR9FhuYo1whAAdShbNC8o1cWPsa7oe+xYqvpCjtFhoDmloW8V
	w/VsdaNDcoRgT9C1XY954sJBOLBHw4EtEKf2cA/PCsWVi2Ek80KYaJjOy/M/D8+qG
X-Gm-Gg: AYBFou0ouIof1vXrOBWy+gNxqupeMt3NrBWgCw+5YND8VFBtmg+lGZGclg1dEBZFnSb
	UIJiaiOkzOiiflalbr8l5UToHN7dNWTMSKGkP5a0JQkmZdWkws+d7nk0WnHO94wyMtohln8Gm87
	AHIzvHERNLlnDboorSAf9hcISJvGgsvASp7fHqU9FexTqyjiN49jEgoc2UpGwbFe6hzYVVZBVCq
	XtZFUKiIQ03GUw+McOpa2D5jc59F52ylaPZHaoVfK19HxgDgbMCsz/EMCc90LYQT3MurDUL+a03
	+31AFcujOpOLUWcxTbDzJPmoutXtbjj2VSw382uPkWkErm5Cx7bvpyocs1ThrtfpRdfI5EGkPiU
	f6l+G3+/E2ARtnczmEwCoLfdUZTuQEPT+mF3IuO1MtQuD2cZfc/hsubnGhUUCarI6BkDLI381XS
	TPZR4gMSwMXqhod1pplHkmRRdsnyJRhVPqdlHx4+lLbwRc0CEzuQm2aRv0Ojn6YWtrhtnz+axGA
	+5nsH6NtJwejpaaNeQkFBL+SNYv/ZhFAkeY6xxeMDrE
X-Received: by 2002:a05:620a:6606:b0:93c:7955:afd9 with SMTP id af79cd13be357-9494bb9e1dbmr296002785a.52.1794563531924;
        Fri, 13 Nov 2026 01:52:11 -0800 (PST)
X-Received: by 2002:a05:620a:6606:b0:93c:7955:afd9 with SMTP id af79cd13be357-9494bb9e1dbmr296000085a.52.1794563531469;
        Fri, 13 Nov 2026 01:52:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm73666766b.27.2026.11.13.01.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:52:10 -0800 (PST)
Message-ID: <b47bcc52-b969-4337-bd86-890b9cd80c3d@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:52:09 +0100
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
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, penhouse24@proton.me,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6ddcc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=mdUqMN-9PR8XuoQFAEgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 4TVP5KIp4PKO0vAE0aaD3ZQxW_-H_Jz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzOSBTYWx0ZWRfX+rktbVy1hPjK
 jg3ukeX16bZeILhvB1Z41RHaze6dCAbPZiw677/uz60ecgLQJ5M8KMrOyC6WLZ1f/uI5OsHrUs0
 B9RVE/LIGAbn4ZzEIDELfIlqZ1FMYYUT1YqYrZq4X6l/tX86AyG0EkXoaZF0r3ikR7uTMgSo34u
 NzONR7PfABJQ+0cBZNW2NNXRobSpJ2hIm05NG7duUf1MlPAmt8H6HPH6HbAfsUwop/63A0vR9Wi
 bGnoAoLmTQe8/IvbBOKONwcSaHGUCpMqTmoTawQjOnY9XO8dEgCB4GRIYfoZagOitCcCMRIk500
 F4N7r9KIT6wxYhuG+hLCvIwOV/j9Sup8uLK8dUtICmUPyl51qXHC9lBFjfnJkpzKe9OME8kKyM/
 djNlWLTbUzz0+aWvFBrjfq43qkdI/75dHjifWRQzn8rL3y/yDmjxdu9KFIYF6vTVPplDhMxv68l
 Ws4dN0H0qLeIZmaYwCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzOSBTYWx0ZWRfX87lESOV8MEBj
 SMFLNk7TceOLVOV0OWSu6TFfiqPkg4v0MNaIKWfS94Y+2updA2DYk250abyJWy5hAZ8XvXLizCW
 MpRo1xPpVk0waD/47FVxODpnCnX9jjc=
X-Proofpoint-GUID: 4TVP5KIp4PKO0vAE0aaD3ZQxW_-H_Jz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130039

Hi,

On 13-Nov-26 09:39, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well but since this is not a standard ACPI ID match it also via DMI
> strings just to be on the safe side.
> 
> Reported-by: penhouse24@proton.me
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you for your patch.

> ---
>  drivers/i2c/i2c-core-acpi.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..98a8d63e3fb8 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> +#include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/list.h>
> @@ -356,6 +357,16 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	/*
>  	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
> @@ -377,6 +388,14 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	{ .id = "ELAN0678" },
>  	{ .id = "ELAN06FA" },
>  	{ .id = "ELAN1300" },
> +	{
> +		/*
> +		 * Some Dell XPS 17 9720 systems do not use standard
> +		 * ACPI IDs so we need to match also via DMI strings.
> +		 */
> +		.id = "VEN_04F3",

04F3 is ELAN's USB/I2C-HID vendor ID and the commonality between all touchpads
with needs this seems to be them being from ELAN.

Also a quick grep through my DSDT collection shows 0 uses of VEN_04F3,
which makes me think this is pretty unique.

So all in all I think we can just add a match on "VEN_04F3" without
requiring / adding DMI matching ?

Regards,

Hans



 

> +		.driver_data = (kernel_ulong_t)i2c_acpi_dell_xps_17_9720_dmi_ids,
> +	},
>  	{ }
>  };
>  
> @@ -385,6 +404,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
>  {
>  	struct i2c_acpi_lookup *lookup = data;
>  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
> +	const struct acpi_device_id *id;
>  
>  	if (!adev || i2c_acpi_do_lookup(adev, lookup))
>  		return AE_OK;
> @@ -398,7 +418,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
>  	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
>  		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
>  
> -	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
> +	id = acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev);
> +	if (id && (!id->driver_data ||
> +		   dmi_check_system((const struct dmi_system_id *)id->driver_data)))
>  		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
>  
>  	return AE_OK;

