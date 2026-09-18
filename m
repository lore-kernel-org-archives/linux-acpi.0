Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD23D9041
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710080; cv=none; b=UUg9oVJHaMZtxTKSZQmEnosbRgm9CGfnvIF7M267MLnpSfmX0/gMWEc1gExyPuZjAjBFjEeD7vo9xMBJjWILj8uqPDCfx4h0er0Odpx5LIbchIa4KW3G5HGRBprNcI8O1wNpyB5j1QnvPsXYTUymRaXxlgI6NREDRLEhVUyVBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710080; c=relaxed/simple;
	bh=VA1iZkpKLsP31AptUWmjVmN+0ut8zSXRATtnPZO5bjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJynmhra9luqTeZHJJi3Q9x7fEi+yxn6+9RpNbs+bLyt2nTzBRrZ80keP1T1mVySRRzWl/U+fsnxjahMl9oS7Nvmw12L8do9Fhsn0dYccDQdTidZtfi+1dXodeAsROd7mO0sCt+4aWImAQIO4tgJeEsgpemDggvNNri3naByBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQOs0xee; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQOs0xee"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so120071b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Sep 2026 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789710077; x=1790314877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JFMkuW0Bqe7MVkCpNYHYvmJJeyYJ8ubSGhbpI1Nwdj0=;
        b=pQOs0xeeplTsdlCs4nqBh52mX4XwZCVu/DSRCWtN9tOeEAjxnPB2ucx7EycFUpYjFf
         dJPdcD5xr/ZPz9mWgUycdW3sf1lbiNm1A6tbDQB+QidqFjtkQvQdis6PM0QjiUAtuazD
         ka18pVdNGVoRxxp1GVoPJ67lMATCnNJdAxuF20HWtRTcbF0dIljt3t9zvg4INWD1OxpD
         aXfYOWW3wYqMTzSvWxWPmtxVPVlbufHYkcimonNcN9s3rx0+Wxe6lBmif4+wZjvi3GYC
         zG+DKcVC9jsVUsMTU42rzhkoqYZq9SEyzgikB+5JjYeeevvnAnGKfGUiq1l4IG9Z++ET
         Tfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789710077; x=1790314877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFMkuW0Bqe7MVkCpNYHYvmJJeyYJ8ubSGhbpI1Nwdj0=;
        b=OTs59aSdqIYVrBZHaiJ3pZynAN7Ggd+hfr9d4HXJfeQdTY97JUdlGRchDdX3naNtdM
         j43OV0zisHsYRw++sucxioG/Rur+MF6YdhwACtWvYZh7cQJ9gqafi1pggQ2GKKX1/UPS
         dC5jcJZq7bmDSanfAwFDA23IhAvV49L4fsnE2+vIHvv7BweYdQnBZta/CNikILGtGfu+
         2+E+6wnAXxfob1Y5R/7mlEl1V0DC/XQqY+d/7Vxp3fYGd/R9V8KYpMpic5/9yNkRql1C
         f13o3k57NmUCBsmMX+LLR9Ncfv3v5e7Er7H11uy7igegx7dRLB4OPN25xrLn7hYWC4K/
         mz7g==
X-Forwarded-Encrypted: i=1; AKwUvBw8ZrIoMq1//UzRh8PfrKfNGKnaLNZlbMBBBO7TlEOiTPxXpMIrc/S2ijesdqJ8oUz8VwJ/ru9iyjNt@vger.kernel.org
X-Gm-Message-State: AFuF++kNmS7w3S9F7LMqqjXsidaN7/p9F826/cgeSxx3pRdZr/22QoUG
	A5iUPsBSHBPje7WkubmluDKT5q8HMpeZx5DJOo6X0LRQRDPhyHmKHvnn
X-Gm-Gg: AYBFou1hmF/VXLHsqvfKUQRhr+YY9ZqJ3bd9aLZ/vmTXzJ1a2kO6rrOloOIwEkBjI+w
	UUPC3wFHJfv8+VQxbLs+3lJz8RtbE/jUp4LW0+s6EwMN5D1bxqx9/YC9GYY2cYfGXJPRM5ts3iI
	cwQ+GNBGWOADoGT2uTmLK8Nfn9PB5S0wmkesBlvpXKmmoXNFtAsIFCpGQoMEduEL300PJeKXdiK
	P1GosA8aFViCsRqDkla4JqJHaVOr5DqblQeKgvw7n2HRL5IT0k8ev4Tj9I6jIMXOqOAgREXovCZ
	NE8mA5p4iUI+d9U32N119lJT71lre59Z37MUbUE2nUzHzg6qxhAozDTAmMEM5Yyr65yg/g3DhnH
	Ck6Oq1nCtlCwBfSx3nUBDCPBHnDSyg6G9pZeBrSufOk8fDN0OZaLVcbFUr/p+wfwK/M7sYfPCPY
	3Exqo81fthJcrlD80lzczXYAsIPO720Jw/gsXlwyf+cyFLtGFjvCzXtvFTbfxYpnEz7P8dbgmNn
	Wt2mRsIx9heDCHYbPrfgCxOGjiKCFdtyXiTgFOzFqmlz8YEeZXMD4rgZqji85Ew6SrXW7EF1Fyw
X-Received: by 2002:a05:6a21:6b8b:b0:3da:fe32:4217 with SMTP id adf61e73a8af0-3dd8bc6cf32mr1894679637.16.1789710076506;
        Thu, 17 Sep 2026 22:41:16 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5bc98a45csm348612a12.2.2026.09.17.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:41:16 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: westeri@kernel.org,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuqi Xu <xuyuqiabc@gmail.com>
Subject: [PATCH] i2c: acpi: Add ELAN0662 to i2c_acpi_force_100khz_device_ids
Date: Fri, 18 Sep 2026 13:41:09 +0800
Message-ID: <20260918054109.23550-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN0662 touchpad (04F3:317C) in the Lenovo ThinkBook 14 G4+ ARA
(21D0) intermittently stutters and drops touches. libinput discards
invalid touch coordinates and logs (rate limited to five messages per
24 hours):

  libinput error: event6 - ELAN0662:00 04F3:317C Touchpad: kernel
  bug: Touch jump detected and discarded.

The ACPI DSDT describes the touchpad's I2cSerialBus resource on an
AMDI0010 controller with a connection speed of 0x00061A80 (400 kHz),
and the kernel does not lower it for this device, so the touchpad runs
at 400 kHz. This is the same issue previously fixed for ELAN06FA and
ELAN0678.

Forcing the bus to 100 kHz was tested with a DSDT override on the
affected machine, and the kernel confirmed the override:

  ACPI: Table Upgrade: override [DSDT-LENOVO-CB-01]

Before the change libinput discarded three touch jumps within about a
minute of touchpad use; after the change no touch jumps were logged
during more than an hour of normal use. The patch itself was not build
tested; the behaviour was validated through the ACPI table override
above.

Assisted-by: DeepSeek:deepseek-v4.1-flash
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 3af0e0551185..aae4f159955a 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 */
 	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
+	{ "ELAN0662", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
 	{ "ELAN1300", 0 },
-- 
2.55.0

