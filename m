Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26806466B4E;
	Wed, 27 May 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905492; cv=none; b=HX1ukZk/HbRatEH0LJz5Xh/bwzpqu2cDU0x+tZvFCo8uc9/5ez8BRL3t1ekCSff3yMwSA6sRPfJIaqLLBZuBUWFsTGja6QBOfjkCFHJ7RGR64Uqmw4reUye03NZ7I8Kj3VuvCP5UC52Pdb5UdwIUJcQEGyF3ZIyFBgn3oGEpqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905492; c=relaxed/simple;
	bh=/9NiF+BNAKChQtnQAsOC20DQmNYI2Gf1MnSiBQd5swk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doe9zDZRJODriljdUVaMs6dgOs58DY5MUjWdilR2p7RXF4d+51zVGh805lBhE2IPVqarbX21XC5YvDLhm8UYhZcPZoCGGBtPBe15lkInQMMMTsDMP7Ng/D8jyxE7oSLs/JTqpTXmxdizfVF8sDAsigTvj6Iyu3VxiLMD+rVc/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc7gzFvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc7gzFvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0071F000E9;
	Wed, 27 May 2026 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905490;
	bh=86hjIXbd0EbrAMNYjhAC1eES2t1qELqqBymG3v0Po1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc7gzFvI2V/eHTmsMv75LPZdJ3MZYbmCpPzLacl8jcUPLO7dR5wrBPs0YXGd2kkdR
	 k0mw+w5lls4EwmnekHvvHiDRoHJV//bSWmDNXiMB2avbQBKfzItL4hdvZ2XvWgdhIP
	 t6vJLl1hUkKPn7u4jCWN1kIIxNavnyLL1/Jp+xo0e/G25H7qmW0rOppWnGHOz0w+rx
	 vJ7QVDAKAuPf15qMJ40DXWMugoV7Xx1znFpAgVS1vj3B23693go1j2jdDCGq7AULDs
	 s0OeCYXrj8YEjYjKIgJPGckhALbLh2OIghu5Z24ze5xyi6HGVIrmug3vTLbtCbq4ZI
	 JmMrYKK0eQseg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 27/27] ACPICA: add boundary checks in two places
Date: Wed, 27 May 2026 20:10:18 +0200
Message-ID: <5180044.0VBMTVartN@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

Add boundary checks in acpi_ps_get_next_namestring() and
acpi_ps_peek_opcode() to prevent out-of-bounds access.

Link: https://github.com/acpica/acpica/commit/cfdc96896d8d
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psargs.c  | 18 +++++++++++++++++-
 drivers/acpi/acpica/psparse.c |  6 ++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 95d540bda4fb..4643c839df7f 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -148,10 +148,16 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 	/* Point past any namestring prefix characters (backslash or carat) */
 
-	while (ACPI_IS_ROOT_PREFIX(*end) || ACPI_IS_PARENT_PREFIX(*end)) {
+	while (end < parser_state->aml_end &&
+	       (ACPI_IS_ROOT_PREFIX(*end) || ACPI_IS_PARENT_PREFIX(*end))) {
 		end++;
 	}
 
+	if (end >= parser_state->aml_end) {
+		parser_state->aml = parser_state->aml_end;
+		return_PTR(NULL);
+	}
+
 	/* Decode the path prefix character */
 
 	switch (*end) {
@@ -176,6 +182,11 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 		/* Multiple name segments, 4 chars each, count in next byte */
 
+		if ((end + 1) >= parser_state->aml_end) {
+			parser_state->aml = parser_state->aml_end;
+			return_PTR(NULL);
+		}
+
 		end += 2 + (*(end + 1) * ACPI_NAMESEG_SIZE);
 		break;
 
@@ -187,6 +198,11 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 		break;
 	}
 
+	if (end > parser_state->aml_end) {
+		parser_state->aml = parser_state->aml_end;
+		return_PTR(NULL);
+	}
+
 	parser_state->aml = end;
 	return_PTR((char *)start);
 }
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 29b57d2c4cc4..42ec8abef626 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -70,6 +70,9 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
 	u16 opcode;
 
 	aml = parser_state->aml;
+	if (aml >= parser_state->aml_end) {
+		return (0xFFFF);
+	}
 	opcode = (u16) ACPI_GET8(aml);
 
 	if (opcode == AML_EXTENDED_PREFIX) {
@@ -77,6 +80,9 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
 		/* Extended opcode, get the second opcode byte */
 
 		aml++;
+		if (aml >= parser_state->aml_end) {
+			return (0xFFFF);
+		}
 		opcode = (u16) ((opcode << 8) | ACPI_GET8(aml));
 	}
 
-- 
2.51.0




