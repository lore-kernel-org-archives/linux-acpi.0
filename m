Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216903E00B6
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090858; cv=none; b=U2m9ZdfcswmW3xcruN3TEeoEdpxK+fOuCzszD2YsGu3Qr1d93fIisLR2Q0O+t2aYypQusB/WH8dfbc7nWkVZIxzI9/leyG7TIRLh9MZwLqrvfPAiiSWBC1rSYELt7+j86VYXyohMp+f0DaOD7ABspr+WTPoRCkAbNLb5L9iQKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090858; c=relaxed/simple;
	bh=aPiBeLh3lG8cPL7Jg0LLmBRWc+do16dLJX/xIZLlA8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgch7On/DzjtBVN8a/yfR8eGVyPXuE4PC8yz+5+PEArXE4zbDI6SSp9xrPTsaS98tZn8fmN/0wKtYqD/LF/O8KQp6RrWC5lqk3PqiYW58Q2EQMOENdSEZuov0B/ox7GJu1nI+mO1cKkgFJoTSN0J+szwBkdt1pd2hiSLVMznIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Zj9g+o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Zj9g+o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so8156985e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090846; x=1779695646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZIry/uS8ZFI2nZX4B4am8kKwMyHaZt8EZw4IRUQPLU=;
        b=P0Zj9g+ovGFgKOw3UnqgrUclw66/GYvhgCTM3YFrbNIX0/fCp6QcAnp8WoYHDUw7Iv
         TkNbvkQAuoEIfw/dlqttv4qpS5QD+VSGU76T1phXUG4ZjvbGLG0ju35H5aAej9DJyOWV
         d8FE+7JRenK144OoW7ck/JK/z75SYJFRQ0XewUewLYVQQ+gNGTTynoJeK2OfCy46IRHf
         VyYlF35LcNTR5Q2QaurVP2//vjG1An+fLgLRS7h7Fwt/NJrxduapgpa7sREHOWySl5sR
         w3hCozRuZ5txmOqmxcbS+ULKxL/DbV1CKWO9khwBsmybZs1N2e2wCo7CvhfTsTCB0ZYP
         ceuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090846; x=1779695646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZIry/uS8ZFI2nZX4B4am8kKwMyHaZt8EZw4IRUQPLU=;
        b=QZHYlm9Z9hha8ThGAZvItXlqSMCFmzPm4q7ZUOHZU2eV3t9U0t5DgvHfNMDoHE/r56
         Dbhrl4D79S2lAdTkyBcgXEQbyjPDvTBauT7f4W1jm2vpwD7rpTOfQQ2CSTBPUDqpnyUb
         O/Iy0YgyV9rwuGPXrE/Y4jLDZPYDvUBT8EU92xr7VN3Fw8WGUvOhXxQ1/0PGc3mwc7sb
         jhPL/s/OtPVdZTft5aFOGjwoiDnwOpFMOP96/dif+zWtxmC5E2uAtTDTZ2cCEZKAMUdF
         DC0nDx4SgHrUm66jRiRexXoyFt+utEiKeL9s1uBLEbfZzG7Xa3ZC5f6H112s2TRjgjGm
         WY/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Xqtgz+JhcxgpL0uItd9suZySxMU5L90IfofWr5ENw2klE6zg7dVoDaMcuN1yuXAeWwS60i5F5N6aI@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPss/Js/zcUYgVT/1fwsFmLny6hB5Ay9kn+jdRR9Q+n+uxAt8
	1oQgi81agTIFvXp7rtw8NCMVFNEHN2zSWVfD153LBLzzWrmji/BSKtOA
X-Gm-Gg: Acq92OG+WfCQTkGCuxbgHNaLDXczWYC+cMfqZcJjd2tHL2IWms8zFmIsEpTdLQesp7c
	JWYmZjfLOqgq7MHuJcXU8oXC9AnDRH6pWLC2cs1DRMMZ2voHGydR5P22cP2joeB7mdPglMwc/Zz
	x6nPxSzkLVsj8VzTk3elvlQEoxiiNmBGrOjqETpuzyuopw1i57DlHOV8sjs9o9TzTkXT6NVbWy1
	qTYG2FjiePNpff6B0ZZV+520wGpRLBsOZkhi1s1faNg9kuVmuS9W3219RQDzeCriou2UE2VM0Zm
	zoEdJGqnv2KT7sRP6EvK5OltPK5+Vku6QypHQRE0XfXYB9izme95Iv4ZBJLjSwD/5coKwPJ0SW9
	4t1NiHST6hlNHk3E/YrdDdVTBrx4Do9ygCbvt8LAMX1yyVV147zgGmSKVam3E5czsypekqDHM5d
	T9TzLKQwjicb1PKGs=
X-Received: by 2002:a05:600c:34cf:b0:48e:5990:9698 with SMTP id 5b1f17b1804b1-48fe651588fmr217217785e9.24.1779090845805;
        Mon, 18 May 2026 00:54:05 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:05 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 04/12] gpiolib: acpi: Fix resource leak in OpRegion cleanup path
Date: Mon, 18 May 2026 09:53:49 +0200
Message-ID: <20260518075357.112584-5-mscardovi95@gmail.com>
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
 drivers/gpio/gpiolib-acpi-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 90bda2d7da57..4c8cd2038aa1 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1240,7 +1240,6 @@ static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
 	if (ACPI_FAILURE(status)) {
 		dev_err(chip->parent,
 			"Failed to remove GPIO OpRegion handler\n");
-		return;
 	}
 
 	list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) {
-- 
2.54.0

