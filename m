Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43437187C
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734459; cv=none; b=FxCxYHD0vt0zB7JNU4yg+Wd2l0QvlKU8PjLrkdR68OURh+rCU/2qyUGTaSh6C2kwuXprWIb3Jm59E3Ua6jBSlIJNXffAVMi7VY3Ul0ZageNtXhwYfg5VMsi0oajgdZTl3L6UJlIXr90gvtkl62LFU2W7sFdPMcI//XUSApP+a5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734459; c=relaxed/simple;
	bh=DqJPd1rSSwOUypZZpKZJdJ1RFdfxoiHrYBUvtA3uynM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbIOqrMsWqnOkfa+mfMa64v2Ce90fy3SwN6wC5QafY2eGmS/qpYIX4fmGnMH7itHmb8uI5vO4z2UpZC38ahqmv/VaEwh9qPoSU4Pafs9ZpiOWH+ZVcKJZLIqUld4GPJBq5TYc9rLgYE6CQR5DxFgwXLIoOJmjeTs+lIox9PMPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U23rSAW9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U23rSAW9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso7256711f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734456; x=1785339256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZIYTDQ1CdLu48IBG5jErUfboeK44RLROApsJ9xnnSI=;
        b=U23rSAW95esiemn9K9GkJJXAYYN5LNdATe8S3xVsYYvmH4nuOAhZsbb92vMOxttN5o
         cABPwEhK6F4v9pg0eKsxOQwOQuA+1L9VxIi0x3I4iLssuAlG/+vvGV+3FUs1pLrt9P3E
         LppAGyL8fEAKH6PWyV6YUNGjFvX1cDvbLp7RmfS9PTS8akMfoh9BDvLkucyNgjW6ZO1e
         0CH+yINwq208PvBrXCETln4t7L7liaQseKYJeCcnIYrD+n+QmksVZ/Pf/JLh26QjvQPq
         bgnCy5sTkWiVlPU9HJQ+emIR/FXF4pMBZrSp0h6W4HJXlXuF4BoHD82Aw0F52PMQY8Ak
         GK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734456; x=1785339256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZIYTDQ1CdLu48IBG5jErUfboeK44RLROApsJ9xnnSI=;
        b=YTUSP09jCdKCAeKeUq+Fi9QEFcZsYVDWvVZhBKDwRmEg4+NB+rbqQKkzX5DS37SyF9
         4LYb0HMjcQ3S7Owuc9kAVuSKgU0CTEwCfguTwgHZN+NcShD8TrDHqsUT+FTj3vIEkv/p
         5oxvE33WdsnmWqXdpgs0WE81OrnSNVVkzqhkc05Dda++XSqt2ZBSzTyE24+v6Ju0x7Ur
         9NdFhAy9jI0HuUlmdHyhf0VI2hsnWsztBbkr0NeNazkirR712Db9n4oR295C+Z0BKTA6
         XwwbKOPleLWq5NKt4jaPUDtkfFv1byqzghIsPJssk2AOL3i9hMKf4xabBalYqlXfnYFN
         xp6w==
X-Forwarded-Encrypted: i=1; AHgh+RpllhpJJREJI2mDusL6J8CXmGDfTIe0KX+knwFWyhLGE2NUMy3GCZDDW75jWYvHDWg955OLIFjYsfsM@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+UwirhBueNjLh0rQFaVpA1ROjv7/4t/l4m4Ul6RXHA48t7dU
	objpfanywpX2JXDhnRt3QR2qg/xo1J1fP4UHL8YAvJEFt+hmPZe3JhxFYiaj2ZaH
X-Gm-Gg: AR+sD10vUwk+fgwKQP/1SHY4RGMAxlCz60S2h7an6F7px6rK4fTwqie6BzQjaINXdPB
	C+c8djJ3/DlW7eEnleho7za/yVijswTOdTSHh3wapn1B4QPWt6Kb+z6fsAiDnIWGKXe/gOB/uGo
	iSJxvODcMcDberNCTkXzCVOAMTyIavQ//xeCKi0l4U0Vus/ztrKwCIpNU1l0CtSF96Nl031F4fG
	7mWI3ONmCaR4J/ifka6UdoIfPFQGQC0Xnw3wyfJ04Yd766wqDH15DEZRl0Xk3hS5zubjtenAqH8
	jQpr0SKNE2LydaiBZR0p4SuQ5NeFH0xGSnd5TBrnl4SnxDFp2LS9ktbhCR2/VJ8sXkM2PluhA6q
	r/JMKnzXSUJRZoxZqE1BQKOh7BndwcJv4RcWGtAbQ7ji0ftYlMJHRJ5t3CkjMVP/jnUEZnkdl20
	FVBf2nXppSASW6Zt6QnP4mwDp9+ib6vzUuQH8bHCMKpG1B70NIsUnfo+QRKWr9YNvbkiN2xkBX
X-Received: by 2002:a05:6000:71a:b0:47f:4c5a:dc76 with SMTP id ffacd0b85a97d-47f6233fb3bmr28882720f8f.56.1784734455639;
        Wed, 22 Jul 2026 08:34:15 -0700 (PDT)
Received: from c64.fritz.box (p200301048f00a0008929cf80c219ff67.dip0.t-ipconnect.de. [2003:104:8f00:a000:8929:cf80:c219:ff67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6f076sm6891505f8f.34.2026.07.22.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:34:14 -0700 (PDT)
From: Saverio Miroddi <saverio.pub2@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saverio Miroddi <saverio.pub2@gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Avoid confusing complaints regarding missing _OSC features
Date: Wed, 22 Jul 2026 17:34:08 +0200
Message-ID: <20260722153408.21873-1-saverio.pub2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5143711.31r3eYUQgx@rafael.j.wysocki>
References: <20260721192914.1166891-1-saverio.pub2@gmail.com> <5143711.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I tested your version on the affected system.  The requested and returned
capability masks are both 0x006a7eff, and the two misleading error messages
no longer appear.  The negotiated capability masks are unchanged.

Tested-by: Saverio Miroddi <saverio.pub2@gmail.com>

Thanks!
Saverio
