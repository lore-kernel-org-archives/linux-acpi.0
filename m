Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C940F750
	for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2026 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790422011; cv=none; b=IozFIwyxxDRw0Cc6Fa6pk9lang4/VDpttNKtvpsfFtNN66QOtd41/At/fJPAjIMrY/4VCy/9rV7g2z5QGUoSUJcif/wi6NpGMSJk6WEc3zRkIDLcGcqSqdEmZVWvYH2Q/VMKKb/b5ed+L44YuKTlb1bAw9nIvHn9xYR8CHQK2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790422011; c=relaxed/simple;
	bh=1009E+OV49y9ei1QpwSQlS0Y23MikCdVe5F5Y36Ggls=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=Ho0yDbVtKn+l9YCF3IuOMw8v31+uZoMJC5FSCsYAuAixz/7ZnvHjNB24NpsYQTy/dU/K7OlYCLBwwEliRyox3dRmUnDtO4/PilB1fZ2oeGkStdpG+w3I6pk737wVZx7EqZwXU0MrjbiJsPupGNl/jzUzPNzipz3O4rbxCb2w30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTph+3Su; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTph+3Su"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso916541f8f.0
        for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2026 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790422007; x=1791026807; darn=vger.kernel.org;
        h=content-type:mime-version:date:subject:reply-to:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHPaExtfhluSdFU0L46Z8nZGmiV0E/2V9Ek+p9fDWZM=;
        b=QTph+3SuY9X7QpKZJF7A9o1vCffV/4nZPtqS4DhbpLFWPasGqyYny19CSHrNVUf0J2
         0xH7Wl7Alb0y6OMhsnyXOahXX5gwPTWP396rxgw7LtkI+I4xXu+0ZB4MtGqvevEoOikh
         jOj8P+dOftkdpfBZpVnLMN3QWgNRdKuckVOqi9PtXR3BqfXI+kBjCMraEBcBt1gt23dD
         QuRkqDvGcJPxplqCkTFFiGjdWCZ9rWJ0kPHIaM20WfXA0fRDjdUd+Irvc4IIzL1m/F3P
         jwKIp3juqwY+vyet6p79W7yv2LfIbpbF11ytnF2gEs85yAXdmqt5xveLw8k5jWehxppZ
         jUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790422007; x=1791026807;
        h=content-type:mime-version:date:subject:reply-to:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHPaExtfhluSdFU0L46Z8nZGmiV0E/2V9Ek+p9fDWZM=;
        b=ALg7IBzu4Lzvef3NFiGArPVAL9swTBBLO5UtKxd2HP0/qRtVJ7DGmKkGfoGOX0U3u9
         e1vSqjmfTUftprtabryMB3BNS0zDHt4xI90CyZ/TYm9mL7dZGEOMX2XXToNviPodUrCH
         Z2lHaL3U9fb8AUfHBssq/WjfwrzI8X0HlhPMLg+1UNb+TJMZR/j/ThhtWkQvwNNSKvVf
         azSsjlAl4ZqaXLxyDU+kayg6DKiwGIcBN4yzb8/4xM59ToXCUoK7L93ItYeHM/Av2CD8
         URdliXNeouhnfQJKKWz7Pod9Juh8FMKNBXKSPYs8oqogYqAahmfwDp3wGEydZTeXYk5+
         +ezQ==
X-Gm-Message-State: AFq9FYIMVRRN+Y7v3SBlVGokVZejuIVyqkvwKK3QaJNrc3imzuVmaatl
	n+A57ok+I+XEivBEH6yWv2R1Eonlldk8hL4JmPIoUUYhx+i/e5EiKfJavunC+Q==
