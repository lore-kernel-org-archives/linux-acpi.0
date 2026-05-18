Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320A3E1233
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090861; cv=none; b=DNDYNxuHjaKV8gxaHRPRoyK555tb92KSNCAaNZOFZ2vYi3MQqRpF+R79ZVK+AeWicImGxuapUmenOYR6XGqLINsn6YpJYTfIonB1U9u0bRLtI5g86sEhJVcP7zWGIsGuzHyLzbEn1WRE8iVd3zzA8dWmOXtGQMHojZjKQqwiryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090861; c=relaxed/simple;
	bh=iv39VAslRAqgad6LKrBKdc0Y2gyQhR958hGtPNBwDEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjzMcZ0bx8iiCpQaywb+A2llM6srCixKMKTSkzoUYqRolmuo1ElsfT9n7VwdywvGwdPvgEaemIpZhH7LKTKThYA72asEaRT19ktXrtxrgUASZC1L6CZj1pbkRjW8ygD4nVVHxNMvrzF1PQLFkMz2uPBmAod4WuCfI9zEG6g1zfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdsIoJM/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdsIoJM/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45562c41ec7so1014143f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090851; x=1779695651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iV4KXyAPK+K+KWzEeqIiwRK0AcdSNjQuvN9IpFfq6U=;
        b=qdsIoJM/B+ozEXaiNBGGQtM61pt2v/z2YKCqEKvI9UkVIH3eMlMg+qywxpQx0uqYP+
         k5G9UccDVSQ+0k0Ubtvn59YqqGisr7wx531JGOvPX7xIrS5dynawka8Mkm7+tcTtLshe
         06llZrBQEGZz4iQvA93fBtHzzh7Z6y0qCmLxvtxovl+hLMDxC3TquW5O2/Ye2kgmLxVm
         JylqUG7f3CVjSRvkdCpIKNyiAylwaxdiveVHVQ8vLT7MUxqXpIWlpQUrwaKBqLUp82pO
         LY4UFxw6U+UsJW+8HlvQ7HGo+Egs6YY87CQBXZCSl/7CvgLVNTE4m70YPR64YmmsykIk
         27KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090851; x=1779695651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+iV4KXyAPK+K+KWzEeqIiwRK0AcdSNjQuvN9IpFfq6U=;
        b=jP7J/imfhCBGuy7/YDpBCUhTeHF+zvNm+pWRl+y3ZsHFdh+LT2RRK18QZ5DCVSQ9G0
         /VC0SKAIz8sUWWaaprfPa0mZCpoDQDUw09utN7D1BjOPFKVTBf/Oy1YuWC5aarkFXEo9
         xzx/YglRytcsKYX6VdINoUvvvO98J/8SbC40NTy+IlHO7I3nR3apNERrArUXyGQjjnEU
         JP8UPEbQ2lD121/lGO3VsSOoCXU1DJuOqVcbiN+Gw8QTkr7N2faKlYrT6Cw2oJ3sPB74
         8mzchFA3NQDLFJ7orQ/84/3jeslOuV4w9nnv8P4V2ez+n+euTqmMKqeM3Lqbg76DXUuU
         38wA==
X-Forwarded-Encrypted: i=1; AFNElJ9eMuu9KBpkGdAV/eErMlun7i4yhK0p5bjA51DbV8idvNkyKoeMTaKXwbhZWI39ebv+f3jB+VjaBpfF@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKQbN6iOoxkVBKzHaRMERxD0LwBUJd4BPp8SLt2n6ro4W69ej
	MuPoTixl+v0AkH5vhZc3br5WPi25y038eEOh+KPRKPfPe3DcV5rcWIBV
X-Gm-Gg: Acq92OFddUpkFFkeMSdj8WZp72WSqreQuKDAo6ADDglofe6IXDERVrsVljKPfGIPue3
	YTc4VR32nvM2og2GSI5HSakENBA/YBtt67IFvapTw6L2XvVJQVKaWoLmvECFAoc887UZe6RMwxk
	Iol1WOlDberfSIszUZohTCJZxOP0RZs3RwvTK/M/RA6MC3xCgPsC/kFP1X7XaACW1OGatLjPipk
	c/a1O5Pvk2EisQvN58XU0adPRSZFbQD3JEOBrMy9rt38fepE5t5+PbwyBy7mIQn431ZHfcfoXBz
	pOe2fS0+ZVrxGMk0hzTjoV4+d88lNiWsXV0psM1q1gMQBbdqlAbU6CyHMcFq3dySaGv3VEq89fD
	yP+0DNHnFNWUMBIzHNKM+OKXMMJCnP9eDPnMylTL2KK8GSItSPzZmbvu67a4X51KlNvQOA+ih7G
	H69xuG0XZ4G+Dn8PA=
X-Received: by 2002:a05:600c:8b6e:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48fe60ecc24mr220895185e9.8.1779090851593;
        Mon, 18 May 2026 00:54:11 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:10 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 08/12] gpiolib: acpi: Divert OpRegion registration callbacks from core
Date: Mon, 18 May 2026 09:53:53 +0200
Message-ID: <20260518075357.112584-9-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518075357.112584-1-mscardovi95@gmail.com>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 36 --------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index afd76301c41f..4802d4948f89 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1169,42 +1169,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	return status;
 }
 
-void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
-{
-	struct gpio_chip *chip = achip->chip;
-	acpi_handle handle = ACPI_HANDLE(chip->parent);
-	acpi_status status;
-
-	INIT_LIST_HEAD(&achip->conns);
-	mutex_init(&achip->conn_lock);
-	status = acpi_install_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
-						    acpi_gpio_adr_space_handler,
-						    NULL, achip);
-	if (ACPI_FAILURE(status))
-		dev_err(chip->parent,
-			"Failed to install GPIO OpRegion handler\n");
-}
-
-void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
-{
-	struct gpio_chip *chip = achip->chip;
-	acpi_handle handle = ACPI_HANDLE(chip->parent);
-	struct acpi_gpio_connection *conn, *tmp;
-	acpi_status status;
-
-	status = acpi_remove_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
-						   acpi_gpio_adr_space_handler);
-	if (ACPI_FAILURE(status)) {
-		dev_err(chip->parent,
-			"Failed to remove GPIO OpRegion handler\n");
-	}
-
-	list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) {
-		gpiochip_free_own_desc(conn->desc);
-		list_del(&conn->node);
-		kfree(conn);
-	}
-}
 
 void acpi_gpiochip_add(struct gpio_chip *chip)
 {
-- 
2.54.0

