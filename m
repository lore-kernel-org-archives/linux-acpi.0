Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481590;
	b=nJsz4qVngJTQUKEzVlNPdl4dPFlkdV1nIcz9J7dIO/O/KbW/MQVBgq4hqMR15HGIj1fQ
	 cWhiwrsbLOEnNw2bwF9uBfuGGVkril4mJir6M96Hw5y/RQN5Ql2Kp0NvfM8oFlY6qVMmZ
	 neLUfB1J7V8O2Nt1NBN5yteYXK/EWs3tcmVvTPoLm6iMxbWVd8OFd9DJ0cSPgF09ZOg9E
	 SUmhTKu2oSl2uU0p537N6BTmeyhjVlpyK09LfDlxMPT9sAIV6Gjz1e5+rSH/KjIwpUFx4
	 +AOIX48lS6cMKiWzFfTR7GbXfbb111pYHnpKTStCSfO3+Oom99HnKqpEzE18ZFoyRPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481590;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=fYKQz3cWfTjGNTLbgQhvtfCkBy9aAqAZ/NhwOgU+3jo=;
	b=13FrGS+4HC22huLhJeymB2VJ335+khbIVxyGEr/D40PF3PQUgcgzz2NYZuLOQW6bN99T
	 Q05auAaYg486RkqUhv2wNR28k1iUarwi5XATWifKBarZNskcwXDzbWVYhsplPEitrmRkf
	 Pgub/drnwA3cCDJ09Dw7aY8J+y7eefRlbOo01UFJzNqlIfubA+CzKnoZcN4HaHiaFJKuU
	 MkqFjrolJ2gNms5FEp5wpIBRan1LH7Ob3j6ljB6ZHcq0ph5IVsSyWwums8t/lxddTeKOS
	 KUMePg/8XxiXTjTlDRnQfMY8UYg0Jgk6tmK+N1yvTSpEOOmZP/e8oQ1NqcEAbh8ay6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=JCcDNnS9;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF8606A327;
	Sat, 31 Oct 2026 21:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FF8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=JCcDNnS9
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jH9pP39TvzKvm8;
	Sat, 31 Oct 2026 22:19:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793481581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYKQz3cWfTjGNTLbgQhvtfCkBy9aAqAZ/NhwOgU+3jo=;
	b=JCcDNnS9VCSrRM8v4RwP4YuGyHB8IayrTpzWAxwiAtOdVd06Js4fHIZNfJigQ/LfqF3zyH
	HdTlu4tp0W/m/61O4ySKw8NV9ECDMHvjiz4RiUUO6KGX8FHBqBRY7uvriaNhTe+ov3N+yh
	ELtsstVAuNqdjT5HdQaWM9H0ylO5AzK7nhdWUpoCe4fWPMuzgLbnXDfv//Jfy3XAqkKsLT
	avVl+w/G6V3jq6WvRPFMy2wrYRzlGUL0yvNiGKDr6phV2NF9MrUR9uS3C/sePfitsX67pg
	uCYgXlMigG13MN4T1IlSoSKt6yJ6Zt3AzQ9aXb0kqWxIkPOgvH7m6I2UmHOzMQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: AC: Rename thinkpad_e530_quirk() to ac_sleep_quirk()
Date: Sat, 31 Oct 2026 21:19:37 +0000
Message-ID: <20261031211938.581230-2-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031211938.581230-1-hugo@hsal.es>
References: <20261031211938.581230-1-hugo@hsal.es>
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
X-Rspamd-Queue-Id: 4jH9pP39TvzKvm8

The callback sets the delay before reading _PSR and has nothing
ThinkPad-specific in it. Name it after what it does, like
ac_only_quirk(), so other machines with the same firmware pattern can
use it

No functional change

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/acpi/ac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f19d6dd43473a..1cd7482bc0246 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -158,7 +158,7 @@ static int acpi_ac_battery_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int __init thinkpad_e530_quirk(const struct dmi_system_id *d)
+static int __init ac_sleep_quirk(const struct dmi_system_id *d)
 {
 	ac_sleep_before_get_state_ms = 1000;
 	return 0;
@@ -181,7 +181,7 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 	},
 	{
 		/* Lenovo Thinkpad e530, see comment in acpi_ac_notify() */
-		.callback = thinkpad_e530_quirk,
+		.callback = ac_sleep_quirk,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
-- 
2.56.0

