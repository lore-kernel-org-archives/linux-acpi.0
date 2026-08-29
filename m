Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF13B0AE3
	for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788015345; cv=none; b=Lr3x99CySKHTI0/0DanqJxXjaSkDmtf7BC23WIu3U0HD9hzdgSa4PygehixUSwYMYfvPawJJWA0OSyfGXmGZI5RQkvlgBo1wQNJsO1X4DVBgNvILyFPiqB+ERc7DD8iV0BfpBK9PG439rnu8hqiQLvq/f0qJyDbbvg4KocCkwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788015345; c=relaxed/simple;
	bh=BwrsapI1lbY1VuA5R33NbR3GNe+BnBcSC2crTnv7Rlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSHtDqR1HLbLsM3yPqldTzn44ydsvx5n4eIyU7CTUYNrdtuvQmbUFOZORWJ3wAEiagDd78T7/TpUGb3nUPVmxc8EQjssx1bqX3Fpc7CWPVHzeymtg2FXMHsZTJEPGzU+t0JKfHjevmi7gBjs7v8hZP+EMKrTY+fYBG5kMpNcfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeQO2tAS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeQO2tAS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so10611705e9.3
        for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2026 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788015340; x=1788620140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sznin/P7lIs0oXLcYrBqu0KsuS3x0PiQ6+HHBq1mQpk=;
        b=aeQO2tASpTC6K+OKTMzafHVMm27055KpCE0AyqCeat5/0QZ+hmgyIy7I/j1iqKJQO0
         u8fDotU7MidWZqFZPcLX0TiP6KpKcPSXT0s0vI7LuP4UZaColNeM95UWi070LgxtibNk
         sHOYJg72WufV2QJMtjOc5yC5eB4C67EtohCn9NeZaviNgiIarYfPOKY0AqL/Xso9PwuX
         TAg21ooii38JEqwIlu9YWG/ND24YBUCCPGr1uBj1DFZveOvOaszeP5qjIRh835K9XmrB
         8mf0VZV55oktvE+WbQzEzbsMZDD0dTq5iKEooyJ8hLeoEyJYWfh16p7jxvTGdtEchUS9
         hLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788015340; x=1788620140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sznin/P7lIs0oXLcYrBqu0KsuS3x0PiQ6+HHBq1mQpk=;
        b=j9yiydssU0RtRXKxhYxusnfExHOr6qBMlN/VO+S2QMAtWeLcn0s1O0RTGOe80ohnSx
         lNRLjDqaB2vforznWmVbEeHoP1o7kktdg8dQEbSIhVcBOedtpHkTQrvlZRiL6TpDYWxL
         F/laXghvetNpFF/TmW2SievBa//51XQoOAuLbh/BOo69EmYX6XH4zHpM5dNQ5dXgXcgy
         r3UZ9pr2zEIWD9KOpT01gjBcE8vz7fSttGdZ5eF8bZ+xdUv8eDS6TxYrnSNLjWl2KiQg
         Bx8LOh2Dcmq83RAOCwKQIk5AiTJNPiSdlVlNyZ8XYkFIW0Ewm47wBN0kDx0OEhcTrJ+m
         pv1g==
X-Gm-Message-State: AFuF++lj6IYX7LycsLV4LQFkbL1mf920Kczf290uOLjpQY9Mcc692FYC
	yudbghXOREw58ZbCDHWoj2QmZhgcSuFD82N66Uix6HHwQe9+SX7RC/jRjqSN1g6TeyA=
