Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3263B634E
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727634; cv=none; b=QbaSPaXQp5kC1cGVuP21aBmtgu+mi813h1KlrppPbSpO1EP4fTFjyMhH1w3XsA0L0Nr0YfpEePvm5SwsmZPqN4a2tZL0eTOqP1cL//Tmx99CsVpXzxAnIJXTNVRY1VpVOYQLSkXUvFtazOdQS1FHVf+1RxJHAjapZMb0zfpHtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727634; c=relaxed/simple;
	bh=peQvglYaqtmwXb0WTupgH8dzST5Lwyiqg0bLF9xcLxk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cy9jK3y4HbBmJhygmvbr4CVS/RqAQ59SoUwkL8RQjiPcmMgXov+ZSV+dN679oGoZJEk6e+HpRbxAz2p8U8SgjXS1nXook89MxlOIh3msan6pOIx2WEvlH7ESt0e/UlMxX0OKej6Eyq+neEytUyKUiZoNJHoZKiGWpb/q+fP0mm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePPmbi0t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArLwLhKd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePPmbi0t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArLwLhKd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xDY82447414
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxKtmKH4Ba7gwjMK4BRBaCCo3zwVIw79x05QJLK2AtE=; b=ePPmbi0tlr6g2RSs
	1zk4O8o6faSpmX2WF+YtTPzQvDUQ1vOX1B95c1vI5BFfzZGOJ2QSpJ6ywHXwOYjW
	zvKyVJOXJD8/6BC+Jr0fbxMUel3+PRnUth/jQwvxu6IIZ8n+ITaLl51j/aaTku9B
	S6lJKF+o7cbZElavaVCRpsZD/UCDbHOpOLBrvVBIoW/M4QKUFUayvZ+3iySJN8/J
	mv7yRIZTffoG6lofVR5HXykm7mUTI0mm89X6IcfBumme4yscUsR8R4A4ugyIXfdj
	iVXWhdxNJVSW6Bo5aGFnTdUKnI6KcV5mcqbM3UZQpdxgZ64seQBrzqdzsv/nVgXi
	GnaHog==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7g96t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:07:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-967973f71fcso1564831241.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727631; x=1783332431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nxKtmKH4Ba7gwjMK4BRBaCCo3zwVIw79x05QJLK2AtE=;
        b=ArLwLhKdBsEfNMWC0OPc9ldfpB2BcDF9BpnaGvX/7Tlychxnh25jy7QF/odcV68KMO
         AzRzsTEb76g1vXGWIhygbo462q0nCIRiO5+jExAeF6haKuzgjvzsFOkwuNiGF7pWDr12
         Gsi9xYl45zUdaFMGQovSpwa0iWRUmmLzxxwbGLF1ya90DdIrFMn8t/6/4NmuCD7rea3A
         SlR1/assfKMy2iTDvw+SFDzzVOpyd6jMgnWTxLWAm8xA/951F1ruKFs2NzTY5brnTke5
         Y6lCCS4v+NfuL94ZfFfUKiQS21jAjkr/9ru2JrhesnTlzaDzCG+f+F1ei6i/vb3ojSn/
         V97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727631; x=1783332431;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxKtmKH4Ba7gwjMK4BRBaCCo3zwVIw79x05QJLK2AtE=;
        b=qv8enNzL59IQZrgJ7kTcy9gfQmwnn2XyCctIwkmkb10HDg0QBMM2vYLAiGQukU+Yma
         dE5uZzXRYWZjrDO37hBQ1XcSy+MQWzNu0UjRPtvgdj1PJKJLvq89BAZKuR1hxaABX5pN
         cFV/GQ9l0zQSTUWITeAOH7Dob9nNDSQM1cRaEL3QfYlN2AI+wfCy8ASoMCfGWZ+tn7kS
         QJMwRhbmktI0/rwEwwfBxD3zfrCafaC+0sMFpnAl6B7WmITUsnxF4vdSZcGC05NvUgQb
         4vCc6NQS227eG4j5ywNyxuB/YGcnkdM3jNv0BHnrn+hiEY3FID0/JMHdvi1xVRUtuM+j
         yKbA==
X-Forwarded-Encrypted: i=1; AHgh+RrW8q4j2NxXqrmOblQUlvWSIygIaOvex46/iMmFsABc8bTPje1Y3qfrP0t8YCMTG3omEGFNCc7eGE7d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1I8MsJSnIiJWwSl4yYRQNwESJuHN5z9i+lceBCHBWo8kYQ+Wo
	7RUOOm3olrbsKP869Yg2TA0piQ09jE6Pcap39dp6nFmlwKCbNjS4sbRhqfFAjGaA7FTLDvC770t
	nR1mFJobn+I0aKfMvbLfm0Gy9Bz21G4VfcNINbg3OswwCDB4kj8gYpL+Lebe5tnRv
