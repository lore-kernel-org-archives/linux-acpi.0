Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837159;
	b=Qi1OdLRrdf9fLFCGSr+2Lt1upFaC6sZiG+/kojFtNm/Yu1QaGtxl4BwSH+bcgaIDHhyo
	 lDUuv+bTXYLAZXLiHHbp+R/tnsp49p4PxWsNfu5J41tMZoUTUZaI67ZWioTdhf1T5lVv/
	 U82RrzLSfjmiytHZZigr4XOID6wxkJSXu8faQSG5qTNwiqTjQbpe938P+6Kk7CEhEjJTW
	 avZSzEpwsoi9K1zCxsLU0Wbj6sGeiCFMOksJxTbhOQ7l/IWlu96DLacjzJevxQgT/kVz6
	 SJDATJytKF0MwUptrhB4ZVSV7twr0jRSWblYjXFdGK8D+/Rk5wmmKupOlFGA2pmck0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837159;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Io1BI6qoNCZuXyB0hpVKaDQ4e+kSz3Jj0EHD4cdk5bI=;
	b=2y+38TCaEjL/CcZ0z7bcTxWiHOx6J86d++s+3L9aoHzvBJGFXFPKl/OfcOHfjK2vz4+D
	 Mdsy2XoVOhoTW1GkAH4+invbUyrJwj3qQTG4Pu3UOGmqtdB3Yz3hMJEqEhzsWe7ITJJaj
	 n/XuSqOVjar4JZfVBQeUWzSudB+f1hTCx9++tP2P2vq2SxDnJWOzZe4MycIJDJkx0FgFz
	 z7Es4YpssfhsHeid6jyHkP1gGN8KtyPpGqgB1kXzsRewC0wlSxtpsLNtbBDtsYOiwzops
	 aZCuosO8e6ZAxCny79ukSChc9G3qwQ8v7d0CTT3+VSE5kRbE3PatFN6zyDyglZAP84Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uTzXgKX7;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56B606A32A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B56B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uTzXgKX7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC799C4EFD8;
	Mon, 16 Nov 2026 13:52:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B45B26023F;
	Mon, 16 Nov 2026 13:52:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7814D11BC0465;
	Mon, 16 Nov 2026 14:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794837155; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Io1BI6qoNCZuXyB0hpVKaDQ4e+kSz3Jj0EHD4cdk5bI=;
	b=uTzXgKX7TZ5HexcBNzk+bN4X/4RHGFmVz7b7qxT4jii4fbopEUoC9Mv2zUCyQ8NT7CEFYH
	p6Q4yVi0RnR2wv+HC5VGmn2Z+Dtv6P239jvLZWQ3Tgu9k8n+nshgcD5o0Cf5pQf3Yuyu5Y
	ElKLGT8JOuQEvLk1sKwSBN4LD1Fc3B87JBteLSb5OlhcZxKmu+iydgkoH739pOza4Q6gQ9
	kaUAcRFeRglYg9GIhgcE5TBVp0xdRmH8nhHK3HqbNM3bZ4bBxtrN3bcJYMnwo2858qThjp
	kdcp04d9jxkzoxwHPbcsTYdX/hHWaFddmQ1l9ieYbMtx003M7bv9Hcgff7lQ4w==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 1/2] clkdev: Improve clock discovery with clk_find()
Date: Mon, 16 Nov 2026 14:52:16 +0100
Message-ID: <20261116135217.37038-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116135217.37038-1-paul.cercueil@bootlin.com>
References: <20261116135217.37038-1-paul.cercueil@bootlin.com>
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

With a setup where a clock provider registers a clock with a device name
"mydev" and a clock name "myclk", calling clk_find("mydev", NULL) would
not actually return any match.

Update the code so that we can support this while maintaining the
existing behaviour:

- clk_find("dev", "con") matches in order of priority ("dev", "con"),
  ("dev", *) and (*, "con");
- clk_find(NULL, "con") matches (*, "con");
- clk_find("dev", NULL) matches the first case of ("dev", *).
  Note that in that case we don't handle wildcards for the device name
  or it would end up matching everything.

Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v3: New patch. Imported from
    https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercueil@bootlin.com/T/

    Originally sent separately to go through different trees, but the
    context was lost which didn't help reviewing.
---
 drivers/clk/clkdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 919fc680ae4d..ee6c0afd6ec0 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -53,7 +53,9 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 			match += 2;
 		}
 		if (p->con_id) {
-			if (!con_id || strcmp(p->con_id, con_id))
+			if (!con_id && !p->dev_id)
+				continue;
+			if (con_id && strcmp(p->con_id, con_id))
 				continue;
 			match += 1;
 		}
-- 
2.47.3

