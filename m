Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896528;
	b=PPfCfY8DT9ghi9XMJmBEbisqXNGfAw+kIKwxxQyoLTss7QN7/jtb+Jys8hsVZDfoqiri
	 N/+0r+j7nkaknLyqgFqazlUAD+KPSQr2cI8PVLQjPD1A+98ma/uzI19uz4xoC7chI5ao2
	 7+XTwhrdlsDiE5OUu1Mz9txNuLlWHz0arrBCLATZkwKA40Iyza40H1pITuXRXL5nEqI0G
	 HrMyoGf+h6gUm8T2J6DmsVghNi+2T4KAw4arWxnp9taguqLcs1eDzowqfr5nUzgHSJm/3
	 kJsxW5XjEPJI5RFyU+E99q9uUUrUEeGYHQgSNy2527JWAoU2maVoOQ7+u3PnRLSoA9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
	b=3ql9o1UFFzi4m20icJypU/dh8foHlIQKYWvsadcC+5RUU497K88vOk0dUwR5cu6xdstY
	 RjSVFwvk9A2v7yYEVo3xeFfIFyyI8WB5s/zV47/vRvzCLwX9pYV16+SU0S3FN7JAYo9PH
	 8bm8yipANk83lpRtHWeXRA5u0xXSzPnynOHfgZliIcIk89biautwAXBi1pPzWLz9UB6B2
	 rUCGB7WwEUMLoGnPJNTSjojLkJ9k0j5USexQ6sA6IzI0eiBUZrR2QJXEBcEVE8HL8P3hD
	 qepnlMG0FPR0Ij95o7foDPyb5Ys0Md4ciHN9oZYgCt0cbjZ5jITFfh47vdzWtHjEqag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BnZdFL02;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118B606A31F
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2118B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BnZdFL02
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-156cbe59622so1277102c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896527; x=1793501327; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
        b=BnZdFL02ObgqDdlRhZQVGeDOr1hl5bQP9RSCGMuwGhcWXvjsvfQYDrj4Wf5qsZVtKh
         JQnQODsdbE3HCc9RLQwb8IeYH5EU0Tb8v8PDXsVtXh9DbxKkEd8/NP1ZJNfsT+F/SUij
         ugaMNlo5N9Kwqhfz/8O4RQNlBNNk2Dg7f1KyRuS62mV46ZHB5WNFwNBR3GYD3/DLzRue
         tct6QOYLVfYERH51QLZAZTmGuZwrbIAzMjtSOqKuzdZtKGEjXUNP7xQC7v2cvVYDV6u2
         6aVciLAG/ooH6QwJDJqHo2G04nyKzPj69t99i3U0TjdkfAmpXc5aaRGwrGjQdkz+7XrU
         OQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896527; x=1793501327;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
        b=LYeBP5h9eGJ+BlcLMPBy0ZmhvYsV210nwA6oNTQtCS805k5zWcZQiDryUVwk1H+ssc
         hl+T4MLoZzfVRM8XExlN7EyEC5lLC3LLTbyDPymEB13s75xNGLofnLwkG7mu3b7IHImx
         +t556tnecE5lOkDUof3YNtJYfc9+TqmgNlFtGUJIRVcUWnSRPx4F2+egamrrP8haxhDN
         RRr957rKYaVCCBaytbRS8o5rG3wah/UpXZX8dPf3h/yGRTKVvBcyunSqjyjm3JAuXXgZ
         S1cDXdwTCnGjt2mFIwizbVpABNY6YvYtkYueC68phYYCNlKGSqUH7hpcPG4AhcUl9Kf3
         xLQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtFyyIgmXmmT2rp69KdLVjTPRGZJK86bV+Fuvm7aUn0sz3HBOHfvP3jXkJ+K0rVPX3jbhQy7ZQw0gp@vger.kernel.org
X-Gm-Message-State: AFq9FYIkJm/kXWLuzZYXnXsNX1WhQDpRsaKi9r6JXfoO63XiMi0xXebi
	vZcW0bk10MqMmRGCtMm6B37bWu5dCU64ovRMaY+RqCIqvCTiqh2QaT3m
