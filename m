Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302237268F
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263402; cv=none; b=roBPOSrMwxzAJzOzb9vaAkICwdSt1rP2M/9rsRamkWg1DQxhYyoCpLEOdiZYw3AF7+IVQSwdhofedvn/kM+qGLcS0gEvOwKFmJr1KbOWmDGDScdt9XatO4giEEgGo15JXn4Pu17t51c8Op8+idMu4XdRRzlBHYzE6ebJnEDB09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263402; c=relaxed/simple;
	bh=BnIfkijOqhETRqAvk4NXBGnVXN/QWwu0koX8lwy3/tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViyDc4u7eqmfGA/F0nuVYkCxtqFVz/ns1qr+54BZuXTHFNjuuQ/VdZ211Gid88Br9Y2UdHNZGxbXfg7+wPFaNUVYSUGpXp7j6RZC8Ma5Xrj61X/bRClXHtWR8HbYjlKP4gb/7re3qYWgUBsG+myJ8l905DXjanIMyIIh8sKhFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFFkTIw1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFFkTIw1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso22840625e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779263400; x=1779868200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZWSaEiPka45nin0aHf92f+9R1duVlyTxQYhDwK6lTc=;
        b=kFFkTIw1ndqYmpcDXM006kvjfbXWH2bTlIUC8TJTUqKrqXunB2sec/fq/2RNZIZEKd
         5Z/qKu5TQYvEpxfoz2MIBfVJ5oUtb8wHwOVwzoiuUqgsO3VK2RyCaQbAEiAReXfkbCyz
         JIJ2MJq1KAG9RMhEfW4xNqAOHtbXUsunLjcVqbwxfOvmxkGY4YU8m8pQBUiJIBPRwvjL
         NiHqT3Ky6hh6UQX3z0Z8zYb7Uh3T64WJrnXqNhR0R1eeX7JCeBFhln43w2guVlwAZWQ/
         ThbRD3aQ+QnAjhJqfm7VImCwcc6XSHSRyYcYIWtIAP1cMgO9IyYjZHSvaO1ldhv1JkM9
         55sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263400; x=1779868200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZWSaEiPka45nin0aHf92f+9R1duVlyTxQYhDwK6lTc=;
        b=dSmKIFayNbPSi8XwkDDiZELG0NairHF420htZwTbGDL1vFFQs3LtXnQQjUzNiHjpZj
         5FHoB75zkrVeqFQjl3xgXHmNGeTNrzntyWZfXv0fIzNom2gvFZ0km9U0LjQAFe5fQBmP
         rjyLNN/sLMSCosmK0Z5lNsG0oj7EMnTaVxSu3Ulbz7awod8ZFOHEJEkpHi27BldjLNEK
         YznkxWwX5O+nBH7q2I7bT8wlL/DauLlJzDkBKnlsb2RUXYl3rwxzvAFscjdQJ7Fg0NUz
         3eR+RlTtG3Jdj8ksph9eyfqPQpRveJe5USOkcy2XroXtYL0/2Yi/n0uWnT8Va/8r/wb0
         7fxw==
X-Forwarded-Encrypted: i=1; AFNElJ/R2FQPDeAPwAzzom22HJUqL78mHfN087jcTo7PR3x8NrB/gw8Lj4jhUuAkNazdAd9jCRxlduRwNKo1@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiCq8Vj4ku89sFAASrWyFDGepQkMnH1z41go0mt/6PvVkNVOe
	aY7jFx76peB19xIYBQuoE8hMfI7M4oIYs0uFS4JClua6kjc2q1idbVVD
X-Gm-Gg: Acq92OEmSUvG9mZvnY2HFvQpM2h7Ty2DLKQk09PNYdvi3dSeGuAv+Lqiw/+jZGhziRU
	OsOqmzOkJ6Bg8bcyzZXKsrgb8XnM3SxK5x6kRGakfB0+r4NMydNpSiYUVbV8lpoW4usxSOg5gc+
	bLZhfyJcTImbnup2HmBxi7cKy243lPx4eov7xddE/6dRJ8S1x2YlyLkjeQl+N96EX3dOkmNEAQz
	cpj3ms8licUlRqLqHKVB/V1vRJCoAN1q4DnAiRVaVcQD4uuo3JpyXIV4Kaf1QGPsKB+YSWGsEAk
	Tzw1P07Yunr5D1r2Nl93II22zrrsVLKVKOcpo2e/lX796p6uxBeMygAGDX0f7zUtFrJaNvZH3vg
	RerAYYa2B7XgEHALO8nsfow0o3O6P70pupGjXZdzeuryBICG/6c/iyLiun38ahcvQb/sW2PYIWY
	qEbWRIrWAtfgszpV6Y17k=
X-Received: by 2002:a05:600c:5247:b0:48f:d1b8:9aa0 with SMTP id 5b1f17b1804b1-49007bdff16mr199799125e9.7.1779263399515;
        Wed, 20 May 2026 00:49:59 -0700 (PDT)
Received: from G614PR ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm496536215e9.9.2026.05.20.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:49:58 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	mscardovi95@gmail.com,
	westeri@kernel.org
Subject: [PATCH v3 0/2] gpiolib: acpi: Fix bounds-checking and connection leak
Date: Wed, 20 May 2026 09:45:45 +0200
Message-ID: <20260520074955.55443-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agwfEMtEctXYC1oc@ashevche-desk.local>
References: <agwfEMtEctXYC1oc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

This new series addresses two issues in the ACPI GPIO library while trying
to address your feedbacks:
1. Adds robust bounds checking for pin resource indexing when requesting
   owned descriptors and querying wakeup/interrupt pin configurations.
2. Fixes a connection/descriptor leak in the OpRegion address space
   handler and handles connection rollback in a transaction-local list
   to avoid wiping successfully established connections.

Please note that some of these changes were found during a personal follow up
analysis before submitting the patches to the community. They are reported
to explain why some of these fixes are made in that way instead of another.

Changes since v2:
- Fixed a global over-cleanup bug in the error path of the handler, which
  incorrectly wiped the whole persistent connection list (achip->conns).
  We now use a temporary local list_head (new_conns) inside the handler
  to log and rollback only the connections requested during the current
  transaction, and splice them into the global list only on success.
- Renamed the global connections teardown helper to
  acpi_gpiochip_free_all_connections() to clearly indicate its scope.
- Fixed a potential concurrent connection duplication race in the handler
  using an optimistic double-check allocation retry pattern.
- Introduced the acpi_gpiochip_find_conn() helper to reduce lookup code
  duplication.
- Changed the subject prefix of Patch 2/2 to "Fixes: gpiolib: acpi: ...".

Changes since v1:
- Reworked bounds checking in acpi_gpio_adr_space_handler() to validate
  that the requested pin range [pin_index, pin_index + bits] remains within
  bounds of the ACPI resource pin table, returning -EINVAL instead of
  silent truncation.

As always I'll wait for your precious feedbacks

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>

Marco Scardovi (scardracs) (2):
  gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
  Fixes: gpiolib: acpi: resource leak in OpRegion

 drivers/gpio/gpiolib-acpi-core.c | 157 ++++++++++++++++++++++++++++++---------
 1 file changed, 122 insertions(+), 35 deletions(-)

-- 
2.54.0

