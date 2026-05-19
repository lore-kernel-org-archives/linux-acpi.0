Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A73B3890
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174048; cv=none; b=pbJ49+yUCriYyrnrlkoZ1qT66aY1U2JNiMY/O+3nBX5dInHSSZLOWTKdr4Cz65T6lXMmacpguaTxrBCQXwyhvNK9vu+sXUqn79WxD1WASytn12kFVpEWfc5HzJo36NNNbnZDRNYRLJAlf4cHLku2pOsG+3oBVdoHLi5I88L3weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174048; c=relaxed/simple;
	bh=w1tZIepQGFYtYFoENL99ySBr+/28OBAQKy+9C6Hd4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+OUzb5EtmwXiDPeCDnqVvIbaxZ3gK9pOnD3h1RX0fVw9HE7v18TkhXmSpNriypwEBgTgU0TAk2Sds8CD9WtzZxyi+TEre/9SDeQBchbgHO4SuMGv2DpKT9VkfEjvJcQURP9gKG0XCjDISxOuDoAA0m1lAPCGZG2C+mOVssyFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDKFodO0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDKFodO0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso35553735e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174044; x=1779778844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfcO+m7MeLV2HJwGHjH6JC9BxabHpLv6fyEA6WWIYtg=;
        b=qDKFodO07rQsMYbglOpUw4r0NFFVBCKayiYH6bhJC/WESUiWz6YupWeZEMj1K06Lz3
         FTrG41Wh0PZSharQTR+xYqPMoLJeXlVJpC4+Q1lfUAInob40pNCnLA33GIA/vB3yuand
         mOWAz3r3yrEbBa9/ESSccvcsiuCAQX7sAK/XXBO9PaC8vvnNhGszJiCH5mNFmfPYZdUq
         b/jnSA3ilpNcBg+UVvdcd+KY7fGIWWHt25Kp4czxRrPiqqk3klTY/MccZWibO1rxPNgd
         d1vzX8hEEkMPfg0fTmNZu5rKd6fZOHJrJBnuXpl6jDyixHhSIv0ROtjOe3VR7fzHvsa0
         ZZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174044; x=1779778844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfcO+m7MeLV2HJwGHjH6JC9BxabHpLv6fyEA6WWIYtg=;
        b=fMmUc6iqWeB/wxxhsWySztL92Q7hJj1HamRddPq1x2dn+0P4hRyFt3Gu7APCRSzpr6
         Gnqxl9bQuTYB63ZLG2Agwp/UWHd7+XTmxvc5y2eMXk6DydQl2GVV5WdJHTrzm599Ge+d
         D12kvIPDIW5c/dCorFYEGdA3ZvqOy8msIyt324j40Cl6H6Kg+zxgeaIcPiK7ES3oxk4F
         aG0WURkE8m9hHfzyuI0xyCe5DZ2ZbRmSC+5Dug3kqFm7WLoT3D3+i0emrDw1pXm8wFc/
         hdwpD0ubk3THVtamKQGyISGE0Sea3lUmb0ldT2LC0/PlUqEXobUdtFT3Qzz8Uf/dVHrl
         iIow==
X-Forwarded-Encrypted: i=1; AFNElJ/cnXwU3xJ8iJ3BujccmkgLYtqBHW90ZMNeUKRWKTkTSMA86JvhqVp1Sn8/JtuglHCnnC5TfxCcudoD@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSrrAD8DoBEGalwrAOY6MBDJ2UGkUuUNqbyVumHBbfkleoGr2
	68PVJlmIYxVpTIa6P8QwJXei1wj1SWYjgAf9KO05/AiThrXWPATxMv1w
X-Gm-Gg: Acq92OGKMNsGZCCw+vkCY+VwsGsa8QyU5G4V8FktFFPxF2ukKLstjIMP7X87uxxpuCv
	gtFLc5Ski+Y9SgHhfy7Zqh36qe0eK+Fiu8nyBWyrck5b+QXDFCFqG+sSPgfGBqq2BY1VpJrs+jW
	37DUtE/fzmZh7FjUAJNeljle0/8aFrehWQS1uPUl44JIMzi57kQvLIqD5sBajj6qhF2rlWhZNbp
	ogdfC+Oaaytfh02yqtMdFfeEwwThT+jTtfoVRuELfKfhiOolki/gnwdppn4I9WAvuG/yWDIie36
	twHAtxWAHBHKSQ81JN/NeOa5VXy5NgSxkwx2tZTHJzAxltnoihOinZ668xcZerj/nvFgHamYSoU
	6q0gwoykwy5sIBFmNX47XXttsYzxt/FbyDR3/q34bIWa09o5wQPUIdCMw+BUXLhKjnMYc86V00b
	mTt7oiG32AeFiecpCTe5UeJtsUUDfVmQ==
X-Received: by 2002:a05:600c:4e46:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48fe632243cmr299893535e9.22.1779174044168;
        Tue, 19 May 2026 00:00:44 -0700 (PDT)
Received: from G614PR ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm149177055e9.4.2026.05.19.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:00:42 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mscardovi95@gmail.com,
	westeri@kernel.org
Subject: [PATCH v2 0/2] gpiolib: acpi: Add bounds-checking and fix leak in OpRegion
Date: Tue, 19 May 2026 09:00:29 +0200
Message-ID: <20260519070039.9280-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518103302.GO84797@black.igk.intel.com>
References: <20260518103302.GO84797@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy, Mika,

Thanks in advance for your time, patience and your feedbacks.
I decided to split the original patch in two, one for the fixes
and one for the modularization of the code.

This first series includes:
  - Robust bounds checking for pin tables to prevent potential
    out-of-bounds reads when parsing malformed or empty ACPI
    namespace tables.
  - A resource leak fix in the OpRegion cleanup path if handler
    removal fails or encounters errors.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>

Marco Scardovi (scardracs) (2):
  gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
  gpiolib: acpi: Fix resource leak in OpRegion cleanup path

 drivers/gpio/gpiolib-acpi-core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.54.0