X-Gm-Gg: AfdE7cmVcCPMXoxVoqaa/39KId8j0h9R8dW+nmHuobRitUp5BAqYLLj0r6TZw1otVMh
	8vEeA1p2cfVG7LIVApijRaZsFJAg6zJbUxEC03OhmMDOIp0m0hlt5ffgEOByg1n2aTglGWwJF0g
	uHOQcvsydgtAq8vC4ETW3vxmaHDFVb7CKxDMQEV9EP97HAQEfpv/h6e4A2z+wGHpo3iw5sbzDEK
	T33CXGCnAut9/RmdAQQLxw8zwOLDWuGOBKo8KN/P1xLzJI0djoTqQ4c7thn6V+SdWGmqGTYv33R
	/vONk2OxkWu2S9dW7YKvh094+7HBAWPbfGU8rtEb/rTspPa3+lzNQ8RirPCcS1sRItH1JKW/zn1
	P74DgUcWJ9BO1gYMthr3I88sKyez4Ew==
X-Received: by 2002:a05:6122:8112:b0:5bd:b2d2:a1b9 with SMTP id 71dfb90a1353d-5bdb2d2a7a0mr429593e0c.5.1782727630580;
        Mon, 29 Jun 2026 03:07:10 -0700 (PDT)
X-Received: by 2002:a05:6122:8112:b0:5bd:b2d2:a1b9 with SMTP id 71dfb90a1353d-5bdb2d2a7a0mr429557e0c.5.1782727629920;
        Mon, 29 Jun 2026 03:07:09 -0700 (PDT)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac461csm6694710a12.6.2026.06.29.03.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:07:09 -0700 (PDT)
Message-ID: <9e47c991-0d7c-413f-86a9-33c5322fa85d@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
To: Bjorn Andersson <andersson@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <akHTOUvHXooq7ykT@baldur>
Content-Language: en-US, nl
In-Reply-To: <akHTOUvHXooq7ykT@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfXwxVbJlNrAy32
 QK6MfTRgglA49wIA+b8HSlpwXxkLA74wJJDA/E6+9qQXX2eHLNvPo3rxE6G27uClCgcUZw64MsX
 1mkFRNirdWB0cm6AFtoxXbBtFbA/EB3BskwS8euy8JVt/iCbGVsExK9K3S/5LiOtTJv9zI1lV7V
 x0XwiTtezYeMLu4U/5PAK0xwJrFCWA++264fYzxzOJ54tR7DPcpq/6swTX37mLK934d7T7qVn+D
 tdcNvuL+0pUhuhAmSyHuo1n2Tn+XyRcqV6VMtLKIODlHgnyvTeldNuu6i+rsNVaIIIlcKP4bR1F
 ADB4tum9d0Deg9vW7dTEzM6m3x0veNfttvMAlO6tUBJgKbL+2lP4hkO/NWwp/qd/8TjTk9v1HY7
 0uNUjjSPQLxIWmAqc8C3G59VT+dLciQNKE9WpM6l5HljoK5tSP/LS3Fj7C1g0LO4BDYVz6er8rU
 RUB2p6Xer+QPR8ICzNA==
X-Proofpoint-GUID: -f5lPlVGxefZOKXNYPRdJA7vLmPT9_Ts
X-Proofpoint-ORIG-GUID: -f5lPlVGxefZOKXNYPRdJA7vLmPT9_Ts
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfX1+dHeNeT6Zt0
 1XU/+g9pM3aWjxT2NqhSyUFZbV5HRhaiJnR9ByWaHfStb0dlw5PeXBN09Yl/kHjtD19WGCACL8x
 225lItJk/iy6IoRNuPrXLvw1MKJuT3Q=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a4243cf cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=TY5eUhlIuujBRl2ao3oA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290081

Hi Bjorn,

On 29-Jun-26 4:27 AM, Bjorn Andersson wrote:
> On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Currently as soon as the kernel boots with a populated DT provided then
>> the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
>> gets disabled. On WoA Snapdragon laptops where the factory Windows OS
>> actually boots using these tables this is not necessarily desirable.
>>
>> It might still be interesting to at least parse the ACPI tables and make
>> the ACPI fwnodes available for device-drivers to use. I call this DT-ACPI
>> hybrid mode.
>>
>> This mainly is an experiment for now and possibly a method for accelerating
>> the ongoing effort to run Linux on currently available Snapdragon laptops.
>>
>> On current laptops Linux cannot boot using ACPI due to some information
>> missing from the ACPI tables. People are working on changing this so that
>> for future WoA Snapdragon laptops Linux can boot using ACPI only without
>> requiring Devicetree.
>>
>>
>> There are a couple of scenarios where DT-ACPI hybrid mode is useful:
>>
>> a) This leads to a populated /sys/firmware/acpi/tables allowing one to run
>> acpidump, which is useful to grab info from the ACPI tables when e.g.
>> creating a DT for a new laptop model.
> 
> This depends on the laptop in question sufficiently following the
> reference design, such that you actually have a good enough base DT to
> find those i2c-hid devices...

