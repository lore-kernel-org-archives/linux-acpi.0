Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931400;
	b=5aTYaXoxbySmD9r8B8qdv8onSDC0zR/of1wiGzcMDoRf6HfE9VTdEwx/P2d3cAeEHll3
	 nsx7chPR1hUVlNex56xGjOFAZ/0klzHcNgQivp4Ybhfhq9DakrKQyPeSN86eC9JJrUrJt
	 8jI/WsMuv0pmXfQZPfgIjbey8pbJAxUYPVmyfunmmrwHt4fH7nGzq0r6HIA13HSJwtaUO
	 WAHaHK3GtfzFEvqkNCOlWptQ0t/pEV0DaezisIF+1I5dJwl6e+M2icggKGdrpF4qzMV36
	 5Z0N1isTJdVLEZGZ5i5CdtEYmc8N9btaFJ3knHMsiijt81ID5VkQktY9YcCubj1eODg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931400;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
	b=Du9wXa4CJJJ73oTtduVYtHWXRDv+ZLmTOtBbjaPqRAnPhMLisBWHMAJSzGkiVitlsE0H
	 e5hjTVj5SCi0ZpW1uMl9EI1Oi1Ec4LS/SmCrzCtRsugA6D/jODpI1+YJMPd5nxrg2LSRQ
	 FB0gLcoNutrZagRM8DJrWZdwrMZsPWNzZKb6r/KLCTFhZER48S/lxbSo0nPRrEYMM7ESq
	 yLmulCR3NpU8PpanhM8KBKGei5FwSc0pzSSUJkCwBAGguIBrQPI9duTza4PS/zbHu5OT+
	 wV4QmDEJMRIKVIRdfxY8LOaT99+hXKLdkoRj8KF8kr81cMrvIrdlwECe4pPLqwlLhPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DjH7rE7r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ciYjquy3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A1606A330
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 16:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649A1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DjH7rE7r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ciYjquy3
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQYFB4169635
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 16:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=; b=DjH7rE7rXPUt1HX/
	wnWqhTKgUG6zzAcP2cdBB7rOkK0/+hINtf+imirMNoaJtRDUnJ6GJb7GyFaOpjIO
	DR+JPWNr/nHrNC8SnvdajhhbziVtD9nfokhUnKeKZ9Pm1LN4OVc+GAm2ejBf0BrK
	G/KE3JbWvMOWvCtl4BJrotWwIw7RRQCqd8RUY3cQ2ak0kTF/07bgIpx+yTqlXtyC
	ZLCXpZP/09lMbCe5ZBtHOgfzf1eeYWqfJXAtktIOGUaVa4wj9hlUpi4sPRFsj5Vl
	tTsiOUuNbGvZnZqnlL0NZtgOauxcjfa8LEYVvD83+GRsYMf0S+N4STCQB6yuRuUQ
	o+xvvg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve2b89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 16:03:19 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc48fbca26so260913137.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794931393; x=1795536193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
        b=ciYjquy3mKYpLBVYOeTMAYxKZKY6SRXCfL/ZSMmqwB7SPFgttRv3pq9U7tXw+tc5Er
         IZRye7Ac27Iymk8RRwprZq3ML4zcbdlBHgXDlqKURd3F3APYAGHTqsstP+U+qFHLFtK3
         wWPk/Kh3/6tbc/mQNNmdyOedmc7lbjJ45dGtVxiDZTltfw2tAEnEKIBt9TQGfMM+75Uo
         rYMkgeYAgWCBEWRStnRbB5fCp6WfywXdGHxPdhIr70vVblZ/G0zjL61XA92zb/so+INV
         yLMELCp4OGyEZx84qoG0VnQcrJs4ag1ZqNmngV6P7o9oVg70AACd3hi77HSY8w0eojp3
         ySGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931393; x=1795536193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
        b=KT5TlhzPdmYSvIflM/k3giQXLCLE25NLLuucb8+g8KCNcIXTHudEsvoFi8uQRbn07T
         BUOqtTbx1IENu0YqsRWgFyhXgF3N6XIhKyhWPrOiD6I8uWkYoCe0dOzts7binOFwNJ/Q
         V2q1Ms2+2rMPNZu8uWJL5V/cahsA9jjlHjcugy1WwtRW/mxIk+AQ0DIq7g4RWj8Qqy3M
         5UnUn5pEqKljk1fZzgmAQBOq610alfsV+rrWf57KaO7LuMHrvY7Jh7KOPReSnOYld6oP
         tuJRTVtqNojgppR5ahxwuGoNGw2Hz/0/5mgm79Vc9H1G07vZGa7jSkiL4r5z5VZga7xv
         zOtA==
X-Forwarded-Encrypted: i=1; AL+hErF8hNq3yNjl+g7wuSRkSGPnCSne913W305YmIFRXYPlSFbX2DcCbWJ69lBirAfg3VEEc3/UaxwUzgvh@vger.kernel.org
X-Gm-Message-State: APuU4Z823KoyTX11Xx4rAcMRsWJu/Fx+vfMbssM5u3OtXQ3DI8z5tBkb
	cIPDVN0qIlKnfV8SgjtjgSmE0r6YRTAQM2FdpaHJ0PQtOrcuektMgW2Dngq8Bkn9iwSH/kEe++N
	mj7Qs8fdUZ+OX302F1frkB9GecpKXDnLJvUoi1IqnM6RJUkbUrJ6KH4ax0uFJVUxI
