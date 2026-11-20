Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163197;
	b=3dh5MIuX7dKN9Bv2oFO/Hac/NpWIeGpYyjxBTKLoTbzveIWTxHpiQetXzFZkA4ABv5/5
	 iEK7MeC9zE3Fqzf16q75kIvNP8b9wDk/jhOGGihGDb5Qn0H/R2Vgecx4+vKcA1Ke+fUux
	 w/P/1K8z3h8KyY7Lse2fzwks5kTOV6Gupgwy5Pli/mgVF/nXRT+7Wc+tKicESqr9Ys9UY
	 kDBV0/YHBcIirozuP3PN56lJL6/vJMbxSwpn5oq+Ll8jzSbVV7fJyTBgzmEd+YmrhqVwv
	 ILWRf1S9gDx6j33NONFdWp5yu/3kxT8bRrFthBirMIOzjycvkW8N6G6vnivhlAridnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
	b=a8A0qK1vHRZYHpbW+jYGYJEtKq0U0yH4JLSUZdy4dfOuSk/JQK1qVcMkaL51xzAzyUPP
	 0nlQpZkksMaVGVZkLW4JZoa0loCcFB+n1IM+lDNhXBNEegkrXXPwVyYrnFDJMB/p7VsqL
	 wJxwi42qF4QDTnPYztndRDaGEFGZqEYlOCPu4O7sK5qEccaJuScIoxaTP8XiQLB8VaWLG
	 /5wPzGPZqHlmx4Vw6NyJ22zPfZcY1QoTJO7tktbJkSYmMupSQP1osjRtgStYNDNPeKk9s
	 VaYleRy1tj4YslgWecHHgFgrGadVkUt8hdtbrpQNI7cgWUU4KCvcQLLX5jEmHKAVr1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjZAjXLS;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1406606A320
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 08:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1406606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjZAjXLS
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2efdb4499a3so270985ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 00:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163196; x=1795767996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
        b=ZjZAjXLSv+F62wiVs+vkIAM2IBJstzIDu3Ch7zjXRc3kkhhEEiLBiNYrjkyyVkNfG0
         Np6iM7l44MMj0h7oO2WKnS4urvSXKhwS93hLZWflt3tcQxi255thH5ykO/dRh652HOmS
         jD8GIWm8O+oFERZxufC+cJA3FWzG/W7Z4HrWwN+hYzEOpoeDbxtXOrYgeuNHCpSeX0DX
         q+X4Ux2nCuzQmq7g/jTsG/BHMLhwEe4qKjmsZ2X/ZCQAQd14MPOxIWEbSEv8mP61XD7n
         B0hEXfWBT6yCLrlD9FiAem2/Xo/bOcTrpk7EP27pbfCFbJFMggS6fNc5gH/ntfL/fylu
         i0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163196; x=1795767996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
        b=Fq2cZ2fyAPm/aRP4c6mfc3UpWabNYDCOxMvvcO1O65sh3Oq1h2MYE/iT4bG89ok1DJ
         TkRhUaBKQ0GXQ5lw5Ed80vyjP5Q0Vv6cJPgTFtZ/ApxW/58RLYRJgvwIxBgUhlS4Lrtp
         Y5eVSprJtGyED6Qj8d+ppu4cIx1IEbAyM+saYZ4/PNjyYGk5ax+nBx6uiBigvPg1pxru
         9f7kHd2NXns27WelsA/i/s6fEmceX7tcCPEFUGfz+V9bEvQw/XxpCXmdeuFOG9qdJhCr
         iTak8GkQioMZxd2eWnQ5KBV1WNpu/IHdMOlG39ACogRx1jZ52KBSdmZuSjXiVmF8DPJg
         sbTA==
X-Forwarded-Encrypted: i=1; AL+hErGPgUVa1HnyrVPZ3XEw/byV1C+KXfFekdhZToA4VD4441MPAr8Gvr9CdSM9ewOAhtVKJAxbPmnll13x@vger.kernel.org
X-Gm-Message-State: APuU4Z/h18/Kz9BuY+sS3dLqglKhFdmoFMRwfcLmrKXSml4dQ7kaR1wt
	8jmXbaOppec/Sfi001/a7q4PlSYW0BvNw74X2Gumegn4eVN6At8qHi/w
X-Gm-Gg: AZFdTZe4oYSCf1T96izFNIq5C7sXTPxSrrBY8tUj5KLyv/dg623dG1i6z1RsYdD+PDf
	4GV5knVdVV3JOcDhvsvR3NLJktID5SZx6UoMdOoQnxNGhVOBnDQeAeYlOsuZ0q+bt6yfRwd3g7H
	XYkvZ/xfGqHPxwIDOqdcm0Lx/PoNsT1az+bgFz8Tdnp9eHP3gb6Ap9w2gzxJtB+i/OD5OyzWjX0
	YWM5ylvFQ5tyuE2tkoV/HgTuKAHeOTuWO8sBJwoLNFu8hpTvv2GLSzzRAHrO982ea3f7WGh2CA8
	5xs6R8w3p35qAGyix7Vhf+VR5x5OT96ImdcIOtVGmbLLhIm9EELmCutlLi37EB2glGlZSvIGoVa
	z2V4mlGgijnc9Y1WOqkeghhDOQNqpnW8KL1psc/21OihB2GgnOPZ1SsorH+vgn33W8SU9UYhqhS
	2TLSD1X+uVKqx8lyrB+pMXnv2ekg0musy1vZ2DfzkAJC0ULBxZDUyda08RYi/PVe+uRC/wm/vDL
	LIAP/aGd/Cj28yS82Zx+SEB/u4ed6c89+UrbcngH1Xz7LzgM3ySJ1ZCcDcaWbo25sqrA0Fu/zyj
	XEzAjLLXJ2ItBjab0lYnweK8GMwGVnX/RJQN8dcjV28bDRY8rI7GJMFLZnSJKgjEZNF19w==
X-Received: by 2002:a17:90b:4a48:b0:3b0:9984:18c6 with SMTP id 98e67ed59e1d1-3b41c907e3bmr3330845a91.3.1795163196016;
        Fri, 20 Nov 2026 00:26:36 -0800 (PST)
Received: from candy.tail8b50b6.ts.net ([49.0.83.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbdd80sm1472985a91.2.2026.11.20.00.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:26:35 -0800 (PST)
From: Krittikun Wongnin <krittikunwongnin@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [stable request] ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on[]
Date: Fri, 20 Nov 2026 15:26:31 +0700
Message-ID: <20261120082631.110172-1-krittikunwongnin@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider backporting this upstream commit to the stable trees:

  8eb2754ef96d ("ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on[]")

It went into mainline in v7.4-rc1.

Why it should be backported: on the Acer Aspire A515-53G, Linux turns off
the unused ACPI power resource 'PCRP' at boot. That removes power from the
NVIDIA MX230 dGPU, which then falls off the bus, so the dGPU can't be used
on any current stable kernel. The fix adds one DMI entry to an existing
quirk table and affects no other machines. I tested it on 6.12, including
checking that the root port still reaches D3cold when idle.

Please apply it to: 6.12.y, 6.18.y and 7.3.y.

It may not cherry-pick cleanly: in mainline, the entry just before it
("NLCC 001") is missing from those trees, so one hunk's context lines
won't match. The change itself still fits at the end of the table. If it
helps, I can send backported versions for each tree.

Thanks,
Krittikun Wongnin
