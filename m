Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285B37F8B2
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362477; cv=none; b=VbEdBZ+QnTtL/NOfT1RfKSA2s4rXOvqj77W7w0EHDGzVQJLDnyVJhFG29w0y8TP+2Au9UJVpoTs8lRHs8Ez/3KfH/YaT4FAKHw0SpVu4qUqj/cYUTw47UEdZ6tRi99PKx+6yNXXlvj3xkwMdhhp4K1Z7ybfQNU4MUKKlA6fEfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362477; c=relaxed/simple;
	bh=qDhTeka7d1c8/IYbvvQMidQR2C5JwpNhijQCZ16HeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCzHyAljFBAHWet+chu9MNwP9VkEgVK15lKBOhnEEG/UBz+0cWeTDxbcCwT5TdkVm61d0QTIIJMKjF+ibrs7c+LaNeUOPBb4D02eQJIHwsP4LyCWa16JfsdnnPyJMagratV33lmK0Z+WgtvMQMlL81wxNYhB5l/FMAyhEXMPN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNdJ4cHM; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNdJ4cHM"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f57438248so89995f8f.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784362474; x=1784967274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScEoBLN1IabXnL+txD3sm9iysFKF5LfVa7gsCjSFaL4=;
        b=KNdJ4cHM6uCMUvVRxRnfFWWXkRzciBxocaUM9IWc81kSlqzo6hKtVxClXlU77zQ7k3
         1G+9jtYadFE/m51xSPneukzNksNKhZErfyeOeNC5X7tC743vfS6jia4T9MGrBUslzVuV
         rsEVqLDktNhUHzmmX7Kl4y9q3fLyC0fEYoS9tj0zLEjgsxwWBap6agF2sHg4/FaKiC3Y
         dhZk4BhsVY40wZ7l9wHySOPN5DWFT+1r5z4Ob/35dQJREdoCjGgKt8GMMOpRunmAb5zm
         bjYWCWiVYh4anEwgz99aoIujh70ITvOo5IcHFU5uWQJBagnd6MrNv10CP42HyQQycDUF
         HPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784362474; x=1784967274;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScEoBLN1IabXnL+txD3sm9iysFKF5LfVa7gsCjSFaL4=;
        b=si8nne95QMUuKwoyVINXJWz6gx025xPG3NDjWox8m1ZqvrM1CNR444Mw9RocfnHqJO
         Nh334f7dIhfsJvTr7MCndqkBBYOs6Mg7ndy6a7/3QQeB8wwDjO3cAIkfL3uEWAkxQ9A4
         Skuscbpjdh/XJPjfIucREtWsyxKL01bUDi2Fx7Wra3+GUbHXFgUi3MPMpY3XXHtPdAau
         ADjEGFeZMRo8lc/HqREuPwNMGVOD1dLRRQwIYH8/G40sOE5qPiWC5saddXcutpBbMr7z
         EaeW7ULaU1BXBxCNQd8L0q9lHAK1MvLzAtPjy2XJFP+JmaRgWaYrwROy10U7PXCMgush
         7GFw==
X-Forwarded-Encrypted: i=1; AHgh+RoR5x3Ahy63A1R6+uaOJVLFXIBAMyb9sTsCQ17gUatz3FdA4nKYAGvtp6dsNL7u0M7NDoSrbxFV0bRm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VgNLE0f2l8BlTSG3KBAYSoNXsD+nkdPVMJwJWZXXpzSmXzRy
	C3Pzug4+r2Bol4ZuRxdZJe1V7xFOagH8vIP3I4w5vyOqd0vSLhtC0ZwV
X-Gm-Gg: AfdE7ckU45mGQm/6yBz/B8+2RdMffX4Wbg+xKvL1mih9vKzU9yxHf3Ca6lHp82aFsLN
	bvw7K1JVpadAaE2Ru/3AoRh0ZrPiax/fWRgJ6IxhzbdlqL9cazbd9sJMde+yTSIbplpuxihEYGx
	Mls7OzGgVe7FwQdMuC8Y1gCzeaQsWk3d+zWv7cIfbIrdvIFkwMybef5mCcn0hCVGpzo76w3kD4n
	In/27SyV+CFZntqfMV47YL4kM8I2SHqKYPae6rKAFseGFKwM0fgyfdlGAKfliqxJwA36hZ+Bg50
	Rc0M7sLfNcuhGJOVlhGpsdO2RPD9UzbaLK2BxVAirnP7SP9hYn5iNkSG/UwOpk6/cfBQOeAN3xV
	hozBHxPllcjfz/j1ZcQgJMnO0SV0w9ldqtgtaTA/+x2MjdELrW9DQOBilVPWJmkwodx4euy7tyH
	rzdg==
X-Received: by 2002:a05:600c:548f:b0:495:4840:c6b with SMTP id 5b1f17b1804b1-4954a3d59d4mr40189375e9.1.1784362473622;
        Sat, 18 Jul 2026 01:14:33 -0700 (PDT)