X-Gm-Gg: AYBFou0VpBMGH3VsiUtXgWRwAFLPyaPcMy2CnYdnFutrK5KqZutqLV+7dd3WErbBap1
	Lw58ON5GJYuzT9axmcm03jt0Q9I5mHCTUW6ubGrqSO+wnxD6AsZvumU5Whl7/ZQkFGw/r76SxG/
	6ubKx7WpEVRFaTzBQ1yLyxyGsVMJx2Db3qY6os9JrWB9P6KzaFDmCAma+oWFLPqArk8nrlRczvc
	Du+NN1Vase+CCPiBY7/uXhwe8wyOnlVIPNrNRvFXcKeLbfTLl2GPOKLT7wOIa4DQbZQu4EQ1pOZ
	6iePiyoifGelqy58P3HW+v/pTnkGp5UoqZJpi9GYTuClQEXbecWKMiqdGTez5DAwqN+ZXpSlFEZ
	h+VDdsGms/aIkn26pM1QbitRag/YEmoo+q0kiO646ASK2DaqcO7i1q7jO4ui5o+/5CpjdNmT72f
	FrKHmlcJkIp/omlPUEJxmIQWSgAdNA+0h0aiHR8A==
X-Received: by 2002:a67:e7cc:0:b0:7cc:33c9:b3d2 with SMTP id ada2fe7eead31-7d64d84039emr4314647137.25.1794931392776;
        Tue, 17 Nov 2026 08:03:12 -0800 (PST)
X-Received: by 2002:a67:e7cc:0:b0:7cc:33c9:b3d2 with SMTP id ada2fe7eead31-7d64d84039emr4314573137.25.1794931392102;
        Tue, 17 Nov 2026 08:03:12 -0800 (PST)
Received: from ?IPV6:2a0d:e487:16f:e583:d991:ba24:64f2:e39e? ([2a0d:e487:16f:e583:d991:ba24:64f2:e39e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm111459425e9.10.2026.11.17.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:03:10 -0800 (PST)
Message-ID: <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 17:03:05 +0100
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
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar
 <viresh.kumar@linaro.org>,
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
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX29+L2nFEt8UN
 Q8S9D8FHA376+cOmFf0MugjYriimgkh5CEEhd7++tq/rwfEfkKlHvPyPYkwQp1tmS5epABt3/pC
 a6NSFHMwZTlxAY47UZzcwoYLlkFx5FU=
X-Proofpoint-GUID: OBvEWZUMi-4Y7z6OoPxBkvZXZ2c5A63d
X-Proofpoint-ORIG-GUID: OBvEWZUMi-4Y7z6OoPxBkvZXZ2c5A63d
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc7ac7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=XpNdnCcgRucV5c9rQ-UA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX329/vdnW27Fk
 n4AtuQva1L6EF1AB46EScQTrOld+Uc2auYbzDXFS36twqwqlqTaDa5Kao/croLUM0AD4lNhUyp9
 SUbIJ+wB2q9SVi239g/Gky3y7gRGh1LrGMgIpLYZVR6mpl6jVqf6wAELr7uhUkMbi83BvhN1skw
 7dmOEeR8G5yRkYfEhPpLMI/mgqxxWVGLggWs4GnkhUFvfftknRkZ7jkhbnm/ojUoxYD7S2mVTBp
 WMPvIHriD4omvm44KB0Vf5AOzZR5TBJLmBfbiSiKk9AJCQGRgXKyzxg8WlHgNAtdjYYD+DyKMyd
 PgsNsTIoLfjvF8o4aF3yx+rIwrV3YV9YrDJ5mgqjSve9OgOrE0aXLFHgZUdQT2BjJoFKmL/AB95
 PHsoNvPw4esRG/WcuGvBcZ43WSadj/5fApL/69h0sQSvukY2SlmvXE24q+cyDldFBhYuTXuvsFc
 FlfFC30cQwpIvYvKrWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063


Hi Geert,

On 11/17/26 12:48, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>> Platform profile providers already use device-based callbacks and do not
>> need ACPI types. The core is nevertheless confined to the ACPI build and
>> refuses to initialize when ACPI is disabled.
>>
>> Move the implementation to drivers/platform/profile and introduce the
>> firmware-independent PLATFORM_PROFILE symbol. Update all provider
>> selectors. Keep provider-specific ACPI dependencies and the
>> platform_profile module name.
>>
>> Isolate access to the legacy ACPI kobject in an optional compatibility
>> object linked into the same module. Retain the legacy ABI on active ACPI
>> systems, and initialize the class even when ACPI is absent or disabled.
>>
>> Use subsys_initcall_sync so the class is ready before built-in thermal
>> and CPUFreq providers, but after ACPI has initialized its compatibility
>> kobject.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Thanks for your patch, which is now commit 699041135f75b13a
> ("platform profile: Extract the core from ACPI") in pm/linux-next/
> 
>> --- a/drivers/platform/Kconfig
>> +++ b/drivers/platform/Kconfig
>> @@ -1,4 +1,20 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +config PLATFORM_PROFILE
>> +       tristate "Platform profile support"
> 
> I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
> you have updated all provider selectors?
> 
> If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
> configuring kernels for different architectures do not see this option?

The goal of this series is to make the platform profile firmware 
agnostic so it is available for all architectures


