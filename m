Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03822369D4E
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365535; cv=none; b=eqbe5CKeo7/vcAAF0HocdyOIBTsnXhy7CtIGT0sY/4vkiOo3tWEALnw+o3hpRm7BcxGCfd+VXjPMvpOSQRMhPokIJcsC7BrfQDYncb41rLfE9m7nR82tYT/xYdK4GzzSeMkDHPRRAyMB8KSxBNa1wcwtlbvUrG/c8qc7PIqsqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365535; c=relaxed/simple;
	bh=eVeDAQqxVLXX6YSod0X3CYnAFY8vzLSez4EZNLorgwI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=s4/WTP2kP04E6z8Yj5lCKfIXFB26mk8RcY330p1VNhJEIBrmlbDitWAjsRWRSCAxxg7fb/BOgFxUGG98zp5DKSyJ3ytaNtqMKwU+ZNEKfP1UIcpzjhCvdtm41fMNtT81J0KWJqQLzPybAeR1zEVm/wUJxRMNhD8v6vFeE5QiA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHPFJdFo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHPFJdFo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47362928f65so7771651f8f.2
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365532; x=1784970332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sw5aZVFHW1VS5UwNiOTG+o0F8sfiSMyVLl31oydfzmg=;
        b=JHPFJdFoUsWOh8HFJevEAVUo/Epm8f+ahJ4Rl4XqQ04nTo7n9GglFu+LYyRKA5chJB
         tqyYeFnzyyac1BPtnCQaSyHcIaPOqSbudqU8/JFtuVakVL6jlcKitbyNctHmOp5d+e5l
         XbmbOT876gG/uQ2TOWf88nJdwQ7LUL3ol71I83ixAL6EeVuPKoj/6PhBkrxbJSonGUul
         +vzYSrFbKZHrZhvHuzlqImZxj0Q7dBHGh9GF+Z055Rp6aU9BPfm6JahXppaXFR7QPS+6
         XoEad1/il3eDDC0e9SfjySB/l2TQ/p3JiYgrQxttdQNJzGxWSs9lrBtAxt7N30BPkKte
         vGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365532; x=1784970332;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sw5aZVFHW1VS5UwNiOTG+o0F8sfiSMyVLl31oydfzmg=;
        b=cyKKdSUYzzrP5duY/mGqg6Cs5a5pXJaUCOFDqNMUSMP0+Clg2Aly/gb7XC/dmy6b0y
         gT+U1VpJAe+qflr9ruvc7DcgAzTtmx+zEZjllfRlIbFWUARmuiGrM8xp5q7FaEwsTuNJ
         exZui1XjGIT9d+zFKnPoy8OfnshBI4iGMnjbXeqrRJWtIGutwRoonqfXXULJCotOUxrY
         wVmKuyPBv6g5YXoH6UbIkS2Wz7mOuEz6w7RY4eNojlshjVnDfR7EMMNfw4LjWxx9xWur
         VNp5LMZ9VwKn0TZHCzFrK7UxnxokL/T/CTOT/B+gOlDj/Qj6xDDUBEkPka/ZKszLltQE
         sUMQ==
X-Gm-Message-State: AOJu0Yzum0Uq28h05iVQW2wacjmvJ04/H+3fbmPwM24yr5ZQKVnXIyzR
	Yx3bEfaYwRvC1RNcPltVT6vWdi03bhwTIbfX6/q7FZ4ZNHo6O8lUojP2rSaEGUgy
