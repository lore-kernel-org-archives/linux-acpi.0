Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF23E168E
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090863; cv=none; b=LFcOavDQ+lWblr/m13JhqFRKT5wdBpSIklAtraKUtSdyvlCEkB9dyw96a7IEkzNHCVM2zDd1bTBRA4Cx22cUpjXmJP1zj5udFizGKOG/izGAgwBqy5CTlCQ67+K2Iv6UEDfUJww8MijwT31of2wioULk+1jOc2hWJYiybTymHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090863; c=relaxed/simple;
	bh=7VBmQ0QxJnGExiUhZKQxvKL2TL1+qN9rL/V2s5flKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aij4JrOKvVn5ffOk6+UxPo01NzOAdcbPlLBj94NdEoWkpcwCtA5bIwi+Ou1UGuPT0s4/cMMZQRZiPeffofosLY8M3ZKMZfcoULjtp1e9gzIvF4FHaeT9J64BYKGtwrBxM6kpnQ8un32VGIxRxtT4xEV0YfYZbmt6KkgCJ+SQNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw5DVKb4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw5DVKb4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so10953685e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090853; x=1779695653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0KmdNrJVMFxKN/kI/cbQSQ7h8U+WxFfpCT2ri4hO5g=;
        b=Zw5DVKb4+txjkFU/tlwjr4UrSFVvdElZXQqBKvoTXLQifQweWhsJZFNCW2nnojKBHa
         RT+vXKwYUmU1qQ12aKHbCCatF5qytjK6EeZBkQ6HK/fGZweYuNLchJpty/NHDiOLDiZJ
         t5ZO7ptH/vwSLSxS2TRvv0SC8bOIv6NFMAaOBxXx7dq2R5y9sqTQk9jYJT/PbOFZ2MbN
         W9UZjsgYhHsj0QOS0p1f15f6Exp0c8UdKidX1xp0TeUXkp7F6NbNlG+f345W/hPrL1O+
         b/3VWKOCwB8A9g/7pSef8SQLh7ylHA8ka/AdwGQsTWIqHIfUw7la5dyC70crrxcQodJx
         6bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090853; x=1779695653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0KmdNrJVMFxKN/kI/cbQSQ7h8U+WxFfpCT2ri4hO5g=;
        b=aYm74q8S/sMsQgqCSVnINA4nmkjphISSy6u9lW/6L3G0Gdv/udvKVKnK5oM00v3FPp
         2a9dNJNyhs4GkYAdcMtjbJcEN3cOEAmYQIziGKqZ/HNhOLasYuGz02SA4wydEAxSZ1Rt
         Mtpy9dEnVdo0E5TCFcg0PLlZkAiTI3rsMfMoTBCu1J83av75b2Fw0rnTRw21HeHjvJA5
         JCZ5lndGoLooBwYF1moZ9Wbq+qLV0giTNHfJPAcNcn2txm9fQUubD++v1EPGgF+WQXJR
         wM0NtJbJ+SnhUCdg2Dy/Mwt9yraIJP/FQkHfjTJquSFI/X9Mwo2rBKXNACVidplKEHte
         kgrA==
X-Forwarded-Encrypted: i=1; AFNElJ/Oh4tWxJSbzcv0DYGZXPGpNo7IqvCiMdE3la9us40yfiEDZyO+jl+sIVdY5DQgt8ZT+Vvp5ALHoTpn@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQ1MdoSlyYIRCobwJ5cfLyBDJY76qiQD+2/aPwXjeLjQnPX33
	qpLWVpuXJRc07PBSU/Ns5jp1pskzplAhK/Fx6AQImrLjPmKhfO8Wh/ZO
X-Gm-Gg: Acq92OHA8S0NdjEQ9zTvbzR40QgsCgmTF7t/pumvXpvWhqMdyUJQZWERBS82f+2z+a3
	N4/0ELaUGSSPxJu3Im2yVblGvDc+H8k35Fko5vs5l6Y91tN1NZolPaS3YGLCDeHq1qscFIc38HE
	HIaj5scYRbewBimpWV5S8jLZrZT55jq6ELX/jyWo0hIfhdq97K1RYy4C3ZoTcd9CQp1N44gH7rG
	e2UCbBTGShWAbSr2BZiJWbi1YVn7QYXXUi3pBd2SfIgsBGUmdlDiHUPYOMx/sEK0eYRHiW2507N
	mS8Gqkun9BES6KiTyGptjIKepQWL/J5Wzs8VESCmYasEyAGSUV7dTUR7XcjBoOBFjFLubPzr1Km
	/MWIY20WVhR7sZs9g6Y/vtVb6V7ogbg42+OH49itoA6vn4N/nZHzfymQ99t5hKopvdxfNENr99Y
	9Uy9mUU51UvmoCHyI=
