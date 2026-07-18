Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB094383C9D
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362486; cv=none; b=NiesKgFkhRmgbqYAqk+Uzf9KnGmyh9/ysqYIXpISgTt0RprA9iiasMZ8P0SFHmpUriM06MtyKy3BqOJ8mKF4lFgXG0DI9KjSf8Wy+XN8gufR/AGIefqMeGQaiWpwFY8dqYoBOtIBmYAdIjgIqkymQ1z1+p9oy+cY0heugZtD3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362486; c=relaxed/simple;
	bh=7mqqUmKOwojj90QBKxQo5976QWxtr3z75Np0e6HDPZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBk0fVclfWx9yvSELaZ0DUDazB+ev1XwyplwFRHA+nBfymmcaB0CFi3V5eqpgwF4FVnJNK3saR0ii5WNy926j3CdO24kZfY2EL8MOSyNBlAqqiWhlIOuiRlg4Q6wbrKHriOBYeb80OhqQvfaTuDEKH+ieuHuq7wpUh35WNWfZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSAOUIdR; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSAOUIdR"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493f7c4152dso1799665e9.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784362478; x=1784967278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XndUYw6uMF7rNMbIkhITXAtIJkErIj2hiUmmdPXXLA4=;
        b=bSAOUIdRvnG+tPlT0WrJS+Geo0TsITnM0O8qvWQD1jx4qfjsqQOaGjO55qGCUtlvJv
         U2z2eWbOYfw1DIWbVWAMHawPK9Rv/3Dt44kmer7Y7OOp6/AE0Nw7Xwv3zK7+I57wVGj/
         l5ubHIhUKdjCalDBKw6771V9c8hxDvoEHdnRa4egJ4/hKR99GYLkzlJmKKWLH752u6td
         B39rXvLZUQZo0UhefZhPVWDd4wEA6Bs22q9MbzN8aL9U6fQ9oSn8+7SptZfCN3+1b2z6
         mY0YHDc4p5OO03bU+EKFziDoK7Jc8yMv+KMAsBJlV8K/c8jxF1ZJ1jtiXMQ4XMG6sbw9
         ERfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784362478; x=1784967278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XndUYw6uMF7rNMbIkhITXAtIJkErIj2hiUmmdPXXLA4=;
        b=YDsDhJQFuVW3SmSm/ZxNylTReSZ/9cyJi81SV68BWJcOPB/ZNgMghIQDvDqjYDxZxr
         +GZtGdsbmHbHsWefVSA/gGsdd+IkN6gxX9vLWCTBD2F96lmW/B/TRut8QhHuPU4V63B2
         MPg1ICmPlNM3PLoo81qIDLm8J5eDieHYzuTEa9u6D1wKxdm8xzyDGdNsWsbTnFOzTsTt
         O2ksJ2C8XCIJgPc7kkF2UNnMkQUWB5PwqhYxzh4hAgcDbKfm/gAw2qneK9euy7TzG2Hj
         HhMB6l48Du8cfBO0PBp9CqY9xG4Kxx2wEa4jtLYRwQOTF5lX8GOrTbe/J9Wz2yL6RJ2Y
         8oxg==
X-Forwarded-Encrypted: i=1; AHgh+Rqdt3g7GBLce4U3DxHAxPoUFJBA2fV6yU3gysuZHGgUB2Aw+/UQ940ssYeBnkqNFVi6d9uI0TbBPuts@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+0tV+Kp1+E1MvwiGuvxHrb+92+ZuHsuCX87RwyH8zv97/qEU
	yvvQyKFYpWnZoSNelapuSEWBlNjqlHTmWHu/x2OOs3AlOs7kZhENmGw0
X-Gm-Gg: AfdE7cnv7gQY/CdML4IK9UNS0QVjA5DNuvU/QMzDBgQJmFqpEoqxZCZpULwDj0T7cyp
	0Hk+bQG3K7CVZDYUXi8v1BJHyG97q6VJvrmiJaF29YWLJ5imXfdwh9VJV+/9BPGBlmMGQMXctpb
	2Bjg5hoRAt+wb5ApaTJW/omZOp+hVePvLjkb37xJKU2ltTYCL5yOss3iT8StjtLf31KjFpTfwU+
	/YFJDuR1wPFT+1GfEukFyzAbVuB4CAbypRnMQ3Bc6gBTmGO3C0DNacfLutRbaArUHxp6DEq5BY/
	Kpp7O6OtMHFbpE+HlcwtQL1mxxX8tFgiqetJRK0UNEMz+onCpmz6xDakSHTSrW3E4MPWKXyofdn
	UcayxmpZee1MsUwEWz+TDyasE0ctq+RSqfNHTbFlhyrtuAbhPae76kMsdYJEeyMFmTMOeRhF2rX
	BnUdJkgzDgZLBa
X-Received: by 2002:a05:600c:4fc9:b0:495:45fd:be41 with SMTP id 5b1f17b1804b1-4954a51322amr39341955e9.5.1784362477416;
        Sat, 18 Jul 2026 01:14:37 -0700 (PDT)
