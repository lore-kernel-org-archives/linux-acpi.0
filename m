Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264154;
	b=aHp8exYFODUu8M/EdH1gUi7B9LMvw5Zx2eecPYGeJjBkhdujIg5+wE/1uvbV9JruEL/8
	 R4pdbu/aQxcbEwLsHLBR/oaF83T/TjnaSKd2VGKaHB5Kuv9EWDGflZUPZal8V20Pz1FBk
	 XIaCf2muTogk6qxdV6NCPd70VxDQfsyTFybVmMe7szSUCboof1x55Ckd8n1VKYibv1BOo
	 aWBmuVGdJ889MNYDFrUYWdBQCfUE5VOg8dZhftXCapwGOa+GRTmmYOh40BMN44LNXkqcX
	 qR44BvaDP+tVByzQYDAQ+EWWtqDmjfvH0gfCqFu3QwDe+f89EYz9Yao/IWkyGPvNWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
	b=H5gkY3QVhafbjfYon80/gv6gYUm9jZKLW2pIoxR6d3r2PAORMCfacUX62VQe5zG9F+5X
	 HnR8P4V4UpgKhqXiHjfyeyO3wMrPgcpRJDaBrJniuH6FiEQ+P3gV1T0GJiFLdhEFh41VD
	 nVBympMtW8ydSfxmrIpb3u7GW1S1Pa6xdZFL025+P9g+cOfPmhYFL0ubmSVa41dkxVOOj
	 xXoRu8qDaPZyxxTMfRhFu3eeC/M/+DyMfgmKrZNff3wIKCvlO7k7D3VrICRF1gbjMYyLW
	 ejbTPrcnPbxy7jAB5zV3YlGlOygUkxa9ofQIfnf3pI1AfruvkbgdFkWtr2v9DYUPgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLptjGD4;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486C606A32D
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1486C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLptjGD4
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-369f33df08eso3511008eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264152; x=1793868952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
        b=DLptjGD46znSG6byzVrIUXtEd0wYp2ocot16hHp52y7rmlSFqfhMJlc6i2rtkGMNBC
         Lgp16RnFrXpaOvusnzJqL0Eh7tb8mrb+2S6ryqC4/zFcjcyLv9hWVwYn3Ct8znpb1mAY
         so8I8+u8h95CImV2pByyPmF8cmpo1oCNQNz8QowMRx103M7m3wqfPNJaNdCOnyzam9aC
         s0Ew2+a8RHtNJQMbBZr3Fuyn6iie3/gbNdgGgCe1hA1aD+U7IEXr99AgA0mAo/8Z543B
         gQLUedJ85qZ4m2DMMLVn/f/dF2yt6LCZfyLT6jtXnVAoOe+nA0P/YgtA+MtL7Neibt5k
         lprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264152; x=1793868952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
        b=YRSkvE52OIDimxg2nvmMLidXIyBdlbGc18ot5MxUxej98G3ygXrVLfQY+vmZSI/LEr
         oVdHfahHojz5gXNLBXZC9lsO2vjahGvQTvX6bOwv1nvDnYXRA5WMbbK/5tKPMSZcjuT3
         7M257SFpSAUt/bket3TQ6pTf9OkmulFYhI6W2TKHjAmMBTr5RgrTJYhks0Wwg4d2l2OM
         jQQY5f6sUZjNP5qNcuJmhCzz/Fekf9+bMNam558JpzvNULBVzlpJ23hrtl1CrcYrdTDw
         2tzHDK9Sapt5iZT1WYkNoVmxLLcIFS+KgjV9kNB1MLuxxIP+oTzINsaw/jAJ1x8MxmyT
         OVJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH9YhUsFBuQ47Sh7Nc4u8Q382/RH7gjzXLmCtetWdfzm6NPfrP07gDq36ahOdogVCyf9+JvVVm8ESJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJef5bBP8U3ObLKtJgRdnx4VgWe9e15nqAj+bNCtAk9njoHL1VW
	wt093G2TXlxqJ1e8qyy4fNaeeCMzunrBUxGg7Pg/8HTlDSVGGnwz6Z4=
