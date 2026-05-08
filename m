Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91A377ECB
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221087; cv=none; b=f4bZr4qRzajXksuQqaNeGqS+w5TL0la8g1g2mYAGBQqw2OMgSGB0++GQhMrf3dSi35CjicjFJpjGCgoHzMeLCi2ozjbIjYWrTkwNGgils4Sx2aCVp8fSjG3A7hnpq7nmVqvgFx1D/j7V95fy0IoEjigUBExrmF8K50bsYvoZG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221087; c=relaxed/simple;
	bh=iAz3jJlPBsba8da3kwjpUIhKKIX2c5o7oUegAZLaLs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBItSGE0YRTNXfVgAADJIgHyOzxQm9G3yPWjUxMuS2oFWEV8HJs+VHRp4kGUY14fOkK3sfzAqWYNU8XcTogcn99eyPvLI3FxUcFY3vKcoinbxK4ZBqk8gD37VR84x/d6SIAmtK2i1PewYEx90/ZB7kI5HZHSeXAArqnm58Oh7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZLlb5Xm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZLlb5Xm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso9858385e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221075; x=1778825875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/HBkO+y62XsV45mtLzlDevXxl0xhhsA9eRibM5h14I=;
        b=bZLlb5XmFI5aUFxtUyQJyuZaE3fA3eA3C/SAu+k5kxhItC5EjvAhgAUvCjqJ9kF+NY
         OzmFlXPYXSCe1jtrSxsLYiu0u7goCAbg1pu3FLUI/nFEgrDwRX3T61Tfx+VJoRWG94QV
         z/tRN/WsF3ab6LItv1YThZycu9mDO6lmAJ7xWzveADTpHhKJliDuxq21hs2wSb3z0l/N
         BpQiYVEQpTGvApanGRWRu8NdJd9qDCFrgGGy/rsGD6MxE+hjMjscTPOSvS96PXk5YpB1
         gG+j45kP010HTcQ790KDFnIDOXQhxb3rk8VooSS1gQYlmPmt7NO9In6TK0661I1QydKF
         3qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221075; x=1778825875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/HBkO+y62XsV45mtLzlDevXxl0xhhsA9eRibM5h14I=;
        b=PlGsTQfuDvq5PpBN3/M6zZekS8OUQo/NOsN9Tq/2xqkX7qsGUjVfvsGnFd7DjTt5Ej
         lb6Yz2gU3mEEe23E/3DjE2RjI/pUOk10Wmak7bCyie+RJBGvQoFUF7SQnTm8Q4uPKBhM
         yi1ZHFfqi2ZY5n/7knK/09DuZN3NB/kDBwjDEexx00OUo86uvNLI0Il8njNLUOJvbr0Y
         8J6vsa5iolqP0vkZAjmKls55gih67y5IQmKkI3qTCmC+VmPB/HjTypEzVoP7ijaq9ypF
         h1BiIaoD/6VGOMu1yKOsDljmdJZFmb1NpfL9t0KrRlVM2mcTujbISECuYHmFkS9KvQkR
         54Sg==
X-Gm-Message-State: AOJu0YxC7iYi+scy/52Sz8q9NTyrjf4gBuQQeS1/TlRjS7jqMk/fQDis
	QjDRV8mFwkzsx9gxXhmimVSnWsEH/5Tu+TUb6VhecgIy744oD/OiGjup
X-Gm-Gg: AeBDiet147WcbFAB6yefQinYR6YopOVwA7a8g6/o7XJReXJwWqZ/B/dHKrGQvoe1S0R
	9miButy2WT4Mx5IX5pbyWO889o+ZfNLvEVsAzJUetzJS4LrozJxJppLGA/ouHFk1BeiC6p4wGqo
	kPsZYM8S0pkSBJLrJ5YiHg861ebrAIsdwATppwGEyptU+oq4Z4TwiZx3VYOpGUmJrLCKgtdbNPv
	RZAbg7XN0OLd0cKEVp3/e4L/qrGY+jOaMqEBCsPLAtqKtkPKYT1DyE4DhM1tGfYR9ukB2DbW65g
	B7CjKTd6w5Wc0XNSqMz3ar0w31dMsIJtF4zjYHD29yaZLnyQdeA++Qnc9h9hcEdk0ENB7vHcxO5
	VRnsi2nlLSL6LwMTImuAIarFzEVfeqaz+nUnKKUJjFZ/22afuvqolz5BoMf2O8s/j2oISPr2pvb
	RMjL5fWcQnLUiPm+jgwMCxDLF4sg==
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48e51e19668mr170774595e9.8.1778221074930;
        Thu, 07 May 2026 23:17:54 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:54 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 4/6] gpio: acpi: use guard(mutex) for conn_lock
Date: Fri,  8 May 2026 08:17:27 +0200
Message-ID: <20260508061729.9530-5-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508061729.9530-1-mscardovi95@gmail.com>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
 <20260508061729.9530-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls in
acpi_gpio_adr_space_handler() with the guard(mutex) helper. This
ensures the conn_lock is automatically released when exiting the
scope, preventing potential deadlocks and simplifying the logic.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index e53d68578024..33d6c3b6cdf0 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1123,7 +1123,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		u16 word, shift;
 		bool found;
 
-		mutex_lock(&achip->conn_lock);
+		guard(mutex)(&achip->conn_lock);
 
 		found = false;
 		list_for_each_entry(conn, &achip->conns, node) {
@@ -1155,17 +1155,15 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		if (!found) {
 			desc = acpi_request_own_gpiod(chip, agpio, i, "ACPI:OpRegion");
 			if (IS_ERR(desc)) {
-				mutex_unlock(&achip->conn_lock);
 				status = AE_ERROR;
-				goto out;
+				break;
 			}
 
 			conn = kzalloc_obj(*conn);
 			if (!conn) {
 				gpiochip_free_own_desc(desc);
-				mutex_unlock(&achip->conn_lock);
 				status = AE_NO_MEMORY;
-				goto out;
+				break;
 			}
 
 			conn->pin = pin;
@@ -1173,8 +1171,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 			list_add_tail(&conn->node, &achip->conns);
 		}
 
-		mutex_unlock(&achip->conn_lock);
-
 		/*
 		 * For the cases when OperationRegion() consists of more than
 		 * 64 bits calculate the word and bit shift to use that one to
-- 
2.54.0

