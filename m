Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC15B1EB
	for <linux-acpi@vger.kernel.org>; Sat, 14 Mar 2026 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451933; cv=none; b=TLQTjqmlpq9xUGUsaIVEcQl0TJh0HaaIko7q3IPLdKGHXUSInU1V0z95DhgtSpDX0WPDfTlvfh/j71SRBQaSq6YSa3G2jVTK8prC/ctP8dPG/NA/05ULPKST5A9zDOVsoVRsQVSNBHdkE32Ao/N5irZfn6IGBImM6mmbg7E3Di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451933; c=relaxed/simple;
	bh=dNJvwOvtKkuRy5CJp7kfu5V0sbcA8LMVkK7KgeS0AaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9uo0k3frMFOZaJjcYW6vCbQA5s76xXq22sTcsRjoz5az1Rlqtk2f1JwbE3cRtcNd8dKKxEKzkjHRiyqEp288WQmgB8Bdiogo+i+HySG3mZT7dtN4WCCC25X7leIakFHENc6EBYFMyl4vnTwEBTD8W6usY9IRX2IxnH98u1Lqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3y/RC0Q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3y/RC0Q"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439d8df7620so2028917f8f.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773451931; x=1774056731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3d+vA9WOD1aIXWABPX3fea+gZYGZsE6ZaKFwHPcp3I=;
        b=T3y/RC0QSiLCNAODcJPUDco8nXt0Ps2Hv4BoFX9ZvOp8xtZvax0GV6+eYvmfoKFylr
         M294aq0xTu9devijqN5tNUkq05k3ZIZRZj4cMvxq7cMlAZ18qOeua47x6c+77CKaNHVr
         VyNF3QzD82MxmP+wkM43h3bXJgSyYC2jfCurzCLpmQZUTjSHH3/ZRpc9EO+KEV04Gkt3
         MY+07o/3QJmlJcesemijSQB9SUqzyOt51XV9EnCyW8xU135nL6cHJWi3qq13AXceoljz
         xWzcJqI6N7GMdM7VkNxkg8a3xSB2ySJmwJR+zPXnRjF3L4y4o6rXXu7FGo5YG8lotakD
         4CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451931; x=1774056731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3d+vA9WOD1aIXWABPX3fea+gZYGZsE6ZaKFwHPcp3I=;
        b=lH+ulUWeF/Visek48saKKpWMzVPHMztJwvo7530THDwE86GerXTtabnIxWxF2GFrKi
         nc2INC8Z2P5MnhNBGdSw7eeRVZFiNkWSKGeSwmbyAtb4wFtSM1tmlZJWq8NcvP/CisV2
         1ViHxCDYEldPtAcQrjSw4fvXpJqaFIbUqE7aZZR2eLvw+E69NU/T0CZmelB0LbxpK03e
         VybyQ5au2a3IVBxK+2Om1lSDUlrRfy2kHqDfSHIEaZcw8Q7wvRaRICf5cDIU4JsBoRUY
         1Xy882RS74dHPKkLJQGLojJcipaUEyGsPo3BblgCi/GgCyQG5x/9euaVVHIbX9sHkkQr
         5bmw==
X-Forwarded-Encrypted: i=1; AJvYcCUnP3q25AxYgmPLQSBLRye2Ix7DGrptcfNlMiismlaBKptyIrFn3N/OUXcXgXPYcj1flgHAgatVYERX@vger.kernel.org
X-Gm-Message-State: AOJu0YxdfdLrxY+JTwhTnes5KgbFZLE7rmMq1jqE9FTAsnumecFyTl4F
	ukswnzP+KURelfWidKaa7+/ruqZHQHtuO5syoTiqO3vkWbSFKSCFnbBR6AD2fSYuku4=
X-Gm-Gg: ATEYQzxZ11B8feZRgETVmhjzNlxxYgoc8KZV8DtPzK6FR1Vui2geBpwaqhqM4ulgRsK
	jC8J1ewE8gkYSjs1IUS/zT3e4y9M60wwE1jIrru0mUYrVG8SqKGq1yf0m5HwUZ3aYFq2UQkXGP7
	hbsTSZiCTyiLI0RYGJXqJT2Ho5Z/XL4p6b5gjsyinodgrL/HWu7rhpj9St6MD3wtJlwHyTLe8lh
	Y9jeksb7W42p8VQXWJgzquc2Ug6HNgQCjM9JjgTC3YOBLL0iDPex3x8fuD5uumDJQ8Y3aljMCpf
	HmK/e/UKjKdHEqSMevBnIC6plpEZnT8Ql+YoZO9w3/5j1HwWo/cGI8R+tMiuigDwL1z6wN02J9O
	hD3jFLhi17jUvcELvdbz4hbEt0f92kkiLOHvLk4utIoSxaYgYsITMK3L0g2BFUIJsiszh66o9tc
	g/wJ5MREJEqKA02WCTEwks1+srGpzEPDWSpo4Dx6gzvNoGn0nZP4Qc6E6e1VS6Btw+F2C3Vryvv
	Pn6xexuyutJZxvD7Xsa7ptwxD+/iPK+tPXCaXVsJhK0weRdc7L9CSL/edGsaja//0cxpbIZMe+w
	EWOX54pirIQ=
X-Received: by 2002:a05:600c:3b14:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-485566d5178mr83204885e9.10.1773451930625;
        Fri, 13 Mar 2026 18:32:10 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm21876575f8f.31.2026.03.13.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:32:10 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	wsa+renesas@sang-engineering.com,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH 0/2] Add UCSI I2C transport driver for ITE885x USB-C controllers
Date: Sat, 14 Mar 2026 01:31:54 +0000
Message-ID: <20260314013157.7181-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS Z690/Z790/X670E motherboards use ITE8853 (and related ITE8800-ITE8805)
USB Type-C controllers that implement UCSI over I2C. These are currently
unsupported in Linux, causing a boot error:

  i2c i2c-1: Failed to register i2c client ITE8853:00 at 0x40 (-16)

The BIOS on these boards declares two ACPI devices for the same physical
hardware at the same I2C address: a generic UCSI device (MSFT8000) and a
vendor-specific device (ITE8853). The generic device registers first during
ACPI enumeration, blocking the vendor-specific one with -EBUSY. The ITE8853
ACPI device carries the GPIO interrupt resource needed for proper operation,
while MSFT8000 does not.

Patch 1 fixes the i2c ACPI enumeration to skip known generic devices when a
vendor-specific sibling exists at the same address. This is a general fix
that could benefit other platforms with the same BIOS pattern.

Patch 2 adds the ITE885x UCSI transport driver, modeled after ucsi_stm32g0.c.
The only device-specific quirk is that PPM_RESET is handled internally by the
ITE8853 and must not be sent over I2C.

Tested on ASUS ROG Strix Z790-E Gaming WiFi:
  - Boot error eliminated
  - /sys/class/typec/port0 registered successfully
  - UCSI commands complete within one polling cycle (~50ms)
  - USB-C device attach/detach detected with partner enumeration
  - USB Power Delivery negotiation functional
  - SuperSpeed Plus Gen 2x1 devices operational through UCSI-managed port

No MAINTAINERS entry is added as the driver falls under the existing
USB TYPEC UCSI section. Happy to add one if preferred.

Edward Blair (2):
  i2c: acpi: skip generic I2C device when vendor-specific sibling exists
  usb: typec: ucsi: add ITE885x I2C transport driver

 drivers/i2c/i2c-core-acpi.c       |  88 +++++++++
 drivers/usb/typec/ucsi/Kconfig    |  11 ++
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 285 ++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c

-- 
2.53.0

