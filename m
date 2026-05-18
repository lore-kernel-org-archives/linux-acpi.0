Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D33E0724
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090846; cv=none; b=pdOyE8aDd7TxuEcPK71xjdVoLHgWtKu4dJDcM4supHohg5q4I90Pt3Hy7TlW3Nuk+D0yNRIH7n8+vhiUFL+yE6rwx2ssn5LeREkry8BXj9WjGK1T3qf+nLZkSl3is/siuxIj4wpV8ul4au7c3ntr3L4sqaivL7n19n+6RyGC61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090846; c=relaxed/simple;
	bh=WCFTNgalPCyI+sy9RLNEoFvhiBqK+HERYFo0HvPnOpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bd8KSB3s/KthZgYm/0Pe9EwDdE8ucndsgfng/SGh/gayjMxxmfqTD3PFE5mCk6H35cKxYX/VZm0kp0y3F4uE7+XMQbdOQRMqZZHsrbsWDLCR/lcpdyP7skGbBX8HkYZvj4FdAAfA0rdlqO1DVNSdTU2SF2EBza743IlMQbR539E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH20tHFE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH20tHFE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso13669965e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090840; x=1779695640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OpOy3ncayuyh97YCAToNo+s6kNuDC2GipWRHQoTk0xw=;
        b=JH20tHFEV00Yx/cCfHiu0iQPTpn0aoSeGxMlp4Qc2H6jYOVh7TpV1UHjSlpSdYWo2j
         VG30uqWmVlAVDXK6PR2hzvUlueeynEL+cH48qgHZiA0UJM43zvjiIUSWQhCh2yL3YolU
         hMy/7KX7TYvazNHfLhREDoARVi6N2qHg+VtWfE/djbTtv69jkImzYMu+QcZPRTO20Lpb
         cgCd/aYECIpv/wVh1fDschzSMq3m97+pMYgGpuovHFbC7kDvfxx/hbIqd3W+E7NdEExu
         9s3vQxy2+fYh0G/APyvRm360fFCD60ibX7/sDHzSNXv4KnDPLuveE4p9H8QhIh+XymVr
         8QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090840; x=1779695640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpOy3ncayuyh97YCAToNo+s6kNuDC2GipWRHQoTk0xw=;
        b=EUUPV4xd7w1Vr/Sx5e7vT5XPg465g//C5l5J5lAItb+Fenn485H2ONnNrWS7Wgn8uq
         1qcD0b6vbf6a+gkgbrz5+nLr4isqcdgEZrlyYNAgvGUaF5SpTv0aPDk7af4pxgnbJUeL
         gyRwgB9B8f/XTxPEfLuks7224dIyMUrhvJLCL7zSws+9sYrtdzvCZAyEZuAPMYT4P4Mo
         7J897ICKiIgQi605GpY8LPZfgwW6AsucB9XdrCH3hFoYNpA0vWHLgOoFP54a1Qrw0UMl
         mPMKTOcY1EwVHO0RrX3GOOfMivhNG4T35vg71kxaa8qwScUmA3Yotm7z9jC/qf8n5DoX
         1KjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V+vn4plC5zuAXEPiLn6MFjx9S7vAwd1RI1Nen7e6U2ff+aOUtQbrxhJ4RXSVfI0q7ciw/4LzfEjhM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxowa4dFaKpLai0NP1YiCSqVZLucgRh35GQ/xosUnjZ4rOHBGg/
	fDM/+VR/ev1eYWNu4N99F0Vn76mrT8EChKnb24DYKRL446RbUCDRSYyy
