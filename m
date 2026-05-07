Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCB29827E
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169416; cv=none; b=IxVN1pQBgec0wgdr2wOF08VmSI2Ldftof3ysSPQsFGpbBZxX3ey6sw6L+C3ig0zXcqlvReXEKldpI+4j+2Y1GmEPp/VWyjwadH8xa4EmLG6Mt2kM8H9EIQYBzmSOvkPq2VVtj+olx9aJj4MFSva73Se5i7OS+Pa8lXrtiRAlYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169416; c=relaxed/simple;
	bh=L8ZG5MdSMRfMYLK/Y/vQSssOeyeJ766Jb2gi3/xtKnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0a7X5TsqKe3NptgMw0wgB9NqGFi1Ev0Xt2TKJNPO4Ldwm6uZsuZFMEozwA8+0v8GaqPtaqq+jxbt9X5jhBqhDpII6Y38kYj082VQSViWwHn3t2CKAPD49OwR43si5XDG5pRzBkWQepoRyWx4KR6AJbtkzCQJNfd/IWcPUzRaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbLfc4BF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbLfc4BF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso11915775e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169413; x=1778774213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWOVJWQ8SVjB03sGFiTDM6pslttSB4g+BKLqIEqV8xg=;
        b=GbLfc4BF1gQlVfxD8tjDYAZQp30e0OhOG9vUr9/4q31d0bkOb4ygX+JZHjlcJe30es
         7N1kazFVijYvHPjK9/xwJz8ZFIWAzwu8qDQFm6jwCRh2p4oKCg7BiROVP+95N8s1R8hU
         KV0XDYbODQPfrLdKg5ovoKYLLIENJnaR3MD0HGUT/e7uecTpjETV3TKj/UtUMIr/aYD4
         kJG71O22ZoC/n5ZfM4LqtwSIAiAsjooYMeuaHF4CoKARbFXShWUuoGAeV6dz1r/oh8zf
         xLgoEDdHGiHgLXuk+cAmWCRzgu7ZCiHAqNsGfS/3IDo9a/7hwfYfxrkiBKv7tkGcL5nl
         X2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169413; x=1778774213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWOVJWQ8SVjB03sGFiTDM6pslttSB4g+BKLqIEqV8xg=;
        b=B8fxNh+C5VByMvuDH3dJuxsEmyEGBNdgf9bOphGfvcgLYs7CY3rDtgCDprPKNvxL0G
         y8m8Y6yCEygndLtAzR2I+adMw1LqJ8zjXvZR+5x1qSKvH/JSL+nfbjmOxiTsou28xSjd
         fxF5xneqVkRWhYzGPoAgg+N3hSvYaZB792j72VwafkAdhVRcEh43EqWr1A2oSDE+VOWB
         zaM6BDc6TG77L2sHzQYlHZw+OKKxtBrNR7Ial5jMxWEwV/j8zG10zKBe0yckv9N+ljLh
         b10cdMdhotSEBpJR83D9wFUFAsu3ImeJOycbxnh+fg6i6fbxsPJ1j67XjfdZ0HltjZiP
         ASkg==
X-Forwarded-Encrypted: i=1; AFNElJ/qQPk3g/46BB9tcoTqySYt3YYoJodAhZFfvIzyTVd+rK4VgGCh35NNB83CA6qQdtD/xGwdJ2aatGwC@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnVyaoLGLlflVXYw1BgK+iV5flbdUXs6RYH3EIOEXIRWwHjL5
	chn+qD2RoojZI5NK4b3NKnZ66OH5fLNrAoeD3dpczmY57ykZaorMQu7p
X-Gm-Gg: AeBDiett9QdH/2rAremeFBDiMcKmGgP0Mg/71kWhmYLKWH09XTQzZNUKQKGsF8X+OsX
	K88RabWNbn6B4ZrEcW677lSgERCTJagLBB8OlXPhEC/ANh9LTRZlPTTASActQGWPmZYodEU6ffl
	mhA30Av8yHroixYqW/du2sxe9oEOnmbpDPMC+aeT+7KCdy6NDY3DiwzyLoFVrd8ATUZUL8O9oyW
	Rz8zx3lzXiyeB/zXVHjgUD3KXVD+LdRCWNGLSKg4AsF/xj5ezm1AzCjpc5RbF1BHONrxGWQXCFi
	Yfwc/ktYzH0bNN+JawhVhDANGV5U0wpTV+nhYI7459itAOKRxww1y7IGOBv3PwvUi0rFcLZ8S0j
	kIT4+6i+nfvCP7AriqJ+oguzL2bfP0wiOdLDtpKQ9j+CMAPELXqHErvT5xQjI9BQSbCoCp3xhIV
	wvFlScZvQGUmFEKBIExyBGtgqCsg==
X-Received: by 2002:a05:600c:34c8:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48e51f2ed22mr157447255e9.15.1778169413102;
        Thu, 07 May 2026 08:56:53 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:52 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 0/6] gpio: acpi: modernize resource management using cleanup.h
Date: Thu,  7 May 2026 17:56:41 +0200
Message-ID: <20260507155647.403964-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506123421.1077421-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy, Mika,
thanks for the patience: I was way too excited about my first patch on
the linux kernel and let it takes over the reasoning and I'm sorry for that.
I've moved the defines on the right places as requested and refactored the
patches to be smaller and tested the build with KASAN and kmemleak as requested
by @Mika without any visible regression as for now.

Marco Scardovi (6):
  ACPI: Move DEFINE_FREE(acpi_free) to global header
  gpiolib: Move DEFINE_FREE(free_gpio_desc) to driver header
  gpio: acpi: ignore out-of-range pins in acpi_gpiochip_alloc_event()
  gpio: acpi: use guard(mutex) for conn_lock
  gpio: acpi: use cleanup.h for automated resource deallocation
  gpio: acpi: sort header inclusion alphabetically

 drivers/gpio/gpiolib-acpi-core.c | 57 ++++++++++++++------------------
 include/linux/acpi.h             |  2 ++
 include/linux/gpio/driver.h      |  2 ++
 3 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.54.0

