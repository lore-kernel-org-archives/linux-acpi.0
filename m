Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67B13D891
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809000; cv=none; b=KiVaxArrjPSZicP17ymC+w1f7hW6lI6nZZtjcORK6ZNDBRKQCcrqzxt9W4QzXFsJpvR7xvgC/05KZQFK2Hd9YkqVH5ZHLkKivfSDGrDQbhx++PGcV3HulVsIx4umR2LHMvAV4dT6tgDJLEqdsGsj3KMLKEahUuPasGdHAicqDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809000; c=relaxed/simple;
	bh=pZfKd+assU3VL24yWogzRGRbmX1jkyrlbRU5ScQsWXs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Q48p4nj2hdIt3Zn+m3IaN4vtRUh+mD55fTxESkdkHE471mXVXrZUUSR/s3x7v8qt3dMu+Osibj62GVpDiO4InJdz47ZJb9R6NSVZVdqbrGjyRN55Rz/xYQ8PVg9uodo4ikK3o5C79d3/q93RYokqU2TdnmcwxEkd1tZ6knQiWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Xh2tkzh6; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Xh2tkzh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785808989; bh=vYwZM+30tJSrnVZnXjBHoe/Nii0cRwvnAag3naV/C34=;
	h=From:To:Cc:Subject:Date;
	b=Xh2tkzh6RcdyIN/+zlBhaG6hqWqYiig98xTaKiQd6p8qDcEnyYcwkoGV6SxXGtcXf
	 WQkneEsFCqCcGCXAy+vGb0QDbRjzLYKdHYoorCZr9ey43dtzqxowy+7F1ytRqxvTOK
	 h2IgR0buMFODgdzJcFrUsmEFq6oqpDvo3MXBlR10=
Received: from Xiaomi-Book-Pro-14 ([183.162.103.196])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id C69845F; Tue, 04 Aug 2026 10:03:06 +0800
X-QQ-mid: xmsmtpt1785808986tdr9s6o8s
Message-ID: <tencent_E0DC09C013F1131F80E3BD2021DAAE6DFF07@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA9XFs4IhXaE8S6JuuPEn8uKZHZ4aCgEa1+Zv2TQD3cKpEnSbXZu
	 3hZcBMTXSp9QdUTwWLxMPVw/vz6Leh/K6VlA3a0Ac16LGU7Y/RHpepTJMKL3Dh7pefh0ngoFXLrm
	 Ng4fYNtqNotwcqyBt+nr7tHnQawoEDASkQFU0Kar6pFxLJhifDTiMXbNozY58QiS5gFYPwji4QEg
	 91sjk03gScOhpkXpxokkDi9/LPPkIopLU1x0ivNdde5fvHCHeP3ofFgCsdqMph4uJ0H7uCJGwRNw
	 58BX/DU+31YZJIE0epQXWatcO59RTFdP7NyLMFsDXyKcb4HqYl5BRUaQFJ83gzGE0eK4jDJ/24MV
	 rzUI6BTuTF337yd0177cncPrMGXA4MlRTwF0/5uVNpf0WthHjCvUgEq1Hv42fgIGZu/JrGGITJHw
	 zByqJ7vsDvQBPeqt/sFTpOZmFM/udVAbEkcauIwInudt+mI52w2A04xivk62b9Jc8yKt98mDv7hD
	 WAIl+M0akS0qVP0Ncv9cRTiTj+ax4Ygltx4ENKV2XnEstlOzGxBR9Ma5Qwkt1QbfLNGY+KjfD40i
	 KEERFjgriN3NGRLt0+a3BETPapRqGWOiYrCKzWfj8HUKDg3qWAo1Al/sGJovzGQwRsPGU9UGSwkE
	 vVNxo4Dd0BC+BOwXu0HIdsrNNrtH4n7mYBQAwCHP9GuY0dVBCQRBmZz/xr9KI5PHrQCPn7z5SdO+
	 Z2P/80xnbBW8VqiSf7fMUS6NhqimK8owf5eBq3vQVVw6Z3laI6VZ+2jus8Gzk/1iTptN+85tgwJL
	 8z7QaubVAONh7IOo4k+Uox/0sc/6d2W/ZFGdylG9aOjNRC54DjoRNn5p9sqr+VXUc2jF8d0gM+l2
	 h/k57Tt1uo9+/M4bjhxABK6pnXXAvS41GbA5bXVWt7kpvk+82VT4NvrWRDh8kEq/bp3qqRtP8N+p
	 5kFXxaR2q2TXVuMJd37ZVta7jOpvDvvYOpoCZZFJFYrJAs2CIacZiOeWaX2ANhCnuneACp7V5LAU
	 sHRLJBZJBvP8JRQKg5U6CEr25xVtc=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: frank717@qq.com