X-Gm-Gg: Acq92OGwWIT6Ei0oe+JnRYquJD1QsTJBqf/qE3/lIv96lP7ALm+NG/Q3EmAI/rJSp+x
	5I+ES1O70QyS2F699d3WB/vYqs4H0LefY8MEoMtkvJJRglCTKu4fu88CnvB3i0aK77f3ctRBG5T
	m2Hxe72YOYp+c8NuOB4lPoC9mfbitmHskscO6BK8lIdoBimE3lTJXVRdy1+oHGYMiRHaG+HFKzk
	m8FhsuZTBhCaoZaz7a6PSBhADkAHfs2plyk7rjtz2wdtZD2PiS3VDmYPcXwnEBHjTdfn4pKocmJ
	bOQ45oGLRSDggEG2oX9CmbDzJ22cVJrBYNarD5VxagFxG6U62ORccq8sDzRmLyv7yMEODdXf5jw
	dDc2uH4AMbQv7PRD4PTHuGq2CNTq0rFiGRMQAEbNurV9UGA3hf7FZsS+Z1fjJ656B6QEmgUKgkJ
	SyHMNYs6HfT6Ul9Tk=
X-Received: by 2002:a05:600c:4f8a:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48fe62f8c6bmr210573225e9.24.1779090840303;
        Mon, 18 May 2026 00:54:00 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:53:59 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 00/12] gpiolib: acpi: Refactor, harden, and modularize ACPI GPIO support
Date: Mon, 18 May 2026 09:53:45 +0200
Message-ID: <20260518075357.112584-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good morning everyone,

This patch series took fairly a bit of time because, well, it ended up going a "bit"
out of hand. It improves style, robustness, resource safety, and modularity
of the ACPI GPIO subsystem. The massive gpiolib-acpi-core.c driver (previously
well over 1400 lines) has been significantly refactored, reducing its footprint
by separating concerns into distinct, dedicated modules for ACPI Operation Region
handling and ACPI Event/Interrupt processing.

Key changes and structure of the series:
1. Hardening & Correctness (Patches 1-4):
   - Style adjustments to match Linux Kernel coding standard.
   - Modernized parsing in quirks using standard sysfs/kstrto helpers.
   - Added robust bounds checking for ACPI GPIO resource pin ranges.
   - Fixed a critical memory resource leak in the OpRegion cleanup path.

2. ACPI Operation Region Modularization (Patches 5-9):
   - Declared shared data structures in the local header.
   - Exposed private-to-core registration helpers by making them non-static.
   - Extracted Operation Region handling logic to gpiolib-acpi-opregion.c.
   - Diverted callback registration to the new OpRegion module.
   - Removed the unused static emulation handlers from the core driver.

3. ACPI Event & Interrupt Handling Modularization (Patches 10-12):
   - Declared shared helper prototypes in the local header.
   - Extracted Event/Interrupt logic to gpiolib-acpi-events.c.
   - Fully decoupled static event handlers and event structures from the core.

Build correctness and functional behavior were validated on x86 virtual
platforms using virtme-ng under KASAN and kmemleak with successful boot,
execution, and zero resource leaks.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>

Marco Scardovi (scardracs) (12):
  gpiolib: acpi: Fix style and formatting issues in core
  gpiolib: acpi: Modernize string parsing in quirks layer
  gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
  gpiolib: acpi: Fix resource leak in OpRegion cleanup path
  gpiolib: acpi: Declare shared structures in gpiolib-acpi.h
  gpiolib: acpi: Expose core GPIO resource and OpRegion helpers
  gpiolib: acpi: Add dedicated Operation Region module
  gpiolib: acpi: Divert OpRegion registration callbacks from core
  gpiolib: acpi: Remove unused static address space emulation from core
  gpiolib: acpi: Declare shared event helpers in gpiolib-acpi.h
  gpiolib: acpi: Add dedicated ACPI GPIO events module
  gpiolib: acpi: Decouple Event and Interrupt handling from core

 drivers/gpio/Makefile                |   2 +-
 drivers/gpio/gpiolib-acpi-core.c     | 488 +--------------------------
 drivers/gpio/gpiolib-acpi-events.c   | 309 +++++++++++++++++
 drivers/gpio/gpiolib-acpi-opregion.c | 175 ++++++++++
 drivers/gpio/gpiolib-acpi-quirks.c   |  23 +-
 drivers/gpio/gpiolib-acpi.h          |  50 ++-
 6 files changed, 561 insertions(+), 486 deletions(-)
 create mode 100644 drivers/gpio/gpiolib-acpi-events.c
 create mode 100644 drivers/gpio/gpiolib-acpi-opregion.c

-- 
2.54.0

