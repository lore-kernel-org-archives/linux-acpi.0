Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC103D6CA6
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009790; cv=none; b=BTYXn6hGLHmmdUnqx3qxoR/xdK/zL/rG10gzPS/5cEmFw1Q+T9TuS6UM0IuCywgaFTCdOis14ogmV71XdcXVTE0nGTrcSqLoyFx9LCnRHCHXwUoYV8zNubU0lyDCjXh82/321FMhCp+w8GMWgZNxrXHaPIYWlNy23lKxqNSnHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009790; c=relaxed/simple;
	bh=RC874UnZ5V4aNcIf4tUhq3UKLlVDYTm7i6bLqvZPddE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dV9sWRJ9GcBzFOVb6q3IYjG3oaHDElVEoqeR91WLOPrl0Fk4h+/cgEUsLzZBeJxYH8odh/GugI0HmStm60WfLFRB8gxFVfmGHYTpC+Nq4QMvzb8+tY4UXDdZGik74hlvXWX/W1f74WGAS4tiPN7TNFiBD7PLcRjofkEENW01K+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=AQAL9Im1; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="AQAL9Im1"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 17CC6240105
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 21:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1778009781; bh=p2WTjKxAouF+i6RrLI3rv+nCIxExeNhmo7ib34g0WOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=AQAL9Im1qPdj75ZtEbVPZRKGyANGQm+kTiy2C0q0minbdUIPK5iwAA2gvse0MiDQ9
	 hz0ulDjhtGPjpvOIH6GlNF1CLtnueJE6bOZdTGjvnpkxU9fgatDYfJIWP7nThQWXKt
	 9nC1lQeKKhaDdeqMu9VZ/wbcuaR5fZhLU2pnk28+q22F0Cf0SNS53RzSuMrkOFAuN7
	 UTGGPdXQOn9ekSwVw86yp4ZaV3kKtv6TxfizEPn5HaSOjIYXqCDc3h6DlIPIkXs0OW
	 nhIvbCn8R5QHtz5RYmmCafHOfimVtgVFmm5+pj4rWrJqRLADoJILA1CIpvumAAaAsI
	 RU18VbHBYFuyQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g97zm2mtlz9rxM;
	Tue,  5 May 2026 21:36:20 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Tue, 05 May 2026 19:36:20 +0000
Subject: [PATCH] ACPI: SPCR: Support UART clock frequency field
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de>
X-B4-Tracking: v=1; b=H4sIAKNG+mkC/y2NQQqDMBAAvxL23JRkLRb9SpGi66bdghqTKAXx7
 01rjwPDzAaRg3CEWm0QeJUo05jBnhTQsx0frKXPDGiwNJfC6Ja83KOnoEtbGXR9hYVDyL4P7OT
 9a92ag+PSvZjSN/A3As9LnqRDg66NrGkaBkm1Wq9nqwMhNPv+Ae08xg6ZAAAA
X-Change-ID: 20260430-acpi_spcr-61902fd923f2
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=RC874UnZ5V4aNcIf4tUhq3UKLlVDYTm7i6bLqvZPddE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp+ka0WlBJvrebw1KoVroofR+RdU8bZ/GtTte77
 5Z0VRU8yP+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCafpGtBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Jh2Q//dhCAKoy0tiZOAasNEXXod5fxk3UpAmj
 LOhW+y9izN/dZgBnFhsf9Lpf30iCICOq8lfWzM6uCbY51G8lBOKfVH2fnqR2IJ4cir42sYoFSc+
 ppNYAG78cd4vgwWIKm99tfAZ8hu/y78os1TpKpkRAkaMp8j/ev9cavQ2kWA7HHstJfg7XlitDA3
 natbndoxk2rkx+Hyb5vdNszVWTdMlPGT5STU9bjqx6W5qzoRR8RFCpSL0ng4cHEk7QL/iTlQksF
 oVWamA3AOTwXlKX6NT+HWd/da+x/TohiFzAZ/Rue3qZBiUVXBeyaD7MMLFnoGFFCOzRwEDV08Uz
 y1z/tONblCPVvsOaQxO0OsNrcfJUkvnJzaUf33XgeTO7+9/x6ypuZvXL5npSe4GD785ESqZA9cW
 8ReW0y+Jw2Cstfa98tggzszjFsMUN8TpkDIt1QJNEnnGhbmC1Y9PKp7KT5jrgR8q6JiresBw3Jf
 Upmomrque5x45QWBqCMpzUZD6TdCPJxCcqHbuk7/wV2Qcl+NfRXCIW1P4AukSgQzpP3bALR1Xxw
 FKCO5T+HgWrmfVKXH1Xb6x0qGV19r2jCZLAPSxZtKw5c4f7em0PxRd98ByBEpsNM/jOM+eJtjV3
 l498RfRqAqb650D9FtlfS6NkmN0qkqsBQbT48PNUEyMq2jRBrFxU=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The Microsoft Serial Port Console Redirection (SPCR) specification
revision 1.08 comprises additional field: UART Clock Frequency [1].

It contains a non-zero value indicating the UART clock frequency in Hz.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table [1]
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/acpi/spcr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 73cb933fdc89..d80ad87efae0 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -220,6 +220,9 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
+	} else if (table->header.revision >= 3 && table->uart_clk_freq) {
+		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%u", uart, iotype,
+			table->serial_port.address, baud_rate, table->uart_clk_freq);
 	} else {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 			 table->serial_port.address, baud_rate);

---
base-commit: 9e0898f1c0f134c6bad146ca8578f73c3e40ac0a
change-id: 20260430-acpi_spcr-61902fd923f2

