Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64042222D9
	for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782039628; cv=none; b=M1PQeaq+tLwXVno4gsjAljtFnKcdC8vitZK5d6rjxBiYePXnqMSXnN1SJnaXtVfpL1brBmqDhFQ1wKjrhuJ7WX2Xqrd1hDU4BWHv1WKADqnINZ8/yNjXwvEccot34q7qVJZrDX1ohZAM1loN28xvJPg7oCGbFSMtagqU7ZTW/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782039628; c=relaxed/simple;
	bh=fguVSGysFew77hKfEUDHYpcKuMdwVzjKCBgXk7HtN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDrNkBaI2xW9irbJioK1u4/YXBDeQegmccItQ7PHnGsW/I4pWN9e+e4dGXXJcRrENdwJJTBVG7/eDzfZD/YRbW5BSS3zV3/ClMbdIozaEjVN3S9jFVY+idNMeV5sNqK9XfaxbvszcmyEMS32JjZwSnuLNl+r0wozS1RBeRxocYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAiSB1Tk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTWJb2zL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAiSB1Tk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTWJb2zL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65L9tbdS1543794
	for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 11:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KP2d0e/Iz4EmIJ1yifJ4lYdXiXwHZNnQCD63uhIsUQ8=; b=pAiSB1TkSF57mp1C
	Mda5hKB1JhuHADPgqFwAh3YkkAil/8FiHGl2RnqYj5QFIy/XJclwFQxjDWod1U56
	l8bwRbud92+BN4cqD5E+Lt1+KSmO3jBBm00Q4z6p3mT5YCAtcBGwwApMwsn4ik7p
	Q4pExX9V2Ry/3Aj2E9+rByQcFQxUf7c3CvjzVkJbWhydmlrwxcan9hEAkWVWyRib
	2fsvAD9rOWMexvxUzHcW+aXoaPH3u0UKE0oQgnO8/Fsjt6Eea6DAzbtuCMK+hTq5
	CzhJShU6b2zTukE706FfL+QxkeHcgJiyGf9+IO5dcfgEClb8/quniI4jqOxPJ+Ye
	PXXAEw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewgjeb465-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 11:00:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5175bf22b1bso44142001cf.3
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782039626; x=1782644426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP2d0e/Iz4EmIJ1yifJ4lYdXiXwHZNnQCD63uhIsUQ8=;
        b=bTWJb2zLZqGvCv/0HaWuAQ42sO12F8l8lnUmbrjOgxmXhXbyoLQk3Kiq7zkDFR3Af/
         DgAgXOMPGqEigItJaDh22exrVIAhVH5lQBc0Tx+BrrLciCJ1ZoGZuhdCzyoLEtbk/obD
         HEil3uPQMDSpZUfZ7luGlsXIYvCUzqs+4ztzqqHnKgmR/BJXpggBpUx2SyX16ZjPNPha
         bkCGtNtjygugA04bJGKbgceCkqJFmVXU/A4yew1Zi/Cnr1MtHaORSS699Puq0iCEaWn3
         i39Svh+JQrUIO2pY6KAVDgNcSlhjJpd6erGqVtnPzo5Gpoz9dfh/lHd2tDjM7dDZCCOB
         pfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782039626; x=1782644426;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP2d0e/Iz4EmIJ1yifJ4lYdXiXwHZNnQCD63uhIsUQ8=;
        b=UtUkuSvAD+NFgi9mLyg0wO2tpNRTtAVHtJEt+alDtJN6lQKK8IK3AoSYBdfZJ64RN0
         XgL7qMtWEuaUMsleu372/O4CQ1QhaVP3umSJj0LURzJSQLbvp2YJOazASiHmp+PJNyY5
         JjsUi3f2KYPGSp0MrURFLh0voUmqBPd4wGpncytTBANXeX7Nu0Ko3dUTnStFcFy41ogI
         Y9MCbiH4T+saMbSM60aVsKt6EZejTPYXnzbPycYSNIo61bcpal8ccPXhyxi7kf31wWdl
         3cvsuMTTvxVTLzi7Nk8ZdeaWFh9CYnnOwTbdkP3nIPsyQgu5eDXudVKhv7dho5tPvSUz
         Zcpw==
X-Forwarded-Encrypted: i=1; AFNElJ9ojJyvzjJOYOfdvvgfO/sOXuNOpOd8fXTX0Iem2fSJQyKMVDmBED91yFWysa3FE4qS0skWmjfi+PjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZ/TAJLhEH0XBQzjPTEB/Uvr4MEwXi94aCMN82UW3uzJcjBed
	tKMUMNPKZSED6fUJUgPl0pRs3VTzUHYIbxh94PS0pnVpimAu1bLSRniqDZkKWGSTt2FBq4y3GjB
	yoMPuQ07oIcwu4zKyETX7Pk3ZYryYXVuWTGnsXPncTUuS5cIDJBII/995pEn3fRJ2