X-Received: by 2002:a05:600c:4455:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48fe60ea92dmr193027845e9.8.1779090852710;
        Mon, 18 May 2026 00:54:12 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:12 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 09/12] gpiolib: acpi: Remove unused static address space emulation from core
Date: Mon, 18 May 2026 09:53:54 +0200
Message-ID: <20260518075357.112584-10-mscardovi95@gmail.com>
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
 drivers/gpio/gpiolib-acpi-core.c | 120 -------------------------------
 1 file changed, 120 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 4802d4948f89..b8976a0c798e 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1049,126 +1049,6 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_wake_get_by);
 
-static acpi_status
-acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
-			    u32 bits, u64 *value, void *handler_context,
-			    void *region_context)
-{
-	struct acpi_gpio_chip *achip = region_context;
-	struct gpio_chip *chip = achip->chip;
-	struct acpi_resource_gpio *agpio;
-	struct acpi_resource *ares;
-	u16 pin_index = address;
-	acpi_status status;
-	int length;
-	int i;
-
-	status = acpi_buffer_to_resource(achip->conn_info.connection,
-					 achip->conn_info.length, &ares);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO)) {
-		ACPI_FREE(ares);
-		return AE_BAD_PARAMETER;
-	}
-
-	agpio = &ares->data.gpio;
-
-	if (WARN_ON(agpio->io_restriction == ACPI_IO_RESTRICT_INPUT &&
-	    function == ACPI_WRITE)) {
-		ACPI_FREE(ares);
-		return AE_BAD_PARAMETER;
-	}
-
-	if (pin_index >= agpio->pin_table_length) {
-		ACPI_FREE(ares);
-		return AE_BAD_PARAMETER;
-	}
-
-	length = min(agpio->pin_table_length, pin_index + bits);
-	for (i = pin_index; i < length; ++i) {
-		unsigned int pin = agpio->pin_table[i];
-		struct acpi_gpio_connection *conn;
-		struct gpio_desc *desc;
-		u16 word, shift;
-		bool found;
-
-		mutex_lock(&achip->conn_lock);
-
-		found = false;
-		list_for_each_entry(conn, &achip->conns, node) {
-			if (conn->pin == pin) {
-				found = true;
-				desc = conn->desc;
-				break;
-			}
-		}
-
-		/*
-		 * The same GPIO can be shared between operation region and
-		 * event but only if the access here is ACPI_READ. In that
-		 * case we "borrow" the event GPIO instead.
-		 */
-		if (!found && agpio->shareable == ACPI_SHARED &&
-		     function == ACPI_READ) {
-			struct acpi_gpio_event *event;
-
-			list_for_each_entry(event, &achip->events, node) {
-				if (event->pin == pin) {
-					desc = event->desc;
-					found = true;
-					break;
-				}
-			}
-		}
-
-		if (!found) {
-			desc = acpi_request_own_gpiod(chip, agpio, i, "ACPI:OpRegion");
-			if (IS_ERR(desc)) {
-				mutex_unlock(&achip->conn_lock);
-				status = AE_ERROR;
-				goto out;
-			}
-
-			conn = kzalloc_obj(*conn);
-			if (!conn) {
-				gpiochip_free_own_desc(desc);
-				mutex_unlock(&achip->conn_lock);
-				status = AE_NO_MEMORY;
-				goto out;
-			}
-
-			conn->pin = pin;
-			conn->desc = desc;
-			list_add_tail(&conn->node, &achip->conns);
-		}
-
-		mutex_unlock(&achip->conn_lock);
-
-		/*
-		 * For the cases when OperationRegion() consists of more than
-		 * 64 bits calculate the word and bit shift to use that one to
-		 * access the value.
-		 */
-		word = i / 64;
-		shift = i % 64;
-
-		if (function == ACPI_WRITE) {
-			gpiod_set_raw_value_cansleep(desc, value[word] & BIT_ULL(shift));
-		} else {
-			if (gpiod_get_raw_value_cansleep(desc))
-				value[word] |= BIT_ULL(shift);
-			else
-				value[word] &= ~BIT_ULL(shift);
-		}
-	}
-
-out:
-	ACPI_FREE(ares);
-	return status;
-}
-
 
 void acpi_gpiochip_add(struct gpio_chip *chip)
 {
-- 
2.54.0

