Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8922E285C
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698008; cv=none; b=qOOeD+yFJaX9hGwFpAb1MDVx6GiX2jcIntwbH7qaibz0P+BGAtAM5m6aCzAt9YTxmfGMbdmnpkHCp/Mb1HTc09FW/ctwbnpH2EHRNr7mBT8MZeTIWkrHTOCX8u7RNvMFQdzlPUonydl92L133ItZqGt4TAb9OerMdrVu//W28wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698008; c=relaxed/simple;
	bh=NMst9Xf+v4STuaN1fx0zrwmvwT5Ra/WhR1fBpDJtJrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lSAK01phSdimdI9Xp7qqxBFjD/34DKE7HwjGGSpWf/KdfhcWQ4vxrbxNb67l52oRNcUn5WO//37W4cLhJdkglEe6Gshmoz3xsAdJp7cOgvxCOHbzda6pJZGn+vrtUL2QUCNoDzc/M8FYq3IZbYMe1gxgoWbyMbczqhEplLtvej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WXsirBYH; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WXsirBYH"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h4jRS2Gmzz6GtK;
	Wed, 22 Jul 2026 07:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784698004;
	bh=NMst9Xf+v4STuaN1fx0zrwmvwT5Ra/WhR1fBpDJtJrU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=WXsirBYHvzpCwsOsgdZZu00+qIo4Lad4dPKOmw4ce7r73iNbEg3dNntH/aBp90uyZ
	 VNLV7Asc9lJyX4L3iSaq2hPA3N1/Ncf5Bysnj7IbqPzbHz6h5BsSr8v/iaoLMLhVKo
	 JSoCm8inAZYd0+8B1I7IQeY7ZZBDEfcPmCTUOfAoD4sCu/mBNzrrMv97dAEd1QJ5Tg
	 KkRdiTkYnxhnVeAVhVoTFN03Korx1BjM7/hebhL8It3ETi635qM1ohmDQdbpT1nK5q
	 fUC1PcV/cAZAVZbZi6xHiT0WnjSYwbmE1A9QhV/aRw0SF1TNZ+5UiFdz+OnPtTtUQX
	 yMGsQpd/hDIiA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h4jRS1Yczz4xQ8;
	Wed, 22 Jul 2026 07:26:44 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h4jRR5Kp6z8sch;
	Wed, 22 Jul 2026 07:26:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 28D5F5F9DD;
	Wed, 22 Jul 2026 07:26:43 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <cc383c33-d0ef-40fc-9c14-865a6d7f5d75@leemhuis.info>
Date: Wed, 22 Jul 2026 07:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Regression=3A_Backlight_control_broken_on_HP_Omen_1?=
 =?UTF-8?B?NeKAkWF4MjQ2bmYgd2l0aCBrZXJuZWwgNy4wLjDigJEyOOKAkWdlbmVyaWM=?=
To: harryblanc <garett26@gmail.com>, linux-acpi@vger.kernel.org
References: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178469800339.4154715.10056306368639657873@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 28D5F5F9DD
X-NC-CID: 4yt6E9FuGj5qqMzVe5B2ZOW6LexO7L8/pIRP+dYnst7UcvMt7n8=

On 7/18/26 11:05, harryblanc wrote:
> 
> I would like to report a regression affecting backlight control on my HP
> Omen laptop when using kernel 7.0.0‑28‑generic (Ubuntu 24.04 base, Linux
> Mint 22.3 XFCE).

Hi! Thx for your report. But this is a heavily patched vendor kernel and
also a series that is EOL. Please test latest vanilla 7.2-rc or and
report back. Ciao, Thorsten
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
> Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jul 1
> 15:50:57 UTC 2024 x86_64 GNU/Linux
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
> Backlight should be adjustable via intel_backlight or acpi_video0, as in
> kernel 6.17.
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

