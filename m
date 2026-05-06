Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC6270540
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071021; cv=none; b=a/e2qFw1VrcuKwxNR4nwBVSVWXmbEDsYrcdoGaG7W7XnxZ2j6P8y2nzwpYLIPgahYUfoV6zLxZAXtlK5nmsvnI1krnxUxv3XWfasIMppZdGAWTRBi7Wpb+3Ml5caXwznzB4mRbwmypn8vnnEDj+LDwxyRDX5m9Uv+WqJ5ewEVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071021; c=relaxed/simple;
	bh=cApX1dihbn8PQ41u5UpHALMQ0+hXvurYSyFH0ym8sdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhKI3o3vfTQ8VcGKXf3E6SrPSjU63u2vh/2WuErPGLHc3Bo+00A9nJmkz39DUzizR8/45ln3Wj0SULNOVACdg7F9aSsSoq6JaJx3pXU6h6/0POyRMVRB3HZ/bQ12E6Za922WiJwF+QvdWz4IWxtgKvC/iwzphi8K9Z0EBhdGEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTT2ogFg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTT2ogFg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso75163465e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071017; x=1778675817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o/09lEmBoTZNo86PdS11r1OH5tVpbMNKESkbLzHhHg=;
        b=kTT2ogFgo4lSi6JzJsobmBtNM/5KcLFIB1SQF+5yGCY2N/LpjmfsotZIfV7eSFo4qT
         dCARjV8ssuJn5/ZRdCa7jljKncwlHP8oH8vBpRAhPegYFQNlr18s0faBHVq8JvhqB35j
         RgXhbcl/QZKbkmn3B6VOviU0Y64zS9VAVsnESRXfPvAwUB48GV4Ni9ABFTlq7lA+tJG8
         6ONoaFTXoSTJFiSWYErZhh6PxxamyZ3wfLpb+jl8oeIJj3Lb5JXaV7Doy3zHBKe1lXzP
         DgCGodgOc5F0ESyNczM5otV1DRQk0OMmlvlR7MpYtuZC4an8t4OEb2hhrlMhnOt3PbIJ
         3OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071017; x=1778675817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1o/09lEmBoTZNo86PdS11r1OH5tVpbMNKESkbLzHhHg=;
        b=BN/8nHKNXP1KQo7Uu20uG0Z4KqxaC55NELRc34aTha3A4OIf8VteWWv/Blr4+6BMLd
         ACUOtxnAlcUcjD68zd8AYgisfWWQWEgFF3E++yw+J4sRQ9MMOgdNhW1HB+DOeiFRQ5co
         W3pYBwh+vPvrgNON2Qo2N4hgPI37ELF1c2QXW5qfItntOlNLdv+DwdGrX8Nf3lShigMN
         Oh4phBGKvJoVMOD1Yu5/3jmn/hyaAvCKIBwMYphCl31XaLnXX+xlxjCobQjkytUnobpW
         CRxtSOGWHshXtSxQ3N+rNXZon1wZNnVYx63ANIgDHCk0DuUjHKU9KqLqNBte2FpjT82S
         gYtA==
X-Forwarded-Encrypted: i=1; AFNElJ/z3DluIJCQ3ZRhuiUZE/o2NyYMcawqMyF9J1ZR0z/AxCCtqZPhHpJ51JngeUOzhtLBYCJBoOlDPWMF@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnsGqos1xn7+bXvB1j903JYj/WTnZzjaPvjmdPZbNzqWZGsom
	zCv1L2Ad2Rg2KdpUzXnuF193YSz4A+WdGY963sVjHInCGB4Pkk7Dn5lZ
X-Gm-Gg: AeBDies4IWKNdwV9uGxcfhajoBiWhv/MVVgU3gplpWlrY04P+34OEnlBAtUuxE49qZv
	T97niXcDfcUH7mYuAeya78/jkfHkIrK37xazPyIrYQvS4ryuiZXj0EK+RMNBIL5JhTgkMBmH6V+
	yHd/8aWyfaQRhmORaSavJKDalbOT8rf7VpozRzbuRzrnIwp3sFlqzS3JQ2cTLI9Nv4rYcN5mfJM
	MwdgkymRsghwP5TEwR526jRqf321Mioi2yVeWfd+Vi/pm6Ni5UrEgArqgSF6s5bYpWjtV812kdy
	CmP/By1KhDHef74ZbBDlbRnWXnz2pBfIUV3tD5/r8s3bu1W9+gCY8FD+WbiYnFlFuyN8GFSeYBe
	7318GqKrkzp/oWkguIvLBrDU2LukFcsscIT8LJzhbBoLtJDqX1oHsVX/k3H6R394PTR0uswMAIt
	Cryb8em5kgyK59hB32Afp7KSBfBA==
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48e51f3054cmr61078965e9.18.1778071016590;
        Wed, 06 May 2026 05:36:56 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530cf964sm31767485e9.1.2026.05.06.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:36:56 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v2 0/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:35:33 +0200
Message-ID: <20260506123637.1077421-2-mscardovi95@gmail.com>
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

