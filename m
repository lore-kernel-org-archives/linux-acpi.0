Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358169;
	b=ntqEWdTsytr3guJ7QS/8xAmGWJhLw1m3+QlZkJxyuf5FGOG1BWuKp+CpeamHhlu1fDRI
	 Vh4LyDx7QDpl2K1PkKPFt15aIAZAl9QaH0ytAPA9ZpjDFK6g2dqAYuR7z9WidsXlHwLjX
	 7gMQCBt870pnqb8eLi9UXN/3Ro7PgT78BDSkI66E1nFASR7eNdmayHq/FGeIdwuU06DTF
	 cnu2qLZEqNhOjulfleE0nFKGb4jlBHNHpEOQ/oBbWj6g4rQjEtI4EZdqy2rKdOIBWp9//
	 jqY5sxEcSmlcFNV1c24gRsJGQrL/ivufPDUrECXIqYsuSXELov/cZfyKI5LF+LzwOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
	b=gDEIwKsXgCJ5SZp98uXIvftm/rOpFY0cted3xqu3yvdz6sC5TmkA4oclRZj8gcMqvIkZ
	 yzXvEXXeJJPVC+dj3QO82M4qkxhDKj8FiytOGv8BzfDM6cLk2YaGjMl52Gm+1g1hmp9L7
	 yW3Wr35yOskKHcAEzJz5fNCw69IX1f55WWilLJJJ7ZxtVN7psFU8bnBbviGFWRJ5cX/P2
	 oYjftpoNaFhz41+IXBbfc61IPRQIWj2Tg94hrKsdn1AgP3zfaaz36MdltaVFWwnx2/xeb
	 goj+kJo+8oZdxMmbIY4+plA2bYdu4AI8RRFooDctAabV0bC/usYl5MPl6l59+vLL3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=I3PtcBJ0;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193A606A32C
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B193A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=I3PtcBJ0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so1308890f8f.3
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1795358167; x=1795962967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
        b=I3PtcBJ0exH2ZGLGqWA4fG7e53pi9gjgl9qRJVQMT5ixEAMFvDJ4uQcVCan8Ca4k4A
         in0gcxUzdJ4ne86ycH0ppigAdD74BYWiyB1Fj1YhHQG74AXBw2gkHGBZpq6Dh/cH3Q7P
         MGKZ+znutUY3HuxokIqmOzI6mObUYb4vpgkuFhgg5vMOovO1lUORdDtqsFuBMLKH4zmf
         JqTjxQvu5PAZZc3O8BSzk+KDgEZPB2NydQJoSA9wosjG362XgqiFItafV6KqRvZfhoME
         Wpq/pt6GVmnxc49G/iPPLwIpSO1qZkDLqqNxwmSADfWhtuYfJjHJ6VQl1rqZj3y63LoD
         HhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358167; x=1795962967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
        b=GUBPMbJUIbiyye3Oiz0CgyHrhGW7BQGAFQhCKVmrE/WGNNVuJYqI8MgGyXLosZmyvO
         2J32L747mpiyVTMGz8uKRPX08M3Z2skj1TjRB3DIukAgYhPFMnLsIhJj+fXQlc1+Sq1q
         YlE34x5K8IajSqlmAAjhTigTegyPzaEyW0qY6R/o2U6r1RkEWs4JBrILayFxtbrDOikS
         gaJ+lqCdEBq3U157HQbkvI6+gCvCo0guefq0925cIX971YNmh9dlg7rYVLulSj30Gdyn
         DJ5zccM5fCorBP4uoJo8LNkZjZ5M7i2u7H+vPw46F1UgNdK++DioePwXDEfFIpR/SMWh
         zQJQ==
X-Forwarded-Encrypted: i=1; AL+hErH9d9yCgJId7PQ765rSgDZVmwZSVnW7qGS/uswOLGvVXgGxXEnMBDGhuu3U8tXa09BuAc7GOG4A0eyV@vger.kernel.org
X-Gm-Message-State: APuU4Z+0O9Kp+/j9AHxSjYPiOqaJrJ9w56sb05U+VAx0d3/CNnyHytjc
	S7xIycrv0tYyeiJDHkPS6h6MP+Eh0se1ETXBmKlSz2sSZkR1Kp8VQrB39jfYHLsVAg==
X-Gm-Gg: AZFdTZeJ1E+kfAxhEb97Cls9cqck/TyRL4qXyV1VdPO3agXTpz3Qmv8N6C/kQC1aZii
	8htRgHmLQ/RI89TxEjm04a4OF8pIe9WRrRqj241k/eGQFUxMpcgAA7hV6XMcgcPyKfnb9FlwFUo
	fNl5VvJWMaV5PLuww9uwxUM7lrXWdWA2xxkbObxrnC21aydwwSjkZFYM4uWvzbbL0YPAVD6Rrad
	LunBErFc5JpKDjF0IqyVI1JY039tWSpwXdjvBb6B2Gte7jHeWnEzm+k8INQq/3CVyHGcvE+LRmf
	gx0k/w2U3XDj7oEgatcqpftR7e2c0fAiIrwwm15ugWa5qr+cPfnD/9RLpgqk8opga1KbO7pPf7q
	2exul/Y0A7Ulm6+cE9mlbVqQcyOEBoJFD3zl/RqdY88BjRDgDnyfWXRiVTzX9ZFQWSuJWiN1jM1
	aANu1BRRH5LsafIBRomrbGvrid537qsFpLQLOIyNGwHt765Tk+vd1zpNsNJuBGpOLV2mpHwWo7M
	SlZKZb0Lnlbc3ZJtkb7T448pCGX3PC2SjY9xiP/0KY08Al9S1i2w+DtYlIQESAiDLYwL4Y9yXFD
	V9YEmV2KpJC3TshSRxRCXIcTQY1+IsJaAn/JtVbiBsXwa2VbK5uiBXtQp53/ZVNrW0+2x6nb+Df
	q
X-Received: by 2002:a05:6000:4616:b0:4a8:cf12:6f34 with SMTP id ffacd0b85a97d-4abaab6318fmr18378688f8f.4.1795358166624;
        Sun, 22 Nov 2026 06:36:06 -0800 (PST)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm18945409f8f.24.2026.11.22.06.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:36:04 -0800 (PST)
From: Mike Lothian <mike@fireburn.co.uk>
To: superm1@kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY
Date: Sun, 22 Nov 2026 14:35:57 +0000
Message-ID: <20261122143557.2412982-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Mario,

Thanks for the CPM _L05 quirk. I've tested it on the G513QY (BIOS G513QY.335) with the dGPU runtime-resume patch on top. The boot log shows `CPM: \_GPE._L05 notifies missing \_SB.PCI0.GPP0.VGA, using \_SB.PCI0.GPP0.SWUS.SWDS.VGA instead`, and the external displays come up after a dock attach with the dGPU in D3cold

Feel free to add my Tested-by

Mike