X-Gm-Gg: AR+sD13JelweevjNa659o4sejByFJhcFxDCqaK+3zGSedVWsYJJchQNCWrsfKPFv1em
	nKooj+PU2CNhjgyiXv69YlPjSbB7+os7Ptdy09JrUy4tFHhWYs6HrdB2hsYwS3nw2BXK7Y2h5Na
	yF8jviVfVPSOP8T/sJK0xbx2WV608Vjw+3wZ+Z8kchFhcj+PgVGAdnUtiV8d6BsApGdY1ViQoRZ
	sW40zHXYuhGb7/Rr8zFMMZ3suDp5Dsjbefm77+79S81tkGr9Ie3zfSPQQRU0ZNa4nQJpSkduZ9d
	mKov2t9SI2Kjou9oJCtHJeDKJoj2ooQxUytqN6E9uzrQu2OjhPVEUTkZg2sOwH6amfbyvId4RoB
	bFIOgU3r33VlU1Li+z0sefomdChxdfFWsDe8KjMKkQgKPSQVABCKEUXInX/V66My72nNa6vav8S
	z3Jgn2fD6+lafPmpQOPxEIsCYL52F13ixA1FZxm6Woi9c38HlCCrJEtyKulu2POXx5Qw7EZRW83
	bmI6vbo/vy9pvmMKFhLD3mMwPSsZhs1qYXLLpVgDgDcKAaT7IXE/khdTzH2QEfKOh5A7y3GjO5u
	9EROQiYg62sKrzEbyRORoj9NYwtq5FuvLJ2/NaxVO6LMYobZ
X-Received: by 2002:a05:600c:8411:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-49b91c279e1mr243879245e9.8.1788015339857;
        Sat, 29 Aug 2026 07:55:39 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4dfdf00csm195113255e9.14.2026.08.29.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 07:55:39 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	heikki.krogerus@linux.intel.com,
	mika.westerberg@linux.intel.com,
	gregkh@linuxfoundation.org,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH v3 0/2] Add ITE885x UCSI I2C transport driver
Date: Sat, 29 Aug 2026 15:55:14 +0100
Message-ID: <20260829145516.13500-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ASUS desktop boards describe the same ITE USB-C controller twice
in ACPI: as an MSFT8000 Resource Hub Proxy and as an ITE885x device at
the same I2C address. If the Resource Hub Proxy claims the address first,
the ITE device cannot be registered. Only the ITE node provides the
interrupt required by this transport.

Patch 1 handles MSFT8000 generically in the ACPI core. It keeps the ACPI
device present but prevents its SerialBus resources from being
instantiated as I2C, SPI or serdev clients.

Patch 2 adds the ITE885x UCSI transport. These controllers use
ITE-specific offsets for CCI, MESSAGE_IN, CONTROL and interrupt
handling. They do not expose a VERSION register or accept PPM_RESET
over I2C.

The register layout and reset behaviour were checked against the ITE
Windows driver supplied for this board.

Tested on an ASUS ROG Strix Z790-E Gaming WiFi with ITE8853:

- Built and booted on x86_64.
- ucsi_ite bound to ITE8853:00 without the previous -EBUSY failure.
- /sys/class/typec/port0 was registered.
- USB-C attachment detection worked.
- No UCSI, ITE or Type-C initialization errors were logged.

Suspend/resume and the ITE8800 through ITE8805 IDs have not been tested.

Changes in v3:

- Rework patch 1 as suggested by Armin: add MSFT8000 to
  ignore_serial_bus_ids[] in acpi_device_enumeration_by_parent().
- Keep the MSFT8000 ACPI device present while preventing its SerialBus
  resources from being instantiated as bus clients.
- Drop the ITE-specific ACPI x86 status override added in v2.
- Add a comment explaining why MSFT8000 is ignored during serial bus
  enumeration.
- Rebase onto current mainline and retest the series.
- Patch 2 is unchanged apart from the rebase.

Changes in v2:

- Move the v1 duplicate-device handling from the I2C core to the ACPI
  x86 status-override code, as suggested by Mika and Heikki.
- Correctly identify MSFT8000 as a Resource Hub Proxy.
- Restrict the quirk to exact matching I2C resources.
- Use devm_request_threaded_irq(), as suggested by Heikki.
- Rebase onto Linux 7.2 and update for the current UCSI API.
- Read and cache complete UCSI events before acknowledging them.
- Match the vendor transport's MESSAGE_IN and PPM_RESET behaviour.

Changes in v1:

- Initial submission.

v2: https://lore.kernel.org/all/20260825201426.47030-1-edward.blair@gmail.com/
v1: https://lore.kernel.org/all/20260314013157.7181-1-edward.blair@gmail.com/

Edward Blair (2):
  ACPI: scan: do not enumerate MSFT8000 as a serial bus slave
  usb: typec: ucsi: add ITE885x I2C transport driver

 drivers/acpi/scan.c               |   5 +
 drivers/usb/typec/ucsi/Kconfig    |  11 +
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.55.0