X-Gm-Gg: AYBFou009hmcBWzxelFp0wK8ZYwLahKV0hbGrzGayrfPFwHCN081ELdkTWwjUT8YG6H
	qzbP9mKK09BcQgt3O5p/D5/DKK5DRsQNHVq/3NUonN8y0H0NSfECE4muferxahyiB/9lLezUbxI
	r0nGnCb7CoiktpeUBhQ33ALSoovCqDfEvZoTtTvLbK46FOAAqedREanNg8ftM8EgMi1fTiNDxxI
	81QeKjo+5fBnXgq3zuuqwz/t5yAzY4AdAmdVYSJtahHS6nrlKeF1BCTs6i1k+a6qX+fL91Nvy5z
	u9q0fmVmjzXWxvCD1dNTL4nonM1AcIECSvbbsr6s0Nrf/Asb4+KrPbEPWdztwiOoNmzIFKZc3m7
	FAZAhAxEn77B4hAKUkqAJfl2VGNbXTlicVbMcZiWwSylg4DNm8aMF7J7suVZqwe8Ag6mln7kz7Q
	dy86gC90Ej5jv+Wr0/gCwE4V8VManW2P/2rD2DmqyMLNKWwQCMq9KhR+I1pqd0h/KdWCnRWDN2G
	j/meSH7YN+bKKI+0Ft7OgylaFFYW1idbB6JskvlDnNv7OUDlrKX/RFrS2jBlr4v3oJ1ZIiFUDaD
	tWkyoQA0Ei8/CCGuVT3E6JnhFGeWrWRpEYs4ZxvbX9xhbR4KVppOc//IC5jnMLRdX3BnZsIjck3
	zWgiOO58=
X-Received: by 2002:a05:7301:7c12:b0:35c:ba31:6fef with SMTP id 5a478bee46e88-36a2016c61dmr10086277eec.36.1793264151721;
        Thu, 29 Oct 2026 01:55:51 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:55:51 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Thu, 29 Oct 2026 04:51:57 -0400
Message-ID: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

applesmc is very old, and all of its code is lumped into one
driver. Fan control, sensors, the light sensor, the motion
sensor and the keyboard backlight in a single file
with its own way of talking to the SMC. It is hard to extend
and to support new machines.

This series adds Intel Mac support to the macsmc drivers that
were written for Apple Silicon (the Asahi implementation).
The SMC works the same way on both platforms, so we share a
lot of code with Asahi. Only the way of talking to the SMC
differs.

To make that work, patch 1 splits the macsmc driver into a
common core and a backend. The existing RTKit code moves into
its own backend. Patch 2 adds an ACPI backend for Intel Macs
with I/O port, MMIO and interrupt support. After that, each
function gets its own small driver using the standard kernel
interfaces (hwmon, IIO, LEDs, power supply, RTC, watchdog),
instead of one large driver doing everything.

On Intel Macs these drivers replace applesmc (hwmon, light
sensor, motion sensor and keyboard backlight) and acpi-sbs
(battery and adapter). They are mutually exclusive with the
drivers they replace, so only one is used at a time.

This is an RFC to get early feedback on the design. The macsmc
split and the Intel Mac backend touch fundamental parts, so I
would rather change them now if maintainers ask. After that I
will test the series on more macsand send it upstream as a
proper series.

The series is organised as follows:

  1      Split macsmc into a core and backends
  2      ACPI backend for Intel Macs
  3-6    New drivers: watchdog, IIO light and accelerometer,
         keyboard backlight LED
  7-9    RTC support for T2 Macs, a T2 detection flag, and
         disabling the broken ACPI RTCs
  10-11  Power supply support, replacing acpi-sbs
  12-13  hwmon support for Intel Macs
  14     ioctl for userspace access to SMC keys