Received: from meto.local ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm73234285e9.0.2026.07.18.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:14:35 -0700 (PDT)
From: =?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	=?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
Subject: [PATCH 2/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint sensor driver
Date: Sat, 18 Jul 2026 11:14:29 +0300
Message-ID: <20260718081431.25456-3-metehangnen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718081431.25456-1-metehangnen@gmail.com>
References: <20260718081431.25456-1-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The GXFP5130 is a press-type fingerprint sensor by Goodix Technology.
It is found in Huawei MateBook laptops (D16 2024, X Pro 2024, 14 2024)
and is enumerated through ACPI with HID GXFP5130.

Hardware interface: The sensor does not sit on SPI or I2C. The ACPI
firmware maps a memory window (eSPI flash-channel mailbox) and three
GPIOs: write-done (host pulses after writing a command), read-done
(host pulses after reading each response chunk), and irq (sensor asserts
to signal a response is ready). All frames use a 4-byte eSPI wrapper
header followed by a Goodix MP protocol frame carrying the command body.

Driver structure:
  transport/   eSPI framing layer (TX, synchronous RX, IRQ-driven RX)
  hw/          ACPI resource parsing, MMIO helpers, GPIO helpers, delay
  proto/       MP and Goodix command protocol encode/decode
  cmd/         individual command helpers (version, MCU state, reset ...)
  driver/      platform probe/remove, IRQ thread, UAPI misc device,
               debugfs trace ring buffer
  include/     private driver headers (gxfp_priv.h, gxfp_constants.h)

Userspace interface: A misc character device /dev/gxfp is created. Only
one reader at a time is allowed (CAP_SYS_ADMIN required). write(2) sends
command frames; read(2)/poll(2) return response records prefixed with
gxfp_tap_hdr. GXFP_IOCTL_FLUSH_RXQ discards the kernel-side queue.
The libfprint library communicates with the sensor through this device.

Startup: On probe the driver executes a firmware-version handshake (up
to 3 retries) and falls back to a session-recovery sequence if the
sensor does not acknowledge the first attempt. The IRQ line is kept
masked until the handshake succeeds.

Signed-off-by: Metehan Günen <metehangnen@gmail.com>
---
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
 47 files changed, 3047 insertions(+)
 create mode 100644 drivers/misc/gxfp5130/Kconfig
 create mode 100644 drivers/misc/gxfp5130/Makefile
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd.c
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd.h
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c
 create mode 100644 drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_irq.c
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_irq.h
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_platform.c
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_platform.h
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_trace.c
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_trace.h
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_uapi.h
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c
 create mode 100644 drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c
 create mode 100644 drivers/misc/gxfp5130/gxfp_main.c
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_acpi.c
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_acpi.h
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_delay.c
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_delay.h
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_gpio.c
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_gpio.h
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_mmio.c
 create mode 100644 drivers/misc/gxfp5130/hw/gxfp_mmio.h
 create mode 100644 drivers/misc/gxfp5130/include/gxfp_constants.h
 create mode 100644 drivers/misc/gxfp5130/include/gxfp_priv.h
 create mode 100644 drivers/misc/gxfp5130/proto/gxfp_goodix_proto.c
 create mode 100644 drivers/misc/gxfp5130/proto/gxfp_goodix_proto.h
 create mode 100644 drivers/misc/gxfp5130/proto/gxfp_mp_proto.c
 create mode 100644 drivers/misc/gxfp5130/proto/gxfp_mp_proto.h
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_common.c
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_common.h
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.c
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.h
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.c
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.h
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_tx.c
 create mode 100644 drivers/misc/gxfp5130/transport/gxfp_espi_tx.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 390256ed9..5b20aa292 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -651,4 +651,6 @@ source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
 source "drivers/misc/amd-sbi/Kconfig"
 source "drivers/misc/rp1/Kconfig"
+source "drivers/misc/gxfp5130/Kconfig"
+
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fed47c767..e85c68aa1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -74,3 +74,5 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
 obj-y				+= amd-sbi/
 obj-$(CONFIG_MISC_RP1)		+= rp1/
+
+obj-$(CONFIG_GXFP5130)		+= gxfp5130/
diff --git a/drivers/misc/gxfp5130/Kconfig b/drivers/misc/gxfp5130/Kconfig
new file mode 100644
index 000000000..0af2a0dec
--- /dev/null
+++ b/drivers/misc/gxfp5130/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+config GXFP5130
+	tristate "Goodix GXFP5130 eSPI fingerprint sensor"
+	depends on ACPI && HAS_IOMEM && GPIOLIB
+	help
+	  Driver for the Goodix GXFP5130 fingerprint sensor found in
+	  Huawei MateBook laptops (MateBook D16 2024, MateBook X Pro 2024,
+	  MateBook 14 2024).
+
+	  The sensor connects to the host via an eSPI-based MMIO mailbox
+	  and is enumerated through ACPI (ACPI HID: GXFP5130).
+
+	  A character device (/dev/gxfp) is created for userspace access.
+	  The libfprint library uses this interface for biometric enrollment
+	  and verification via fprintd.
+
+	  If unsure, say N. To compile as a module, say M; the module
+	  will be called gxfp.
diff --git a/drivers/misc/gxfp5130/Makefile b/drivers/misc/gxfp5130/Makefile
new file mode 100644
index 000000000..0bb206d23
--- /dev/null
+++ b/drivers/misc/gxfp5130/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_GXFP5130) += gxfp.o
+
+ccflags-y += -I$(src)/include
+
+gxfp-y := \
+	gxfp_main.o \
+	transport/gxfp_espi_common.o \
+	transport/gxfp_espi_tx.o \
+	transport/gxfp_espi_rx_sync.o \
+	transport/gxfp_espi_rx_irq.o \
+	hw/gxfp_acpi.o \
+	hw/gxfp_delay.o \
+	hw/gxfp_mmio.o \
+	hw/gxfp_gpio.o \
+	proto/gxfp_mp_proto.o \
+	proto/gxfp_goodix_proto.o \
+	cmd/gxfp_cmd.o \
+	cmd/gxfp_cmd_version.o \
+	cmd/gxfp_cmd_mcu_state.o \
+	cmd/gxfp_cmd_mcu_config.o \
+	cmd/gxfp_cmd_reset.o \
+	driver/gxfp_platform.o \
+	driver/gxfp_irq.o \
+	driver/gxfp_trace.o \
+	driver/gxfp_uapi_fifo.o \
+	driver/gxfp_uapi_ctrl.o \
+	driver/gxfp_uapi_misc.o
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd.c b/drivers/misc/gxfp5130/cmd/gxfp_cmd.c
new file mode 100644
index 000000000..90a50710f
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "gxfp_cmd.h"
+#include "../proto/gxfp_goodix_proto.h"
+#include "../proto/gxfp_mp_proto.h"
+#include "../transport/gxfp_espi_tx.h"
+#include "../hw/gxfp_delay.h"
+#include "gxfp_priv.h"
+#include "gxfp_constants.h"
+#include "../driver/gxfp_trace.h"
+
+int gxfp_xfer(struct gxfp_dev *gdev, const struct gxfp_xfer_req *req)
+{
+	__u8 *tx;
+	__u8 *body;
+	__u8 *rx;
+	size_t rx_len = 0;
+	unsigned int t;
+	int body_len;
+	int frame_len;
+	int ret;
+
+	if (!gdev || !req)
+		return -EINVAL;
+	if (req->req_payload_len && !req->req_payload)
+		return -EINVAL;
+	if (req->resp_payload && req->resp_payload_cap == 0)
+		return -EINVAL;
+	if (!req->resp_payload && req->resp_payload_cap != 0)
+		return -EINVAL;
+
+	tx = kmalloc(GXFP_TX_BUFFER_SIZE, GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
+	body = kmalloc(GXFP_TX_BUFFER_SIZE, GFP_KERNEL);
+	if (!body) {
+		ret = -ENOMEM;
+		goto out_free_tx;
+	}
+
+	rx = kmalloc(GXFP_MAILBOX_MIN_SIZE, GFP_KERNEL);
+	if (!rx) {
+		ret = -ENOMEM;
+		goto out_free_body;
+	}
+
+	body_len = gxfp_goodix_build_frame(req->req_cmd,
+				   req->req_payload, req->req_payload_len,
+				   body, GXFP_TX_BUFFER_SIZE);
+	if (body_len < 0) {
+		ret = body_len;
+		goto out_free_rx;
+	}
+
+	frame_len = gxfp_mp_build_frame(GXFP_MP_TYPE_A,
+				 body, (size_t)body_len,
+				 tx, GXFP_TX_BUFFER_SIZE);
+	if (frame_len < 0) {
+		ret = frame_len;
+		goto out_free_rx;
+	}
+	gxfp_trace_logf("cmd_req req=0x%02x expect=0x%02x tries=%u tx_mp_len=%d",
+		req->req_cmd, req->expect_cmd, req->tries ? req->tries : 1, frame_len);
+
+	for (t = 0; t < (req->tries ? req->tries : 1); t++) {
+		struct gxfp_mp_frame_parsed mp;
+		struct gxfp_frame_parsed p;
+
+		ret = gxfp_espi_xfer(gdev, tx, (size_t)frame_len,
+				    rx, GXFP_MAILBOX_MIN_SIZE, &rx_len);
+		if (ret) {
+			gxfp_trace_logf("cmd_retry req=0x%02x expect=0x%02x try=%u rc=%d",
+				req->req_cmd, req->expect_cmd, t + 1, ret);
+			gxfp_busy_wait_us(req->retry_delay_us);
+			continue;
+		}
+
+		if (!gxfp_parse_mp_frame(rx,
+					 min_t(size_t, rx_len, (size_t)GXFP_MAILBOX_MIN_SIZE),
+					 &mp)) {
+			gxfp_trace_logf("cmd_bad_mp req=0x%02x expect=0x%02x try=%u rx_len=%zu",
+				req->req_cmd, req->expect_cmd, t + 1, rx_len);
+			gxfp_busy_wait_us(req->retry_delay_us);
+			continue;
+		}
+		if (!gxfp_parse_goodix_body(mp.payload, mp.payload_len, &p) || !p.valid) {
+			gxfp_busy_wait_us(req->retry_delay_us);
+			continue;
+		}
+		if (req->require_proto_ck_ok && !p.proto_checksum_ok) {
+			gxfp_busy_wait_us(req->retry_delay_us);
+			continue;
+		}
+		if (p.cmd != req->expect_cmd) {
+			gxfp_trace_logf("cmd_unexpected req=0x%02x expect=0x%02x got=0x%02x try=%u",
+				req->req_cmd, req->expect_cmd, p.cmd, t + 1);
+			gxfp_busy_wait_us(req->retry_delay_us);
+			continue;
+		}
+
+		if (req->resp_payload) {
+			if (p.payload_len > req->resp_payload_cap) {
+				ret = -EMSGSIZE;
+				goto out_free_rx;
+			}
+			memcpy(req->resp_payload, p.payload, p.payload_len);
+		}
+
+		if (req->out_resp_payload_len)
+			*req->out_resp_payload_len = p.payload_len;
+		if (req->out_frame) {
+			*req->out_frame = p;
+			req->out_frame->payload = req->resp_payload;
+		}
+		ret = 0;
+		gxfp_trace_logf("cmd_ok req=0x%02x expect=0x%02x try=%u payload=%u",
+			req->req_cmd, req->expect_cmd, t + 1, p.payload_len);
+		goto out_free_rx;
+	}
+
+	ret = -ETIMEDOUT;
+	gxfp_trace_logf("cmd_timeout req=0x%02x expect=0x%02x tries=%u",
+		req->req_cmd, req->expect_cmd, req->tries ? req->tries : 1);
+
+out_free_rx:
+	kfree(rx);
+out_free_body:
+	kfree(body);
+out_free_tx:
+	kfree(tx);
+	return ret;
+}
+
+int gxfp_cmd_xfer(struct gxfp_dev *gdev,
+			 __u8 req_cmd,
+			 const __u8 *req_payload,
+			 size_t req_payload_len,
+			 __u8 expect_cmd,
+			 __u8 *resp_payload,
+			 size_t resp_payload_cap,
+			 size_t *out_resp_payload_len,
+			 unsigned int tries,
+			 unsigned int retry_delay_us)
+{
+	struct gxfp_frame_parsed p;
+	int ret;
+
+	if (!resp_payload || resp_payload_cap == 0)
+		return -EINVAL;
+
+	memset(&p, 0, sizeof(p));
+	ret = gxfp_xfer(gdev, &(const struct gxfp_xfer_req){
+		.req_cmd		= req_cmd,
+		.req_payload		= req_payload,
+		.req_payload_len	= req_payload_len,
+		.expect_cmd		= expect_cmd,
+		.require_proto_ck_ok	= true,
+		.out_frame		= &p,
+		.resp_payload		= resp_payload,
+		.resp_payload_cap	= resp_payload_cap,
+		.out_resp_payload_len	= out_resp_payload_len,
+		.tries			= tries,
+		.retry_delay_us		= retry_delay_us,
+	});
+	if (ret)
+		return ret;
+
+	dev_dbg(gdev->dev,
+		 "CMD_XFER: req=0x%02x expect=0x%02x payload_len=%u\n",
+		 req_cmd, expect_cmd, p.payload_len);
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd.h b/drivers/misc/gxfp5130/cmd/gxfp_cmd.h
new file mode 100644
index 000000000..7d7b5bba3
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CMD_H
+#define __GXFP_CMD_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+struct gxfp_frame_parsed;
+
+/**
+ * struct gxfp_xfer_req - Parameters for a single Goodix command exchange.
+ * @req_cmd:              Command byte to send.
+ * @expect_cmd:           Expected command byte in the response frame.
+ * @require_proto_ck_ok:  If true, require protocol checksum to pass.
+ * @tries:                Number of send/receive attempts (0 treated as 1).
+ * @retry_delay_us:       Microseconds to wait between retries.
+ * @req_payload:          Pointer to request payload (may be NULL).
+ * @req_payload_len:      Length of request payload in bytes.
+ * @out_frame:            If non-NULL, receives parsed frame metadata on success.
+ * @resp_payload:         If non-NULL, response payload is copied here.
+ * @resp_payload_cap:     Capacity of @resp_payload buffer.
+ * @out_resp_payload_len: If non-NULL, receives actual response payload length.
+ */
+struct gxfp_xfer_req {
+	__u8		req_cmd;
+	__u8		expect_cmd;
+	bool		require_proto_ck_ok;
+	unsigned int	tries;
+	unsigned int	retry_delay_us;
+
+	const __u8	*req_payload;
+	size_t		req_payload_len;
+
+	struct gxfp_frame_parsed *out_frame;
+
+	__u8		*resp_payload;
+	size_t		resp_payload_cap;
+	size_t		*out_resp_payload_len;
+};
+
+int gxfp_xfer(struct gxfp_dev *gdev, const struct gxfp_xfer_req *req);
+
+int gxfp_cmd_xfer(struct gxfp_dev *gdev,
+			 __u8 req_cmd,
+			 const __u8 *req_payload,
+			 size_t req_payload_len,
+			 __u8 expect_cmd,
+			 __u8 *resp_payload,
+			 size_t resp_payload_cap,
+			 size_t *out_resp_payload_len,
+			 unsigned int tries,
+			 unsigned int retry_delay_us);
+
+#endif /* __GXFP_CMD_H */
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c
new file mode 100644
index 000000000..cc38d7d96
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#include "gxfp_priv.h"
+#include "gxfp_cmd.h"
+#include "gxfp_constants.h"
+#include "gxfp_cmd_mcu_config.h"
+
+int gxfp_cmd_upload_config_mcu(struct gxfp_dev *gdev, const __u8 *cfg, size_t cfg_len)
+{
+	__u8 ack_payload[32];
+	size_t ack_len = 0;
+
+	if (!gdev)
+		return -EINVAL;
+	if (!cfg || cfg_len == 0)
+		return -EINVAL;
+
+	return gxfp_cmd_xfer(gdev,
+				   GXFP_CMD_UPLOAD_CONFIG_MCU,
+				   cfg, cfg_len,
+				   GXFP_CMD_ACK,
+				   ack_payload, sizeof(ack_payload),
+				   &ack_len,
+				   GXFP_DEFAULT_RETRY_COUNT,
+				   GXFP_DEFAULT_TIMEOUT_US);
+}
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h
new file mode 100644
index 000000000..9a32aa802
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CMD_MCU_CONFIG_H
+#define __GXFP_CMD_MCU_CONFIG_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+
+/* Not used or tested */
+int gxfp_cmd_upload_config_mcu(struct gxfp_dev *gdev, const __u8 *cfg, size_t cfg_len);
+
+#endif /* __GXFP_CMD_MCU_CONFIG_H */
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c
new file mode 100644
index 000000000..d6a238474
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/timekeeping.h>
+
+#include "gxfp_priv.h"
+#include "gxfp_cmd.h"
+#include "gxfp_constants.h"
+#include "gxfp_cmd_mcu_state.h"
+
+int gxfp_cmd_parse_mcu_state_payload(const __u8 *buf, size_t len,
+					 struct gxfp_mcu_state *out)
+{
+	if (!buf || !out)
+		return -EINVAL;
+
+	memset(out, 0, sizeof(*out));
+	if (len < GXFP_MCU_STATE_LEN)
+		return -EBADMSG;
+
+	out->version = buf[0];
+
+	out->b1_raw = buf[1];
+	out->is_pov_image_valid = (buf[1] >> 0) & 0x1;
+	out->is_tls_connected = (buf[1] >> 1) & 0x1;
+	out->is_tls_used = (buf[1] >> 2) & 0x1;
+	out->is_locked = (buf[1] >> 3) & 0x1;
+
+	memcpy(out->reserved, buf + 2, sizeof(out->reserved));
+
+	return 0;
+}
+
+static int gxfp_do_query_mcu_state(struct gxfp_dev *gdev,
+				  struct gxfp_mcu_state *out)
+{
+	__u8 payload[GXFP_MAX_MCU_STATE_PAYLOAD];
+	__u8 trigger_payload[5];
+	size_t payload_len = 0;
+	int ret;
+	struct timespec64 ts;
+	__u16 ts_u16;
+
+	if (!out)
+		return -EINVAL;
+
+	memset(out, 0, sizeof(*out));
+
+	if (!gdev->hw.mailbox_mmio || gdev->hw.mailbox_size < GXFP_MAILBOX_MIN_SIZE)
+		return -ENODEV;
+
+	ktime_get_real_ts64(&ts);
+	ts_u16 = (__u16)(((__u64)(ts.tv_sec % 60) * 1000ull) + ((__u64)ts.tv_nsec / 1000000ull));
+	trigger_payload[0] = 0x55;
+	trigger_payload[1] = (__u8)(ts_u16 & 0xff);
+	trigger_payload[2] = (__u8)((ts_u16 >> 8) & 0xff);
+	trigger_payload[3] = 0x00;
+	trigger_payload[4] = 0x00;
+	dev_dbg(gdev->dev, "MCU_STATE: trigger ts=0x%04x payload=%*ph\n",
+		 ts_u16, (int)sizeof(trigger_payload), trigger_payload);
+
+	ret = gxfp_cmd_xfer(gdev,
+			   GXFP_CMD_TRIGGER_MCU_STATE, trigger_payload, sizeof(trigger_payload),
+			   GXFP_CMD_QUERY_MCU_STATE,
+			   payload, sizeof(payload), &payload_len,
+			   GXFP_DEFAULT_RETRY_COUNT, GXFP_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = gxfp_cmd_parse_mcu_state_payload(payload, payload_len, out);
+	if (ret)
+		return ret;
+
+	dev_dbg(gdev->dev,
+		"MCU_STATE: version=%u pov_valid=%u tls=%u locked=%u\n",
+		out->version,
+		out->is_pov_image_valid,
+		out->is_tls_connected,
+		out->is_locked);
+	return 0;
+}
+
+int gxfp_cmd_query_mcu_state(struct gxfp_dev *gdev, struct gxfp_mcu_state *out)
+{
+	return gxfp_do_query_mcu_state(gdev, out);
+}
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h
new file mode 100644
index 000000000..593b62499
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CMD_MCU_STATE_H
+#define __GXFP_CMD_MCU_STATE_H
+
+#include <linux/types.h>
+#include "gxfp_constants.h"
+
+struct gxfp_dev;
+
+#define GXFP_MCU_STATE_LEN 20
+
+struct gxfp_mcu_state {
+	/* byte 0 */
+	__u8 version;
+
+	/* byte 1 */
+	__u8 b1_raw;
+	__u8 is_pov_image_valid;
+	__u8 is_tls_connected;
+	__u8 is_tls_used;
+	__u8 is_locked;
+
+	/* byte 2 - 19 */
+	__u8 reserved[18];
+};
+
+int gxfp_cmd_query_mcu_state(struct gxfp_dev *gdev, struct gxfp_mcu_state *out);
+int gxfp_cmd_parse_mcu_state_payload(const __u8 *buf, size_t len, struct gxfp_mcu_state *out);
+
+#endif /* __GXFP_CMD_MCU_STATE_H */
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c b/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c
new file mode 100644
index 000000000..b2edba33a
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+#include "gxfp_priv.h"
+#include "gxfp_cmd.h"
+#include "../hw/gxfp_delay.h"
+#include "gxfp_constants.h"
+
+#include "gxfp_cmd_reset.h"
+
+int gxfp_cmd_notify_power_state(struct gxfp_dev *gdev,
+				__u8 state)
+{
+	__u8 payload[1];
+	__u8 ack_payload[8];
+	size_t ack_len = 0;
+	int rc;
+
+	if (!gdev)
+		return -EINVAL;
+
+	payload[0] = state;
+	rc = gxfp_cmd_xfer(gdev,
+			  GXFP_CMD_NOTIFY_POWER_STATE,
+			  payload, sizeof(payload),
+			  GXFP_CMD_ACK,
+			  ack_payload, sizeof(ack_payload), &ack_len,
+			  1,
+			  GXFP_DEFAULT_TIMEOUT_US);
+
+	dev_dbg(gdev->dev,
+		 "NOTIFY_POWER_STATE: cmd=0x0E state=%u rc=%d ack_len=%zu\n",
+		 state, rc, ack_len);
+	return rc;
+}
+
+int gxfp_cmd_sleep_cleanup(struct gxfp_dev *gdev, unsigned int post_delay_ms)
+{
+	static const __u8 sleep_payload[2] = { 0x00, 0x00 };
+	__u8 ack_payload[8];
+	size_t ack_len = 0;
+	int rc;
+
+	if (!gdev)
+		return -EINVAL;
+
+	rc = gxfp_cmd_xfer(gdev,
+			  GXFP_CMD_SLEEP_CLEANUP,
+			  sleep_payload, sizeof(sleep_payload),
+			  GXFP_CMD_ACK,
+			  ack_payload, sizeof(ack_payload), &ack_len,
+			  1,
+			  GXFP_DEFAULT_TIMEOUT_US);
+	dev_dbg(gdev->dev, "SLEEP/CLEANUP: cmd=0xD2 rc=%d ack_len=%zu\n", rc, ack_len);
+
+	if (post_delay_ms)
+		msleep(post_delay_ms);
+
+	return rc;
+}
+
+int gxfp_cmd_reset_device(struct gxfp_dev *gdev,
+			  __u8 reset_flags)
+{
+	__u8 payload[2];
+	__u8 ack_payload[8];
+	size_t ack_len = 0;
+	int rc;
+
+	if (!gdev)
+		return -EINVAL;
+
+	payload[0] = reset_flags;
+	payload[1] = 0x14;
+
+	rc = gxfp_cmd_xfer(gdev,
+			  GXFP_CMD_RESET_DEVICE,
+			  payload, sizeof(payload),
+			  GXFP_CMD_ACK,
+			  ack_payload, sizeof(ack_payload), &ack_len,
+			  1,
+			  GXFP_DEFAULT_TIMEOUT_US);
+	dev_dbg(gdev->dev,
+		 "RESET_DEVICE: cmd=0xA1 flags=0x%02x rc=%d ack_len=%zu\n",
+		 reset_flags, rc, ack_len);
+	return rc;
+}
+
+int gxfp_cmd_recover_session(struct gxfp_dev *gdev, bool unstick_tls)
+{
+	int rc = 0;
+	int r;
+	unsigned int tries;
+
+	if (!gdev)
+		return -EINVAL;
+
+	/* D0Exit notifies MCU power state */
+	for (tries = 0; tries < 3; tries++) {
+		r = gxfp_cmd_notify_power_state(gdev, 1);
+		if (!r)
+			break;
+		if ((tries + 1) < 3)
+			usleep_range(10000, 11000);
+	}
+	if (r && !rc)
+		rc = r;
+	gxfp_busy_wait_us(GXFP_RESET_DELAY_US);
+
+	if (unstick_tls) {
+		r = gxfp_cmd_protocol_init(gdev);
+		if (r && !rc)
+			rc = r;
+		gxfp_busy_wait_us(1000);
+
+		r = gxfp_cmd_tls_unlock(gdev);
+		if (r && !rc)
+			rc = r;
+		gxfp_busy_wait_us(1000);
+	}
+
+	r = gxfp_cmd_sleep_cleanup(gdev, 200);
+	if (r && !rc)
+		rc = r;
+
+	for (tries = 0; tries < 6; tries++) {
+		r = gxfp_cmd_reset_device(gdev, GXFP_RESET_FLAG_MCU_SENSOR);
+		if (!r)
+			break;
+		if ((tries + 1) < 6)
+			gxfp_busy_wait_us(500000);
+	}
+	if (r && !rc)
+		rc = r;
+	gxfp_busy_wait_us(GXFP_RESET_DELAY_US);
+
+	dev_dbg(gdev->dev, "RECOVER_SESSION: unstick_tls=%u rc=%d\n", unstick_tls ? 1 : 0, rc);
+	return rc;
+}
+
+int gxfp_cmd_tls_unlock(struct gxfp_dev *gdev)
+{
+	__u8 payload[2] = { 0x00, 0x00 };
+	__u8 ack_payload[8];
+	size_t ack_len = 0;
+	int rc;
+
+	if (!gdev)
+		return -EINVAL;
+
+	rc = gxfp_cmd_xfer(gdev,
+			  GXFP_CMD_TLS_UNLOCK,
+			  payload, sizeof(payload),
+			  GXFP_CMD_ACK,
+			  ack_payload, sizeof(ack_payload), &ack_len,
+			  1,
+			  GXFP_DEFAULT_TIMEOUT_US);
+
+	dev_dbg(gdev->dev, "TLS_UNLOCK: cmd=0xD4 rc=%d ack_len=%zu\n", rc, ack_len);
+	return rc;
+}
+
+int gxfp_cmd_protocol_init(struct gxfp_dev *gdev)
+{
+	__u8 payload[4] = { 0x00, 0x00, 0x00, 0x00 };
+	__u8 ack_payload[8];
+	size_t ack_len = 0;
+	int rc;
+
+	if (!gdev)
+		return -EINVAL;
+
+	rc = gxfp_cmd_xfer(gdev,
+			  GXFP_CMD_PROTOCOL_INIT,
+			  payload, sizeof(payload),
+			  GXFP_CMD_ACK,
+			  ack_payload, sizeof(ack_payload), &ack_len,
+			  1,
+			  GXFP_DEFAULT_TIMEOUT_US);
+
+	dev_dbg(gdev->dev, "PROTO_INIT: cmd=0x01 rc=%d ack_len=%zu\n", rc, ack_len);
+	return rc;
+}
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h b/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h
new file mode 100644
index 000000000..29f7434c1
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CMD_RESET_H
+#define __GXFP_CMD_RESET_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+
+#define GXFP_RESET_FLAG_SENSOR 0x01u
+#define GXFP_RESET_FLAG_MCU 0x02u
+#define GXFP_RESET_FLAG_MCU_SENSOR (GXFP_RESET_FLAG_MCU | GXFP_RESET_FLAG_SENSOR)
+
+int gxfp_cmd_sleep_cleanup(struct gxfp_dev *gdev, unsigned int post_delay_ms);
+
+int gxfp_cmd_notify_power_state(struct gxfp_dev *gdev,
+				__u8 state);
+
+int gxfp_cmd_reset_device(struct gxfp_dev *gdev,
+			  __u8 reset_flags);
+
+int gxfp_cmd_tls_unlock(struct gxfp_dev *gdev);
+
+int gxfp_cmd_protocol_init(struct gxfp_dev *gdev);
+
+int gxfp_cmd_recover_session(struct gxfp_dev *gdev, bool unstick_tls);
+
+#endif /* __GXFP_CMD_RESET_H */
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c b/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c
new file mode 100644
index 000000000..7ea28e965
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/unaligned.h>
+#include <linux/string.h>
+
+#include "gxfp_priv.h"
+#include "gxfp_cmd.h"
+#include "../hw/gxfp_delay.h"
+#include "gxfp_constants.h"
+#include "gxfp_cmd_version.h"
+
+static bool gxfp_extract_ascii_version(const __u8 *data, char *out, size_t out_len)
+{
+	size_t j;
+
+	if (!out || out_len == 0)
+		return false;
+	out[0] = '\0';
+
+	if (!data)
+		return false;
+
+	for (j = 0; (j + 1) < out_len; j++) {
+		__u8 ch = data[j];
+
+		if (ch == 0 || ch < 0x20 || ch > 0x7e)
+			break;
+		out[j] = (char)ch;
+	}
+	out[j] = '\0';
+
+	return j != 0;
+}
+
+static int gxfp_do_get_version(struct gxfp_dev *gdev,
+			       struct gxfp_get_version_result *out)
+{
+	static const __u8 req_payload[] = { 0x01 };
+	__u8 payload[GXFP_MAX_VERSION_RAW];
+	size_t rx_len = 0;
+	int ret;
+
+	memset(out, 0, sizeof(*out));
+	out->status = (__u32)-EIO;
+	out->gpio_status = (__u32)-EIO;
+	out->tx_status = (__u32)-EIO;
+	out->rx_status = (__u32)-EIO;
+
+	if (!gdev->hw.mailbox_mmio || gdev->hw.mailbox_size < GXFP_MAILBOX_MIN_SIZE) {
+		out->status = (__u32)-ENODEV;
+		out->gpio_status = (__u32)-ENODEV;
+		out->tx_status = (__u32)-ENODEV;
+		out->rx_status = (__u32)-ENODEV;
+		return -ENODEV;
+	}
+
+	ret = gxfp_cmd_xfer(gdev,
+			   GXFP_CMD_FIRMWARE_VERSION,
+			   req_payload,
+			   sizeof(req_payload),
+			   GXFP_CMD_FIRMWARE_VERSION,
+			   payload,
+			   sizeof(payload),
+			   &rx_len,
+			   GXFP_DEFAULT_RETRY_COUNT,
+		   GXFP_DEFAULT_TIMEOUT_US);
+	out->tx_status = 0;
+	out->gpio_status = 0;
+	out->rx_status = (__u32)(ret ? ret : 0);
+	if (ret) {
+		out->status = (__u32)ret;
+		return ret;
+	}
+
+	out->bytes_read = (__u32)min_t(size_t, rx_len, sizeof(out->raw));
+	memset(out->raw, 0, sizeof(out->raw));
+	memcpy(out->raw, payload, out->bytes_read);
+	dev_dbg(gdev->dev,
+		 "GET_VERSION: payload_len=%zu head16=%*ph\n",
+		 rx_len, 16, out->raw);
+
+	(void)gxfp_extract_ascii_version(payload,
+					 out->version_ascii,
+					 sizeof(out->version_ascii));
+	if (out->version_ascii[0] == '\0') {
+		out->status = (__u32)-ENODATA;
+		return 0;
+	}
+
+	out->status = 0;
+	return 0;
+}
+
+int gxfp_cmd_get_version(struct gxfp_dev *gdev, struct gxfp_get_version_result *out)
+{
+	return gxfp_do_get_version(gdev, out);
+}
diff --git a/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h b/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h
new file mode 100644
index 000000000..8f619ab3a
--- /dev/null
+++ b/drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CMD_VERSION_H
+#define __GXFP_CMD_VERSION_H
+
+#include <linux/types.h>
+#include "gxfp_constants.h"
+
+struct gxfp_dev;
+
+struct gxfp_get_version_result {
+	__u32 status;
+	__u32 gpio_status;
+	__u32 tx_status;
+	__u32 rx_status;
+	__u32 bytes_read;
+	char version_ascii[GXFP_MAX_VERSION_ASCII];
+	__u8 raw[GXFP_MAX_VERSION_RAW];
+};
+
+int gxfp_cmd_get_version(struct gxfp_dev *gdev, struct gxfp_get_version_result *out);
+
+#endif /* __GXFP_CMD_VERSION_H */
diff --git a/drivers/misc/gxfp5130/driver/gxfp_irq.c b/drivers/misc/gxfp5130/driver/gxfp_irq.c
new file mode 100644
index 000000000..09ad2aaaa
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_irq.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/minmax.h>
+
+#include "gxfp_priv.h"
+#include "../transport/gxfp_espi_rx_irq.h"
+
+#include "gxfp_irq.h"
+#include "gxfp_uapi.h"
+#include "gxfp_trace.h"
+
+#include "../hw/gxfp_gpio.h"
+
+irqreturn_t gxfp_irq_thread(int irq, void *data)
+{
+	struct gxfp_dev *gdev = data;
+	size_t rx_len = 0;
+	int ret;
+	bool complete = false;
+	bool push = false;
+
+	if (!gdev || !gdev->irq.rx_buf || gdev->irq.rx_cap < 16)
+		return IRQ_NONE;
+
+	mutex_lock(&gdev->lock);
+
+	ret = gxfp_espi_irq_read_step(gdev, gdev->irq.rx_buf, gdev->irq.rx_cap,
+			     &rx_len, &complete);
+	if (ret) {
+		gxfp_trace_logf("irq_read_step rc=%d", ret);
+		goto out_clear;
+	}
+
+	if (!complete)
+		goto out_clear;
+
+	if (rx_len == 0)
+		goto out_clear;
+
+	push = true;
+
+out_clear:
+	gxfp_gpio_set_read_done(gdev, 0);
+	mutex_unlock(&gdev->lock);
+
+	if (push)
+		gxfp_trace_logf("irq_rx_complete len=%zu head=%*ph", rx_len,
+			(int)min_t(size_t, 8, rx_len), gdev->irq.rx_buf);
+
+	if (push)
+		gxfp_uapi_rxq_push_packet(gdev, gdev->irq.rx_buf, rx_len);
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/misc/gxfp5130/driver/gxfp_irq.h b/drivers/misc/gxfp5130/driver/gxfp_irq.h
new file mode 100644
index 000000000..9b7fb41a1
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_irq.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_IRQ_H
+#define __GXFP_IRQ_H
+
+#include <linux/interrupt.h>
+
+irqreturn_t gxfp_irq_thread(int irq, void *data);
+
+#endif /* __GXFP_IRQ_H */
diff --git a/drivers/misc/gxfp5130/driver/gxfp_platform.c b/drivers/misc/gxfp5130/driver/gxfp_platform.c
new file mode 100644
index 000000000..842c9d803
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_platform.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include "gxfp_priv.h"
+#include "../hw/gxfp_acpi.h"
+#include "../hw/gxfp_gpio.h"
+#include "gxfp_constants.h"
+#include "gxfp_uapi.h"
+#include "gxfp_irq.h"
+#include "gxfp_platform.h"
+#include "gxfp_trace.h"
+
+#define GXFP_IRQ_RX_CAP (128u * 1024u)
+
+
+static int gxfp_platform_add_acpi_driver_gpios(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev = platform_get_drvdata(pdev);
+	struct acpi_gpio_params *params;
+	struct acpi_gpio_mapping *map;
+	int irq_idx;
+	int done_idx[2];
+	bool done_active_low;
+	int rc;
+
+	if (!pdev || !gdev)
+		return -EINVAL;
+
+	rc = gxfp_acpi_get_gpio_crs_indexes(&pdev->dev, &irq_idx, done_idx, &done_active_low);
+	if (rc) {
+		dev_warn(&pdev->dev, "ACPI _CRS: cannot build driver GPIO mapping (rc=%d)\n", rc);
+		return rc;
+	}
+
+	params = devm_kcalloc(&pdev->dev, 3, sizeof(*params), GFP_KERNEL);
+	map = devm_kcalloc(&pdev->dev, 4, sizeof(*map), GFP_KERNEL);
+	if (!params || !map)
+		return -ENOMEM;
+
+	params[0].crs_entry_index = (unsigned int)irq_idx;
+	params[0].line_index = 0;
+	params[0].active_low = false;
+	map[0].name = "irq-gpios";
+	map[0].data = &params[0];
+	map[0].size = 1;
+
+	params[1].crs_entry_index = (unsigned int)done_idx[0];
+	params[1].line_index = 0;
+	params[1].active_low = done_active_low;
+	map[1].name = "write-done-gpios";
+	map[1].data = &params[1];
+	map[1].size = 1;
+	map[1].quirks = 0;
+
+	params[2].crs_entry_index = (unsigned int)done_idx[1];
+	params[2].line_index = 0;
+	params[2].active_low = done_active_low;
+	map[2].name = "read-done-gpios";
+	map[2].data = &params[2];
+	map[2].size = 1;
+	map[2].quirks = 0;
+
+	/* map[3] is terminator */
+
+	rc = devm_acpi_dev_add_driver_gpios(&pdev->dev, map);
+	if (rc) {
+		dev_warn(&pdev->dev, "ACPI: dev_add_driver_gpios failed (rc=%d)\n", rc);
+		return rc;
+	}
+
+	dev_dbg(&pdev->dev,
+		"ACPI: installed driver GPIO mapping (irq_idx=%d done_idx=%d,%d done_active_low=%u)\n",
+		irq_idx, done_idx[0], done_idx[1], done_active_low ? 1 : 0);
+	return 0;
+}
+
+int gxfp_platform_probe(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev;
+	struct resource *res;
+	unsigned long irq_flags;
+	unsigned int irq_type;
+	int ret;
+
+	gdev = devm_kzalloc(&pdev->dev, sizeof(*gdev), GFP_KERNEL);
+	if (!gdev)
+		return -ENOMEM;
+	gdev->dev = &pdev->dev;
+	mutex_init(&gdev->lock);
+	atomic_set(&gdev->mailbox_seq16, GXFP_ESPI_SEQ16_INIT);
+	gdev->irq.assem_active = false;
+	gdev->irq.assem_total = 0;
+	gdev->irq.assem_copied = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing MMIO resource (mailbox window)\n");
+		return -ENODEV;
+	}
+
+	gdev->hw.mailbox_size = resource_size(res);
+	gdev->hw.mailbox_mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gdev->hw.mailbox_mmio))
+		return PTR_ERR(gdev->hw.mailbox_mmio);
+
+	platform_set_drvdata(pdev, gdev);
+	(void)gxfp_trace_init(&pdev->dev);
+
+	/* GPIOs */
+	{
+		int gpio_rc = gxfp_platform_init_gpios(pdev);
+
+		if (gpio_rc) {
+			if (gpio_rc == -EPROBE_DEFER)
+				dev_dbg(&pdev->dev, "GPIO not ready, deferring probe\n");
+			return gpio_rc;
+		}
+	}
+
+	/* misc device */
+	ret = gxfp_uapi_register(gdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register misc device (/dev/gxfp) rc=%d\n", ret);
+		return ret;
+	}
+
+	/* IRQ */
+	gdev->irq.rx_cap = GXFP_IRQ_RX_CAP;
+	gdev->irq.rx_buf = devm_kmalloc(&pdev->dev, gdev->irq.rx_cap, GFP_KERNEL);
+	if (!gdev->irq.rx_buf) {
+		dev_err(&pdev->dev, "IRQ: kmalloc(%zu) failed\n", gdev->irq.rx_cap);
+		ret = -ENOMEM;
+		goto err_ioctl;
+	}
+
+	gdev->irq.rx_tmp = devm_kmalloc(&pdev->dev, (size_t)GXFP_READ_CHUNK_MAX, GFP_KERNEL);
+	if (!gdev->irq.rx_tmp) {
+		ret = -ENOMEM;
+		goto err_ioctl;
+	}
+
+	gdev->hw.irq = gpiod_to_irq(gdev->hw.gpio_irq);
+	if (gdev->hw.irq < 0) {
+		dev_err(&pdev->dev, "IRQ: gpiod_to_irq failed rc=%d\n", gdev->hw.irq);
+		ret = gdev->hw.irq;
+		goto err_ioctl;
+	}
+
+	irq_type = irq_get_trigger_type(gdev->hw.irq);
+	if (irq_type == IRQ_TYPE_NONE) {
+		/*
+		 * ACPI DSDT for SPBA reports:
+		 *   GpioInt(Level, ActiveHigh, ExclusiveAndWake, ...)
+		 */
+		dev_info(&pdev->dev, "IRQ: trigger type unknown; defaulting to LEVEL_HIGH\n");
+		(void)irq_set_irq_type(gdev->hw.irq, IRQ_TYPE_LEVEL_HIGH);
+		irq_type = irq_get_trigger_type(gdev->hw.irq);
+	}
+
+	irq_flags = IRQF_ONESHOT | IRQF_NO_AUTOEN;
+	ret = devm_request_threaded_irq(&pdev->dev,
+				     gdev->hw.irq,
+				     NULL,
+				     gxfp_irq_thread,
+				     irq_flags,
+				     "gxfp-irq",
+				     gdev);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ: request_threaded_irq failed (irq=%d, rc=%d)\n",
+			gdev->hw.irq, ret);
+		gdev->hw.irq = 0;
+		goto err_ioctl;
+	}
+	dev_dbg(&pdev->dev, "IRQ: registered (irq=%d, flags=0x%lx, type=0x%x)\n",
+		 gdev->hw.irq, irq_flags, irq_type);
+
+	dev_dbg(&pdev->dev, "gxfp probed (mailbox=%pa len=%pa)\n",
+		&res->start, &gdev->hw.mailbox_size);
+	return 0;
+
+err_ioctl:
+	gxfp_uapi_unregister(gdev);
+	return ret;
+}
+
+int gxfp_platform_init_gpios(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev = platform_get_drvdata(pdev);
+	struct gpio_desc *d;
+	int added_map = 0;
+
+	d = devm_gpiod_get(&pdev->dev, "write-done", GPIOD_OUT_LOW);
+	if (IS_ERR(d) && PTR_ERR(d) == -ENOENT) {
+		(void)gxfp_platform_add_acpi_driver_gpios(pdev);
+		added_map = 1;
+		d = devm_gpiod_get(&pdev->dev, "write-done", GPIOD_OUT_LOW);
+	}
+	gdev->hw.gpio_write_done = d;
+	if (IS_ERR(gdev->hw.gpio_write_done))
+		return PTR_ERR(gdev->hw.gpio_write_done);
+
+	d = devm_gpiod_get(&pdev->dev, "read-done", GPIOD_OUT_LOW);
+	if (!added_map && IS_ERR(d) && PTR_ERR(d) == -ENOENT) {
+		(void)gxfp_platform_add_acpi_driver_gpios(pdev);
+		added_map = 1;
+		d = devm_gpiod_get(&pdev->dev, "read-done", GPIOD_OUT_LOW);
+	}
+	gdev->hw.gpio_read_done = d;
+	if (IS_ERR(gdev->hw.gpio_read_done))
+		return PTR_ERR(gdev->hw.gpio_read_done);
+
+	d = devm_gpiod_get(&pdev->dev, "irq", GPIOD_IN);
+	if (!added_map && IS_ERR(d) && PTR_ERR(d) == -ENOENT) {
+		(void)gxfp_platform_add_acpi_driver_gpios(pdev);
+		added_map = 1;
+		d = devm_gpiod_get(&pdev->dev, "irq", GPIOD_IN);
+	}
+	gdev->hw.gpio_irq = d;
+	if (IS_ERR(gdev->hw.gpio_irq))
+		return PTR_ERR(gdev->hw.gpio_irq);
+
+	if (!gdev->hw.gpio_write_done || !gdev->hw.gpio_read_done || !gdev->hw.gpio_irq) {
+		dev_err(&pdev->dev, "missing GPIOs write-done/read-done/irq (write_done=%p, read_done=%p, irq=%p)\n",
+			gdev->hw.gpio_write_done, gdev->hw.gpio_read_done, gdev->hw.gpio_irq);
+		return -EINVAL;
+	}
+
+	gxfp_gpio_force_done_deassert(gdev->dev, gdev);
+
+	return 0;
+}
+
+void gxfp_platform_remove(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev = platform_get_drvdata(pdev);
+
+	if (gdev && gdev->hw.irq > 0) {
+		disable_irq(gdev->hw.irq);
+		synchronize_irq(gdev->hw.irq);
+	}
+	gxfp_trace_exit();
+	gxfp_uapi_unregister(gdev);
+}
diff --git a/drivers/misc/gxfp5130/driver/gxfp_platform.h b/drivers/misc/gxfp5130/driver/gxfp_platform.h
new file mode 100644
index 000000000..fa69f18e5
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_platform.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_PLATFORM_H
+#define __GXFP_PLATFORM_H
+
+#include <linux/platform_device.h>
+
+int gxfp_platform_probe(struct platform_device *pdev);
+void gxfp_platform_remove(struct platform_device *pdev);
+
+int gxfp_platform_init_gpios(struct platform_device *pdev);
+
+#endif /* __GXFP_PLATFORM_H */
diff --git a/drivers/misc/gxfp5130/driver/gxfp_trace.c b/drivers/misc/gxfp5130/driver/gxfp_trace.c
new file mode 100644
index 000000000..e51dfe422
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_trace.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/stdarg.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "gxfp_trace.h"
+
+#define GXFP_TRACE_RING_SIZE 1024u
+#define GXFP_TRACE_LINE_MAX 192u
+#define GXFP_TRACE_DEFAULT_ENABLE 0
+
+static struct {
+	spinlock_t lock;
+	bool inited;
+	bool enabled;
+	u32 seq;
+	u32 head;
+	u32 count;
+	char lines[GXFP_TRACE_RING_SIZE][GXFP_TRACE_LINE_MAX];
+	struct dentry *dir;
+} gxfp_trace;
+
+static void gxfp_trace_push_locked(const char *line)
+{
+	u32 idx;
+
+	if (!line)
+		return;
+
+	idx = gxfp_trace.head;
+	strscpy(gxfp_trace.lines[idx], line, GXFP_TRACE_LINE_MAX);
+	gxfp_trace.head = (idx + 1u) % GXFP_TRACE_RING_SIZE;
+	if (gxfp_trace.count < GXFP_TRACE_RING_SIZE)
+		gxfp_trace.count++;
+}
+
+void gxfp_trace_logf(const char *fmt, ...)
+{
+	unsigned long flags;
+	char msg[128];
+	char line[GXFP_TRACE_LINE_MAX];
+	va_list ap;
+	u64 ts;
+	u32 seq;
+	int n;
+
+	if (!fmt || !READ_ONCE(gxfp_trace.inited) || !READ_ONCE(gxfp_trace.enabled))
+		return;
+
+	va_start(ap, fmt);
+	vscnprintf(msg, sizeof(msg), fmt, ap);
+	va_end(ap);
+
+	ts = ktime_get_ns();
+	spin_lock_irqsave(&gxfp_trace.lock, flags);
+	seq = ++gxfp_trace.seq;
+	n = scnprintf(line, sizeof(line), "%u %llu %s", seq, ts, msg);
+	if (n >= 0)
+		gxfp_trace_push_locked(line);
+	spin_unlock_irqrestore(&gxfp_trace.lock, flags);
+}
+
+void gxfp_trace_clear(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gxfp_trace.lock, flags);
+	gxfp_trace.head = 0;
+	gxfp_trace.count = 0;
+	spin_unlock_irqrestore(&gxfp_trace.lock, flags);
+}
+
+static int gxfp_trace_dump_show(struct seq_file *s, void *unused)
+{
+	char (*snapshot)[GXFP_TRACE_LINE_MAX];
+	unsigned long flags;
+	u32 count;
+	u32 start;
+	u32 i;
+
+	snapshot = kcalloc(GXFP_TRACE_RING_SIZE, sizeof(*snapshot), GFP_KERNEL);
+	if (!snapshot)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&gxfp_trace.lock, flags);
+	count = gxfp_trace.count;
+	start = (gxfp_trace.head + GXFP_TRACE_RING_SIZE - count) % GXFP_TRACE_RING_SIZE;
+	for (i = 0; i < count; i++) {
+		u32 idx = (start + i) % GXFP_TRACE_RING_SIZE;
+
+		strscpy(snapshot[i], gxfp_trace.lines[idx], GXFP_TRACE_LINE_MAX);
+	}
+	spin_unlock_irqrestore(&gxfp_trace.lock, flags);
+
+	seq_printf(s, "enabled=%u ring_size=%u count=%u\n",
+		   READ_ONCE(gxfp_trace.enabled) ? 1 : 0,
+		   GXFP_TRACE_RING_SIZE,
+		   count);
+	seq_puts(s, "# seq ts_ns message\n");
+	for (i = 0; i < count; i++)
+		seq_printf(s, "%s\n", snapshot[i]);
+
+	kfree(snapshot);
+	return 0;
+}
+
+static int gxfp_trace_dump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, gxfp_trace_dump_show, inode->i_private);
+}
+
+static const struct file_operations gxfp_trace_dump_fops = {
+	.owner = THIS_MODULE,
+	.open = gxfp_trace_dump_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static ssize_t gxfp_trace_clear_write(struct file *file,
+				      const char __user *ubuf,
+				      size_t count,
+				      loff_t *ppos)
+{
+	(void)file;
+	(void)ubuf;
+	(void)ppos;
+	gxfp_trace_clear();
+	return count;
+}
+
+static const struct file_operations gxfp_trace_clear_fops = {
+	.owner = THIS_MODULE,
+	.write = gxfp_trace_clear_write,
+	.llseek = noop_llseek,
+};
+
+int gxfp_trace_init(struct device *dev)
+{
+	(void)dev;
+
+	if (READ_ONCE(gxfp_trace.inited))
+		return 0;
+
+	memset(&gxfp_trace, 0, sizeof(gxfp_trace));
+	spin_lock_init(&gxfp_trace.lock);
+	gxfp_trace.enabled = GXFP_TRACE_DEFAULT_ENABLE;
+
+	gxfp_trace.dir = debugfs_create_dir("gxfp", NULL);
+	if (!IS_ERR_OR_NULL(gxfp_trace.dir)) {
+		debugfs_create_file("trace_dump", 0400, gxfp_trace.dir,
+				    NULL, &gxfp_trace_dump_fops);
+		debugfs_create_file("trace_clear", 0200, gxfp_trace.dir,
+				    NULL, &gxfp_trace_clear_fops);
+		debugfs_create_bool("trace_enable", 0600, gxfp_trace.dir, &gxfp_trace.enabled);
+	}
+
+	gxfp_trace.inited = true;
+	return 0;
+}
+
+void gxfp_trace_exit(void)
+{
+	if (!READ_ONCE(gxfp_trace.inited))
+		return;
+
+	debugfs_remove_recursive(gxfp_trace.dir);
+	gxfp_trace.dir = NULL;
+	gxfp_trace.inited = false;
+}
diff --git a/drivers/misc/gxfp5130/driver/gxfp_trace.h b/drivers/misc/gxfp5130/driver/gxfp_trace.h
new file mode 100644
index 000000000..2041ba0b0
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_TRACE_H
+#define __GXFP_TRACE_H
+
+#include <linux/types.h>
+
+struct device;
+
+int gxfp_trace_init(struct device *dev);
+void gxfp_trace_exit(void);
+void gxfp_trace_clear(void);
+
+void gxfp_trace_logf(const char *fmt, ...) __printf(1, 2);
+
+#endif /* __GXFP_TRACE_H */
diff --git a/drivers/misc/gxfp5130/driver/gxfp_uapi.h b/drivers/misc/gxfp5130/driver/gxfp_uapi.h
new file mode 100644
index 000000000..ecc60ee06
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_uapi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_UAPI_DRV_H
+#define __GXFP_UAPI_DRV_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+
+struct gxfp_dev;
+
+void gxfp_uapi_rxq_push_packet(struct gxfp_dev *gdev, const __u8 *buf, size_t len);
+
+void gxfp_uapi_rxq_flush_locked(struct gxfp_dev *gdev);
+ssize_t gxfp_uapi_read(struct file *file, char __user *ubuf, size_t count, loff_t *ppos);
+__poll_t gxfp_uapi_poll(struct file *file, poll_table *wait);
+
+int gxfp_uapi_open(struct inode *inode, struct file *file);
+int gxfp_uapi_release(struct inode *inode, struct file *file);
+ssize_t gxfp_uapi_write(struct file *file, const char __user *ubuf, size_t count, loff_t *ppos);
+long gxfp_uapi_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+int gxfp_uapi_register(struct gxfp_dev *gdev);
+void gxfp_uapi_unregister(struct gxfp_dev *gdev);
+
+#endif /* __GXFP_UAPI_DRV_H */
diff --git a/drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c b/drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c
new file mode 100644
index 000000000..d6b4a888f
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+
+#include "gxfp_priv.h"
+#include "../transport/gxfp_espi_tx.h"
+#include "../include/uapi/linux/gxfp_ioctl.h"
+#include "gxfp_uapi.h"
+#include "gxfp_trace.h"
+
+int gxfp_uapi_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *m = file->private_data;
+	struct gxfp_dev *gdev = container_of(m, struct gxfp_dev, uapi.miscdev);
+	unsigned long flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (file->f_mode & FMODE_READ) {
+		spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+		if (!gdev->uapi.rxq_inited) {
+			spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+			return -ENODEV;
+		}
+		if (gdev->uapi.rxq_reader_open) {
+			spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+			return -EBUSY;
+		}
+		gdev->uapi.rxq_reader_open = true;
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+	}
+
+	file->private_data = gdev;
+	gxfp_trace_logf("uapi_open ok mode=0x%x", file->f_mode);
+	return 0;
+}
+
+int gxfp_uapi_release(struct inode *inode, struct file *file)
+{
+	struct gxfp_dev *gdev = file->private_data;
+	unsigned long flags;
+
+	if (!gdev)
+		return 0;
+
+	if (file->f_mode & FMODE_READ) {
+		spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+		gdev->uapi.rxq_reader_open = false;
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+	}
+
+	return 0;
+}
+
+ssize_t gxfp_uapi_write(struct file *file, const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct gxfp_dev *gdev = file->private_data;
+	struct gxfp_tx_pkt_hdr txh;
+	__u8 *mp_local = NULL;
+	size_t payload_len;
+	size_t need;
+	int ret;
+
+	if (!gdev || !ubuf)
+		return -ENODEV;
+	if (count < sizeof(txh))
+		return -EINVAL;
+
+	if (copy_from_user(&txh, ubuf, sizeof(txh)))
+		return -EFAULT;
+
+	payload_len = (size_t)txh.payload_len;
+	if (payload_len > GXFP_IOCTL_TX_PAYLOAD_MAX)
+		return -EINVAL;
+
+	need = sizeof(txh) + payload_len;
+	if (count != need)
+		return -EINVAL;
+
+	mp_local = kmalloc(4u + payload_len, GFP_KERNEL);
+	if (!mp_local)
+		return -ENOMEM;
+
+	mp_local[0] = txh.mp_flags;
+	mp_local[1] = (__u8)(payload_len & 0xff);
+	mp_local[2] = (__u8)((payload_len >> 8) & 0xff);
+	mp_local[3] = (__u8)(mp_local[0] + mp_local[1] + mp_local[2]);
+	if (payload_len && copy_from_user(mp_local + 4, ubuf + sizeof(txh), payload_len)) {
+		kfree(mp_local);
+		return -EFAULT;
+	}
+
+	mutex_lock(&gdev->lock);
+	ret = gxfp_espi_write(gdev, mp_local, 4u + payload_len);
+	mutex_unlock(&gdev->lock);
+	gxfp_trace_logf("uapi_write rc=%d mp_len=%zu head=%*ph", ret, 4u + payload_len,
+		(int)min_t(size_t, 8, 4u + payload_len), mp_local);
+
+	kfree(mp_local);
+	if (ret)
+		return ret;
+
+	return (ssize_t)count;
+}
+
+long gxfp_uapi_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct gxfp_dev *gdev = file->private_data;
+	int ret;
+
+	if (!gdev)
+		return -ENODEV;
+
+	switch (cmd) {
+	case GXFP_IOCTL_FLUSH_RXQ: {
+		unsigned long flush_flags;
+
+		ret = mutex_lock_interruptible(&gdev->uapi.rxq_mutex);
+		if (ret)
+			return ret;
+
+		spin_lock_irqsave(&gdev->uapi.rxq_lock, flush_flags);
+		gxfp_uapi_rxq_flush_locked(gdev);
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flush_flags);
+		mutex_unlock(&gdev->uapi.rxq_mutex);
+		gxfp_trace_logf("uapi_ioctl flush_rxq ok");
+		return 0;
+	}
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c b/drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c
new file mode 100644
index 000000000..7be5f1265
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/poll.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+
+#include "gxfp_priv.h"
+#include "gxfp_uapi.h"
+#include "../include/uapi/linux/gxfp_ioctl.h"
+#include "../proto/gxfp_mp_proto.h"
+
+void gxfp_uapi_rxq_flush_locked(struct gxfp_dev *gdev)
+{
+	if (!gdev || !gdev->uapi.rxq_inited)
+		return;
+	kfifo_reset(&gdev->uapi.rxq_fifo);
+}
+
+static void gxfp_uapi_rxq_push(struct gxfp_dev *gdev, const __u8 *buf, size_t len)
+{
+	unsigned long flags;
+	struct gxfp_tap_hdr hdr;
+	struct gxfp_mp_frame_parsed mp;
+	size_t need;
+
+	if (!gdev || !gdev->uapi.rxq_inited || !buf || len == 0)
+		return;
+	if (!gxfp_parse_mp_frame(buf, len, &mp) || !mp.valid)
+		return;
+	if (mp.payload_len > (size_t)U32_MAX)
+		return;
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.len = (__u32)mp.payload_len;
+	hdr.type = (__u32)(mp.flags >> 4);
+	hdr.ts_ns = ktime_get_ns();
+	memcpy(hdr.head16, mp.payload, min_t(size_t, mp.payload_len, sizeof(hdr.head16)));
+
+	spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+	if (!gdev->uapi.rxq_inited) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return;
+	}
+	need = sizeof(hdr) + mp.payload_len;
+	if (kfifo_avail(&gdev->uapi.rxq_fifo) < need) {
+		unsigned int avail = kfifo_avail(&gdev->uapi.rxq_fifo);
+
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		dev_warn_ratelimited(gdev->dev,
+			"rxq: drop need=%zu avail=%u\n",
+			need, avail);
+		return;
+	}
+	(void)kfifo_in(&gdev->uapi.rxq_fifo, (const void *)&hdr, sizeof(hdr));
+	(void)kfifo_in(&gdev->uapi.rxq_fifo, mp.payload, mp.payload_len);
+	spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+
+	wake_up_interruptible(&gdev->uapi.rxq_wq);
+}
+
+void gxfp_uapi_rxq_push_packet(struct gxfp_dev *gdev, const __u8 *buf, size_t len)
+{
+	gxfp_uapi_rxq_push(gdev, buf, len);
+}
+
+static bool gxfp_uapi_rxq_ready(struct gxfp_dev *gdev)
+{
+	unsigned long flags;
+	bool ready;
+
+	spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+	ready = gdev->uapi.rxq_inited && !kfifo_is_empty(&gdev->uapi.rxq_fifo);
+	spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+
+	return ready;
+}
+
+static int gxfp_uapi_wait_nonempty(struct gxfp_dev *gdev, struct file *file)
+{
+	unsigned long flags;
+	int ret;
+
+	for (;;) {
+		spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+		if (!gdev->uapi.rxq_inited) {
+			spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+			return -ENODEV;
+		}
+		if (!kfifo_is_empty(&gdev->uapi.rxq_fifo)) {
+			spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+			return 0;
+		}
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_event_interruptible(gdev->uapi.rxq_wq,
+			gxfp_uapi_rxq_ready(gdev) || !READ_ONCE(gdev->uapi.rxq_inited));
+		if (ret)
+			return ret;
+	}
+}
+
+static int gxfp_uapi_peek_need(struct gxfp_dev *gdev, size_t count, size_t *out_need)
+{
+	struct gxfp_tap_hdr hdr;
+	unsigned long flags;
+	size_t need;
+
+	if (!out_need)
+		return -EINVAL;
+
+	spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+	if (!gdev->uapi.rxq_inited) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -ENODEV;
+	}
+	if (kfifo_len(&gdev->uapi.rxq_fifo) < sizeof(hdr)) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -EIO;
+	}
+	if (kfifo_out_peek(&gdev->uapi.rxq_fifo, &hdr, sizeof(hdr)) != sizeof(hdr)) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -EIO;
+	}
+	need = sizeof(hdr) + (size_t)hdr.len;
+	if ((size_t)kfifo_len(&gdev->uapi.rxq_fifo) < need) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -EIO;
+	}
+	if (count < need) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -EMSGSIZE;
+	}
+	spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+
+	*out_need = need;
+	return 0;
+}
+
+static int gxfp_uapi_pop_record(struct gxfp_dev *gdev, __u8 *tmp,
+				size_t need, unsigned int *out_popped)
+{
+	unsigned long flags;
+	unsigned int popped;
+
+	if (!out_popped)
+		return -EINVAL;
+
+	spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+	if (!gdev->uapi.rxq_inited) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return -ENODEV;
+	}
+	popped = kfifo_out(&gdev->uapi.rxq_fifo, tmp, need);
+	spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+
+	*out_popped = popped;
+	return 0;
+}
+
+ssize_t gxfp_uapi_read(struct file *file, char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct gxfp_dev *gdev = file->private_data;
+	__u8 *tmp;
+	size_t need;
+	int ret;
+	unsigned int popped = 0;
+
+	if (!gdev || !gdev->uapi.rxq_inited)
+		return -ENODEV;
+	if (count == 0)
+		return 0;
+
+	ret = mutex_lock_interruptible(&gdev->uapi.rxq_mutex);
+	if (ret)
+		return ret;
+
+	ret = gxfp_uapi_wait_nonempty(gdev, file);
+	if (ret)
+		goto out_unlock;
+
+	ret = gxfp_uapi_peek_need(gdev, count, &need);
+	if (ret)
+		goto out_unlock;
+
+	tmp = kmalloc(need, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = gxfp_uapi_pop_record(gdev, tmp, need, &popped);
+	if (ret) {
+		kfree(tmp);
+		goto out_unlock;
+	}
+
+	if (popped != need) {
+		kfree(tmp);
+		ret = -EIO;
+		goto out_unlock;
+	}
+
+	if (copy_to_user(ubuf, tmp, popped)) {
+		kfree(tmp);
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	kfree(tmp);
+	ret = (int)popped;
+
+out_unlock:
+	mutex_unlock(&gdev->uapi.rxq_mutex);
+	return ret;
+}
+
+__poll_t gxfp_uapi_poll(struct file *file, poll_table *wait)
+{
+	struct gxfp_dev *gdev = file->private_data;
+	__poll_t mask = 0;
+	unsigned long flags;
+
+	if (!gdev || !gdev->uapi.rxq_inited)
+		return EPOLLERR;
+
+	poll_wait(file, &gdev->uapi.rxq_wq, wait);
+	spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+	if (!gdev->uapi.rxq_inited) {
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		return EPOLLERR;
+	}
+	if (!kfifo_is_empty(&gdev->uapi.rxq_fifo))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+	return mask;
+}
diff --git a/drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c b/drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c
new file mode 100644
index 000000000..c797ed432
--- /dev/null
+++ b/drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/sizes.h>
+
+#include "gxfp_priv.h"
+#include "../hw/gxfp_acpi.h"
+#include "gxfp_uapi.h"
+
+#define GXFP_RXQ_FIFO_BYTES		SZ_1M
+
+static ssize_t acpi_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct miscdevice *m = dev_get_drvdata(dev);
+	struct gxfp_dev *gdev;
+	char hid[16];
+	int rc;
+
+	if (!m)
+		return -ENODEV;
+	gdev = container_of(m, struct gxfp_dev, uapi.miscdev);
+	if (!gdev || !gdev->dev)
+		return -ENODEV;
+	rc = gxfp_acpi_get_hid(gdev->dev, hid, sizeof(hid));
+	if (rc)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%s\n", hid);
+}
+static DEVICE_ATTR_RO(acpi_id);
+
+static struct attribute *gxfp_misc_attrs[] = {
+	&dev_attr_acpi_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gxfp_misc);
+
+static const struct file_operations gxfp_uapi_fops = {
+	.owner = THIS_MODULE,
+	.open = gxfp_uapi_open,
+	.release = gxfp_uapi_release,
+	.read = gxfp_uapi_read,
+	.write = gxfp_uapi_write,
+	.poll = gxfp_uapi_poll,
+	.unlocked_ioctl = gxfp_uapi_unlocked_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
+int gxfp_uapi_register(struct gxfp_dev *gdev)
+{
+	int ret;
+	int rc_fifo;
+	unsigned int fifo_bytes;
+
+	if (!gdev)
+		return -EINVAL;
+	if (gdev->uapi.misc_registered)
+		return 0;
+
+	gdev->uapi.miscdev.minor = MISC_DYNAMIC_MINOR;
+	gdev->uapi.miscdev.name = "gxfp";
+	gdev->uapi.miscdev.fops = &gxfp_uapi_fops;
+	gdev->uapi.miscdev.parent = gdev->dev;
+	gdev->uapi.miscdev.groups = gxfp_misc_groups;
+
+	spin_lock_init(&gdev->uapi.rxq_lock);
+	mutex_init(&gdev->uapi.rxq_mutex);
+	init_waitqueue_head(&gdev->uapi.rxq_wq);
+	gdev->uapi.rxq_inited = false;
+	gdev->uapi.rxq_reader_open = false;
+	fifo_bytes = GXFP_RXQ_FIFO_BYTES;
+	rc_fifo = kfifo_alloc(&gdev->uapi.rxq_fifo, fifo_bytes, GFP_KERNEL);
+	if (rc_fifo)
+		return rc_fifo;
+	gdev->uapi.rxq_inited = true;
+
+	ret = misc_register(&gdev->uapi.miscdev);
+	if (ret)
+		goto err_fifo;
+
+	gdev->uapi.misc_registered = true;
+
+	dev_dbg(gdev->dev, "misc device registered: /dev/%s\n", gdev->uapi.miscdev.name);
+	return 0;
+
+err_fifo:
+	if (gdev->uapi.rxq_inited) {
+		kfifo_free(&gdev->uapi.rxq_fifo);
+		gdev->uapi.rxq_inited = false;
+	}
+	return ret;
+}
+
+void gxfp_uapi_unregister(struct gxfp_dev *gdev)
+{
+	unsigned long flags;
+
+	if (!gdev)
+		return;
+	if (!gdev->uapi.misc_registered && !gdev->uapi.rxq_inited)
+		return;
+
+	if (gdev->uapi.misc_registered) {
+		misc_deregister(&gdev->uapi.miscdev);
+		gdev->uapi.misc_registered = false;
+	}
+
+	if (gdev->uapi.rxq_inited) {
+		mutex_lock(&gdev->uapi.rxq_mutex);
+		spin_lock_irqsave(&gdev->uapi.rxq_lock, flags);
+		gdev->uapi.rxq_inited = false;
+		gdev->uapi.rxq_reader_open = false;
+		kfifo_reset(&gdev->uapi.rxq_fifo);
+		spin_unlock_irqrestore(&gdev->uapi.rxq_lock, flags);
+		wake_up_interruptible_all(&gdev->uapi.rxq_wq);
+
+		kfifo_free(&gdev->uapi.rxq_fifo);
+		mutex_unlock(&gdev->uapi.rxq_mutex);
+	}
+}
diff --git a/drivers/misc/gxfp5130/gxfp_main.c b/drivers/misc/gxfp5130/gxfp_main.c
new file mode 100644
index 000000000..863e36a88
--- /dev/null
+++ b/drivers/misc/gxfp5130/gxfp_main.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+
+#include "include/gxfp_priv.h"
+#include "cmd/gxfp_cmd.h"
+#include "cmd/gxfp_cmd_reset.h"
+#include "cmd/gxfp_cmd_version.h"
+#include "cmd/gxfp_cmd_mcu_state.h"
+#include "driver/gxfp_platform.h"
+
+#define GXFP_DRV_NAME "gxfp"
+
+static int gxfp_startup_sequence(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev = platform_get_drvdata(pdev);
+	struct gxfp_get_version_result ver;
+	struct gxfp_mcu_state mcu;
+	int rc;
+	int mcu_rc;
+	unsigned int try;
+
+	if (!gdev)
+		return -ENODEV;
+
+	msleep(150);
+	memset(&ver, 0, sizeof(ver));
+	memset(&mcu, 0, sizeof(mcu));
+
+	mutex_lock(&gdev->lock);
+	rc = 0;
+	for (try = 0; try < 3; try++) {
+		rc = gxfp_cmd_get_version(gdev, &ver);
+		if (!rc)
+			break;
+		if ((try + 1) < 3)
+			msleep(20);
+	}
+	mcu_rc = gxfp_cmd_query_mcu_state(gdev, &mcu);
+	if (ver.status != 0) {
+		dev_warn(&pdev->dev,
+			 "INIT: get_version failed (%d); attempting recover_session then retry\n",
+			 (int)ver.status);
+		(void)gxfp_cmd_recover_session(gdev, 1);
+		(void)gxfp_cmd_get_version(gdev, &ver);
+	}
+	mutex_unlock(&gdev->lock);
+
+	if (ver.status == 0 && ver.version_ascii[0] != '\0')
+		dev_info(&pdev->dev, "INIT: FW='%s'\n", ver.version_ascii);
+	if (ver.status != 0)
+		return (int)ver.status;
+
+	return 0;
+}
+
+static void gxfp_shutdown_sequence(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev;
+	int rc;
+
+	if (!pdev)
+		return;
+	gdev = platform_get_drvdata(pdev);
+	if (!gdev)
+		return;
+
+	mutex_lock(&gdev->lock);
+	(void)gxfp_cmd_notify_power_state(gdev, 1);
+	rc = gxfp_cmd_sleep_cleanup(gdev, 0);
+	mutex_unlock(&gdev->lock);
+	dev_dbg(&pdev->dev, "REMOVE: sent SLEEP/CLEANUP(0xD2) rc=%d\n", rc);
+}
+
+static int gxfp_probe(struct platform_device *pdev)
+{
+	struct gxfp_dev *gdev;
+	int ret;
+
+	ret = gxfp_platform_probe(pdev);
+	if (ret)
+		return ret;
+
+	ret = gxfp_startup_sequence(pdev);
+	if (ret) {
+		gxfp_platform_remove(pdev);
+		return ret;
+	}
+
+	gdev = platform_get_drvdata(pdev);
+	if (gdev && gdev->hw.irq > 0)
+		enable_irq(gdev->hw.irq);
+
+	return 0;
+}
+
+static void gxfp_remove(struct platform_device *pdev)
+{
+	gxfp_shutdown_sequence(pdev);
+	gxfp_platform_remove(pdev);
+}
+
+static const struct acpi_device_id gxfp_acpi_match[] = {
+	{ "GXFP5130", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, gxfp_acpi_match);
+
+static struct platform_driver gxfp_driver = {
+	.driver = {
+		.name = GXFP_DRV_NAME,
+		.acpi_match_table = gxfp_acpi_match,
+	},
+	.probe = gxfp_probe,
+	.remove = gxfp_remove,
+};
+
+module_platform_driver(gxfp_driver);
+
+MODULE_DESCRIPTION("eSPI-Based GXFP5130 Fingerprint Sensor Driver");
+MODULE_AUTHOR("vindeu");
+MODULE_AUTHOR("Metehan Günen <metehangnen@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/gxfp5130/hw/gxfp_acpi.c b/drivers/misc/gxfp5130/hw/gxfp_acpi.c
new file mode 100644
index 000000000..17e42fcd3
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_acpi.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+
+#include "gxfp_acpi.h"
+
+struct gxfp_acpi_res_state {
+	struct device *dev;
+	int gpio_seen;
+	int gpio_io_seen;
+	u16 gpio_io_pin[2];
+	u8 gpio_io_pol[2];
+	int gpio_io_crs_index[2];
+	int gpio_int_seen;
+	int gpio_int_crs_index;
+};
+
+static int gxfp_acpi_res_cb(struct acpi_resource *ares, void *context)
+{
+	struct gxfp_acpi_res_state *st = context;
+
+	if (!ares || !st || !st->dev)
+		return 0;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_GPIO: {
+		struct acpi_resource_gpio *g = &ares->data.gpio;
+		u16 pin0 = 0xffff;
+		const char *ctype = "gpio?";
+
+		st->gpio_seen++;
+
+		if (g->pin_table_length < 1)
+			break;
+		pin0 = g->pin_table[0];
+
+		if (g->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
+			ctype = "GpioInt";
+			st->gpio_int_seen++;
+			if (st->gpio_int_seen == 1)
+				st->gpio_int_crs_index = st->gpio_seen - 1;
+		} else if (g->connection_type == ACPI_RESOURCE_GPIO_TYPE_IO) {
+			ctype = "GpioIo";
+			if (st->gpio_io_seen < 2) {
+				st->gpio_io_pin[st->gpio_io_seen] = pin0;
+				st->gpio_io_pol[st->gpio_io_seen] = g->polarity;
+				st->gpio_io_crs_index[st->gpio_io_seen] = st->gpio_seen - 1;
+				st->gpio_io_seen++;
+			}
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int gxfp_acpi_get_gpio_crs_indexes(struct device *dev,
+				  int *irq_gpio_crs_index,
+				  int done_gpio_crs_index[2],
+				  bool *done_active_low)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct gxfp_acpi_res_state st = { .dev = dev };
+	LIST_HEAD(res_list);
+	int rc;
+	bool p0, p1;
+
+	if (!dev || !irq_gpio_crs_index || !done_gpio_crs_index || !done_active_low)
+		return -EINVAL;
+	if (!adev)
+		return -ENODEV;
+
+	st.gpio_int_crs_index = -1;
+	st.gpio_io_crs_index[0] = -1;
+	st.gpio_io_crs_index[1] = -1;
+
+	rc = acpi_dev_get_resources(adev, &res_list, gxfp_acpi_res_cb, &st);
+	acpi_dev_free_resource_list(&res_list);
+	if (rc <= 0)
+		return -ENOENT;
+	if (st.gpio_int_seen < 1 || st.gpio_int_crs_index < 0)
+		return -ENOENT;
+	if (st.gpio_io_seen < 2 || st.gpio_io_crs_index[0] < 0 || st.gpio_io_crs_index[1] < 0)
+		return -ENOENT;
+
+	p0 = st.gpio_io_pol[0] ? true : false;
+	p1 = st.gpio_io_pol[1] ? true : false;
+	if (p0 != p1) {
+		dev_warn(dev, "ACPI _CRS: done GPIO polarities differ (done[0]=%u done[1]=%u)\n",
+			 st.gpio_io_pol[0], st.gpio_io_pol[1]);
+		return -EINVAL;
+	}
+
+	*irq_gpio_crs_index = st.gpio_int_crs_index;
+	done_gpio_crs_index[0] = st.gpio_io_crs_index[0];
+	done_gpio_crs_index[1] = st.gpio_io_crs_index[1];
+	*done_active_low = p0;
+	return 0;
+}
+
+int gxfp_acpi_get_hid(struct device *dev, char *buf, size_t bufsz)
+{
+	struct acpi_device *adev;
+	const char *hid;
+	size_t len;
+
+	if (!dev || !buf || bufsz < 2)
+		return -EINVAL;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	hid = acpi_device_hid(adev);
+	if (!hid || hid[0] == '\0')
+		return -ENOENT;
+
+	len = strlen(hid);
+	if (len >= bufsz)
+		return -ENOSPC;
+
+	memcpy(buf, hid, len + 1);
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/hw/gxfp_acpi.h b/drivers/misc/gxfp5130/hw/gxfp_acpi.h
new file mode 100644
index 000000000..5975a9fa0
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_acpi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_ACPI_H
+#define __GXFP_ACPI_H
+
+#include <linux/device.h>
+#include <linux/acpi.h>
+
+int gxfp_acpi_get_gpio_crs_indexes(struct device *dev,
+				  int *irq_gpio_crs_index,
+				  int done_gpio_crs_index[2],
+				  bool *done_active_low);
+
+int gxfp_acpi_get_hid(struct device *dev, char *buf, size_t bufsz);
+
+#endif /* __GXFP_ACPI_H */
diff --git a/drivers/misc/gxfp5130/hw/gxfp_delay.c b/drivers/misc/gxfp5130/hw/gxfp_delay.c
new file mode 100644
index 000000000..58c0e7396
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_delay.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/delay.h>
+
+#include "gxfp_delay.h"
+
+void gxfp_busy_wait_us(unsigned int us)
+{
+	if (!us)
+		return;
+	if (us <= 2000) {
+		udelay(us);
+		return;
+	}
+	usleep_range(us, us + 200);
+}
diff --git a/drivers/misc/gxfp5130/hw/gxfp_delay.h b/drivers/misc/gxfp5130/hw/gxfp_delay.h
new file mode 100644
index 000000000..7c7f7f46a
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_delay.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_DELAY_H
+#define __GXFP_DELAY_H
+
+void gxfp_busy_wait_us(unsigned int us);
+
+#endif /* __GXFP_DELAY_H */
diff --git a/drivers/misc/gxfp5130/hw/gxfp_gpio.c b/drivers/misc/gxfp5130/hw/gxfp_gpio.c
new file mode 100644
index 000000000..934e8397a
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_gpio.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+
+#include "gxfp_gpio.h"
+#include "gxfp_delay.h"
+#include "gxfp_priv.h"
+
+#define GXFP_GPIO_PULSE_HIGH_US		4000
+#define GXFP_GPIO_READ_DONE_CLEAR_DELAY_US	200
+#define GXFP_GPIO_READ_DONE_HIGH_US	50
+#define GXFP_GPIO_WRITE_DONE_FORCE_DEASSERT	true
+#define GXFP_GPIO_WRITE_DONE_PRE_US	50
+
+static inline void gxfp_gpio_pulse_delay_us(unsigned int us)
+{
+	if (us)
+		gxfp_busy_wait_us(us);
+}
+
+
+void gxfp_gpio_pulse_write_done(struct gxfp_dev *gdev)
+{
+	if (GXFP_GPIO_WRITE_DONE_FORCE_DEASSERT && gdev && gdev->hw.gpio_write_done) {
+		gpiod_set_value_cansleep(gdev->hw.gpio_write_done, 0);
+		gxfp_gpio_pulse_delay_us(GXFP_GPIO_WRITE_DONE_PRE_US);
+	}
+	gpiod_set_value_cansleep(gdev->hw.gpio_write_done, 1);
+	gxfp_gpio_pulse_delay_us(GXFP_GPIO_PULSE_HIGH_US);
+	gpiod_set_value_cansleep(gdev->hw.gpio_write_done, 0);
+
+	gxfp_gpio_pulse_delay_us(GXFP_GPIO_READ_DONE_CLEAR_DELAY_US);
+}
+
+void gxfp_gpio_pulse_read_done(struct gxfp_dev *gdev)
+{
+	gxfp_gpio_set_read_done(gdev, 1);
+	gxfp_gpio_pulse_delay_us(GXFP_GPIO_READ_DONE_HIGH_US);
+	gxfp_gpio_set_read_done(gdev, 0);
+}
+
+void gxfp_gpio_set_read_done(struct gxfp_dev *gdev, int value)
+{
+	if (!gdev || !gdev->hw.gpio_read_done)
+		return;
+
+	gpiod_set_value_cansleep(gdev->hw.gpio_read_done, value ? 1 : 0);
+
+	if (!value)
+		gxfp_gpio_pulse_delay_us(GXFP_GPIO_READ_DONE_CLEAR_DELAY_US);
+}
+
+void gxfp_gpio_force_done_deassert(struct device *dev, struct gxfp_dev *gdev)
+{
+	if (!dev || !gdev || !gdev->hw.gpio_write_done || !gdev->hw.gpio_read_done)
+		return;
+
+	gpiod_set_value_cansleep(gdev->hw.gpio_write_done, 0);
+	gpiod_set_value_cansleep(gdev->hw.gpio_read_done, 0);
+}
diff --git a/drivers/misc/gxfp5130/hw/gxfp_gpio.h b/drivers/misc/gxfp5130/hw/gxfp_gpio.h
new file mode 100644
index 000000000..a36550ccf
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_gpio.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_GPIO_H
+#define __GXFP_GPIO_H
+
+#include <linux/device.h>
+
+struct gxfp_dev;
+
+void gxfp_gpio_pulse_write_done(struct gxfp_dev *gdev);
+
+void gxfp_gpio_set_read_done(struct gxfp_dev *gdev, int value);
+
+void gxfp_gpio_pulse_read_done(struct gxfp_dev *gdev);
+
+void gxfp_gpio_force_done_deassert(struct device *dev, struct gxfp_dev *gdev);
+
+#endif /* __GXFP_GPIO_H */
diff --git a/drivers/misc/gxfp5130/hw/gxfp_mmio.c b/drivers/misc/gxfp5130/hw/gxfp_mmio.c
new file mode 100644
index 000000000..22187cd5a
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_mmio.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+
+#include "gxfp_mmio.h"
+
+int gxfp_mmio_write_qword_aligned(void __iomem *mmio, const __u8 *buf, size_t len)
+{
+	size_t i, qwords;
+
+	if (!mmio || !buf)
+		return -EINVAL;
+	if (len % 8)
+		return -EINVAL;
+
+	qwords = len / 8;
+	for (i = 0; i < qwords; i++) {
+		__u64 v;
+
+		memcpy(&v, buf + i * 8, 8);
+		writeq(v, mmio + i * 8);
+	}
+	wmb(); /* ensure all writes are visible to the device before returning */
+	return 0;
+}
+
+int gxfp_mmio_read_qword_aligned(__u8 *buf, void __iomem *mmio, size_t len)
+{
+	size_t i, qwords;
+
+	if (!mmio || !buf)
+		return -EINVAL;
+	if (len % 8)
+		return -EINVAL;
+
+	qwords = len / 8;
+	for (i = 0; i < qwords; i++) {
+		__u64 v = readq(mmio + i * 8);
+
+		memcpy(buf + i * 8, &v, 8);
+	}
+	rmb(); /* ensure all reads are complete before caller processes data */
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/hw/gxfp_mmio.h b/drivers/misc/gxfp5130/hw/gxfp_mmio.h
new file mode 100644
index 000000000..b701682a9
--- /dev/null
+++ b/drivers/misc/gxfp5130/hw/gxfp_mmio.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_MMIO_H
+#define __GXFP_MMIO_H
+
+#include <linux/types.h>
+
+int gxfp_mmio_write_qword_aligned(void __iomem *mmio, const __u8 *buf, size_t len);
+int gxfp_mmio_read_qword_aligned(__u8 *buf, void __iomem *mmio, size_t len);
+
+#endif /* __GXFP_MMIO_H */
diff --git a/drivers/misc/gxfp5130/include/gxfp_constants.h b/drivers/misc/gxfp5130/include/gxfp_constants.h
new file mode 100644
index 000000000..ff4025cd4
--- /dev/null
+++ b/drivers/misc/gxfp5130/include/gxfp_constants.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_CONSTANTS_H
+#define __GXFP_CONSTANTS_H
+
+#define GXFP_MAILBOX_MIN_SIZE		0x1000
+
+#define GXFP_READ_CHUNK_MAX		0xe00
+#define GXFP_TX_BUFFER_SIZE		0x200
+
+#define GXFP_CMD_FIRMWARE_VERSION	0xA8
+#define GXFP_CMD_TRIGGER_MCU_STATE	0xAF
+#define GXFP_CMD_QUERY_MCU_STATE	0xAE
+#define GXFP_CMD_ACK			0xB0
+#define GXFP_CMD_UPLOAD_CONFIG_MCU	0x90
+#define GXFP_CMD_NOTIFY_POWER_STATE	0x0E
+#define GXFP_CMD_PROTOCOL_INIT		0x01
+#define GXFP_CMD_SLEEP_CLEANUP		0xD2
+#define GXFP_CMD_RESET_DEVICE		0xA1
+#define GXFP_CMD_TLS_UNLOCK		0xD4
+
+#define GXFP_MAX_VERSION_RAW		512
+#define GXFP_MAX_VERSION_ASCII      32
+#define GXFP_MAX_MCU_STATE_PAYLOAD	256
+
+#define GXFP_DEFAULT_RETRY_COUNT	8
+#define GXFP_DEFAULT_TIMEOUT_US	15000
+#define GXFP_RESET_DELAY_US		200000
+
+#define GXFP_FRAME_ALIGNMENT		8
+
+#define GXFP_MP_TYPE_A		0xAu
+#define GXFP_MP_TYPE_B		0xBu
+#define GXFP_MP_TYPE_C		0xCu
+
+#define GXFP_ESPI_WRAPPER_MAGIC	0xF0
+#define GXFP_ESPI_SEQ16_INIT		0x8881
+
+#endif /* __GXFP_CONSTANTS_H */
diff --git a/drivers/misc/gxfp5130/include/gxfp_priv.h b/drivers/misc/gxfp5130/include/gxfp_priv.h
new file mode 100644
index 000000000..71c6d8332
--- /dev/null
+++ b/drivers/misc/gxfp5130/include/gxfp_priv.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_PRIV_H
+#define __GXFP_PRIV_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/miscdevice.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+struct gxfp_dev {
+	struct device *dev;
+
+	struct mutex lock;
+	atomic_t mailbox_seq16;
+
+	struct {
+		void __iomem *mailbox_mmio;
+		resource_size_t mailbox_size;
+
+		struct gpio_desc *gpio_write_done;
+		struct gpio_desc *gpio_read_done;
+		struct gpio_desc *gpio_irq;
+		int irq;
+	} hw;
+
+	struct {
+		__u8 *rx_buf;
+		size_t rx_cap;
+		__u8 *rx_tmp;
+
+		bool assem_active;
+		size_t assem_total;
+		size_t assem_copied;
+	} irq;
+
+	struct {
+		struct miscdevice miscdev;
+		bool misc_registered;
+
+		struct mutex rxq_mutex;
+		spinlock_t rxq_lock;
+		wait_queue_head_t rxq_wq;
+		struct kfifo rxq_fifo; /* bytes: [tap_hdr][payload][tap_hdr][payload]... */
+		bool rxq_inited;
+		bool rxq_reader_open;
+	} uapi;
+
+};
+
+#endif /* __GXFP_PRIV_H */
diff --git a/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.c b/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.c
new file mode 100644
index 000000000..03a30cd6d
--- /dev/null
+++ b/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "gxfp_goodix_proto.h"
+
+bool gxfp_parse_goodix_body(const __u8 *buf, size_t buf_len,
+			    struct gxfp_frame_parsed *out)
+{
+	size_t need;
+	__u16 decl_len, payload_len;
+	__u8 cmd;
+	__u8 proto_ck;
+
+	if (!out || !buf || buf_len < 4)
+		return false;
+	memset(out, 0, sizeof(*out));
+
+	cmd = buf[0];
+	decl_len = (__u16)buf[1] | ((__u16)buf[2] << 8);
+	if (decl_len < 1)
+		return false;
+	payload_len = (__u16)(decl_len - 1);
+
+	need = 3u + (size_t)payload_len + 1u;
+	if (need > buf_len)
+		return false;
+
+	out->cmd = cmd;
+	out->decl_len = decl_len;
+	out->payload = &buf[3];
+	out->payload_len = payload_len;
+	proto_ck = buf[3 + payload_len];
+	out->proto_checksum = proto_ck;
+	out->proto_checksum_ok =
+		(gxfp_goodix_proto_checksum(cmd, decl_len, out->payload, payload_len) == proto_ck);
+	out->valid = true;
+
+	return true;
+}
+
+__u8 gxfp_goodix_proto_checksum(__u8 cmd, __u16 decl_len,
+				const __u8 *payload, size_t payload_len)
+{
+	__u32 sum = (__u32)cmd + (__u32)(decl_len & 0xff) + (__u32)((decl_len >> 8) & 0xff);
+	size_t i;
+
+	for (i = 0; i < payload_len; i++)
+		sum += (__u32)payload[i];
+
+	return (__u8)(0xaa - (__u8)sum);
+}
+
+int gxfp_goodix_build_frame(__u8 cmd,
+			   const __u8 *payload,
+			   size_t payload_len,
+			   __u8 *out,
+			   size_t out_cap)
+{
+	__u16 decl_len;
+	size_t total;
+
+	if (!out || out_cap < 4)
+		return -EINVAL;
+	if (payload_len && !payload)
+		return -EINVAL;
+	if (payload_len > GXFP_GOODIX_PAYLOAD_U16_MAX)
+		return -EOVERFLOW;
+
+	decl_len = (__u16)(1u + payload_len);
+	total = 1u + 2u + payload_len + 1u;
+	if (total > out_cap)
+		return -EMSGSIZE;
+
+	out[0] = cmd;
+	out[1] = (__u8)(decl_len & 0xff);
+	out[2] = (__u8)((decl_len >> 8) & 0xff);
+	if (payload_len)
+		memcpy(&out[3], payload, payload_len);
+	out[3 + payload_len] = gxfp_goodix_proto_checksum(cmd, decl_len, payload, payload_len);
+
+	return (int)total;
+}
diff --git a/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.h b/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.h
new file mode 100644
index 000000000..4bbee6f79
--- /dev/null
+++ b/drivers/misc/gxfp5130/proto/gxfp_goodix_proto.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_GOODIX_PROTO_H
+#define __GXFP_GOODIX_PROTO_H
+
+#include <linux/types.h>
+
+#define GXFP_GOODIX_PAYLOAD_U16_MAX 0xFF00u
+
+struct gxfp_frame_parsed {
+	bool valid;
+	bool proto_checksum_ok;
+	__u8 cmd;
+	__u16 decl_len;
+	const __u8 *payload;
+	__u16 payload_len;
+	__u8 proto_checksum;
+};
+
+bool gxfp_parse_goodix_body(const __u8 *buf, size_t buf_len,
+			    struct gxfp_frame_parsed *out);
+
+__u8 gxfp_goodix_proto_checksum(__u8 cmd, __u16 decl_len,
+				const __u8 *payload, size_t payload_len);
+
+int gxfp_goodix_build_frame(__u8 cmd,
+			   const __u8 *payload,
+			   size_t payload_len,
+			   __u8 *out,
+			   size_t out_cap);
+
+#endif /* __GXFP_GOODIX_PROTO_H */
diff --git a/drivers/misc/gxfp5130/proto/gxfp_mp_proto.c b/drivers/misc/gxfp5130/proto/gxfp_mp_proto.c
new file mode 100644
index 000000000..19fa44e36
--- /dev/null
+++ b/drivers/misc/gxfp5130/proto/gxfp_mp_proto.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "gxfp_mp_proto.h"
+#include "gxfp_constants.h"
+
+bool gxfp_parse_mp_frame(const __u8 *buf, size_t buf_len,
+			 struct gxfp_mp_frame_parsed *out)
+{
+	__u16 mp_len = 0;
+	size_t total;
+
+	if (!out || !buf || buf_len < 4)
+		return false;
+	memset(out, 0, sizeof(*out));
+
+	if (!gxfp_check_mp_head(buf, 4, &mp_len))
+		return false;
+
+	total = 4u + (size_t)mp_len;
+	if (total > buf_len)
+		return false;
+
+	out->flags = buf[0];
+	out->payload_len = mp_len;
+	out->payload = &buf[4];
+	out->valid = true;
+	return true;
+}
+
+bool gxfp_check_mp_head(const __u8 *buf, size_t buf_len, __u16 *out_mp_len)
+{
+	__u8 flags, type, ck_expect;
+	__u16 mp_len;
+
+	if (out_mp_len)
+		*out_mp_len = 0;
+	if (!buf || buf_len < 4)
+		return false;
+
+	flags = buf[0];
+	type = flags >> 4;
+	if (type != GXFP_MP_TYPE_A &&
+	    type != GXFP_MP_TYPE_B &&
+	    type != GXFP_MP_TYPE_C)
+		return false;
+
+	mp_len = (__u16)buf[1] | ((__u16)buf[2] << 8);
+	if (mp_len >= (__u16)GXFP_GOODIX_MP_LEN_MAX)
+		return false;
+
+	ck_expect = (__u8)(flags + buf[1] + buf[2]);
+	if (buf[3] != ck_expect)
+		return false;
+
+	if (out_mp_len)
+		*out_mp_len = mp_len;
+	return true;
+}
+
+int gxfp_mp_build_frame(__u8 mp_type,
+			const __u8 *payload,
+			size_t payload_len,
+			__u8 *out,
+			size_t out_cap)
+{
+	__u8 flags;
+	__u16 mp_len;
+	size_t total;
+
+	if (!out || out_cap < 4)
+		return -EINVAL;
+	if (payload_len && !payload)
+		return -EINVAL;
+	if (payload_len > GXFP_GOODIX_MP_LEN_MAX)
+		return -EOVERFLOW;
+	if (mp_type != GXFP_MP_TYPE_A && mp_type != GXFP_MP_TYPE_B && mp_type != GXFP_MP_TYPE_C)
+		return -EINVAL;
+
+	mp_len = (__u16)payload_len;
+	total = 4u + payload_len;
+	if (total > out_cap)
+		return -EMSGSIZE;
+
+	flags = (__u8)(mp_type << 4);
+	out[0] = flags;
+	out[1] = (__u8)(mp_len & 0xff);
+	out[2] = (__u8)((mp_len >> 8) & 0xff);
+	out[3] = (__u8)(out[0] + out[1] + out[2]);
+	if (payload_len)
+		memcpy(&out[4], payload, payload_len);
+
+	return (int)total;
+}
diff --git a/drivers/misc/gxfp5130/proto/gxfp_mp_proto.h b/drivers/misc/gxfp5130/proto/gxfp_mp_proto.h
new file mode 100644
index 000000000..9773c09be
--- /dev/null
+++ b/drivers/misc/gxfp5130/proto/gxfp_mp_proto.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_MP_PROTO_H
+#define __GXFP_MP_PROTO_H
+
+#include <linux/types.h>
+
+#define GXFP_GOODIX_MP_LEN_MAX 0x6c00u
+
+struct gxfp_mp_frame_parsed {
+	bool valid;
+	__u8 flags;
+	__u16 payload_len;
+	const __u8 *payload;
+};
+
+bool gxfp_parse_mp_frame(const __u8 *buf, size_t buf_len,
+			 struct gxfp_mp_frame_parsed *out);
+
+bool gxfp_check_mp_head(const __u8 *buf, size_t buf_len, __u16 *out_mp_len);
+
+int gxfp_mp_build_frame(__u8 mp_type,
+			const __u8 *payload,
+			size_t payload_len,
+			__u8 *out,
+			size_t out_cap);
+
+#endif /* __GXFP_MP_PROTO_H */
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_common.c b/drivers/misc/gxfp5130/transport/gxfp_espi_common.c
new file mode 100644
index 000000000..fd93a2d86
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_common.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/unaligned.h>
+
+#include "gxfp_espi_common.h"
+#include "gxfp_priv.h"
+#include "../hw/gxfp_mmio.h"
+#include "../proto/gxfp_mp_proto.h"
+
+void gxfp_espi_irq_assem_reset(struct gxfp_dev *gdev)
+{
+	gdev->irq.assem_active = false;
+	gdev->irq.assem_total = 0;
+	gdev->irq.assem_copied = 0;
+}
+
+int gxfp_espi_rx_read_window(struct gxfp_dev *gdev, __u8 *dst)
+{
+	int ret;
+
+	ret = gxfp_mmio_read_qword_aligned(dst,
+				   gdev->hw.mailbox_mmio + GXFP_ESPI_RX_OFF,
+				   (size_t)GXFP_ESPI_CHUNK_MAX);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+void gxfp_espi_rx_chunk_calc(size_t remain,
+			     size_t *chunk,
+			     size_t *pad,
+			     size_t *do_read)
+{
+	*chunk = min_t(size_t, remain, (size_t)GXFP_ESPI_CHUNK_MAX);
+	*pad = (GXFP_ESPI_ALIGN - (*chunk & (GXFP_ESPI_ALIGN - 1))) &
+	       (GXFP_ESPI_ALIGN - 1);
+	if (do_read)
+		*do_read = *chunk + *pad;
+}
+
+int gxfp_espi_rx_start_packet(struct gxfp_dev *gdev,
+			      __u8 *rx_buf,
+			      size_t rx_cap,
+			      bool validate_head,
+			      size_t *out_total,
+			      size_t *out_first_chunk)
+{
+	size_t total;
+	__u16 mp_len = 0;
+	int ret;
+
+	ret = gxfp_espi_rx_read_window(gdev, rx_buf);
+	if (ret)
+		return ret;
+
+	if (validate_head) {
+		if (!gxfp_check_mp_head(rx_buf, 4, &mp_len)) {
+			dev_warn_ratelimited(gdev->dev,
+				"ESPI RX: bad package head (gxfp_check_mp_head failed)\n");
+			return -EBADMSG;
+		}
+	} else {
+		mp_len = get_unaligned_le16(rx_buf + 1);
+	}
+
+	total = 4u + (size_t)mp_len;
+	if (total == 0 || total > rx_cap)
+		return -EMSGSIZE;
+
+	if (out_total)
+		*out_total = total;
+	if (out_first_chunk)
+		*out_first_chunk = min_t(size_t, total, (size_t)GXFP_ESPI_CHUNK_MAX);
+
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_common.h b/drivers/misc/gxfp5130/transport/gxfp_espi_common.h
new file mode 100644
index 000000000..75607c478
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_common.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_ESPI_COMMON_H
+#define __GXFP_ESPI_COMMON_H
+
+#include <linux/types.h>
+#include "../include/gxfp_constants.h"
+
+struct gxfp_dev;
+
+#define GXFP_ESPI_RX_OFF         0x200
+#define GXFP_ESPI_CHUNK_MAX      GXFP_READ_CHUNK_MAX
+#define GXFP_ESPI_ALIGN          GXFP_FRAME_ALIGNMENT
+
+void gxfp_espi_irq_assem_reset(struct gxfp_dev *gdev);
+int gxfp_espi_rx_read_window(struct gxfp_dev *gdev, __u8 *dst);
+void gxfp_espi_rx_chunk_calc(size_t remain,
+			     size_t *chunk,
+			     size_t *pad,
+			     size_t *do_read);
+int gxfp_espi_rx_start_packet(struct gxfp_dev *gdev,
+			      __u8 *rx_buf,
+			      size_t rx_cap,
+			      bool validate_head,
+			      size_t *out_total,
+			      size_t *out_first_chunk);
+
+#endif /* __GXFP_ESPI_COMMON_H */
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.c b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.c
new file mode 100644
index 000000000..43c424366
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/errno.h>
+#include <linux/string.h>
+
+#include "gxfp_espi_common.h"
+#include "gxfp_espi_rx_irq.h"
+#include "gxfp_priv.h"
+#include "../hw/gxfp_gpio.h"
+
+int gxfp_espi_irq_read_step(struct gxfp_dev *gdev,
+			    __u8 *rx_buf,
+			    size_t rx_cap,
+			    size_t *out_rx_len,
+			    bool *complete)
+{
+	int ret;
+	size_t total;
+	size_t first_chunk;
+	size_t copied;
+
+	if (complete)
+		*complete = false;
+	if (out_rx_len)
+		*out_rx_len = 0;
+
+	if (!gdev || !rx_buf || rx_cap < GXFP_ESPI_CHUNK_MAX)
+		return -EINVAL;
+	if (!gdev->hw.mailbox_mmio)
+		return -ENODEV;
+	if (gdev->hw.mailbox_size < GXFP_ESPI_RX_OFF + GXFP_ESPI_CHUNK_MAX)
+		return -ENODEV;
+
+	if (!gdev->irq.assem_active) {
+		ret = gxfp_espi_rx_start_packet(gdev, rx_buf, rx_cap, true,
+					      &total, &first_chunk);
+		if (ret) {
+			gxfp_espi_irq_assem_reset(gdev);
+			return ret;
+		}
+
+		gdev->irq.assem_total = total;
+		gdev->irq.assem_copied = first_chunk;
+		gdev->irq.assem_active = true;
+
+		copied = gdev->irq.assem_copied;
+		if (copied >= total) {
+			gxfp_gpio_set_read_done(gdev, 1);
+			gxfp_espi_irq_assem_reset(gdev);
+			if (complete)
+				*complete = true;
+			if (out_rx_len)
+				*out_rx_len = total;
+			return 0;
+		}
+
+		gxfp_gpio_pulse_read_done(gdev);
+		if (out_rx_len)
+			*out_rx_len = copied;
+		return 0;
+	}
+
+	total = gdev->irq.assem_total;
+	copied = gdev->irq.assem_copied;
+	if (total == 0 || copied == 0 || copied > rx_cap) {
+		gxfp_espi_irq_assem_reset(gdev);
+		return -EINVAL;
+	}
+
+	{
+		size_t remain = (copied < total) ? (total - copied) : 0;
+		size_t chunk;
+		size_t pad;
+		__u8 *tmp = gdev->irq.rx_tmp;
+
+		gxfp_espi_rx_chunk_calc(remain, &chunk, &pad, NULL);
+		if (chunk == 0) {
+			gxfp_espi_irq_assem_reset(gdev);
+			if (complete)
+				*complete = true;
+			if (out_rx_len)
+				*out_rx_len = total;
+			return 0;
+		}
+
+		if (copied + chunk > rx_cap) {
+			gxfp_espi_irq_assem_reset(gdev);
+			return -EMSGSIZE;
+		}
+
+		if (!tmp) {
+			gxfp_espi_irq_assem_reset(gdev);
+			return -ENODEV;
+		}
+
+		ret = gxfp_espi_rx_read_window(gdev, tmp);
+		if (ret) {
+			gxfp_espi_irq_assem_reset(gdev);
+			return ret;
+		}
+
+		memcpy(rx_buf + copied, tmp, chunk);
+		copied += chunk;
+		gdev->irq.assem_copied = copied;
+	}
+
+	if (copied < total) {
+		gxfp_gpio_pulse_read_done(gdev);
+		if (out_rx_len)
+			*out_rx_len = copied;
+		return 0;
+	}
+
+	gxfp_gpio_set_read_done(gdev, 1);
+	gxfp_espi_irq_assem_reset(gdev);
+	if (complete)
+		*complete = true;
+	if (out_rx_len)
+		*out_rx_len = total;
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.h b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.h
new file mode 100644
index 000000000..98ef1fc18
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_irq.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_ESPI_RX_IRQ_H
+#define __GXFP_ESPI_RX_IRQ_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+
+int gxfp_espi_irq_read_step(struct gxfp_dev *gdev,
+			    __u8 *rx_buf,
+			    size_t rx_cap,
+			    size_t *out_rx_len,
+			    bool *complete);
+
+#endif /* __GXFP_ESPI_RX_IRQ_H */
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.c b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.c
new file mode 100644
index 000000000..5afb6e358
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/minmax.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "gxfp_espi_common.h"
+#include "gxfp_espi_rx_sync.h"
+#include "gxfp_priv.h"
+#include "../hw/gxfp_delay.h"
+#include "../hw/gxfp_gpio.h"
+#include "gxfp_constants.h"
+
+static int gxfp_espi_read_assemble(struct gxfp_dev *gdev,
+				    __u8 *dst,
+				    size_t dst_cap,
+				    size_t *out_len)
+{
+	size_t total;
+	size_t first_chunk;
+	size_t off;
+	int ret;
+
+	if (!gdev || !dst || dst_cap < GXFP_ESPI_CHUNK_MAX)
+		return -EINVAL;
+	if (!gdev->hw.mailbox_mmio)
+		return -ENODEV;
+	if (gdev->hw.mailbox_size < GXFP_ESPI_RX_OFF + GXFP_ESPI_CHUNK_MAX)
+		return -ENODEV;
+
+	memset(dst, 0, dst_cap);
+
+	ret = gxfp_espi_rx_start_packet(gdev, dst, dst_cap, false,
+				      &total, &first_chunk);
+	if (ret)
+		return ret;
+
+	dev_dbg(gdev->dev, "ESPI RX: first=%u total=%zu (mp_len=%u) head16=%*ph\n",
+		 GXFP_ESPI_CHUNK_MAX, total,
+		 (unsigned int)get_unaligned_le16(dst + 1), 16, dst);
+	off = first_chunk;
+
+	while (off < total) {
+		size_t remain = total - off;
+		size_t chunk;
+		size_t pad;
+		__u8 *tmp = gdev->irq.rx_tmp;
+
+		gxfp_espi_rx_chunk_calc(remain, &chunk, &pad, NULL);
+
+		dev_dbg(gdev->dev,
+			"ESPI RX: off=%zu remain=%zu chunk=%zu pad=%zu\n",
+			off, remain, chunk, pad);
+
+		if (!tmp)
+			return -ENODEV;
+
+		if (off + chunk > dst_cap)
+			return -EMSGSIZE;
+
+		ret = gxfp_espi_rx_read_window(gdev, tmp);
+		if (ret)
+			return ret;
+
+		memcpy(dst + off, tmp, chunk);
+
+		off += chunk;
+
+		if (off < total) {
+			gxfp_gpio_pulse_read_done(gdev);
+			gxfp_busy_wait_us(GXFP_DEFAULT_TIMEOUT_US);
+		}
+	}
+
+	gxfp_gpio_pulse_read_done(gdev);
+	dev_dbg(gdev->dev, "ESPI RX: done total=%zu\n", total);
+
+	if (out_len)
+		*out_len = total;
+
+	return 0;
+}
+
+int gxfp_espi_read(struct gxfp_dev *gdev,
+		   __u8 *rx_buf,
+		   size_t rx_cap,
+		   size_t *out_rx_len)
+{
+	if (!gdev || !rx_buf || rx_cap == 0)
+		return -EINVAL;
+	if (!gdev->hw.mailbox_mmio)
+		return -ENODEV;
+
+	return gxfp_espi_read_assemble(gdev, rx_buf, rx_cap, out_rx_len);
+}
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.h b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.h
new file mode 100644
index 000000000..665f82348
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_rx_sync.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_ESPI_RX_SYNC_H
+#define __GXFP_ESPI_RX_SYNC_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+
+int gxfp_espi_read(struct gxfp_dev *gdev,
+		   __u8 *rx_buf,
+		   size_t rx_cap,
+		   size_t *out_rx_len);
+
+#endif /* __GXFP_ESPI_RX_SYNC_H */
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_tx.c b/drivers/misc/gxfp5130/transport/gxfp_espi_tx.c
new file mode 100644
index 000000000..05d67ed04
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_tx.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "gxfp_espi_tx.h"
+#include "gxfp_espi_rx_sync.h"
+#include "gxfp_espi_common.h"
+#include "gxfp_priv.h"
+#include "../hw/gxfp_delay.h"
+#include "../hw/gxfp_gpio.h"
+#include "../hw/gxfp_mmio.h"
+#include "gxfp_constants.h"
+#include "../driver/gxfp_trace.h"
+
+int gxfp_espi_xfer(struct gxfp_dev *gdev,
+		   const __u8 *mp_frame,
+		   size_t mp_frame_len,
+		   __u8 *rx_buf,
+		   size_t rx_cap,
+		   size_t *out_rx_len)
+{
+	int ret;
+
+	ret = gxfp_espi_write(gdev, mp_frame, mp_frame_len);
+	if (ret)
+		return ret;
+
+	gxfp_busy_wait_us(1000);
+
+	return gxfp_espi_read(gdev, rx_buf, rx_cap, out_rx_len);
+}
+
+int gxfp_espi_write(struct gxfp_dev *gdev,
+		    const __u8 *mp_frame,
+		    size_t mp_frame_len)
+{
+	__u8 *tx;
+	__u16 seq16;
+	size_t pad;
+	size_t tx_len;
+	int ret;
+
+	if (!gdev || !mp_frame || mp_frame_len == 0)
+		return -EINVAL;
+	if (!gdev->hw.mailbox_mmio)
+		return -ENODEV;
+
+	pad = (GXFP_ESPI_ALIGN - (mp_frame_len & (GXFP_ESPI_ALIGN - 1))) &
+	      (GXFP_ESPI_ALIGN - 1);
+	tx_len = 8 + mp_frame_len + pad;
+	if (tx_len > GXFP_TX_BUFFER_SIZE)
+		return -EOVERFLOW;
+
+	tx = kmalloc(tx_len, GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
+
+	memset(tx, 0, tx_len);
+	tx[0] = GXFP_ESPI_WRAPPER_MAGIC;
+	tx[1] = (__u8)(mp_frame_len & 0xff);
+	tx[2] = (__u8)((mp_frame_len >> 8) & 0xff);
+	tx[3] = (__u8)((tx[0] + tx[1] + tx[2]) & 0xff);
+
+	seq16 = (__u16)(atomic_inc_return(&gdev->mailbox_seq16) & 0xFFFF);
+	tx[4] = (__u8)(seq16 & 0xff);
+	tx[5] = (__u8)((seq16 >> 8) & 0xff);
+
+	memcpy(&tx[8], mp_frame, mp_frame_len);
+
+	ret = gxfp_mmio_write_qword_aligned(gdev->hw.mailbox_mmio, tx,
+					 ALIGN(tx_len, GXFP_ESPI_ALIGN));
+	gxfp_trace_logf("espi_tx rc=%d seq=0x%04x mp_len=%zu mp_head=%*ph", ret,
+		seq16, mp_frame_len, (int)min_t(size_t, 8, mp_frame_len), mp_frame);
+	if (ret) {
+		dev_err_ratelimited(gdev->dev,
+			"ESPI TX: mmio_write failed rc=%d seq16=0x%04x payload_len=%zu\n",
+			ret, seq16, mp_frame_len);
+		kfree(tx);
+		return -EIO;
+	}
+
+	kfree(tx);
+	gxfp_gpio_pulse_write_done(gdev);
+	return 0;
+}
diff --git a/drivers/misc/gxfp5130/transport/gxfp_espi_tx.h b/drivers/misc/gxfp5130/transport/gxfp_espi_tx.h
new file mode 100644
index 000000000..e1a788ab5
--- /dev/null
+++ b/drivers/misc/gxfp5130/transport/gxfp_espi_tx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GXFP_ESPI_TX_H
+#define __GXFP_ESPI_TX_H
+
+#include <linux/types.h>
+
+struct gxfp_dev;
+
+int gxfp_espi_xfer(struct gxfp_dev *gdev,
+		   const __u8 *mp_frame,
+		   size_t mp_frame_len,
+		   __u8 *rx_buf,
+		   size_t rx_cap,
+		   size_t *out_rx_len);
+
+int gxfp_espi_write(struct gxfp_dev *gdev,
+		    const __u8 *mp_frame,
+		    size_t mp_frame_len);
+
+#endif /* __GXFP_ESPI_TX_H */
-- 
2.55.0