Received: from meto.local ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm73234285e9.0.2026.07.18.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:14:32 -0700 (PDT)
From: =?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	=?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
Subject: [PATCH 0/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint sensor driver
Date: Sat, 18 Jul 2026 11:14:27 +0300
Message-ID: <20260718081431.25456-1-metehangnen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a kernel driver for the Goodix GXFP5130 fingerprint
sensor found in Huawei MateBook laptops (D16 2024, X Pro 2024, 14 2024).

The sensor is enumerated through ACPI (HID: GXFP5130) and communicates
with the host via an eSPI-based memory-mapped mailbox window plus three
GPIOs. It does not use SPI or I2C bus drivers.

A misc character device /dev/gxfp is exposed to userspace. The libfprint
library (with a corresponding GXFP5130 plugin) uses this device to perform
biometric enrollment and verification via fprintd.

The four patches are:
  [1/4] UAPI header (include/uapi/linux/gxfp_ioctl.h)
  [2/4] Driver source tree (drivers/misc/gxfp5130/)
  [3/4] Documentation (Documentation/misc-devices/gxfp5130.rst)
  [4/4] MAINTAINERS entry

Metehan Günen (4):
  include/uapi/linux: add gxfp_ioctl.h for GXFP5130 fingerprint sensor
  drivers/misc: add Goodix GXFP5130 eSPI fingerprint sensor driver
  Documentation/misc-devices: add gxfp5130.rst
  MAINTAINERS: add entry for GXFP5130 fingerprint sensor driver

 Documentation/misc-devices/gxfp5130.rst       |  90 +++++++
 Documentation/misc-devices/index.rst          |   1 +
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   2 +
 drivers/misc/Makefile                         |   2 +
 drivers/misc/gxfp5130/Kconfig                 |  18 ++
 drivers/misc/gxfp5130/Makefile                |  28 ++
 drivers/misc/gxfp5130/cmd/gxfp_cmd.c          | 177 ++++++++++++
 drivers/misc/gxfp5130/cmd/gxfp_cmd.h          |  54 ++++
 .../misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c   |  28 ++
 .../misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h   |  12 +
 .../misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c    |  89 +++++++
 .../misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h    |  30 +++
 drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c    | 185 +++++++++++++
 drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h    |  27 ++
 drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c  | 100 +++++++
 drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h  |  22 ++
 drivers/misc/gxfp5130/driver/gxfp_irq.c       |  57 ++++
 drivers/misc/gxfp5130/driver/gxfp_irq.h       |   9 +
 drivers/misc/gxfp5130/driver/gxfp_platform.c  | 251 ++++++++++++++++++
 drivers/misc/gxfp5130/driver/gxfp_platform.h  |  12 +
 drivers/misc/gxfp5130/driver/gxfp_trace.c     | 179 +++++++++++++
 drivers/misc/gxfp5130/driver/gxfp_trace.h     |  15 ++
 drivers/misc/gxfp5130/driver/gxfp_uapi.h      |  25 ++
 drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c | 136 ++++++++++
 drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c | 245 +++++++++++++++++
 drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c | 123 +++++++++
 drivers/misc/gxfp5130/gxfp_main.c             | 127 +++++++++
 drivers/misc/gxfp5130/hw/gxfp_acpi.c          | 130 +++++++++
 drivers/misc/gxfp5130/hw/gxfp_acpi.h          |  15 ++
 drivers/misc/gxfp5130/hw/gxfp_delay.c         |  15 ++
 drivers/misc/gxfp5130/hw/gxfp_delay.h         |   7 +
 drivers/misc/gxfp5130/hw/gxfp_gpio.c          |  64 +++++
 drivers/misc/gxfp5130/hw/gxfp_gpio.h          |  17 ++
 drivers/misc/gxfp5130/hw/gxfp_mmio.c          |  45 ++++
 drivers/misc/gxfp5130/hw/gxfp_mmio.h          |  10 +
 .../misc/gxfp5130/include/gxfp_constants.h    |  38 +++
 drivers/misc/gxfp5130/include/gxfp_priv.h     |  55 ++++
 .../misc/gxfp5130/proto/gxfp_goodix_proto.c   |  84 ++++++
 .../misc/gxfp5130/proto/gxfp_goodix_proto.h   |  31 +++
 drivers/misc/gxfp5130/proto/gxfp_mp_proto.c   |  96 +++++++
 drivers/misc/gxfp5130/proto/gxfp_mp_proto.h   |  27 ++
 .../gxfp5130/transport/gxfp_espi_common.c     |  80 ++++++
 .../gxfp5130/transport/gxfp_espi_common.h     |  27 ++
 .../gxfp5130/transport/gxfp_espi_rx_irq.c     | 120 +++++++++
 .../gxfp5130/transport/gxfp_espi_rx_irq.h     |  15 ++
 .../gxfp5130/transport/gxfp_espi_rx_sync.c    |  96 +++++++
 .../gxfp5130/transport/gxfp_espi_rx_sync.h    |  14 +
 .../misc/gxfp5130/transport/gxfp_espi_tx.c    |  88 ++++++
 .../misc/gxfp5130/transport/gxfp_espi_tx.h    |  20 ++
 include/uapi/linux/gxfp_ioctl.h               |  43 +++
 51 files changed, 3188 insertions(+)

--
2.55.0