To: srinivas.pandruvada@intel.com
Cc: linux-intel-ish@lists.linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	daniel.drubin@intel.com
Subject: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACPI ISHD device missing _HID
Date: Tue,  4 Aug 2026 10:03:06 +0800
X-OQ-MSGID: <20260804020306.699456-1-frank717@qq.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'm reporting an issue with Intel ISH (Integrated Sensor Hub) on a Panther
Lake platform (Xiaomi Book Pro 14, TM2424). The ISH processor is completely
unresponsive, preventing any sensor functionality (ambient light, etc.).

## Hardware

- Platform: Intel Panther Lake Core Ultra X7 358H
- ISH Device: PCI 00:12.0 [8086:e445] (rev 01)
- Subsystem: Xiaomi Device 2424 (1D72:2424)
- Kernel: 7.0.0-28-generic (Ubuntu)
- linux-firmware: 20260319.git217ca6e4.1ubuntu

## Problem Description

The ISH IPC registers all read 0xffffffff, indicating the ISH processor is
completely unresponsive:

```
ISH_BUSY   = 0xffffffff
ISH_READY  = 0xffffffff
CMD        = 0xffffffff
CMD_RSP    = 0xffffffff
MSG        = 0xffffffff
MSG_RSP    = 0xffffffff
FWSTS      = 0xffffffff
ISH_READY2 = 0x0000311f  (only non-0xff register)
```

Firmware loading fails:
```
intel_ish_ipc 0000:00:12.0: ISH loader: load firmware: intel/ish/ish_ptl.bin
intel_ish_ipc 0000:00:12.0: ISH loader: cmd 2 failed 10
intel_ish_ipc 0000:00:12.0: ISH loader: cmd 0 failed 6
intel_ish_ipc 0000:00:12.0: ISH loader: cmd 0 failed 6
```

## Root Cause Analysis

The ISHD ACPI device exists in the DSDT at path `\_SB_.PC00.ISHD` but has
**no _HID (Hardware ID)**. This causes the Linux ACPI subsystem to completely
ignore the device - it's never probed, and its _DSM method is never called.

Key ACPI methods found:
- _DSM: Exists (checks PCI vendor/device ID, not UUID-based)
- _PRW: Returns [0x68, 0x4] (wake from S4 via GPE 0x68)
- _S0W: Returns 0x3 (supports D3hot in S0)

Windows driver (IshOed.sys v5.8.56.0) successfully initializes ISH by:
1. Using HECI interface to communicate with ISH
2. Calling ACPI methods to power on ISH hardware
3. Loading firmware through the IPC channel

The Linux intel_ish_ipc driver loads but cannot communicate because the ISH
processor was never powered on/initialized via ACPI.

## Windows Driver Information

The Windows driver (IshOed.sys) source path indicates it's from the same
Intel unified-ish-drivers repository:
```
C:\builds\ipg-sh\github\ish\unified-ish-drivers\Drivers\IshOed\
```

The driver matches PCI\VEN_8086&DEV_E445 and includes device configuration
data with firmware hashes:
- 7AF851FC54FC7A78 (for Lunar Lake A845)
- 7E907E4577457F78 (for Panther Lake E345/E445)

## Reproduction Steps

1. Boot Ubuntu 26.04 with kernel 7.0.0-28-generic on Panther Lake
2. Observe ISH IPC registers all read 0xffffffff
3. Firmware loading fails with "cmd 2 failed 10"

## Expected Behavior

ISH processor should be initialized via ACPI during driver probe, allowing
firmware loading and sensor functionality.

## Questions

1. Is Panther Lake ISH support planned for the upstream ISH driver?
2. Does the ISHD ACPI device need a _HID for Linux to probe it?
3. Should the intel_ish_ipc driver call ACPI _DSM during initialization?
4. Is there a specific ISH firmware version needed for Panther Lake?

## System Information

```
$ cat /sys/bus/pci/devices/0000:00:12.0/firmware/base_version
0.0.0.0
$ cat /sys/bus/pci/devices/0000:00:12.0/firmware/project_version
0.0.0.0
$ lsmod | grep ish
intel_ish_ipc          36864  0
intel_ishtp            77824  1 intel_ish_ipc
```

Thank you for your support.

Best regards,
Frank

