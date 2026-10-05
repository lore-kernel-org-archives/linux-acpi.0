Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD979CD
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168461; cv=none; b=rNm76yqMiQH4Dt83O7RqG7MAfrdK6/E1+O9EdNFvG5FkYUSouIMpkl3AoBIN5VoM8uolOBkUYKvkWWu7mjMaSVx9S1673NJ50Bt3YfBF/trrsBR3fXY4ht9cYFqyVyyk17bsNcYLlsXWIaApmIiv+Vp8uYQsSjWOdCt5Togl1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168461; c=relaxed/simple;
	bh=ZgvtJM/DUHMnHszNUGeuhEtSEbOa/wydpZaLbhEugRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNP1A2bpsxGOezL/G5aO8bMb3xpUURCeHAyYBblQniDzd9fqme0IqVR+kjrbsy2z/AXC/QF82jbL2xc6ZYPiyf/O48jZj/i2LBQ9SKUbkv9AvgflRF6ILJtcu/o+iO2Kx8vAPJwCdjwsVILJCYKOs5E/KnVuV8JZ54u98n4kdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwCEx8N2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwCEx8N2"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2bfc2540cso2973125ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 04 Oct 2026 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791168459; x=1791773259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fPN+9NWOFucdGixkLZfdt14fhztpKr2pAx7CYx5nGY=;
        b=qwCEx8N24if+xWkPq68GJKkKtl9s60/nbKvwaUX2wbOwRBayypmyc1KZdpnNltelEI
         z3jLKgRVzal74WKXy3R679RxS8cVQI5XCYe6tsSZu47ukr2GhBmJ38uPsVD+3ns+hqoY
         j4y5444l5+sJNRYec2IhVNBrRTSxgd/6zwtBL2qp1Yzsr916lfnIRx88vx6MGrJIZGHq
         Pcgv9o2gbXAQzFbOn2cx2jwNNvnycjML6GI77DBDJqrUnrUXjLXSWu05VEvmxUSz/y2A
         9gCprrmvAsoBgeRbscyjmVpeVdpEznSEhrL7GOxUnJY8TwwSmIz2nqRoYC9Ix7mW91/L
         U/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791168459; x=1791773259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fPN+9NWOFucdGixkLZfdt14fhztpKr2pAx7CYx5nGY=;
        b=W+PgzUrMvsKRh4a1pcFMugXs3uRxtazl8CnCoy5AzsJZ2LQ2CfWik60lIUEqdT6DSr
         4FItZdb97gCKOzd7sDKKORy5p8NN3oXEOlIwbpkO67uBn7tNfSGsEFuOrZdbxP7+ilgQ
         QM5XXQ8u+/aH37VLZEe1CwJQ7A+ul6cbnvZtJDnNiP1mdOY8PjWYHgQTB7PklrMwHX04
         ZdOkXnKypmYYgI9+fu6akBuuoJPyIvyv4a9fdhjCGI3zKlpgfqzZM6R63qoxygKv56wE
         bK1HFqY5dFT/mxivUhjd/x4vNBGLv1ygiOrmfaYb9247Z+CzKko8Id6I/P+5rrGEq9L1
         lIeQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/DnqEd3XwfS1Mq9U3VlkPljAmf2fdMsQIs5wKydpH74ZNtRnrm6tQ/+QUuJq9Zxt/xMj67W089anb@vger.kernel.org
X-Gm-Message-State: AFq9FYIaIyDgvIJK+zhKaWwqE4zljpfSxfCdEB8SysOEBXB1o6Ijcjpc
	Ml6zfwsfk+YKXXcWBE52CE8DPJSlvjXchlUysvqEi9WEQS4Gn1kHs/eu
X-Gm-Gg: AYBFou2n55MpGSmrgdqwKZNbXBDWuPJElqZrEBW9EK4jFR2SPeq9DiTh1VIC1j80EES
	foMrytEiiNMjibz6s6ghdFEkbHvEUshcZC2w0qvExsax4uGdskkjBzFaR4lDzQ+xgzElvfhHEsR
	FpH6BwZ/Zi9MNULtxqXyaEhrf+lnamgzSPBalKLt15lypaz0wchJCy86/S0LkhizUGhxoM7GfrF
	fyGqgFX07kw3zpI+w8ccjnIK5hfyoJsYmzahNjA8DtSVQuOGQAsRJ5DbcmH2Ii/FhfwCeSuyhcd
	zrsdP7JOr5C8tcbMcSp7V525RVSc0eYfgCS7ZTdulWY2Gf+oTThKrfWjXqagCh+yRLl+4vl+TKY
	7ZrrG+dS45W35Gsp3hdf6ZZAc+QGLzcIoOyxO2CpSQocyBX24FHnEaq3wIQ+GsuUWEyb4OyvXal
	/M2ln3MbpB8HrmWk1qQZaGQzYJXV10Qc4SVnPZtaR6kw8Beqwu6G6lW6IRTyzXa7gbMYCeVztkz
	W0Kc8z+0wQAx01VE06gZsEFpGe8QV4ZH2dSR26McCGheIehXA==
X-Received: by 2002:a17:902:d511:b0:2dd:c100:4b85 with SMTP id d9443c01a7336-2e49b6ea3b8mr89037265ad.60.1791168459101;
        Sun, 04 Oct 2026 19:47:39 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([112.2.158.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ef5576sm744665ad.72.2026.10.04.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 19:47:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: westeri@kernel.org,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0662 to i2c_acpi_force_100khz_device_ids
Date: Mon,  5 Oct 2026 10:46:54 +0800
Message-ID: <20261005024654.26888-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918055653.GD106095@black.igk.intel.com>
References: <20260918054109.23550-1-xuyuqiabc@gmail.com> <20260918055653.GD106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi,

I just wanted to gently ping on this patch. It has been a little over
two weeks, and Mika acked it on Sep 18.

Please let me know if there is anything else you would like changed.
Otherwise, I would appreciate it if you could take a look when you
have a moment.

Thanks for your time,
Yuqi

On Fri, Sep 18, 2026 at 07:56:53 +0200, Mika Westerberg wrote:
> On Fri, Sep 18, 2026 at 01:41:09PM +0800, Yuqi Xu wrote:
> > The ELAN0662 touchpad (04F3:317C) in the Lenovo ThinkBook 14 G4+ ARA
> > (21D0) intermittently stutters and drops touches. libinput discards
> > invalid touch coordinates and logs (rate limited to five messages per
> > 24 hours):
> >
> >   libinput error: event6 - ELAN0662:00 04F3:317C Touchpad: kernel
> >   bug: Touch jump detected and discarded.
> >
> > The ACPI DSDT describes the touchpad's I2cSerialBus resource on an
> > AMDI0010 controller with a connection speed of 0x00061A80 (400 kHz),
> > and the kernel does not lower it for this device, so the touchpad runs
> > at 400 kHz. This is the same issue previously fixed for ELAN06FA and
> > ELAN0678.
> >
> > Forcing the bus to 100 kHz was tested with a DSDT override on the
> > affected machine, and the kernel confirmed the override:
> >
> >   ACPI: Table Upgrade: override [DSDT-LENOVO-CB-01]
> >
> > Before the change libinput discarded three touch jumps within about a
> > minute of touchpad use; after the change no touch jumps were logged
> > during more than an hour of normal use. The patch itself was not build
> > tested; the behaviour was validated through the ACPI table override
> > above.
> >
> > Assisted-by: DeepSeek:deepseek-v4.1-flash
> > Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>
> Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
