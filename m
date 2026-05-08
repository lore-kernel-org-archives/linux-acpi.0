Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDE361667
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221090; cv=none; b=Kxc822UskLOQmYhTakctufgZkcDk+DgT2FmVT3PnZyHblOOmMgfoVytGzc69k3ndSJmpN9agdXuQcsrqweG/Ltyf0OGiVApk6pXBjDd2Ab6J9SAlXP6fD31TxCdUeP5GCVzA2c3ORc2emotGli+XZ+fuXgTBle7rNdVJfoJ+h0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221090; c=relaxed/simple;
	bh=/DEFkIW9I9NwWWfUVQdS9qd8W0IKdC3W81KyiTB7ETg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHDDIKWZUOWc00Y5M02hbFtTFZFVyM5/cBQUYJcorbi0znSMbg03OWYicqItFHZv4zB1+aohK/Nh3V/mZdtFjoUXLRtgbpW3qS+BgeP38RyhVMc7vJ7a4NU8jUHUtr7e8jshiiA7akApAdXQ21EFYaNKkbTrqqwTWEWS3/s6TTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt0yV9oF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt0yV9oF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so13641585e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221077; x=1778825877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIgsaz/80F7YVh1co0erXVe0CBs1zSzj8RjSOOEqAps=;
        b=Nt0yV9oFYvcQdlpIVcBPIz+S5V2AVdvo7OlCMwpxJqakzKRFYEx0wGQl5QhioNGAee
         uYQf4GifnjFC2J7xiOFL03dCy0Lm8dVkAwOQiyWQ8nu2SZNyrCMTzzUsnuRGggxF8r8O
         y+c/u+50RjxwwLVHGKBW3899cvNsVoqWyKBImuwtGR/Iy77UFR2zMhLoez48TxBDRJd8
         J9r97uEyipw/MCfrC+7cMGkRUamWEM/29FZmoH613I04NEM4UyB+PuJZRfTTv8pj0/2b
         jTDEfED9Nk0hKmUJou2UnRHuobn96Myawnw11v8UvxtxZ6SuTdh896hzx4VjE8XfuvTU
         hZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221077; x=1778825877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OIgsaz/80F7YVh1co0erXVe0CBs1zSzj8RjSOOEqAps=;
        b=VZnssPRKBO6RcNarWdyXmwjaFGkA267WNRSxf1zmqVFdSqsgn3qQPjCrPL2HAvHGMB
         2LEWjlx04rH24Wu3WvrlO+mnqUnBDMY6EIF38HWbJk/t/2v44bDlQKp0GJGub9v371p1
         C7A9wjHR44fMMHlkYdzX9+l75TRU2iU9HX62xeLuwRMlT7NI7opiJakOX9Cxub2qhFi/
         g/V8atx/1Od3eMNfrXcW6ke7ly87dudPqBpSU60BYmMFrl+96O9qifDxC9dfBZ7l8bps
         2jBBwg85rxhgQzjVC6r/Y6XiojzlM1O2uv2uGxQvNwxPnQztMEVgELAsBKkK7z7L1zeC
         eftA==
X-Gm-Message-State: AOJu0YzSKOGWo8dFFbdvjJcmoZQOxijMOv1XUbeW7bfdw7sKiL8lEzUS
	pZo1wy2Po67ZrnIE7m2PENRALl4J3inqUpEFLen6ajskyuG2AUiOw/sI
X-Gm-Gg: AeBDieulgQoDlk2cmPFbN4FxoCW7eYql/igElMaiTdygopRr8BEfQ4PqP2fBN/l+NzI
	TghVxX3oPfK99mal1iqhL8UcnWDzgsm6O3yFz4+gfiw7uS8Nqk9WLG+CseTUwn7Ya2561AkBwYe
	lPty8FYUQdaYE//UHzrsszytZjRBlJtP4QM0qA1onxwILmj6ssoovgjg901p0+jQS+ujpYKOhKZ
	UTTNm4qbE1FyLatvf/ebc7/UTA1ccC7PiO7n2jcfATHf89pS4zEh6innVjlb+xEtwzcrmo65tE2
	KFj5LdnVcdQQMs/k+fWcMjZFqos5MB3uL9LecQ2g/4/3+QJ8HgXi9IiDkkJWqYlQuToVfsCvtVL
	qfjpnnlgdyPi6vttOnkDyfwiPTRpo2BM8K6tLuzqfLD6omZzx4rRc9+3qNG0wUn/DGJlajUzQ2Z
	kBnlPinRcOoEd5BNU=
X-Received: by 2002:a05:600c:a111:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-48e51f46d1bmr129939265e9.27.1778221077168;
        Thu, 07 May 2026 23:17:57 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:56 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 6/6] gpio: acpi: sort header inclusion alphabetically
Date: Fri,  8 May 2026 08:17:29 +0200
Message-ID: <20260508061729.9530-7-mscardovi95@gmail.com>
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

Reorder the #include directives in gpiolib-acpi-core.c to follow
alphabetical order. This improves code readability and ensures
consistency with kernel coding style for header management.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
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

