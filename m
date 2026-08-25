Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832023F660F
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688880; cv=none; b=fiC9hLImLMZAjsSkeKw+LsJJdvbFLu+x7rthTT2XhYjt49bhh46eJmjdfB5nIyIf+QHvCtJlVlDqEeGsA+j9H+yOkuRsei/ZiPapMXz5MA/IrmWHD8n2/KmGfALaeiNiWUGHMyy7XcVII8U+0yU8PAPBY+/vOSAT8TIddZwFc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688880; c=relaxed/simple;
	bh=pJQehNgA0/KPJWPVK6RC25aULlTJzFDPFiv6PkbQr64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxFVl9zfy4WIib4OgpW1dXivDmb32fUhpSOGHsczd4Iy+3TcW6Ax2Rmh750bL1M5uE/x18PYUjQZJA8kOkNYW4I/dZ49tF2YVpWzg+7HwMlHlBT6ZNKOSuhfT1/+vNb+HTXca9FZHWh/ueSotazk5nkD6Lm9RS7UE0DBvIMernU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptnGqWQa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptnGqWQa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499d1ab3f9dso361735e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688877; x=1788293677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwYmlA57YhxUcNm58FqQdZY1TQeDKQxWXVlcuY+vUAA=;
        b=ptnGqWQaH5kJWfu0Q0HY94i6czwHfYXvUIKb4bMqyS0wO+1t9j3kE443P9vie8Hub4
         4AcsVIt2s8legKzFAqfCXDib6YHXAN3FgV0GtgDIG/2PPdPOr8b2zbMnGgKUfxce5TDS
         ln+czhNn27LjU2mM8cK70ZWCZSlkzRliPzoMw8FxzCyGLSatw/hDvr9jxWGB6XdkYG2u
         IpJJRVFDUb6Vk2PRQLHPAhEyO8Cqb+PnzPMSWOs/bLnhJcBJswarxy8Iq5Xfi9HPQ71S
         ysRk1MprT/f0UrcqcbgjpholK2woOSuxokqNDhplnrpYIAfvF2B0BhpcxV6j3hdRmQuu
         xfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688877; x=1788293677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwYmlA57YhxUcNm58FqQdZY1TQeDKQxWXVlcuY+vUAA=;
        b=ssY4aYJ2xuhabGYeZEPjawOvkdFV2Gm5Yu3mTEegabV6Gl2uBG/HYK3dTZPNXG2uzB
         Y2djwdEg84kEV6a58K/EeeOSXZ43rCmxBDIZ/TNmtWjQ8MJuCfOs49TvpOwXAPAzEJ7D
         fkiGxhfOwwhJWnfD7NtMuUH0jXeoEM/fswTWCxAW4OAYNDWONKIzneQS06ykt8exohXD
         RCA7KxSYEGSvjz8HO8xBdQNVBzKwuOkqZF5RVH290/psdpwVEH6SdoSW/U/HcVUmVGmL
         YAcS08D4uxReu7WZJ9IkZQtVDkG1C10W9EWH0vNILOzPrJ5KA6tAPtZPtIqzsQEbWqLf
         E69Q==
X-Gm-Message-State: AFuF++nvBfsEBDkGl6CkrPAOGvjrcxqdBCbJF2FWXXfDrX6bosKdwsCa
	5y5xrwVlflu2XPNxrQiJnEBh/BMniN6q8jUwN5du5U3+w+0SVtBvyh7+l/BQfGzSBko=
X-Gm-Gg: AR+sD10+nfhT+YeWZcRnO9fiJ9d0WtXwNOba3C0pxCmF6JZRkRcx+SSZ/jJh9B1EPWe
	9blppWJijQ2VnslUQkATat3YtkAJPer4VlGVe01YZlwXoNJuJcd6OtimzgdKI6h9duizxzm5Gvb
	h8H5LsAkvQPx1ALVLzF5iKRO1Z+m4NBoSbP3ArTq/YXQTJc4B3bW8Aoq8b/EUMrgUFfRygY7zWl
	EnK54ZPCEDdxUXsNVX6e0jgVw2QUGFvq07r905UegQjaqdeBZnI/0A4Re03SYZyhD2q8QEe2wvs
	mnNygFta+wP8+AKO2szTi36W2TplOwbSx5VE1mEmXd/+Uj8b+CIV6sSzJtNRWNxhffvwv7vDJdL
	hmymTE72kjA8+ZrZu4KnhA27/oq2P4D82+FpG4OLrEpnKuVAkevI0TZ6aOEtjU0IsyzeW/EAZ2q
	e2e2QcRd4a1EUMqntnE9Jf+VJC3UHLlOlpX8NnpAAzXLphKFaJsDawV0h3PFs9IDsMA50WYw5QM
	ZTeiHM48YseVSm0YJZAIIrygQZi69p9RZlYlwtXDNDBNP/ygHuFefT7OnBP9+wZuv2YYeTjdSt3
	ARmjFdby1tc9VOteQa7pRNHo44DXGc3CZEsI/11tEnU57Zlw
X-Received: by 2002:a05:600c:5491:b0:499:a4d1:d7d9 with SMTP id 5b1f17b1804b1-499dc717e32mr13685575e9.9.1787688876555;
        Tue, 25 Aug 2026 13:14:36 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc960e80sm5050435e9.1.2026.08.25.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:14:35 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	heikki.krogerus@linux.intel.com,
	mika.westerberg@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH v2 0/2] Add UCSI I2C transport driver for ITE885x USB-C controllers
Date: Tue, 25 Aug 2026 21:14:24 +0100
Message-ID: <20260825201426.47030-1-edward.blair@gmail.com>
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
the same I2C address. If the RhProxy node claims the address first, the
ITE device cannot be registered. Only the ITE node provides the
interrupt required by this transport.

Patch 1 marks the RhProxy node absent only when its I2C resource exactly
matches a supported ITE node which also has an interrupt.

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

Changes since v1:

- Move the duplicate-device quirk from the I2C core to the ACPI x86
  status-override code, as suggested by Mika and Heikki.
- Correctly identify MSFT8000 as a Resource Hub Proxy.
- Restrict the quirk to exact matching I2C resources.
- Use devm_request_threaded_irq(), as suggested by Heikki.
- Rebase onto Linux 7.2 and update for the current UCSI API.
- Read and cache complete UCSI events before acknowledging them.
- Match the vendor transport's MESSAGE_IN and PPM_RESET behaviour.

Link: https://lore.kernel.org/all/20260314013157.7181-1-edward.blair@gmail.com/

Edward Blair (2):
  ACPI: x86: hide duplicate RhProxy node for ITE UCSI controllers
  usb: typec: ucsi: add ITE885x I2C transport driver

 drivers/acpi/x86/utils.c          | 151 ++++++++++++
 drivers/usb/typec/ucsi/Kconfig    |  11 +
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
 4 files changed, 558 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c


base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
-- 
2.55.0
