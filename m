Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792882063;
	b=oDYdFPpbfbvBQ4ykFZibOF/8WvCK2rlEl+3xqwENqA+MPwhXhZiFzHr7KUr3DR21Za4A
	 hWLCII5zd+00SS2oP5FYUFSaGKm+Caqb1m1dHqWm+q3BY+R8RdVI4UGy16dzMpTI877VU
	 gGQO0bU37g3XthxTJtZL1lBuaHMDJlW+dPXWlDeCxDsTn/KCWZd4ooUnsb7bfwPIri/m9
	 AhBGIH4T4SXi/JnUnZV4OeVaoOmnuBeXoFiFGz6viMz1pQGjzsoaJCMs2Vu4RN4G/XXCL
	 7qj3SKMD7kEteF2Gxg3R7HcRXmkfDwix9XWsx25niEb1NK6xjN9DtchGXGKkuqhXPqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
	b=OBVZfTUqM23/eFA3zGnIACsmQBgHbAAM/UcRO7GZa2rsTlyRvxTQxA5vPUmocot84XUb
	 Uzzly3DO3xOkCXOrhffZ6ms0wOETKym4J/uOv0xayCr+pIj4d2sysq2tJzDdWPKDtKY/b
	 iyY0iyFW4TDQ50PGSDTBQFqplEP3/9oAexxnQmZQTZ6LH91VP/tJMc+o8lCM2ZqGw6fmG
	 hE0hOqFK1aLSKDLYOFZdUBADxaErUSfpa5j4Uh8gAdNKzHXcfH9o4AFmbUiM3nxURTy1/
	 bZcpuJ3N+Fi4c3FuwIfR9HVeGTjfVY8GYP9Ecrz5bPPun85v+fTLE00lbf2LYyYuUzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NvNTK0Tj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1925606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1925606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NvNTK0Tj
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso2701672a12.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 15:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792882061; cv=none;
        d=google.com; s=arc-20260327;
        b=X2y0cyefcsn/M2/cC2Ju8FAV2DDbY1O+RpcDiKAZXoYAredfU2DXpgAZv5KLCofdKP
         2Uky2WexN5j6fEPpfC/XyTTPicb1nUfrq5N6Qkq/Maeoa7KGxriZU3h/EhaovNQ0975F
         614O+6cbIC54sz8Hh9GvYRpR78KK1Akne/7DzTEVDAjcKfI0QQ4fJPyuKvyTqMyZCO/O
         LYt1pEbEj+7cQ63RCP8vOuwtvT3frFopa9RHYv3+3ejpSfwnMkvpvYp7dQAfLC1Y+Fhe
         fDPsfy44OxfZ6Pu7tKFvcnoLQYtK3AgS7OhPB24uXBKrpmH09BSITtMcDTf+9ECqGCAX
         KNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        fh=0gpmcV5Qg3OUN/z2ZXcjebYxdY/JhqnUsY0jf7azn+E=;
        b=fcRm0C7lQCOWZxgemXz8m3sOG5JAqQfMGLPYh+NOd8nDXZoZ/XV93y/5/SyJJDzvMA
         TPIFvuferbK1pbLdzzttlFkGpRsQPD8WVMzLo256fkw6PiGhdNNFeRluolQ/GGytyBNr
         UClpvbGbF/RWHKlZCO1kLZdmzbRE296vbTZM7rmtYlUXojhXkdTOOn95FvxeAfTBqbP7
         ykSEpFyAez4DZ8hbkQtVBuvabRq0B40b92lsN5Djpyesbwa1yRp6IRyd66ETFFbIo5L+
         /CZfKYC5ygBDauXnRJk4hr1F5fyCYSsB6X5eX8YI1pomrtJM3QOwA0BnR//NTA/WcpRq
         Ymdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792882061; x=1793486861; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        b=NvNTK0TjEDCZAqtWBF3om4HvZP/pnShex/+wJo7ZBram22JM84GtN/m9XPMVXSI/oV
         uGp6mxzSnuWDDwRFj9rDsShNCJ2sf2Pry41W6xUT2LjGSDhiOk3wVTCn5ImKnYoUhbC/
         AygTaRA8OAi5t+JVy9hgZfIy9MaCkpCeSO+ixdjnI/L22F1RqqQnvH6VYG/UadgCdp6p
         fV5mVk9FLFTmdxQu3oToqQIKtzc70RARiqdbgws57TDgCWxaoAWgklZbIyr0Ypz/7+U1
         xhhKFIp/zGxFXNPxTRC/vIBpcIXPiNOjZ/zmf3qttdAmN+TY1Y3uWLYWBDy3wOOchqSO
         H7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882061; x=1793486861;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        b=i2/r7P2qr8pQRIIWrR8l5wIUKfPx8YY6bHyzYm8D9x0ZHSx/35JrFOyRn0qlIGtysu
         V/vtXNJb1ule680Bk9ARk64qjJ35A1gbU0OhA1slSNlzVI+ms+rKp7cofjOnLKc4WICD
         hQFimQGw+2iU0YuVynJNiFacbXc6Sk2FhADfvslTFhm8R2e8rxfbcQ5TBW2+2rS7jaqT
         Spvh4oLFntHuULNHdr+DPVZ9sPgepG0/bIF9nGIpOVtW2LHUz56JTrBC/JiCeejwiM7x
         zVoETzOqnxnRxbqySAMpERT909+8+82wXU5jUE7/2sPExaSDUCxfMrYzMCbe6GWhUe2A
         wrRw==
