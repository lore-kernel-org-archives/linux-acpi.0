Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179469;
	b=KUomTnsCiFcyppGX5e3NsTGBjoMRWaXSq3FAyWmltkURXxJEugQePGp7HtEmxt90GK8v
	 lM9Aehu/ofAgcKxQdDzlb98mazfRE4IsjRpnWoX/JPgKGdv3N4GoDRNHHxYarmqrQsgcP
	 Sdx5VID5zmD1W5uDOZmmtkaHtplwyWkNHSO+SzPeJtj2O5wlNnnyg9b6ETotBT/VjkCtc
	 9TWD4CzpvGUL1MeA/8rDaK6506KL/OFDB0QuvZWxn3LdRla6d7rhtJhNjo8odvKA0LpQL
	 xrXH8rbBdC6kuepNnhjvdDqg7g9YRi9KDi2COKXXSHgopsLtQLrwORtGBjyEa+9lrpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179469;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=8YuqZ8GuOBbpaf2Sgoc++9V1NZuSh8t13c1nFKdqRWA=;
	b=2EgncXh1psNwooZftQKnUt4aeGOZr3O2xaay0Wv9GNyiEWCxkVDRTEgm2S2Hdiqii9SU
	 bI650irJ2wbMz/I3x4aXYcWnXOGmNmLPuyn7MGTNQK4+aDd8Sf1f7movB4teDRNaITVnr
	 UmIqKkcBnYGTEnSt0evuzEn6Qzgg5znKBlRUXicE/bj59OdmEQwjckY+LgxoY+wz4iHsC
	 CTgMEjneSRwnV/otA0za1uFqC5t+zbn4bP8jhvYm9geZ2UamFnQdij2lrf1Fbn94/gIZj
	 gpdkCP4dEyztCHFPiFsmirW6uvs2oN0Ys1jaBJWEFvSn0pzaFX0nldur2NkHekoRz6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=z4PgQUru;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7C606A325
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C7C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=z4PgQUru
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BDABBC62216
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:57:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 151D9601B9;
	Fri, 20 Nov 2026 12:57:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C2BE11BC015E;
	Fri, 20 Nov 2026 13:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795179462; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8YuqZ8GuOBbpaf2Sgoc++9V1NZuSh8t13c1nFKdqRWA=;
	b=z4PgQUruRl3diP1nWHVI9Lr5iUhZI/TxDwzvxPQ9fUqVE4C1zGYJS7BJ6Pr5kymiy4yzWh
	iPMYuRtmSYzIC2fareRhD0doytvLHtCQ22N0Xj2qulK6g5Tb+gBThvB48P9A9fRFVx0KPP
	CBwb/Hetjge0fRHlNAfp5dTusNoF+bKBTw6F7YEVwZSlkQV69n400bqBpEwPv5rqfI4H8z
	NYZu/om3WESiQk+8paIRxncDwSob6S+HpgDo4z5T/6MG8Pu9EQKgE/6gHGfBHTPWFTYx13
	wpPoBo8Q93PhTudE9NwXlrvzznid504yyeUB46hWyeb0k6laBq5XF4CwXukD/w==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 0/2] ACPI: platform: ACPI 6.5 fixed clock support
Date: Fri, 20 Nov 2026 13:57:20 +0100
Message-ID: <20261120125722.209609-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
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
X-Last-TLS-Session-Version: TLSv1.3

Hi Rafael, Russell,

Here's the v4 of my patchset that adds partial support for ACPI 6.5
clock resources.

Sashiko complained about the clock names being too long still, as
ACPI device names can be up to 17 characters and the limit of clock
names is 16 characters; so I now name them "acpi-clkX".

Note that I expect warnings from Sashiko that I got on my v3 and didn't
correct, because they are bogus.

On the clkdev patch:
"When clk_find(dev_id, NULL) is called, does incrementing match here
give a (dev_id, con_id) entry a higher score than an exact
(dev_id, NULL) entry?"

My answer is that you call clk_find(dev_id, NULL) when you know you only
have one clock provided, so you don't need to care about matching
priorities.

On the ACPI patch:
"Should the con_id argument to devm_clk_hw_register_clkdev() be NULL
instead of name? [...] Setting con_id to "<dev_name>-<idx>" instead of
NULL prevents wildcard connection matching in clk_find(), so any
consumer driver calling clk_get(dev, con_id) with a non-NULL con_id
fails with -ENOENT."

That's completely ignoring the first patch, which addresses this issue.

So I consider that those two issues can be ignored.

Changelog since v3:

- [2/2]:
  - Change clock names to "acpi-clkX", because ACPI devices names can be
    up to 17 characters long, and our clock name must be 16 characters
    max.

Cheers,
-Paul

Paul Cercueil (2):
  clkdev: Improve clock discovery with clk_find()
  ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources

 drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
 drivers/clk/clkdev.c         |  4 ++-
 2 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.47.3

