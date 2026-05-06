Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAA44CAF9
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071004; cv=none; b=YSf0qtVnYpSy3hXTEItpRNidSg8jcxeUiQ4pS6F7XHZKSmFjf/xmt9GheeykIN9c1QDNbtZQr4BDf0ny9EsYZqY6PkrTxI1g4i1bkCzx+uOxJ5mtAt+uFRYbNCu/6YF0BNqknVmUlIrPtCeO7ooaV6hndgNa7bCq5soXDAzgTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071004; c=relaxed/simple;
	bh=cApX1dihbn8PQ41u5UpHALMQ0+hXvurYSyFH0ym8sdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF/35gn4mHy09YfcnwOpbWvu0Z1miRVIzuZFeNZ/krH9xIL2KnQbMcz3Z2iayFAiPrwLuEItjpdZbKomUzYQLv21Tn0y6OOqmwScLFbm+FLGcXW9etJ+mqEz6tDdZq7p+5tcQYDKTrf5SVmLRx1POSwDq1cidhOcjaRE1bhhsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiMGIhpB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiMGIhpB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so62413855e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071001; x=1778675801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o/09lEmBoTZNo86PdS11r1OH5tVpbMNKESkbLzHhHg=;
        b=iiMGIhpB0stPvBYNqnemhwomtDdNNbmjT2JiBpgd78GoJvuarNPtTtZUXRLL2DZqu/
         vxt88esxGe+IHnSHeUKIFg96IjKRQh+1H/BWSaQXgE3oO4hE6qeYTfKUO0XoN6xH7Nql
         O0Auz3lwPfJ3yKohBQRFYGlq693Bp30LN7abnHCJm99aHBVo8mH/p6JWpp4YtIoEg8Af
         xieXfcMHq89jvMO2cQwaSqEyym6wBHuoaZ7fxGQTkXHG7xV3Qwmd/YJYoAuQkDxGeQbj
         GPjx7HAmN8/AhYQuAo/TldmFsNfFmG0fqbkv4V+W8tggpOpX87DdButxLbMOapSlq+v0
         frgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071001; x=1778675801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1o/09lEmBoTZNo86PdS11r1OH5tVpbMNKESkbLzHhHg=;
        b=Y2uPSRHx8EjRaQErlwRfAFKmhvSNJoactnEmPDHyEekM8h3UrMZolkAjraeXfg6Zch
         wCjuHzeAxYD1iOGgDSuZJhOu+07ZWkk6CMdHjlnWfgbwzKMQExiTMahfauWONTbeN9D3
         oLxW4QNUp6jO1pBbRJn+VsPeGx0E3ccqGDjGPV/NcYqyKWMHDoUg//4vmLeGL4NPDCzn
         JwKc0Rd44dD4TGak5l1mPtzcA35o/Bmr+ElZDm1sikiD6bI8/m/D744flLTVc1OBkQv0
         muhKWE/Eus2fGWnYH52PEQavpcmWwVs+lFO8+wZvOkHTwJ6aFnE9PU4y0k7SeMc8z9hQ
         1tjw==
X-Forwarded-Encrypted: i=1; AFNElJ8b8XqCYB2+RPybmyRd7qrUXjmZgtAmsCFKWFpE3NHmCSXTH/nJaW9sZrEQQnqdRimSnv7RL9tj0F7+@vger.kernel.org
X-Gm-Message-State: AOJu0YxT70ckc8OG4lah4Tawu/ViWQwliV60Y2QWKg0w7+3HwaQcYc6C
	SuUDpx8jDdX24AZEzhXCMEYzPQlA6S8MFWcIt87R/mMiO1HPMLtTQtDI
X-Gm-Gg: AeBDieuLy5PD6rnfB5dqp3j0KmQU7EiRlmyjd7BTAbHTUtgyZpkmoPHRGmLKo6N03aU
	7jp6w0Bz5uQl29r0G9tGaB89j/MT2pbuHlCB6/hzHRKB40tkB9ZVAlayA6wYVUkjP7VtZasc6Jz
	+SDYDvqO17HARmFp5+2To1vy4Z8EGgu5Cv2SNmGrPJUmonqNGWYNmRmmbLmJ4H4Qz6prShuMjlo
	wZjIxL/jv9a78JkKLNsUd18Iiq5qXkFIXV04d8Yl6h7D+dgLQ9zIGjL6c/2bMYn/esJRXk6wcjG
	m+ca0CH7CFu4X61AY8eJiOloG9LPOm4E53RESYFPwJycmUMlxKVp91a3RkdYpEzvy/eO0bp4DCv
	u4saRWKXq+ZVBYhSQp2lZqu0rCFyo2XFpwFghYdnmKUWzU21E47Ph6gZ4vw1pRWIk1bsiqARI0B
	RYdhx0p9fjXdsWcJN3hLKmJGSQDQ==
X-Received: by 2002:a05:600c:a10d:b0:48a:563c:c8e0 with SMTP id 5b1f17b1804b1-48e51f21e7bmr43775645e9.1.1778071000773;
        Wed, 06 May 2026 05:36:40 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530cf964sm31767485e9.1.2026.05.06.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:36:40 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v2 0/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:35:32 +0200
Message-ID: <20260506123637.1077421-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506113215.GK6785@://intel.com>
References: <20260506113215.GK6785@://intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Hi Mika,
thanks for the quick reply. Unfortunately I noticed too late that thunderbird had
broken my patch during copy/paste. I'm pushing it again using git send-mail.
I've divided tha patch in 3 smaller pieces: let me know if it is ok for you and
Andy. In the meantime I'm testing it against KASAN and kmemleak as You suggested.

Let me know if there's anything else I need to improve.

Marco Scardovi (3):
  gpio: acpi: modernize resource management using cleanup.h
  gpio: acpi: modernize resource management using cleanup.h
  gpio: acpi: modernize resource management using cleanup.h

 drivers/gpio/gpiolib-acpi-core.c | 68 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

-- 
2.54.0