X-Forwarded-Encrypted: i=1; AKwUvBz5DFUgre7Bn+GqNvknhxg2bqYsg643zgjDWj3Jd6bC92a9dNgLfGdCGqJB58ZYn+4OmXPS+iYghweW@vger.kernel.org
X-Gm-Message-State: AFq9FYJeovUNHWTuggqfjw+PpBbXzeZpn6ruLW1QH7sgfCoTemgIa4FK
	KAiK+X1HTer9jOjlUWiz6qA/4J7CsawWsYAXG/dgsf0RLdRVbjs8bBXjXzgPgwcubytVd5bOe5P
	2TOiqxOdFJkzusHr+CsmxXrouP+v/tXA=
X-Gm-Gg: AYBFou2NOuAApqp9bFGSLq3prV9NEwnT58tmyssCyFexbQU9kRrwPFl2tTe+S8uCBu2
	yVqAWRRO3mTlPdRNDYCpQSMkJo5ZTOg45OV0AV0Mk8aJH+p4GvksTaKzCUdQhHeyRFy1Ryc0Km2
	vE7hLa2Ubs1MEOxUXU28slrewv9lbj+WxUYdY7I3jG2m8tcArWXh11Acll0MRd5Y/Oq5BlqKJ13
	K2vEYC0FhDdXp3PM5RoxLjAJN1nIgUCULyT7vcsz5I4X3t8RHs4oEDZVEwHllfift+aWnM+MKoD
	FA15/axv9o1n/eO2mNB/TpW90gwEvtbXSS1lOBOSr7atoOUt3KJgcdxm474FTq7PcGRanDfrfrS
	w7zcj4uIBs5y2O0Cbv2qLyTjCf+M6F2swgOM65g==
X-Received: by 2002:a05:6402:e08:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b443a2fee7mr3591780a12.10.1792882060790; Sat, 24 Oct 2026
 15:47:40 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Domenico Suppa <domenicosuppa@gmail.com>
Date: Sun, 25 Oct 2026 00:43:52 +0200
X-Gm-Features: AclHuK84iwYwcADuMVCUOUYb8Pad-bbbUjeJBTQvX6wwjDeQ-jqJnqjt6Unj6PU
Message-ID: <CADP5X9J16EYxO94eH6cGJT70k1s_QguPPPGEzH=s8hfQ7dknQQ@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 0/3] ACPI: scan: fix the fixed event power button
 since 6.18.57
To: Ting-Han Hou <ue081723@gmail.com>
Cc: Domenico Suppa <domenicosuppa@gmail.com>, fredericmariejoseph@protonmail.com, 
	Greg KH <gregkh@linuxfoundation.org>, kernel@ametros.net, linux-acpi@vger.kernel.org, 
	linux@stwm.de, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, regressions@leemhuis.info, 
	regressions@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Domenico Suppa <domenicosuppa@gmail.com>

Hi Ting-Han,

I applied the three patches on a clean v6.18.58 tree and built a test
kernel (6.18.58-acpifix). The patches applied without fuzz. The power
button now works correctly on my machine.

Here is what I checked after booting the test kernel:

    uname -r
    6.18.58-acpifix

    dmesg | grep -i "power button" shows both lines:
    input: Power Button as /devices/platform/LNXPWRBN:00/input/input2
    ACPI: button: Power Button [PWRF]

    readlink -f /sys/bus/acpi/devices/LNXPWRBN:00/physical_node
    /sys/devices/platform/LNXPWRBN:00

    cat /sys/firmware/acpi/interrupts/ff_pwr_btn
    enabled (was invalid before)

    /proc/bus/input/devices shows the handler for LNXPWRBN/button as event2

I could not run the evtest check because systemd-inhibit is not
available on my system, but the ACPI state and the input device
registration are correct, and the button behaves as expected.

My board is: ASRock H310CM-HDV (Slackware64 15.0 Linux x86_64, Intel i7-9700).

Thanks for the patches.

Best regards,

Domenico
