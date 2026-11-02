Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602020;
	b=YJWc9bUE6x8LkAN4K8tnNvb7TEGfp6VfgmErcEq7WiGWm/x7ZGUD6ujj5yJXR6CdM1n+
	 aL6HLrU3GJqhzgK3RwWZUpTcxeHY4WraIO9BcyARb2g+ATvFucsKoMLvJ+MdZtHjR2WLo
	 YoXq80gypIqRrBR9Jb/NImlch1oVcBMh27krl59Q97m6U9ljTCZ050Md5EQUcr481/A3s
	 B4yHvCnOtbOYrxYt1ULsMN7NnzYpd48usDCdtTLcXtjLBRTdc+38NyDwDCV3BstiKT98/
	 2NhdPoB3uIdXwoyA80Ov8mJRVCIYcq1slawUPES21Irv83xiQVxlywRfcG9xLzGI6AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NcHuZHcFie7Z+9IVPqMkakXOcOFCPc8NX1p3g8aEzwk=;
	b=lEzz4Xwa95MO7cJu7JIAopXCSgng0gbJLnv/IZg6PmBIJOPtQ6f95rzUnb6zQHv+I0O/
	 PenBMMaNPvlolxw3po8Z3avU3mmnI9Qxfxx+V9PSTFTX9CgoWgIslW9YBaSFAJ+aQawWJ
	 Sj3xJvZrZ4J8wECaPsK5DL/aUDoKkNhnjXRP7MDwy24g9e1UMcCgYDwh5ZsXLd2QddhR5
	 HEFOAF4v1NeYHjXxAG/SSnS1d9c5Ik6J1MADExboKjh/ZEcHS4Mhpq4S5vU5VElnX0t0y
	 KdbbYWgkrdBTQXuEw5PEEw6oR7Fa7koA1JSkOC2YADzPHUofSMvF4f7euG4P0c9b+XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag1PxI++;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F360A261F;
	Mon,  2 Nov 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag1PxI++
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602020;
	b=oZdvBLk30hnglkX2JnZuBecSfUvY0eNgUQ5VHdTCh8Mwik2SoV4LR0DIvWYL+OqVF8DK
	 gaSOLJhNSoH7DYSli1PzbSVQidKZg3l2YbECk1Xym3DM2SNa10RKNpDPSTIX3SHXTDLaa
	 x3+U1w2CjLqHeKyerY/btVANPCF0COr7Txqpc2Nzz+YD8vkVFpcwxzhKv4zJEaQuaq5ef
	 dXBS1rdNHm6xkmphNDHWUBE8jV1yKERyhYzaDHBl+ns7nZ4ohBPumnw3OSV6uKs9JMF3Q
	 2s/569XwOycafPZNbkd2l/iGgPMZMHIA+bedzzH03C4ryT1ufgvi/O4hD6zJ6t/HluA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NcHuZHcFie7Z+9IVPqMkakXOcOFCPc8NX1p3g8aEzwk=;
	b=LxeUVQ+Dk3w5IEIhkulqIdqGUb78VsFgh82py+xuKn+6hhDJZ6AFFU0/q+rHwqn/+/7I
	 nxDY826dNCGjj5dWtyW+yozb+8ywwpoTzveITzajUznLqbcSuJniz+uLOexA/gG2Y8ljm
	 rvC/QtUksixuNYlCEH9L/U6Qq9Ws2UG8BiDWgonM8GojFm2KCV8cEatIsYGwFfINjcoYz
	 ylPPZ5OpJo4EVSCzl0kv1D2NHr58rpVNHCx9oOYU8MW3RexKq39S7bQ2NGzYPkJlKfh7N
	 pHCfsfgv6oKpRJcRggRI0hN5GG9r/9uWH8myamfwmr3WH2M3dhExQX/8l35XMsgKh+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A36F21F00A1D;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602020;
	bh=NcHuZHcFie7Z+9IVPqMkakXOcOFCPc8NX1p3g8aEzwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ag1PxI++cq4pHOplgK6VfxhOVDiTRGLCRWKy4Z5VOPG1zu2gllqDgRecW85LpnB3j
	 a0gpgXUnL+HmkVlvEJb2KH30rU1tQqktt3kFWBB24W5wQeB8nvOvYtTOOvNbvQ5zlc
	 H1O4kz4UdC94l/hJbfSO4Snh8jN0TlgCo6QFQ6un7AGTkinM4QyEu+dMWgpgPGwn7S
	 anyhf/ltrbcXCu68RjBrVCKubb6z46y9hDHL5GmFOW4QRoVSZGlKr1D32Tq9QrlnOo
	 f+e4naz8SMzZbMmT0AQeauPZoYvuhx5Iwm/B3Iyz0RT1MR97SxjFjEOhzaigniEeCa
	 ilNCbS5pQ3BZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 22C75463D7;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:05 +0800
Subject: [PATCH v13 12/13] gpio: pl061: tidy up IRQ trigger logging
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-cv75-gpio-v13-12-4f93114ea204@ambarella.com>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=904;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=R6GzA3VQROdvEW9H8cJAb98tiDLV4uW4vocMVrOvc/E=;
 b=hHRaUPshcspXULfLYtxNYW2aDMiqxNFc5U7Tl1w2+G/LyY5bBCLAQuNZNoBGyWVtHwZD49ehz
 6+/LN394EPsAehUZ7vEJCeUqaWsYdRl3C5Qcfwe3ZDxVeXN3yS2mrCH
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Join the level-and-edge dev_err() into one string literal so a grep
for "edge detection" finds it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index ff9215447bbb..63ec5363dd5f 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -170,8 +170,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 
 	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {
 		dev_err(parent,
-			"trying to configure line %d for both level and edge "
-			"detection, choose one!\n",
+			"trying to configure line %d for both level and edge detection, choose one!\n",
 			offset);
 		return -EINVAL;
 	}

-- 
2.34.1