X-Gm-Gg: AfdE7cnapSHAxonOmnmVDu7YUczhqYWEqQ+v2TcOiA7A40Ph4QMZsncpwT5ZcSLLDV+
	/VxQgKW0o3iDVsa8xE4te40nHJ3l9hj2sV9I47bY4wSPJz67gfz8/uqCIRGUYffKHrKLWG3/QcX
	kYV70MwX24gnX3TSvr6uFIc1R49oXRGLWZmQFZb6Dj9XL8AlDidTU4AOjUp0vkCgQfJVK49i6/d
	MaM4AS20OXQzqflEvPmIvMQ+HSbIX/T+MybGnks0La2TfLTX48ovjq1VK2S/tlYtxT2npb3C5E/
	ULpFpiy1LuHdyuaJ1OhMjWxo+WLmO5y0Z/h92XPmj/5ui8qsM6K0NtHdF3YlNdyLA+EvGInYylz
	rWWEVcYCUzK4vsCxxv7He80oak3gm8xRtHT7ALTL06A4S90rd54VisbayMMjxaOdEQmyrnyq6CY
	Ws3JtldVgVfS3hnvnYL3dQ7AKM8cl4/Kr34vHMIpFPIOemrubLCy0C7iySojLZxKCQEBKSmTGGp
	mlqdw==
X-Received: by 2002:a05:620a:29c6:b0:914:7e9a:2716 with SMTP id af79cd13be357-920d46198e3mr1486991185a.38.1782039625772;
        Sun, 21 Jun 2026 04:00:25 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:914:7e9a:2716 with SMTP id af79cd13be357-920d46198e3mr1486977885a.38.1782039625054;
        Sun, 21 Jun 2026 04:00:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b84f362sm1521464a12.10.2026.06.21.04.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 04:00:23 -0700 (PDT)
Message-ID: <9237988a-2f5a-4c4e-8586-12899957bfea@oss.qualcomm.com>
Date: Sun, 21 Jun 2026 13:00:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16
 G614 series
To: Marco Scardovi <scardracs@disroot.org>, bnatikar@amd.com,
        Armin Wolf <W_Armin@gmx.de>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, linusw@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        westeri@kernel.org
References: <221cd70d-70f9-4d01-8e8c-b4a5b347b8b9@amd.com>
 <20260617185318.11237-1-scardracs@disroot.org>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260617185318.11237-1-scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b4eJHAPKI2ij3Th5Sa-SMTd6MSXmkxMp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDExMSBTYWx0ZWRfXwjbIJH6CHkTO
 2npK7kFcMRYX0EcO/xk02wtK5+SvDo4Sg9tMZbt9ovhu/jKjpvusH0S2xe/dPReNKHGp9vtOJnu
 RilQkpquBtluyp904+Y7uA5YRKFDUtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDExMSBTYWx0ZWRfXwcVWcUgpN2Ub
 sDs+DuNtTI2JqPHkX9qMZOoZI61mVwoiWZBpwNlbcjOSwyb0OF6b/be9sgG2zojz/s4oRW4Fjfv
 GgJMKB26W2DaSxlrgnjFG0DyN5zKiQ4IZoVZpRFy7bmaYkAgwiWaO2jU/dKMNoJiP6MofDNXNaO
 kn5r63NQ+3cUlmVLMwtFuZOMkEYHFWvbV21KnnzRvj5SHuGpScyxhCrFP7UCEXiWVY/8oGrUk/l
 ji1wQArqjluvTbsjLCnDl3fMjncwQcINnuB1I+MyxiS8BuO2dtOOUOIW8T3k0UoOgkD4JQFzQZH
 SGZAl52GyVqCYYgqdKeyB9o9MU2mY/XXX/mE05eMotzl/xvwCjDj6cv//W69kaLNBzzPhUfaFRX
 eqgQQFoh9qn1PHa5Pi/acC2V000HWknZXpOLaTXsTTOjhPE5+r3TKrdO1Ek13S6NsYp0/k9/wpa
 +5ijKGKNt7MxnNpRSGA==
X-Proofpoint-GUID: b4eJHAPKI2ij3Th5Sa-SMTd6MSXmkxMp
X-Authority-Analysis: v=2.4 cv=TO51jVla c=1 sm=1 tr=0 ts=6a37c44a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=nMmVnbrQdPhwzN1N7zMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210111

Hi Marco,

On 17-Jun-26 20:50, Marco Scardovi wrote:
> Hi Basavaraj,
> 
> Thank you for your review: this is the v2 with the rewording as requested.
> 
> Changes in v2:
> - Reworded the commit message and the code comment to explain the actual
>   boot-time replay mechanism as suggested by Basavaraj.
> - Explicitly noted that the touchpad itself is driven by i2c-hid and functions
>   normally, and that the ACPI event handler is preserved for post-boot events.
> - Rebased against linux-next-20260616
> 
> Marco Scardovi (1):
>   gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series

Have you tried adding this patch to your kernel instead of adding a quirk? :

https://lore.kernel.org/linux-gpio/20260429025247.1372984-1-mario.limonciello@amd.com/

This modifies the code which does an initial sync of edge-run ACPI GPIO
interrupt event handlers to match Windows and to skip it in certain
circumstances.

If that does not help, we should wait for Armin to get a chance to check
your DSDT to see if the magic _DSM which inverts the polarity check for
the initial sync run is there.

By matching what Windows this we can hopefully fix this for a whole bunch
of devices rather then having to rely on per model quirks.

Regards,

Hans


