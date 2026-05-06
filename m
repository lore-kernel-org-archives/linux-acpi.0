Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F927449EC3
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071025; cv=none; b=NbWDo0fK9fTgUoOpTzsDOE5En+WJt51UnjU+Ug9fZmD0o7PN5Vs/fRDDhrFZOhFsSIza6Z90oYdM6gantgO6G6G8xzAuehSpUUWOqWo5gMxK89cqW4zlU+UnfDxgHkbWraAb4Yb0PCvoNs8yKIobiFukt4TQE2O98Gi1cHhreOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071025; c=relaxed/simple;
	bh=MtVKX0+/RgsoWzLc/ouyVcU1ubZM16+m3j5A53wkB4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhLd5dDYpt8gEiBGrykoNYIJvCksFVdnZ6Y2+hdPmRE8J5de9RO/3JNZ99Y0ez+TMTvEyGhiqCROxnKel2VHfwwaWit0/5ghWEJSmbKUO5kObL+PkEaY6ydHY6Ie4/TAfDVh5naQY+v3dtIan/kxVj/ncmZHxIipBsKVUBlIotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE5oi6+B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE5oi6+B"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso35110105e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071019; x=1778675819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4fhAWXiUtHh50/c6yGRrCeHmG4RlLuqrhdgBtX1yOM=;
        b=YE5oi6+BFzVcPSzvAXmQoMtRJwmvQRMxm8sLZABSCNP4N3+paiXPrVGdVySgfsrmtZ
         vsMNDtpi+nShPImkP2m76/OdvbEdfCZZ3Z1dK09N1d6FauV6tvzfNl0low6bqF0kWlWb
         vxX13sywOv6HmXC+qY9CAXWFcu4fxQLBuCu+qzHYK5WVFt9tdqFja9x7HVQSywGVLpo0
         6ua2A+yygYoLti8+3uwzWbNOzpsEcaW0WY3d6GbpaUoYwEoNyA63gVq0Z5zDTPPf//8W
         KS4P9xOBfFRmwstC2AE/woS8spwQFFZWzRBaQS9wCUyP3cfk337jJcyAUUuwYTluVM7E
         qWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071019; x=1778675819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4fhAWXiUtHh50/c6yGRrCeHmG4RlLuqrhdgBtX1yOM=;
        b=CYA7YHojSzYp5lXS3PKp/c1FB+g1T7Q7F9N72ZgcyWXvKp73BOeI0YQB9npGzR0/ea
         a8RUms/LbrjgvCSicCVU83gNfLbjUBXJufPSl+Mza5kupa9ZzBODC6sKP9Q7hnJlHoqh
         mLg25+gITheZovIWO0yI+0FsypftmqNQ10zLYWqxpqgVaoFeacqSJIU4NKfzPja1BozL
         1tD1NUQruWc9wmxJ5NB30ZRHIgEPWkWUoV3vuh6J80BtPdo6ScxPeYdRfqAhVtSw15bU
         rfmtMK2Hd+gBdob1JBHCL3NwI7C96wAwGRQCoU4FzpGExtBrJY4XGUMMwSZ+paXWNkpO
         iD/w==
X-Forwarded-Encrypted: i=1; AFNElJ9i1avjopeFW4R5MAW/AmUQOYKrUBCPtQaUE6aQFH4wgAoq1tvVvN+jG9yMfI0eNU2rDKLhRWvs0BoE@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsH6Zb7dbAvpGJXf2VP4TegFQw+uO5+gq6OvLcIljb7Ty3j85
	wuYF8wq57Ee4y6gxuvfMQvM/LqPxkAwoeszb1vDv8WooAkxLG7SkBRCL
X-Gm-Gg: AeBDieuB+q6a0xQiLwUoqBbL28yFqKYCaZAMXHC8lqEP9h7jfTffZFlBwArjsnW0OZu
	uQ90KHCqNCJ+xmDFh0nkOgp4xhGdr871XgTyOkOp4dzZ7SA73phzaGQvbXK7Lld9vVhDjQa4ybq
	Je8zPMYqyCjj3+TcZLcxgFdJe79l1pb18YwgIbGQdm3ccHsEooZJpF4eZBJIS2cl31/QUq26N8q
	JA2z1AtLLSVipmyeXr3Y4mNXsTVC0W8FJ57/um026ciQl8Q0GTOEZqNSKkbxS5ySa2ana9EyeJc
	tj7Bh/Z9lJBGniB5bSZErIbUR/DLLr1CEwHz5A57APnvVX4JmXYAxi3bWk607nwEt8IWsALFFj0
	gUF+HIbZw0Z7i5TLOioRKxIGssS+kQZinlVp4Qc6CNAtUpMcjBXaEuNCUsmtZl7VRcfZkZVCN9A
	T+w63l469CnTjH3Uj1YI0L7GY5IA==
X-Received: by 2002:a05:600c:8485:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-48e51f32a64mr60865175e9.18.1778071019394;
        Wed, 06 May 2026 05:36:59 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530cf964sm31767485e9.1.2026.05.06.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:36:59 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v2 3/3] [PATCH 3/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:35:36 +0200
Message-ID: <20260506123637.1077421-5-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506123637.1077421-1-mscardovi95@gmail.com>
References: <20260506113215.GK6785@://intel.com>
 <20260506123637.1077421-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpio/gpiolib-acpi-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index b6accbaba04d..7b6476b90f13 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1126,7 +1126,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		u16 word, shift;
 		bool found;
 
-		mutex_lock(&achip->conn_lock);
+		guard(mutex)(&achip->conn_lock);
 
 		found = false;
 		list_for_each_entry(conn, &achip->conns, node) {
@@ -1158,17 +1158,15 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
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
@@ -1176,8 +1174,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 			list_add_tail(&conn->node, &achip->conns);
 		}
 
-		mutex_unlock(&achip->conn_lock);
-
 		/*
 		 * For the cases when OperationRegion() consists of more than
 		 * 64 bits calculate the word and bit shift to use that one to
@@ -1196,8 +1192,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		}
 	}
 
-out:
-	ACPI_FREE(ares);
 	return status;
 }
 
-- 
2.54.0