X-Gm-Gg: AfdE7ckJvPuo46/bAFK71M30AjeuJ8S0mRYtpaiVw0MlLrZJfXcrbSQKCjcsQ/SOlOp
	U0gddZmjVKzj0iehL2J6OYSuUN41PJKy25F2f7MM2eL2nFPebtlCS6XFVkAM/PByDRuSsfPMUG+
	yf9YPsgX2DPhwt2JPgk49M0sj73BK+vUvCoP22MikqjDJHH0CwQF924HOPzNi/ftzWJOEWiYhz+
	qUYc0tMBkqASLSqC0+F/WG+rXgGuGwtxu8TvAi0BEINPxap24b5QFxyypHtyikzzqaE7JCfCu85
	p6pQJ2pVmImu/l62oQf+0jj2gMHBmtdJ+T2He/9vqB/mWfiOVl+yI11YC1ai6f3E0Ryy0WZbrF7
	MoVn4CGFq++5oLVM7JaDH2Z0GTBfSbOexHDk9fD5sNDrnI8Ads9TY2CErdiUCAQ2elVmslglhkk
	WIp2mMLceabYQ7I4c+G0pcJ/KT5q3t5vqqsrzhy/ZvMsrXpTga4lWZn90P
X-Received: by 2002:adf:e19e:0:b0:47f:4ba0:6950 with SMTP id ffacd0b85a97d-47f623065a7mr7105349f8f.2.1784365532022;
        Sat, 18 Jul 2026 02:05:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f29:5290:1f7d:16b7:b5dc:8a81? ([2a01:e0a:f29:5290:1f7d:16b7:b5dc:8a81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm11898573f8f.36.2026.07.18.02.05.30
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 02:05:31 -0700 (PDT)
Message-ID: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com>
Date: Sat, 18 Jul 2026 11:05:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-acpi@vger.kernel.org
From: harryblanc <garett26@gmail.com>
Subject: =?UTF-8?Q?Regression=3A_Backlight_control_broken_on_HP_Omen_15?=
 =?UTF-8?B?4oCRYXgyNDZuZiB3aXRoIGtlcm5lbCA3LjAuMOKAkTI44oCRZ2VuZXJpYw==?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I would like to report a regression affecting backlight control on my HP 
Omen laptop when using kernel 7.0.0‑28‑generic (Ubuntu 24.04 base, Linux 
Mint 22.3 XFCE).

Summary of the issue:
With kernel 7.0, the screen backlight is stuck at maximum brightness.
Brightness keys show the OSD and the slider moves, but the actual 
backlight does not change.
With kernel 6.17, brightness works normally.

Hardware:
- HP Omen 15‑ax246nf
- Intel i5‑7300HQ
- Intel HD Graphics 630 (i915)
- Nvidia GTX 1050 Mobile (disabled via Optimus)
- Linux Mint 22.3 XFCE (Ubuntu 24.04 base)

Backlight controller:
/sys/class/backlight/ → intel_backlight
acpi_video0 is no longer present under kernel 7.0.

ACPI errors visible only with kernel 7.0:
ACPI BIOS Error (bug): Attempt to CreateField of length zero
ACPI Error: Aborting method \_SB.WMID.WQBK
ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT
ACPI Error: Aborting method \_SB.WMID.HWMC
ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS

Kernel version:
Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jul 1 
15:50:57 UTC 2024 x86_64 GNU/Linux

GPU information (inxi -Gxxx):
Device-1: Intel HD Graphics 630 driver: i915
Device-2: NVIDIA GTX 1050 Mobile driver: N/A (Optimus disabled)
Display: X11 driver: modesetting, iris
Monitor: eDP-1 1920x1080 LG Display

Hardware summary (lshw -short):
Intel(R) Core(TM) i5-7300HQ
HD Graphics 630
GeForce GTX 1050 Mobile (disabled)
16 GiB DDR4
Samsung NVMe SSD + 1TB HDD

Expected behavior:
Backlight should be adjustable via intel_backlight or acpi_video0, as in 
kernel 6.17.

Observed behavior:
Backlight remains at maximum brightness regardless of ACPI events or 
brightness keys.

Steps to reproduce:
1. Boot kernel 7.0.0‑28‑generic
2. Attempt to change brightness
3. Backlight does not change

This appears to be an ACPI/i915 regression introduced in kernel 7.0.

Thank you for your work.

