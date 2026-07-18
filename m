Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC758381B1A
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362478; cv=none; b=qVSQWiOJ9ean4f3l/KaCczW6wzd+UQaQXebfOCFERSL/QcmEHJuXmoNHhbt5J41SVaC3TV1sP4gLII+d2VjlIJEzK26nRG2GYYtxPSJ5//QpQdQUc5iG7vYaOfxa+mSBcqaw2vQu+3OywqrQL4JfJFl8iESvmhEtWt0sYr6Cn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362478; c=relaxed/simple;
	bh=FPYs5SDj6qjqumMg2k6zXtsnAbrUK4LVvGwGcEzDtRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ2lZqlGlgNxGmF0Iik5KzJ8IJUmZCbx4KBbFd42yyu2FwnJVOT1WuxcgFkDIbvVu9Zp5z9Zr//MUtE+7kVlgZPb1OQ5IvQ0dQQjXjTeqefuMzh34Q7e4kE4rSE4/+NVQ4YrgHeNCa7JTsJZuk599vu9K5TCEzpdKB2nVFOvza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/2eUj2b; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/2eUj2b"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493f7c4152dso1799655e9.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jul 2026 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784362475; x=1784967275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpwfRCa3QpVuvv1KidkUVHXcti0UD4UJnC6FARGoVcU=;
        b=K/2eUj2bXP4ZysoFqvFxXAPmr0NAr85xqQqqc2JculX5b5u3yfYxxprOX+cLOAYKMq
         j7KjMFf4kuESws7j/x6WuU3TXRnXFhO7fAPc1/v9Z+xxeuLrc8N1X/3ik/yuNR5/sSny
         c15ZZXbR/jmngmGT6bhvV2x6IcFYZNnX1Q6D4L1fbWEtN6fKmS07DOldwAXGlEaw0jnD
         nE3f/jwFGWJ8e0b8yVjPvJ6113m4U5JgysE27VdhQaYd6JRqxv0T7DldYcaD6vl2qO3H
         9NKnkTSBRHG3Dz2Imy/3/vJwb8MNBJGb1D3dCseRKVVaaWV6Qm4peAaVm0K+O2DwqqvS
         fX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784362475; x=1784967275;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpwfRCa3QpVuvv1KidkUVHXcti0UD4UJnC6FARGoVcU=;
        b=PQBS2j/YTT5229hVDryyaYt5L85XVdpi6FyYUpN7KkWQzhC58nDUt3konzhmSsf6nx
         8UM2XzF5Fekjnvz+fd75os/b+mF7JAP1Q3FsxZoJ2ve/kPdGJQ0p3ZNuZs1+gFkxMoc6
         vE/nvUiX5y2Ug1YQrSGYnHFHG+fKafg8hAKWBSlsiXWnfR/Ib4RrHZZ3KBzTZvABjFQe
         N5hGfh4naf9TIZIJjQsgp5BrKMH17J3hU37fypunOleosdD4wIm615lmSETQ1TFtHoGI
         Tp8O7D6EJGtCqK4v3+lUtr9HhsG0JSVChVhJS0ifZMWAmsfAwMmAdc7qvJDgRfBRoz3E
         o33g==
X-Forwarded-Encrypted: i=1; AHgh+Rr73AaK8UVzjNpaSZSds9FzfjjXRYOme75Xturs7fcbB/0zC/b1aWfCVhp0dCrLAz0utdPS7zEX149d@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtkA+9USfwrCj2NF8iIzQPE784rofoG53MVLGOiO1eo8RVhFu
	AppZF9/BmizkeA26GQiuzNKQ22TFlKJor0x5suSZVRPW2Fvpclmhl/oW2xd23bU4
