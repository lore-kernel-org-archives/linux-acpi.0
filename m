Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD0344DB0
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221081; cv=none; b=YJn0O+EiYbmaw3j0YQzxJGESsqT+aP9pMQoBR22ZfDz3wCfFiAhsxD+YwbjF+dQKmP6icDS4MCWUe0RKtAOC3jizolBSRVwU/81p738tRnz7Uzl7BJFmVRy1FluF3xcqrxcbpB1LksxwmORn0Pu1hmeSC5d5Dsm6m33RIRhnj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221081; c=relaxed/simple;
	bh=KmpGLWa/5yTTXSH2/642FLRpd+4X72Pd3hBXd7rY5oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDV0gMH64+oetjWjzTxr+x8Prt4pVlkZXmc5p755EC/HB2u7AUJbHKsarOvV5X6J4mjkt/g2uFRHxewWYdlxnc85cLGFPfycwT89IJxm0176zSYXCGEHi+VDcOxbAtBGy7a3XsRXqwOX3nK5WrZtIDnEhdVWzS/wwIs0nTj+k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp71GeG7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp71GeG7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so13366625e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221070; x=1778825870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4ypZKRffXl+RmRBDB4bV1g+6g5ZEEix6t6a5NRuqZc=;
        b=Dp71GeG7sxWbHNels+cFtNiE4Ywh/3gD0Fm7JsgzuUz3Fh3blMy9pAkHHW/91QNasd
         BXsK/G9xVuRnd4NxIa8/d7NSWEwqQpUuU+0XsQPCGWgXT6KeUejiN3V6w2haRQ+BCPV+
         fYrm20/TSoqU7uoWtCSbCKLw0xEntsutBTHr1Wcp6M8w1uAAfxb89nvxrG5lM34cOrw4
         GYL2WmiyJnSV18JnblE1sxpGtppqZTlJg5eFlqwAkhpSEGgwA5Cch9qRfiW9u/ZjNhRf
         q6A//0j2+1liccU6OevWM5UaOcClRGQvt+zAW0qA7QvrfG+tRabzUP+Sf1aF1p4fK7Gb
         gVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221070; x=1778825870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4ypZKRffXl+RmRBDB4bV1g+6g5ZEEix6t6a5NRuqZc=;
        b=ac/NOF4Fujr90lpyAaJGp/UZT7+NfzfF5C1n8ROhkCtdt/cnaUow/JTBhqTvRmx4mN
         Fb8GMwsH72QJsImNH07LrdNA27ZIp4mDOrYhGgopgUXLJNkqM84crtguAGZEOWPkjnpY
         BL1UpEYvSaTOe1t9E/gr7jK+d/Aau30GAkcG92rh1yqJaaeUIwHS0JB8t/kCrpAUvjqA
         FlQM5jumQiXXRrSUPecqEcZZpP2SWND3VyKU4kwLCJBuBVpXKU5aUg2s8nMWVslUnOpX
         Mjf6u+gkYS9Bn9G1hCK/+5SVPqldXjsptQ6juba48mwhCXAP5r1h9XNAQd4RJBpvusYr
         3f2w==
X-Gm-Message-State: AOJu0YyqgncdtpJornDMoCdh1KHBFMjOqLW0ZlxqJ7gCQhwFRImNdWkv
	NFYooNGeYcJXMqwA6vb+WxZMuK4p4uW3jV3bQwVq4k4ltzCiryKUwPLa
X-Gm-Gg: AeBDiesid/14wpgk+Qa3Yq4ZWFIMm8S/q3vvGPgiFzF3y5pwoVUZCVgSseQDvU7Ug1m
	4FVdPRxYW2g4x+qgsTHYSgyvrbViu28VWQQX2FU9vbdCpsdwFsJMPUJz8jXYF/FkUOB85NT8G9R
	voTavDPGJMZM/ppQ84NOLP3MiS5Cb8jxUTKWnvgexQyFs13SDMtaxqgY+L3qRk9wNfZbP9+c5Df
	GVc00jC96zrXn/fxUlAgKq7yArz9No2Drz/F9x4sh0HoG/F7zpFNoDeawvPb9M3oXoflHWQ+Y3H
	qfSmSAWumUPJ2x+unLVkxwSc29kDei6+o1Zs5i+NXhUkpS4aT23UJqVZTZWpUkoxPSJ9qLoYqaJ
	1FSazwivtkRJL+n3wQg7irGEF9k5OPnW3dP/swR+fqnTSWkxWsCNRUH+zljqUh2gkkxZ6kXfVIg
	IvfQKNEcw0q4zMl/Di58nt6nxocg==
X-Received: by 2002:a05:600c:1c0f:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48e51f3deddmr195989235e9.21.1778221070029;
        Thu, 07 May 2026 23:17:50 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:49 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 0/6] gpio: acpi: modernize resource management using cleanup.h
Date: Fri,  8 May 2026 08:17:23 +0200
Message-ID: <20260508061729.9530-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <afzlsRkyKQzuUcgL@ashevche-desk.local>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,
as requested I've added the missing Signed-off-by and related commits' messages.
Let me know if it's everything alright now.

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