X-Gm-Gg: AYBFou1ktSWdkO6CDrnVUiWG71LhCQYSagDRZRQ0cJaHOCx1wBrrrNIG9MM6WC3wMnr
	0x1/7XzMFrLRRB4v7S1H4GO2JmpETG/aufEu4W84MqVDgV5YE83tFIsj/3+8LLOzqZ0HQ53D1o9
	prxsjuP5AIhiHkUe7ESoKIcgDLpOfym0tBobM4vXDAczOERSpKTbaPQQrVm7qFTe5GkzupSSfli
	hZCWtAfGBIji8eJQWAjP0ETBXJzJOyXBM2uCgD+zFlo+UNgnCpQK2lmCkOdJnf4MNjXWvfks0X5
	n8f5hpNKhOcsLvJKHQtm+73SvlrfZy6qspfdD5m6qaUAY6rFZIhqZ5vcXTnmJ2GvDE7RFG10yKR
	3+CJOC78am05WHEfiBiw1QhLsjgHW/WMKE8lcGuGMKhg2mWQtlF0KVWzZZOIZIhjz0LURwkj+es
	NDNUiUeudm4FUTMuWd9zQQOFgYQfttAHIZtIgxUOxBd1twBOerCYDeS1UUtnSrnPE2CXQZts2OW
	xr3IZtz80oOQw+nHdepWnrhuLyOkoIQLELa+Z639vY=
X-Received: by 2002:a05:6000:4a1d:b0:487:1470:52d9 with SMTP id ffacd0b85a97d-4887d9fa527mr8926154f8f.3.1790422007420;
        Sat, 26 Sep 2026 04:26:47 -0700 (PDT)
Received: from bugreport.eml (211.red-79-146-43.dynamicip.rima-tde.net. [79.146.43.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm13310130f8f.37.2026.09.26.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:26:47 -0700 (PDT)
Message-ID: <6ab7abf7.09148f95.17f923.ff4b@mx.google.com>
From: calvitohq@gmail.com
To: linux-acpi@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Reply-To: soytucalvitofavorito@icloud.com
Subject: [BUG] ACPI battery: BAT1 status "Not charging" and capacity frozen at 99% while discharging (ASUS TUF A16 FA608UMI)
Date: Sat, 26 Sep 2026 13:25:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Hi,

On an ASUS TUF Gaming A16 (FA608UMI), running on battery, the ACPI
battery reports status "Not charging" and the capacity stays frozen at
99% even though the battery is actively discharging (~11 W measured via
current_now). Expected status while on battery is "Discharging".

Hardware:
- DMI: ASUS TUF Gaming A16, product FA608UMI (1.0), board FA608UMI
- CPU: AMD Ryzen 7 260 w/ Radeon 780M Graphics

Software:
- Distro: Bazzite (Fedora 44 atomic)
- Kernel: 7.2.4-ogc3.1.fc44.x86_64

Symptom:
With AC offline (ACAD/online=0), repeated reads give a stable (not
oscillating) "Not charging":

  /sys/class/power_supply/BAT1/status       -> "Not charging" (stable)
  /sys/class/power_supply/BAT1/capacity     -> 99 (frozen; no change over ~40 min)
  /sys/class/power_supply/BAT1/current_now  -> 617000 (~0.62 A, ~11 W drain)
  /sys/class/power_supply/BAT1/charge_now   -> 4379000 (frozen)
  /sys/class/power_supply/BAT1/charge_full  -> 4424000

UPower consequently reports state "fully-charged", percentage 99% and a
bogus "time to empty", so the desktop shows no meaningful percentage
while actually discharging.

This looks related to the existing report for the ASUS Vivobook 18
M1807HA (Launchpad bug 2152185), where status oscillates between
"Discharging"/"Not charging" while on battery due to inconsistent ACPI
_BST values. Here it is stuck rather than oscillating.

dmesg shows:
  ACPI: battery: Slot [BAT1] (battery present)
  ACPI: battery: new hook: ASUS Battery Extension

I suspect this needs a DMI-matched quirk in drivers/acpi/battery.c to
force "Discharging" when no AC supply is online, as suggested in that
earlier report.

I have the DSDT/SSDT (acpidump) available if needed, and I'm happy to
test patches.

Thanks,
Marco

