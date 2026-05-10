Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3F175A71
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381284; cv=none; b=JXkb4GBue/50zu+pzdWUhi3FxJZul1ZhUGnYB1wv2kvJ13z+XJ4zJFO6I4FuRgHuKUv7bvr51ipE8f9drZ4dj+S/5++oB/zBILrTREIH+c4cNhkznOf0bT8nTBspYtYyy06U99IO41BsYICFPojhA0IwQCGg4bic4XO7wu7Tahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381284; c=relaxed/simple;
	bh=TzAxtJLC4nrW65NT3+Z5alkvspdwsOm9DTbYpzFXhD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI/zZhkSmTpxIn/rqFiSloNmfzJ8KuNjziicg5fbpJav88TGFVt014sXi4IfP4HB/Rs5B4NMiwFUMRBdSzuBdJlx76DpIpZ+aMcUMKKm6KxWD/9yv2MduzPzxaRoObmE0Fd2vTOI53UzHxA7/ZNZJdh4kkdw8lNAEatpnHvaTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpDCDYME; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpDCDYME"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso3826346eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381283; x=1778986083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwWr+IWsYtCpElPZrjabIrCx2zFiiWbS2h3mskiH5E0=;
        b=qpDCDYMEtNH/Kz3zdWhir6P4gl0Slz5GhAHkeUY33vLOU3FpW2xaXgXFn658aYtyLw
         W8ev2a3ms7urHaXF7fq0K6VF+g2ZLpQ0Jt83W8/deULEq61wgEiefA/EGiaW82QNL4rn
         maKN/f5X4ayTda4aBkycllXNaWNH4LTqsru3PVVG8yXbm9+Ygd+l4xX1r+Blml9jXVd6
         NtZn0RyLU84Gv7AXrl4XFI/OqopbYRlKc1e7KNDL2ZeRtS0DfFPPxrLpvv1j5jJ2sip2
         i4GO0aK+taLSnrPz0rhAIjFeqKenMgAQ4yotLEmjV/6nuoziTzMkOYohkp/eJLahKxtn
         987Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381283; x=1778986083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwWr+IWsYtCpElPZrjabIrCx2zFiiWbS2h3mskiH5E0=;
        b=FBwsyCTyju/csYSqvRxtMdTjORBvhKedzZYNCf+hFeslF5ChzRMi5vY9OoDMla3Ifj
         /h/ye7NnuErMklBbM85tiolZgcBrDXfVXp6oMaWGlWVd6xCk4Aq5dJgB0TG12tH3xneI
         Svcm6JA1NHcq34DScbZWqWItokMwy85kSH28uXQPmoZY/1eoo2uQOYRY0jKeIiqL28o2
         +TvZeO3gZnhfVhhlzyVwZB332GLrBN2O+BcwPi/jqmdk3IBq3I2RIqWnd3PFQmJyvmEo
         SXVXACvoINmM3CWhgcdlp/o23djNzEBpY6FucyIF/J3xiGL125korXgYIbZvGvPQVNYz
         tEiQ==
X-Gm-Message-State: AOJu0YzFZpavptvBVzonKrxL2L8Mgr5VfgIIXr6xoQnWy1mXGBs0rxEN
	Qr4fVx7rY8dlhpLsLXimTS6JBxHMNIH7jsWwfOp9x1rsRcJ12iGFxfM=
X-Gm-Gg: Acq92OFnByit65HooHaN0z19GrEImrWry1RWcuVkBJFPjGxWWV/JFvAuBWSRWx5dGAt
	MiG0Xtv1IoVOvHkigZPXGAOf+AVkCTmjMmMpiK+n8Ikn+uGeZWoiY/+VNK9G6HFklbXlVDpGKf2
	b9eluqa+anlUU0Mz3kGgg0qk4Qbojc2uuOpFQxCenmNUEnjKFTVuOhAIvV3yEtdIwJVeH4we9aT
	w6IBuY1Zf1PQa4CJqZQ9rWxX8I+hKvalDbFnvq2UAD4RaQ+Sb7l9D4B9wxG2J/6uBlmxi5gSbHn
	nu1ZwV8OxHRfb4t+r3i2HyYj30dluCWMsAS+4nL36ExWW3029Smww+e2OfBE+tiImxk6S9CBohR
	+f0jqgMJr87HRDklasEC6t8wbV+vxgiDUlpVG+DU5ETxsoB3DHnZ3zHmmbuBrKdcmElqh9G71EA
	m297L0/AQT8cjhBG1h6VlOybA4yn0wcVJdZ+PmyH8fYg==
X-Received: by 2002:a05:7022:439b:b0:128:bae0:e03c with SMTP id a92af1059eb24-132a82ddf53mr2262624c88.30.1778381282784;
        Sat, 09 May 2026 19:48:02 -0700 (PDT)
Received: from localhost ([2601:647:4100:7b00:6600:cad2:6352:4cfc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865955fsm11212475c88.11.2026.05.09.19.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:48:02 -0700 (PDT)
From: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeanralph.aviles@gmail.com
Subject: [PATCH 1/4] ACPI: video: Do not initialise device_id_scheme
Date: Sat,  9 May 2026 19:47:20 -0700
Message-ID: <39d1c5567a2c0c6454a0c10a32d2dd853349d303.1778378939.git.jeanralph.aviles@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1778378939.git.jeanralph.aviles@gmail.com>
References: <cover.1778378939.git.jeanralph.aviles@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:

ERROR: do not initialise statics to false
Signed-off-by: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 05793ddef787..e8880a2113cb 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -63,7 +63,7 @@ MODULE_PARM_DESC(hw_changes_brightness,
  * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
  * assumed even if not actually set.
  */
-static bool device_id_scheme = false;
+static bool device_id_scheme;
 module_param(device_id_scheme, bool, 0444);
 
 static int only_lcd;
-- 
2.51.2

