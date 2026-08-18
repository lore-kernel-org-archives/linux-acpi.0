Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF242BEC23
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058220; cv=none; b=HiNRgYNCaoOdJyWMXGrli4CE8aeUtLdcJ58D7MwMoqGbcfFKwWtlBAfg4fhf9Jy30Jg/mhvhblpyfucpBcDn1z4RxWPiMpKvfgS812ibxZYmyVeZEeJ+A7DkuzdGYdKtiU/ymR0UeFxmqCSgnytPHsaD48zH9LZYWQ+A+Z7bg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058220; c=relaxed/simple;
	bh=xuv0l4aMHcIgVrmvw1tT2Ao+JZvCvoRFws361672pFs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SJ8GBlzsEsHGTez3yPC85Y4QPhHGPVlaq4bG6KQazASOorbZI+tgd/1REtcUQ9EWM6PiHhNVUWhEq8WOitmML8EdVd1OezA+B29B9kMDs8tgjm4eUQ5HcyFMlJb2Gd0sZVPY0dYi9Li8eS2JMdOdsZgnxw1rALN97vFzdOORzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PThoK9g2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PThoK9g2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso23169115e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787058217; x=1787663017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQfoMmLqpQKn5QWGtUOatzjMXQ5IIh4iL2qkuJREMtc=;
        b=PThoK9g22cc87ZUq0rxCkmv0M0wIadgSUca0UDWHW5o4Chnl4PoCZAAwC1xZkIrahx
         ZdfVYpmuxW6+cUEuJT8l7jAb+PVUG84nspsjm0lqGtJeeEiPUAC+5a4y7Db1e3ymYp6M
         VjPAASWEticKdW0RZZzfBm4DAO8BqsM4w8ImoXkl1mtfxe2FldQwQ43+tepWh6XABQ6y
         bcgnGwj0PHBe84ab38AST2wlRVkbYPe2ch0QU0w4P78WXEG/7NDdaIJP1f+bFOnxO9p9
         JbXKCQQELjqydQTtxEtfgaxCtk+JLchF9odlw5FB5VLV04oHpD9aEEZMQV7754vLGqx7
         nDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058217; x=1787663017;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZQfoMmLqpQKn5QWGtUOatzjMXQ5IIh4iL2qkuJREMtc=;
        b=ZIjPtep0Sx8j092DDl+dxg7mk8Oj8LcIjBRaS6uQzWHhJqkgMHbLjFeUV1WEqKAmO3
         nUE+BUh30JMJV4kh5JnfREL1gHq2E3vWZkiey5IFLKMu50yza/EFjBaSJlvJsCRHxYNO
         fIP+NQU7kpWOmVOkFzzEIZCvaxolOE57AzITvjg46OkQ/p/Bw1RwjEzer6Qgcgi7eCfJ
         15D/q0qgtXXgWDQJYBO1+zwfQIKwtIXi8efPHBafUHkH4mT5Dn581/GgH9tdGMlRSdH7
         Ix3IwQnSURmfHOX/eAmXo8lW4N8VezSFRdelEgnOrfO1SqYaCDDKt+aRcAe8Lo2VLzGc
         KFYg==
X-Gm-Message-State: AOJu0YziT2UJn0mKBXQiBrSv2T7u22aRyXIKC21doTr+Id7OqmWkS43o
	00vnuO3n4IOTK7l6BMOohmlblwBwNe/+SL8akf09g500sCXZZHbYI6wS/Q3mfw==
X-Gm-Gg: AR+sD13BGDWuuptsK09jJMxlCP7Dih8LFdTjtORXJ2WU8gHgSn9zk0wk73/Y+Ysi0FD
	UvzwbyxfyzdG/xCloQhza6t2nhAAV70cYy1C90BhoXjfF7ogXprn2InFYY3cTBm9ADjou/p0Sbg
	ISQD0xrOd1rPK0MlZiT5Ph1lXTvTZ3ZMme14axbh8IeFqmr7e6KPzCj5e0waMgMPouWFf9ptxuh
	tHjSJr2MIUlLLth7UW0jruAHHoGPXGrHM1DuFDQvfmQ1g7DhOAEpwQssBX7k+tAemZus6piuJRA
	9eWnN62hYqtxUxemXRsWbsFiuA0WqsndPBYT+WcsMyHhxsvNYiySZKYyl7eYkvhqVIes2cM3WxJ
	cWpchj8OaZn5XcRIT1C6uce2otY/Z70hEijRwz4ulW2sKNBBthmx8dwv3g3YXT+hiA7ne0BGwp2
	4ujetUhh3jS1SW2ehp2P73vQOCMt6fmMw+hwmBSn85847wHMxeA1P4/jcHqdSOKAg9ETiRyUi2/
	kYAbnTDjzWt8U8ogLgjr++v28x+5r3i
X-Received: by 2002:a05:600c:6087:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4999fb07c9fmr157558755e9.2.1787058216595;
        Tue, 18 Aug 2026 06:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f29:5290:364f:b3f9:70b2:d624? ([2a01:e0a:f29:5290:364f:b3f9:70b2:d624])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b203cfsm296750855e9.3.2026.08.18.06.03.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:03:35 -0700 (PDT)
Message-ID: <5d99ccb3-691e-4b89-b58b-017a7318aef0@gmail.com>
Date: Tue, 18 Aug 2026 15:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Regression=3A_Backlight_control_broken_on_HP_Omen_1?=
 =?UTF-8?B?NeKAkWF4MjQ2bmYgd2l0aCBrZXJuZWwgNy4wLjDigJEyOOKAkWdlbmVyaWM=?=
