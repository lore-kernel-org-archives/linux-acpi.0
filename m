Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1323E35F
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678811; cv=none; b=C+vK6yk+QVztemKZz2PGWbb9S0fCgQHancZxCS3HSae241x51jACR+SK8zUtiyDqJBzF8kniIBJhfUOVOWcEpZ2OT8o1YxWNmL2hEvnQwIbyk7Z79JU4U864w2Fr4IEgkvUl0sXCYW0+rcWHd7TsjQAFSB2/oR3nlMnvWLYN0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678811; c=relaxed/simple;
	bh=QWwErNpqv9uWN9rVARPXI2DK95qHDaFyOvIjdYDloX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVpgkFatBOGaA+XoIKRjQpzcHhRqKz9wRAJZvqGHZYXjXJIfDXuH4Q/otzZRgNrDpxLK+pTURZQAuSBP3GEGlmzYmCrsNjEn3LU/jbSr8BIOp1PMeg3W/GCwXv1Kd6uXOovFVXZIZSa75FcVZlw7IbV1sIIEqE9XldOTvZ1siok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjLWDDqJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjLWDDqJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so32042995e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784678803; x=1785283603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWwErNpqv9uWN9rVARPXI2DK95qHDaFyOvIjdYDloX8=;
        b=SjLWDDqJEly9VvgFcLBjbd7/qt2VNMOcvnJyV7ngpmGSVMSnshLVT2USgpg8yF9UL6
         WSZ5dq6nt+eP7wCh/6Mdox28cViJgSuuT5S+J4xGIcGKwKdvJb6r981lBJcfFWqGSgtT
         +T7J5fn8lOLhPPk6XwVBzKYM1O+J2YWPCpl0KN3z77TlU4DG5vnh2E9tDNZizrvHVEX5
         OSZ7A7nAO0II3j92zlS9i4dfjXIAV1sw1oRWS3OrpkLmoy081IG96D3+H0zewhmxQs5D
         vLLhuuijcrKzktc8voYg+/eA39/ELonXXBFJdMAiYSnguS1yEPpaETvuPUQV6fkOEO3H
         F2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678803; x=1785283603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWwErNpqv9uWN9rVARPXI2DK95qHDaFyOvIjdYDloX8=;
        b=dw0zJ2XZnwWDgMhmAiLfTyw8aPOGd1/Ypy0qd8GIXeT9QmFVbyFNc6CwSG9S/hv1TV
         FEkOkx0JOjiq95lAZ0wOZLsjlDk0XINuCsaZz325+FTImXAIlY4cJ2QLDnPWOnI9P8fm
         kRMYpqBY1SnezNiaMz/Aeb23owjTEzswTdB8JNNA1DbPhBVjlwlClYwjlK4uTq3nq0EG
         Jz+jETHZEQkyrNuiLqTlEZBnw4Li3M+T7pP+IBcSMrJNaSKvvXlLsiv561aqDRRsuGE3
         PK86WJDR0v1iDbrCo0Ray8djhYInpvEFsgqoJOGcgf9Pb0IejAUr3u74bvKWqcmeD4GP
         boMw==
X-Forwarded-Encrypted: i=1; AHgh+RpiScR+PDfSq2sMnxsngrLZY8AM4j2tyhy4ci8OmZR1eFXi0crg22AXIqN92uFmO5jAUIP/jZm3+Pll@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aIyMD0Xm1+5pkxV0BBNAVczuaLE1P3x1PCxhjSRRR+6FL6UH
	RAgOhWU8lR1WoKyMJLCxMI/H23+v6FjdUplsHyQL8kmCQDPJVmLHZ4Mw
X-Gm-Gg: AR+sD10+dlIfD09ozw8Bg8/1D3OHS9TlA6OgFw8ZzvWEVt4zpOlS+osF0/FZDZV08t1
	t6GBCSVAlCny7Su+L8V6lPyAaVpfsxNW/dJFT9nE2G62o5B9mCqjdyL1rpHdyxv8E7YYKd4iW3E
	kKasgbGwXedxiSxKXYur2k91V8ryrJT0BUecuEOZ/q43u16VeffJi1JM1OaIZmf8NJS1++5gHbY
	GWSfH4Uqhr+06w8WFI30mtIbHFK3gvIvT59xvS1B35c+hNt5X+lpyDsmaMXe4nyaIWhwmjR2VhP
	eb2lUW5PQC55hAYJWI4YED+h6U4xfKug6HlZhz5mYTN01VahoOeMKAltN0yDz34r0Y4ZHCY9Lzc
	ghqepC6defflhpgAMjKg0m6IFNjJdcpEwaydcj2yV9s2i+wpWsovlfa5E5C3ljfLpsYoB76E30i
	PzQ4UHWP8b34p5XTj5G8KkgAPKtYpuBcpebTNKSB3JqccBjD9KVXznLOju3Qps+4A/FApe5GK5
X-Received: by 2002:a05:600c:3b26:b0:493:aab3:c09c with SMTP id 5b1f17b1804b1-4954a40bbe9mr236184355e9.28.1784678803084;
        Tue, 21 Jul 2026 17:06:43 -0700 (PDT)
Received: from c64.fritz.box (p200301048f0fe900a0f9605663da8872.dip0.t-ipconnect.de. [2003:104:8f0f:e900:a0f9:6056:63da:8872])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm43335235e9.10.2026.07.21.17.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:06:42 -0700 (PDT)
From: Saverio Miroddi <saverio.pub2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: bus: Avoid misleading _OSC missing-feature errors
Date: Wed, 22 Jul 2026 02:06:32 +0200
Message-ID: <20260722000632.2285535-1-saverio.pub2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722001452.019b3e32@jic23-huawei>
References: <20260722001452.019b3e32@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Yes, that's my understanding, with one qualification: we can only infer this from the returned buffer.

The returned capability mask acknowledges every capability requested by OSPM, while OSC_CAPABILITIES_MASK_ERROR says that at least one requested bit was cleared. Since the requested and returned masks are identical, those two parts of the response are inconsistent. The protocol-visible result acknowledges all requested capabilities, so the status bit appears to be a firmware bug.

I'll clarify this in the comment.

For the logging, I'll keep "_OSC: errors while processing control request" for every error return and condition only "_OSC: some features may be missing". That preserves the firmware error report without claiming that capabilities were removed.

Best,
Saverio