I agree that even just for i2c-hid devices this series seems to be something
which will not "just work" for all models because vendors seem to just
pick a random i2c bus for the HID devices.

Not sure why you replied this to item "a)" of my enumeration of why the
hybrid mode stuff may be useful. I think this comment of yours belongs
under "c)" ?   "a)" is just about populating /sys/firmware/acpi and
/sys/bus/acpi/devices without any other functional changes.

This difference is important because unlike the rest of the series
I would like to get "a)" upstream eventually (maybe even soon) because
it is a useful debugging tool when writing devicetrees for new models.
 > E.g. on the Glymur-based Asus Zenbook A14 that I recently brought up,
> keyboard sits on a previously unused I2C bus - something I wouldn't know
> without first acpidumping.

Ack.

>> As a bonus /sys/firmware/acpi/bgrt
>> is also populated allowing the boot-splash to show the vendor logo.
>>
>> b) It might be useful for device-drivers to be able to access ACPI data
>> for the device even when running in DT mode. E.g. Srini Kandagatla first
>> got me thinking about this because he wants to use the ACPI MIPI SDCA
>> tables for audio codec routing when booting Linux on Windows Qualcomm X2
>> (Glymur) laptops.
>>
> 
> As I argued during last year's Plumbers, I'm strongly against this, for
> anything but prototyping/experimentation.
> 
> Specifically something like the MIPI SDCA tables, are we going to define
> an ABI across DT/ACPI such that we now require the hybrid system in
> order to build a Glymur-based DT-based product?

I think re-using MIPI SDCA tables rather then having to manually recreate
the same info for each laptop model in DT is actually a good idea. This should
make bringing up sound on Glymur laptops much easier.

I know you worry about a theoretical embedded devicetree only use-case of
Glymur in which case we will need to create DT-bindings for audio then since
there won't be MIPI SCDA tables there.

But your suggested solution to this seems to be to do the work to create
the DT bindings now *and* then also add a lot of work on top to create
the very much non trivial dts bits for each laptop model.

So what you're suggesting is more work now + more work per laptop model
to avoid doing the same amount of work (but then not per model) later
in case an embedded Glymur use-case which is DT only pops up.

As such I agree with Srini that re-using the SCDA tables seems like
a good idea for the Windows laptops use-case.

Just another random thought which popped up in my mind for "b)",
it might be interesting to use the ACPI I2C-HID _DSM to get
the "hid-descr-addr" in case where there are 2 alternative touchpad/
touchscreen sources which share there I2C client address, since we
currently rely on different sources having different I2C addresses
and then I2C-HID silently failing to probe the non existing one.

Actually checking the _STA method for second sources for some components
might be an interesting use-case for the second-source case in general.

>> c) It is also possible to go truely hybrid and use ACPI to instantiate
>> some of the kernel device objects representing the hardware. For example
>> the last patch in this RFC series switches to using ACPI instantiation for
>> the I2C clients for the keyboard and touchpad on the Snapdragon X1E Lenovo
>> ThinkPad T14s gen 6.
>>
> 
> Which introduces the very shortcomings that are a key part of why we
> don't just run off ACPI in the first place today.
> >> d) This may help identify shortcomings in the current ACPI tables which
>> need to be fixed to allow future laptop generations to use ACPI only.
>>
> 
> This is worth looking further at.
> 
>>
>> Upstreaming of these patches (to upstream or not to upstream?).
>>
>> 1. The first couple of patches in this series mainly implement a) + b) from
>> above. This seems like something genuinely useful to have; and except for
>> missing DT-bindings for hybrid mode this seems mostly ready to go upstream.
>>
>> 2. I see c) as a way to slowly evolve support for current Snapdragon laptops
>> to use more and more info from ACPI and get closer to a point where we only
>> need a single DT describing the SoC and any info related to laptop model
>> specific bits outside of the SoC can be read from the ACPI tables.
>>
>> As mentioned above work is being done to have Linux boot on future laptop
>> generations using ACPI only, so all this applies to currently available
>> Snapdragon laptop generations only.
>>
>> The question is what to do wrt upstreaming patches necessary for c) though
>> (patches 7-12) are we going to allow new Devicetree files for not yet
>> supported laptop models to partially rely on ACPI?
>>
>> The current demo ACPI usage in this RFC series just instantiates I2C-HID
>> devices from ACPI. More interesting would be to hookup the embedded
>> controller (EC) handling in the ACPI tables instead of having to write
>> a special EC driver for each laptop model separately. For the EC parts
>> I believe that it might be worthwhile to implement c).
>>
> 
> Wiring up the EC is the one use case that I can think of where the
> hybrid mode would be really interesting, as a hack around the need to
> write custom device drivers for each one.

Ack, I have experimenting with trying to hookup the T14s EC through ACPI
on my DT-ACPI hybrid project TODO list, not sure when I'll get around
to this.

I agree with you that that likely is the most interesting use-case and
any further discussion on if we want hybrid support other then "a)" above
upstream should wait to see how the EC experiment goes.

Regards,

Hans