From: harryblanc <garett26@gmail.com>
To: linux-acpi@vger.kernel.org
References: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com>
Content-Language: en-US
In-Reply-To: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

*Subject:* Re: Regression: Backlight control broken on HP Omen 
15‑ax246nf with kernel 7.0.x

Hello Rafael, Thorsten,

Here are the outputs you requested, from both the working kernel 
(6.17.0‑42) and the failing one (7.0.0‑29).

For context:

  *

    Secure Boot is *disabled* on this machine.

  *

    GPU setup is *Optimus with NVIDIA GTX 1050 “on‑demand” mode* (Intel
    iGPU is primary).

  *

    These changes do not affect the issue: the backlight regression
    remains exactly the same on kernel 7.0.29.

  *

    Kernel 6.17.0‑42 (backlight working normally)

  *

    $ ls -l /sys/bus/acpi/drivers/video/
    total 0
    --w------- 1 root root 4096 août 18 14:50 bind
    lrwxrwxrwx 1 root root    0 août 18 14:50 LNXVIDEO:00 ->
    ../../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00
    lrwxrwxrwx 1 root root    0 août 18 14:50 LNXVIDEO:01 ->
    ../../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01
    lrwxrwxrwx 1 root root    0 août 18 14:43 module ->
    ../../../../module/video
    --w------- 1 root root 4096 août 18 14:50 uevent
    --w------- 1 root root 4096 août 18 14:50 unbind

  *

    The ACPI video driver attaches normally, and backlight control works
    as expected.

  *

    Kernel 7.0.0‑29 (backlight stuck at maximum)

  *

    $ ls -l /sys/bus/auxiliary/devices/*/

    /sys/bus/auxiliary/devices/acpi.video_bus.0/:
    driver -> ../../../../bus/auxiliary/drivers/video
    firmware_node ->
    ../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00
    input/
    power/
    subsystem -> ../../../../bus/auxiliary
    uevent

    /sys/bus/auxiliary/devices/acpi.video_bus.1/:
    driver -> ../../../bus/auxiliary/drivers/video
    firmware_node -> ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01
    input/
    power/
    subsystem -> ../../../bus/auxiliary
    uevent

  *

    On kernel 7.0.x, the ACPI video devices are no longer bound under
    |/sys/bus/acpi/drivers/video/|. Instead, they appear under the
    *auxiliary bus* (|acpi.video_bus.*|). As a result:

  *

    |acpi_video0| disappears

  *

    only |intel_backlight| remains

  *

    brightness keys move the slider, but the actual backlight does not
    change

  *

    ACPI errors appear in dmesg (CreateField length zero,
    AE_AML_BUFFER_LIMIT, WMID failures)

This matches the regression I initially reported.

If you need additional logs (ACPI, i915, auxiliary bus traces), I can 
provide them.

Best regards, Harry

  *


Le 18/07/2026 à 11:05, harryblanc a écrit :
> Hello,
>
> I would like to report a regression affecting backlight control on my 
> HP Omen laptop when using kernel 7.0.0‑28‑generic (Ubuntu 24.04 base, 
> Linux Mint 22.3 XFCE).
>
> Summary of the issue:
> With kernel 7.0, the screen backlight is stuck at maximum brightness.
> Brightness keys show the OSD and the slider moves, but the actual 
> backlight does not change.
> With kernel 6.17, brightness works normally.
>
> Hardware:
> - HP Omen 15‑ax246nf
> - Intel i5‑7300HQ
> - Intel HD Graphics 630 (i915)
> - Nvidia GTX 1050 Mobile (disabled via Optimus)
> - Linux Mint 22.3 XFCE (Ubuntu 24.04 base)
>
> Backlight controller:
> /sys/class/backlight/ → intel_backlight
> acpi_video0 is no longer present under kernel 7.0.
>
> ACPI errors visible only with kernel 7.0:
> ACPI BIOS Error (bug): Attempt to CreateField of length zero
> ACPI Error: Aborting method \_SB.WMID.WQBK
> ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT
> ACPI Error: Aborting method \_SB.WMID.HWMC
> ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
>
> Kernel version:
> Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jul 
> 1 15:50:57 UTC 2024 x86_64 GNU/Linux
>
> GPU information (inxi -Gxxx):
> Device-1: Intel HD Graphics 630 driver: i915
> Device-2: NVIDIA GTX 1050 Mobile driver: N/A (Optimus disabled)
> Display: X11 driver: modesetting, iris
> Monitor: eDP-1 1920x1080 LG Display
>
> Hardware summary (lshw -short):
> Intel(R) Core(TM) i5-7300HQ
> HD Graphics 630
> GeForce GTX 1050 Mobile (disabled)
> 16 GiB DDR4
> Samsung NVMe SSD + 1TB HDD
>
> Expected behavior:
> Backlight should be adjustable via intel_backlight or acpi_video0, as 
> in kernel 6.17.
>
> Observed behavior:
> Backlight remains at maximum brightness regardless of ACPI events or 
> brightness keys.
>
> Steps to reproduce:
> 1. Boot kernel 7.0.0‑28‑generic
> 2. Attempt to change brightness
> 3. Backlight does not change
>
> This appears to be an ACPI/i915 regression introduced in kernel 7.0.
>
> Thank you for your work.
>
