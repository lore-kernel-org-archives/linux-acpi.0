Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729993;
	b=0Se9xlYq9bCGd8WVbF0tnr1wyRljrdkGurQy5wb57PYhM0ZqfkfGEcEBBkelhjEAT4fq
	 +bxofnAoAjj8jmjC3lmpSzV6k4hvuV+6kaBGH9fPlOq+EHW+5TWFRpMkpM5zYW7NqVBHc
	 sglVfHllXobLO+PvNW6UZxSk7Rt4Mn/coHXokbJN2K+TM6NTQgdITeco7h7I3TXc6PL8W
	 4XPuRmO2j+WhmfzsbReekl5Gdq5pVcRT31AhShyMV5/K1a5VP4CJsff/BvYrypmM0O7UA
	 7EP9Al5gf66Eeubjy0ljnbDK+6M3GxSEseLzboNWdqjiSpzgXnEMdNStCpz0W2hPcAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729993;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CxPmNkrdL66AIfJyn1xViBqXlyUc1HsQv2fthprM7Ng=;
	b=wOh0uuwaSwqDBWNClGp8+6L9Ui18QobqDEShug/A6qYS1jQR/Z5kwVv7+A1IlMuJltA8
	 bQqHKGgoS9F/fdvWpMFL9xWB6U7xKQYzMrJQjWcEkA07BxvSG5BNyrOuvGy0BMfv50RD1
	 /s/atBnpbjlvzpeQoFOnL4ikCXM/k9e/eRQtg/MgUZdoQqB+49z45xnjoNz1sgunc2l43
	 QHl166IZF9rlQJad6DYbvohCtO5+h7wGjKWRcN4Yb8ufbf03mBZXn8Afqdrwx611nsGcB
	 zf6DpEfrG8TbnP5Bedzq7fRKbfc9RnnTGytgvssTZuk7Juutt+J5lVhbWFfRFS84kBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C7606A328
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 18:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0C7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so36584245e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 10:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729992; x=1794334792;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CxPmNkrdL66AIfJyn1xViBqXlyUc1HsQv2fthprM7Ng=;
        b=FYeWvrVnhNyfXIof3H/rpuqGxEml9axxZS02huBivMhLQS/JEvKVRu4q1tq5GVW+OW
         6yubyJDRXdQ0yNaNEL0YosbE3PY6nrt7YgaRCRsOTzO+pZ+8L3Pb5nf8AxGxZvV98rgM
         TVWL9s7qHCm9POlB1GiMSF8Wk5VbhkqpGbtPG7+MkQ5lnPDgvG40bGEG+vkz36jnANCv
         Ci1iZilToPJ35Cmrdc9njb6g1brMU59AF29IojQZqIz7UZty86XMBUqGR+9ZxNd0jSjh
         V3UP8tDHxJqHl5MreqxccDiCrvUy/ocAtGD2AkzcQJOlloUA79wytJUK3WjULnxNP1J2
         a/4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxmDoGm+KodAQy5qYMpjB2R2lR1nwXTkR9OTZvQc2U8M2vNs1VAxN5hIKWTMw0+j4sEfGglTMph2yyx@vger.kernel.org
X-Gm-Message-State: APuU4Z93r6LWEKcn5ICAI7BCMRnlXKnIzDlX//WZsxmF+LR1L/Y7DfER
	YfsrRIhXCzh0HQezANnvQyU5nbMPsCrRy6+LG/rNqkRNQryonIO9HVE=
X-Gm-Gg: AYBFou1KV+dMJI3OJTlj+l7RSHZ7v+LStOUdX73qSC1KxIPQ+5bZhZ5VQhGlmZ871RY
	n3xkbZUXWlGCp8pPGkaT8IoUMZS+AivyAMaEfICrUfJ6MNvgbsJ6B/Q3F/f0jL6fkOPkm7SqIc0
	/9CDID81Tm7JiaHSuAbT85CZdISV92oKdYuM4614Vmr/l/FRs840qE6UKK5+NHB78O91DsoMbhi
	fshe1ndYa8C6ODAAbO8/z0x3KPO611Dpt4sF5D7QG1+g3iOimBMR4CSiEnpxtlhPzQMD5a6Wypy
	3hj4fP0k12PmxN6kHOgFZU3hqGen7m8/NQ4OKkmeq4bW0JTsc+09jx9Z8bDQqmn7A4W0BWjfyrz
	fVjBK6giXFCFliRhJmuNT+bRXen/igLuXJTeQj7YFuMqwi+r0W5WMV5pGlbhZyEeOCkAXrYeVGv
	xk3EhWusjBAdQa2m5bfK4C5rMj2yJgU3MLfc1c81W85sFiGoG4nccXcg8H21Dh1MW1AGkYAvS1h
	IjqZ86ANYOA55/UDvWU7MFxCTobaogFVUgfva14mYvjkgioJYlKlxA71mKd4Lm5mA7W+sb092KT
	jWzcAnK1jF1nYNKZJXdMlvfTSzOuK3rcJ0lq6FRW
X-Received: by 2002:a05:600c:350b:b0:4a3:2f35:38aa with SMTP id 5b1f17b1804b1-4ac1932bac0mr284037035e9.29.1793729991346;
        Tue, 03 Nov 2026 10:19:51 -0800 (PST)
Received: from [127.0.1.1] (84.124.213.91.dyn.user.ono.com. [84.124.213.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b411de95b4sm777745e9.0.2026.11.03.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:19:50 -0800 (PST)
Message-ID: <6aea25c6.9efe04cf.11c115.259a@mx.google.com>
Date: Tue, 03 Nov 2026 10:19:50 -0800 (PST)
From: D. Manresa <dmanresa@gmail.com>
To: brgl@kernel.org, bartosz.golaszewski@oss.qualcomm.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
 andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
 driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] driver core: fix unbalanced reference counting for
 software nodes
In-Reply-To:
 <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
References:
 <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Tested your v2 on a Surface Pro 7+, where ipu-bridge attaches the IPU's
software node with set_secondary_fwnode() after device_add(), which is
the case the series is about. Reading the node's kobject reference count
directly across a PCI remove of 0000:00:05.0:

  6.19.8, unpatched:  4 bound, 3 while removed, stuck at 3
  7.3 + this series:  4 bound, 4 while removed

The 4 is one registration reference plus three child port nodes. No
refcount_t, KASAN or other splats either way.

How much that covers: the rescan does not re-probe, because mainline
ipu-bridge only unregisters its IPU HID node on the error path of
ipu_bridge_init(), so the next software_node_register() hits -EEXIST.
Separate leak, unrelated to your patch, but it means only the first
cycle really exercises the fixed path.

Tested-by: D. Manresa <dmanresa@gmail.com>
Assisted-by: LLM