Tested-on: MacBookPro16,1 , iMac20,1 , MacBookAir4,2 , MacBookPro12,1 ,
MacBookPro15,1

NOTE: Almost all drivers have been tested except the motion sensor
driver as i was not able to find any device that had one.

Atharva Tiwari (14):
  treewide: Add backend for macsmc
  platform/x86: add backend for macsmc in intel macs
  watchdog: add driver for apple smc
  iio/light: add new driver for macsmc
  iio/accel: add driver for apple SMS
  leds: add support for macsmc kbl
  rtc: add support for x86 macs in macsmc-rtc
  treewide: Add a flag to detect the Apple T2 chip
  treewide: disable other rtc's in t2 macs
  power/supply: add support for x86 macs in macsmc-power
  acpi: disable battery and adapter for x86 apple machines
  hwmon/macsmc: add more types
  hwmon: add support for x86 macs in macsmc-hwmon
  mfd/macsmc: add ioctl to access smc keys

 MAINTAINERS                                   |    2 +-
 arch/x86/kernel/quirks.c                      |   37 +
 drivers/acpi/acpi_tad.c                       |    4 +
 drivers/acpi/sbs.c                            |   17 +-
 drivers/acpi/x86/utils.c                      |    4 +
 drivers/gpio/Kconfig                          |    2 +-
 drivers/gpio/gpio-macsmc.c                    |   13 +-
 drivers/hwmon/Kconfig                         |    7 +-
 drivers/hwmon/macsmc-hwmon.c                  | 1126 ++++++++++++++++-
 drivers/iio/accel/Kconfig                     |   10 +
 drivers/iio/accel/Makefile                    |    1 +
 drivers/iio/accel/macsmc-accel.c              |  248 ++++
 drivers/iio/light/Kconfig                     |   11 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/macsmc-light.c              |  189 +++
 drivers/leds/Kconfig                          |   11 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-macsmc.c                    |   69 +
 drivers/mfd/Kconfig                           |   15 +-
 drivers/mfd/Makefile                          |    2 +-
 drivers/mfd/macsmc-core.c                     |  362 ++++++
 drivers/platform/x86/Kconfig                  |   10 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/macsmc-acpi.c            |  642 ++++++++++
 drivers/power/reset/Kconfig                   |    2 +-
 drivers/power/supply/Kconfig                  |    2 +-
 drivers/power/supply/macsmc-power.c           |  751 ++++++++---
 drivers/rtc/Kconfig                           |    2 +-
 drivers/rtc/rtc-cmos.c                        |    4 +
 drivers/rtc/rtc-macsmc.c                      |  126 +-
 drivers/soc/apple/Kconfig                     |   14 +
 drivers/soc/apple/Makefile                    |    2 +
 .../macsmc.c => soc/apple/macsmc-rtkit.c}     |  185 ++-
 drivers/watchdog/Kconfig                      |   11 +
 drivers/watchdog/Makefile                     |    2 +-
 drivers/watchdog/macsmc_wdt.c                 |  140 ++
 include/linux/mfd/macsmc.h                    |  104 +-
 include/linux/platform_data/x86/apple.h       |    5 +
 .../platform_certs/keyring_handler.h          |    8 -
 security/integrity/platform_certs/load_uefi.c |   38 +-
 40 files changed, 3786 insertions(+), 395 deletions(-)
 create mode 100644 drivers/iio/accel/macsmc-accel.c
 create mode 100644 drivers/iio/light/macsmc-light.c
 create mode 100644 drivers/leds/leds-macsmc.c
 create mode 100644 drivers/mfd/macsmc-core.c
 create mode 100644 drivers/platform/x86/macsmc-acpi.c
 rename drivers/{mfd/macsmc.c => soc/apple/macsmc-rtkit.c} (70%)
 create mode 100644 drivers/watchdog/macsmc_wdt.c

-- 
2.55.0