X-Gm-Gg: AYBFou0wz3MJ8c0OobWSBFVIjn9JmGRyW2+ixDzb8jC4q6rCCXuQslz2EFPEndavgvO
	X8SR6PyuUnVaBjY/+B93ogBxJzsIlH+JFNpAtaVcsMdR7/uredNBOvZj3t1KVWskpfcD1uoeDcE
	SCrpU9eEPz3zooL091csL3hpqmlokmv4GDcrX+4/MIXYFxY/6C7qbU7M/xFxRSC/UJz+Mu3jrZs
	Lum9GLCI1RY5/0+mvSyp0+3rUqUHxV2uSC2MJQm4wEABvSQoInEaUJQ+mH2HgnwTOdUjhEYVQWR
	d7BFovn0KLrupmTJiHmzaMxTmmY32cTxYVBbHqC0GC54XnwKx1a7WX4wq1Hz0Iygi1cXH0Od970
	K5Z1O6gN9XFSEeJW6OwTsG+GNeF4KWLs1R4Cnby6Cn31lWODetOfR07uJj+Cs5tm8BOjCWJfGzI
	Od4ILMNgmvl00f2kaseNhkwbG0y/0vWLSaZ4doWFu1/E9VtO0cT7Gp8I1LyVqX7Vk4l+CKV4t8d
	a3U2UaOB5b0BHkx5Q6h2rebKcRjBkMy/DxcuzCuft0hiyDzrwLLg8CkLFOLk9JHejQu09VMXHuW
	KAD/+on0/M4tSKQCb3c/HeumTp3tIW1uiv7C5QT15kg=
X-Received: by 2002:a05:701b:2414:b0:14c:d84c:7182 with SMTP id a92af1059eb24-199356256c7mr3987099c88.22.1792896526990;
        Sat, 24 Oct 2026 19:48:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/8] i2c: convert i2c_smbus_read_block_data() users to pass
 buffer length
Date: Sat, 24 Oct 2026 19:48:40 -0700
Message-Id: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhu3WoC/yXMTQ6CQAxA4auQrm0yFDDqVQyL6UzB+gNkCsSEc
 HdHXX6L9zYwSSoGl2KDJKuajkNGeSgg3PzQC2rMBnJ0LB0RKgW0Fy+GSXxEfo7hgdHPHtnVVdM
 4Pp3rCnI/Jen0/Xtf279t4buE+TuEff8AdQ4tLn0AAAA=
X-Change-ID: 20261022-i2c-smbus-read-block-data-b043550b8943
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Convert callers of i2c_smbus_read_block_data() across input, ACPI,
IPMI, platform, and power supply drivers to pass destination buffer
sizes, adopting the 4-argument form introduced in commit 68f382641f8c
("i2c: smbus: make i2c_smbus_read_block_data() safer").

Because the prerequisite commit 68f382641f8c is in mainline now,
subsystem maintainers are encouraged to pick up their respective
patches directly into their trees.

The hwmon subsystem conversions will be sent out in a separate series.

In cyapa_gen3 and rmi_smbus, passing the requested chunk size bounds
the transfer and avoids potential out-of-bounds writes when reading
blocks smaller than the SMBus maximum of 32 bytes.

In vexia_atla10_ec, the redundant intermediate bounce buffer and
memcpy() are removed so the response is read directly into the caller
buffer.

Additional conversions update callers in ipmi_ssif, i2c-core-acpi,
elan_i2c_smbus, and sbs-battery to provide explicit buffer lengths,
and update the prototype in Documentation/i2c/writing-clients.rst.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (8):
      i2c: acpi: use 4-argument i2c_smbus_read_block_data()
      i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
      Input: cyapa - use 4-argument i2c_smbus_read_block_data()
      Input: elan_i2c - use 4-argument i2c_smbus_read_block_data()
      Input: synaptics-rmi4 - use 4-argument i2c_smbus_read_block_data()
      ipmi: ssif: use 4-argument i2c_smbus_read_block_data()
      platform/x86: x86-android-tablets: use 4-argument i2c_smbus_read_block_data()
      power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()

 Documentation/i2c/writing-clients.rst              |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                      | 39 ++++++++++++----------
 drivers/i2c/i2c-core-acpi.c                        |  2 +-
 drivers/input/mouse/cyapa_gen3.c                   |  8 +++--
 drivers/input/mouse/elan_i2c_smbus.c               | 36 ++++++++++++--------
 drivers/input/rmi4/rmi_smbus.c                     |  4 +--
 .../x86/x86-android-tablets/vexia_atla10_ec.c      |  4 +--
 drivers/power/supply/sbs-battery.c                 |  8 +++--
 8 files changed, 60 insertions(+), 43 deletions(-)
---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261022-i2c-smbus-read-block-data-b043550b8943

Thanks.

-- 
Dmitry