X-Gm-Gg: AfdE7cn29F4mazZjzbJXdReGXOqaah4rpzCLr8JK3NVx22ZCEWeiHTYCsKIuxCXjDLR
	5PUNQycWuVNQ8NYcVncH0bNQ6ViRw7jhFobzw4neTL/YVGuf3I7G5Ccl41np6y+4yPt+YC0aGXs
	E+vhfTnH/OMKAO0oUyVO5Mxys8Fm9MO/212W0NpdssVGfbCCgwIpbwiGmbJNsjFKQandQLOAWmv
	LmY+TC9m3U9k6Nk54gn1y1R/OBf0HiP44KTU7voySVj3ZGf2cpPm8eOZWPS5Kw1fIVv5NWFZerr
	Pbl3fMOxvzC0u64RcCYYSleEqQJ+pA6ZeAhufLOu3H32uuk7bhuQ+L71VWsdzuBJXLhFh3IePdw
	lDdevsIKguQa2N20uzd/gS4atv8h4qVAoRbcHPY4JtQRdPQ8Lt/lxM22e0yU0QnbMntM1ZQhsjQ
	YFo/sfI2xg5eLU
X-Received: by 2002:a05:600c:3553:b0:495:4a33:2c34 with SMTP id 5b1f17b1804b1-4954a39955emr38675365e9.0.1784362474895;
        Sat, 18 Jul 2026 01:14:34 -0700 (PDT)
Received: from meto.local ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm73234285e9.0.2026.07.18.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:14:34 -0700 (PDT)
From: =?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	=?UTF-8?q?Metehan=20G=C3=BCnen?= <metehangnen@gmail.com>
Subject: [PATCH 1/4] include/uapi/linux: add gxfp_ioctl.h for GXFP5130 fingerprint sensor
Date: Sat, 18 Jul 2026 11:14:28 +0300
Message-ID: <20260718081431.25456-2-metehangnen@gmail.com>
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

Define the userspace ABI for the Goodix GXFP5130 eSPI fingerprint sensor
driver:

 - struct gxfp_tap_hdr: header prepended to every read(2) record, carries
   payload length, MP protocol type and a ktime_get_ns() timestamp.
 - struct gxfp_tx_pkt_hdr: header that userspace prepends to write(2)
   payloads so the driver can wrap them in the eSPI frame format.
 - GXFP_IOCTL_FLUSH_RXQ: flush the kernel-side RX record queue.

Signed-off-by: Metehan Günen <metehangnen@gmail.com>
---
 include/uapi/linux/gxfp_ioctl.h | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 include/uapi/linux/gxfp_ioctl.h

diff --git a/include/uapi/linux/gxfp_ioctl.h b/include/uapi/linux/gxfp_ioctl.h
new file mode 100644
index 000000000..c9c6c2d48
--- /dev/null
+++ b/include/uapi/linux/gxfp_ioctl.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UAPI_GXFP_IOCTL_H
+#define __UAPI_GXFP_IOCTL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GXFP_IOCTL_MAGIC 'G'
+
+/*
+ * 4-byte MP header + payload must fit GXFP_TX_BUFFER_SIZE(512).
+ */
+#define GXFP_IOCTL_TX_PAYLOAD_MAX 508u
+
+/* Maximum protocol payload bytes exported via read(2) records. */
+#define GXFP_IOCTL_TAP_PAYLOAD_MAX (128u * 1024u)
+
+/*
+ * Stream tap (read/poll) record header.
+ * Followed by `len` bytes of protocol payload.
+ */
+struct gxfp_tap_hdr {
+	__u32 len;       /* protocol payload bytes */
+	__u32 type;      /* MP type */
+	__u32 _rsvd0;
+	__u64 ts_ns;     /* ktime_get_ns() */
+	__u8 head16[16]; /* first 16 bytes of payload */
+};
+
+/*
+ * write(2) packet header.
+ * Userspace writes: [gxfp_tx_pkt_hdr][payload bytes]
+ */
+struct gxfp_tx_pkt_hdr {
+	__u8 mp_flags;
+	__u8 _pad0;
+	__u16 payload_len;
+	__u32 flags;
+};
+
+#define GXFP_IOCTL_FLUSH_RXQ _IO(GXFP_IOCTL_MAGIC, 0x11)
+
+#endif /* __UAPI_GXFP_IOCTL_H */
-- 
2.55.0

