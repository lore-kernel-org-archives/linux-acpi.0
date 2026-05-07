Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB54657CA
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169422; cv=none; b=Z17jpgIUU6pLpoOn2lrDtxK/iejcr+97eZL2b0KIo2/ARIPdLY8vMlQsbLWiUY7jIagG8FDPsbHJ8d7i41Htl3iZ3zHO1wg/7IL3S/swhOpKW4kFiRmJxFW47+OGK4K9MEACOLfx8YTEDbbhD6XZYRuUv3KAxpuzGlD2O4QRkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169422; c=relaxed/simple;
	bh=37auMNg/QVimiWcnWEOWuPkMh7KrDw5XZX81fsEUK/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEWM2ppvf3vuHmOTs2HxcnrDZpF9pCq3YatuKIZfZrL54ePw9Ww7i4CGg6JLymo0Uarx5XnoKcmwzSCkcj7jzI7viuDl45RbBhBakT/5yYWsOgbT80KvxpQMa384oZv+B80M20ySeKL6n+AnsLfqN86jhyEjMLqwDxZyrX+n5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuT1cXwb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuT1cXwb"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso873798f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169419; x=1778774219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLgSTNMb8UYEFesiZU1z3JNyVkQfEaBHIUu75ZHyE5U=;
        b=VuT1cXwbLDYi1cIqsSiJldPpxlGNZ0Lgkpwm5qcJO4GuvzzDjuHNsEICpMZpUQ/WBT
         JpNRxGrdIjBbvErbVfbsScgoTOm4Quoh+mIb7z3RzpXBN9KnSWicpVj3fp+H4ddvjLR/
         1GvOEkAcMrz0a8B1/CHsYuD0RFfENZGXUL4ksL10Axkk9kdFaU/Nz9sdDXLMm49caJz9
         7aZXBOqnO60+nf6T9wbqhzh9yUhChKAkfv3olAXQnOPpoFzVrD0Fw+sbhnAxIFJgitxx
         YsqW+DVuwK9nOsBEkAcoGhXU4S42rzBrOhJBwt10CT2hXKee46j4okGRIuXWuSRgFO1/
         zuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169419; x=1778774219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLgSTNMb8UYEFesiZU1z3JNyVkQfEaBHIUu75ZHyE5U=;
        b=n1gpWw6gTAxVgBm6T5kM+IjvUHGpEsaE6w3SqWlUR+xHTAtVfqzGUZG/qWJ8lwAxW3
         oiKMhCXKK3Mq2VwBIy8GU7V49JITFTRWV1DZWXqnB4Y+cJNkYXxZgjCA6xXXi4XvnGO3
         +Q6HQ/Jyz/LbvXETN8kYpoc8nZM6VWhzRvCiahKYZVlsy+Voqor0oUvS/QdW+3GjkZR5
         Cl8mOAMfEdjUK1husHqBk/zpvn3FAZ+5RjDt5hp2lU87MgMI8D62mPjrjOwXQRLfZTWK
         pjbkhkuQ/PSckqY/TjwE8q7GimBWMrVsUH1fiEM+JqFzUPVT80rj3tkHegIdOq8HIvrs
         A50Q==
X-Forwarded-Encrypted: i=1; AFNElJ8DGAHCsEfPOyl6RV/9P1XgvLkg3qgfquTrXPbOWWiojy9D+oAUDpFapV0M+OD0N8O8GP3q6LUNu0FJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjYQJl49PJDzBpvhtlEcpGXqOCTbqeOhXgRTPmOKMuIiNg7M3
	qPxOlNJpcfILXChKQXxOri8QurVDKfcwqRCNtHZY4D/tqv67fSEXxZ18
X-Gm-Gg: AeBDiesxdji5ma/22mWpV8w50BPahE+WpTvbKjNd9ylLcMFDlDiyc8rjH4wmIHrHnzI
	qfvv0dJQejkRdo2T9B2V8CJBA5n+Wp9DPmajUPUhQc4pkzJW/xGk4jEnE37eFRE1JJI9aG9MvU5
	w1Pq+TVmQH+Y4RwWV67poZoGFmQHzmnWgehxwOy4odo2gwI5jZlPN5WxBwpJbETSVI+MVM4tTVC
	rnl+1SX+cZ8DQXOpHnXXErN3FelFPY3ciHJe9MGJGe/+fzfMzCgCvjBaas2b610d4E72mcb//wG
	x6BTypb7XjpqTdrs5f+yJhvImdTI5xYna4DgBcNhpoM7w9K6YKqCG0Gh9TksbKMdeWi8s39GwhO
	5egL0x746cGCq9qc9hppLPArkEOxu55FOvDOlSGB6Qjl+wSC/LEavDlhxAWXJAjSYjhrTpfz9KI
	JMuVysrMMcgyh64jQ=
X-Received: by 2002:a5d:64e3:0:b0:441:1cf8:be9b with SMTP id ffacd0b85a97d-4515d9a06cemr15004134f8f.37.1778169418765;
        Thu, 07 May 2026 08:56:58 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:58 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 6/6] gpio: acpi: sort header inclusion alphabetically
Date: Thu,  7 May 2026 17:56:47 +0200
Message-ID: <20260507155647.403964-7-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpio/gpiolib-acpi-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index c9b12e24de14..7b324dd4ae67 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -8,12 +8,14 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include <linux/gpio/consumer.h>
-- 
2.54.0

