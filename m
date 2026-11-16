Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837154;
	b=sl7CWL/5VRfmz8J599AnZplixJmPrSVPMExdVx19ElxUrmXelyqhQybBY5HAVKIs0v53
	 KVocFxOnMIqaVX+FB572Lt1vBOWQoIWs0SKlbzPiuQ4WgbQwCBzgpmzMF8KOxwYCGLlFm
	 mBhXufSmooocUgUBCF8MSsnBkYVtRcPmvsb4IjY8iLLSmmX18+Sp/lT7j7DnKN01LTrc7
	 y0SZN08WsF9sGLLHmGTRNPMuxGXBMQHN8/j2SQn7Bt3qCymncOpGkUhOAvEMKys5V6pDV
	 8DZO+YVUqADrjD9bNO9QTKlqdVLMXHS6IN7xsgOjHoq6ltuzEmgL1b/fNP4lfBmp22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837154;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PzNKVqZ5OSMCj0JtvQfkjphRxL+2UXHkcom4n4wmNjs=;
	b=sCMaLPrgPGlOMVN8x1vmbYMGEVQ43uTmj3IoVtcXmijY5QAu/DePHa87Xra9zRXTNmA/
	 LVNxeLIyWntkrfqCcElCBbNAxz8UOUzaONQRbh/imo6Hs4SxBKUjG5pw7BF4jwl8mnN+b
	 nH72UbfMEK4pVjf2yZfAfIjbK8AqpFyWhc9ub50G9wk5CHWOkZakMQthGjLCBuivmU/f1
	 YPfWbZo3cvNSLIX7JtZ+W6h2umNLGoQY/RDVJYm4q95jyE0d2Tmy3sWjw4SJbBuPsFwRM
	 Rpp4z6QM1hCaJ6HhooNaViKRk60s2hBOzjvJcx0MQN46Hmd1E12iiXex8hhZNHIvQ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qqWk7Dc+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE449606A32A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE449606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qqWk7Dc+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3E7381A168D;
	Mon, 16 Nov 2026 13:52:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01F916023F;
	Mon, 16 Nov 2026 13:52:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD4BA11BC05D6;
	Mon, 16 Nov 2026 14:52:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794837149; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PzNKVqZ5OSMCj0JtvQfkjphRxL+2UXHkcom4n4wmNjs=;
	b=qqWk7Dc+NCbXtX2cq6rrDWJ26gmFzwSHh87Z9QsM4a/JNkbUmg/2zIboa5HKwzZ5yoZGZl
	IcThcIvMnAVov9bVo37RFCAP2KPdQ5/LcRHarUyxBV2muPMvG8hg6maZVZS7PpYLUdw7Xa
	9xkQvhWZe6mKVD3g21BNIFQp9lEBEnpX/6dZ4mU5f/nrsRENAl1zYVr2et+yJKTidrydk/
	XmjGNUP1jNj2nwejtDTLnIUtX4gamj0kTdfDSTLN92IHlOk0QZ+SLUdt1RXw/QQK1lY/Xv
	Cz4nU+G7IfbTtAMTRaKfVieUfGy+yJJO2GOoOl0sL9XyVb7cYaw5c+aXgCSZ2g==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 0/2] ACPI: platform: ACPI 6.5 fixed clock support
Date: Mon, 16 Nov 2026 14:52:15 +0100
Message-ID: <20261116135217.37038-1-paul.cercueil@bootlin.com>
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

Here's the v3 of my patchset that adds partial support for ACPI 6.5
clock resources.

The ACPI patch itself is unchanged since v2, I just added the clock
patch originally sent as [1].

I originally thought that it was a good idea to send the ACPI patch and
the CLK patch separately, since they could go to different trees. 
However by sending them separately the context was completely lost;
Sashiko would complain in the ACPI patch about clk_get() not being able
to find the fixed clocks (which was addressed by the clocks patch), and
the clocks patch didn't provide the context of *why* it was needed.

Packing those two patches into one small patchset gives the proper
context to both patches. Then each maintainer can choose to pick their
own patch (or both can probably go through the ACPI tree).

Changelog:

v3:
- [1/2]: New patch

- [2/2]: No change

Best regards,
-Paul

[1]: https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercueil@bootlin.com/T/

Paul Cercueil (2):
  clkdev: Improve clock discovery with clk_find()
  ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources

 drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
 drivers/clk/clkdev.c         |  4 ++-
 2 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.47.3

