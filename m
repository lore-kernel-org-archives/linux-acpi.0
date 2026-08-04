Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAF27876A
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809247; cv=none; b=D7qDdb7OKChHvbzLNKNbAAg1tCk6A622LIdtv6iuXMWPf34rZieUoA0Eh+jJ13nQS/RcU8mwDu+/bBE638OD2iqwMcrkLCsnr938Ti57kPlURSkhmmERLJAnitu0X3+9azXVJv1bqgQpD5ent1kFT04m8i6OiscWGnvXuFjjNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809247; c=relaxed/simple;
	bh=pZfKd+assU3VL24yWogzRGRbmX1jkyrlbRU5ScQsWXs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RyWGJUsBsIzJVXYRRBOuHNQ9DDpMSI763+nivC6hOwKHM+QvjifSKwOBdfMtZdpBvncAviv6h0ueI5GNKxP9UxV/3Ws/VVxN4hOE+EyyDcvi5xtXCAKc5EsSPltX96TcGyFNyuiFGsDv+H+Pa5VvkTVSE4/RThTQ1QHIXX6qTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Lx7eLnSk; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lx7eLnSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785809233; bh=vYwZM+30tJSrnVZnXjBHoe/Nii0cRwvnAag3naV/C34=;
	h=From:To:Cc:Subject:Date;
	b=Lx7eLnSkOgE8EAHOCw2OvR04ANcdH2RSssTjx01QQvgIq3pTXAYsohB1oyxtEIt/0
	 1cEke6BDM3YFxcC7JsNcYlCeCjqFrXwUtcKOKgNE/K/Dk6OIRY/6Ehqa+FgC8xB2p3
	 zOiDvRGuDFVtIOTwnZtgIaL7szQ3pD3cLyz85FGo=
Received: from Xiaomi-Book-Pro-14 ([183.162.103.196])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 1CB85821; Tue, 04 Aug 2026 10:07:11 +0800
X-QQ-mid: xmsmtpt1785809231tuu82w7hx
Message-ID: <tencent_E301A1C5ED7C868FC1827068ADB63D727B09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GN12c9ErvdTarapyjU+dkGIzPZ9euvu4uhlIdWgCmFMIAj2z079
	 DH5XcqY7MnmV1UtnnoO42jAwoX3K3LiV9dyLBjkLkvOVv1KwqmyiAEHckTla8Obb9yekhs8ejm66
	 4geDO8De2FlAq8+cN5bNgbplZk3iNx8frEaOGvAhmyZX8Df5wNhvWqfxNIDoOoZGx+OnFtrqfBVb
	 dgqZkV8Vi4XkF1fHwkXfjx0CLWzwEp6vsqfjeXn6YtFNChBHJITY8KuesA7ofC8mKwVXvkGMImU2
	 X63FHuRkdWS6n2lWpEOYB+H+cLYqFpPL3SHjkMnxRxpbKmHYWGEP5Z1DTUWB3mz7sFkm8Z9mRe9p
	 szuBT99asB1iGGUd0t48m42D8+R1saBvaCOHgzwsP0tYgFbeIT3vcaGOjsupe0BAgfZsqId6i80p
	 r49BK50ah5tSGjP9/k/ETbBd9sIfUbcvBmJVvHpCL9G1uTrukmv+6TdfnYQkq5u4q9PWfZ3EOJY6
	 ZP3IL366y/AVtWinZRQR+m7BjQsWBqgmk4MV3nn+A8QcsvFnAoK3yO4A8fuhz4jXu+FL1foPMYw9
	 U5VpcuvflDbLs/VHfeWLgd4DgP//59fMP2JH17iG1FajoI/rBFUZDVesIEG3ePFiy3VHfluhEg8M
	 PJ912o9Eb18KYL3AAWbe09bSi9kwAbaxb6mat7nztdWczTTWpVq6fop0AOJShDyL5cN4CsHsBxaX
	 UU3Tr8HKk70H7zXlXlmpG27tTf99Q45QQ50B+JKroxJTv8O5cwEfo8FzhJA7RuCMT9ungFWCcNcW
	 onaQgtZ+qhnrZK68zoJ2xumyFNRM1qhId69p+3H1c+rMkIXmvQIlOyUhLCpLdqBKRvrMhMH4IyUu
	 qTyBpe1hk2iucrU770sCxPfN9vxxz9S6G3telo4J6MPF8/8XKWc1bFSZ/BP5BQrAJ3Yzgn67Nzvg
	 aYGc7LfudJ0ChJq0MB+n4buphzVnyEaQ/KZq8ewg4vyXBQFVLmiJG2t+IS2Vzy+/Xau8BrHfVwv9
	 NJKmGm0SQ/2RCQ6us1BUsVws2aJ8iiptFV515KV1QcKZ/dUcoFAM1Lmipvddx39ePNg1IpV/3I8B
	 nWLQ/FQakuEWvuPbqZnxKlpqn+Hw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: frank717@qq.com
To: srinivas.pandruvada@intel.com
Cc: linux-intel-ish@lists.linuxfoundation.org,
	linux-acpi@vger.kernel.org
Subject: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACPI ISHD device missing _HID
Date: Tue,  4 Aug 2026 10:07:11 +0800
X-OQ-MSGID: <20260804020711.706891-1-frank717@qq.com>
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

