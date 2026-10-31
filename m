Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481585;
	b=lovFeAztL9IV3iB7S072jfo+tnnpr5OeMO/K4UiBvW3I0T6TXrsECVVgb1fMhO8kmwE+
	 +G4m+42pgtcgGasvy+kv+716GVduWacVF/o7jJNLbH7jYY81TgMFpHi7PQOdkqVrOL+Em
	 oC6ZiNR4PrMDx1xG+ZYCMwiM3ZdH+6jGcmQVpLLib4kNHOcDGTcG6V2vSWA5dNeELzWNB
	 4dIvRk4KAri3OjeNO/sN3/2MH01RPm/OBroRkp1a84f2NH90dV7U81+c4ou0ZxnwRpB1B
	 niN8LyKtwNWl/NCvjuA+YAK3cXBRxajU3i+rtxlUCsVYbb1TSO/Q12ruI+HSs6B0nAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481585;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=TVqsR35WozbLQWISeo2x6pd7V/DMSF3VB/0ejZyMr9g=;
	b=T6NLPzlAgSMKkPTtnGHxGr2pVK2+6vC6j0m0BZcxmygBbBLA7q2XCSnFIQBfLXSNNj5F
	 cke9wASdf0p1LFGX2kscAwqCYpfxNOiLNadhbrQZFJ6ual0cANd1urebDIfz+P6OigECk
	 KWvM9frcnWoVw7r1DGFtVRgIFgvmAKEvhUCg7nQeHwKhXZW4I6037AK0zA52vbXSwi/Gg
	 HknWbDqBT3j5GClN6WW3gUJs/nTLs9qJf7ad6Q44IbQ+1qqWPP4LVEouxBDFzIiYZJcco
	 kVbB4E+/Z6pWuKQzIj8OdlqGMdRl2bh/gJ8VJlIzpSdceZrPH26l+CB81zDxa+F+wMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=nVO+XZGu;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FF606A329;
	Sat, 31 Oct 2026 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 872FF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=nVO+XZGu
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jH9pQ0YjWzKmyK;
	Sat, 31 Oct 2026 22:19:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793481582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVqsR35WozbLQWISeo2x6pd7V/DMSF3VB/0ejZyMr9g=;
	b=nVO+XZGuXZW3rWSDx7c0JxpFvc+oiZDDvS1fN72r9OHRHKcuIexCJD7otMspcT56083bAW
	AEotlQOj6wbvay/Mvxu/usXAiSjveukhc4eUbFuhASK5+w2eTqFTG9o4lMNdHOwKdnUgZW
	sBJfjOrXTjarBt7qqlsI2V4hA1YDpkskqImXCR0llYg9OgErb6Bm7udSEIWkyK4ZKi+S9Y
	bmKu2a++mc8E1peXLp3McvNnMbpE3JV14eAQczi0Tumguy9s9YZ5+VTEIkeoHROLUqd8Uz
	bzqrS60z819fWZ7YXDMeYQnq2KknkAxypJxIXbH2o+IXlUi1YrIV9D6/vXN3Cg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: AC: Add sleep quirk for ASUS ROG Flow X13 GV301Q
Date: Sat, 31 Oct 2026 21:19:38 +0000
Message-ID: <20261031211938.581230-3-hugo@hsal.es>
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
X-Rspamd-Queue-Id: 4jH9pQ0YjWzKmyK

On a plug-in, this laptop's EC handler notifies AC0 once, before the
adapter status bit that _PSR reads is set. The driver reports the
adapter offline and no second notify follows, so user space that
switches power profiles on the AC uevent, such as asusd, stays on its
battery settings. Unplugging is not affected

Add the machine to ac_dmi_table with ac_sleep_quirk(), the 1s delay
already used for the ThinkPad E530

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
The EC's plug-in handler, from iasl, without the EC locking and the
ASUS WMI event calls, and with its two sleeps merged:

 Method (_QA0, 0, NotSerialized)
 {
     If (ACPS ()) { ACPF = One } Else { ACPF = Zero }
     Notify (AC0, 0x80)
     Sleep (0x6E)
     NBAT (0x80)
 }

ACPS() returns bit 0 of an EC status register, and _PSR reads the same
bit. Polling the online attribute put the change 392ms after the
uevent. The battery handler _QA3 notifies AC0 too on some paths, which
hid the quirk now and then. On an unplug the bit is already clear when
_QA0 runs, so the notify reports the right state

With the quirk, both plug-in and unplug events reach user space 1s
later, with the right state

The delay runs in the notify handler on kacpi_notify_wq, as it does on
the E530. acpi_s2idle_wake() flushes that queue after dispatching the
EC GPE, so an AC event during s2idle keeps the CPU out of idle for up
to 1s, and a suspend or resume right after an AC event can take up to
1s longer

Tested on a GV301QH (BIOS 418). The match covers every product name
containing "ROG Flow X13 GV301Q", which includes the 2021 GV301QC and
GV301QE: a public DSDT dump of the GV301QE (BIOS 413) has the same _QA0,
ACPS() and AC0._PSR line for line [1]. I found no table dump for the
GV301QC, but a GV301QH board has been seen labelled "gv301qc", so they
appear to share it. The 2022 GV301R and the later GV302 have different
product names, so the quirk doesn't apply to them

[1] https://github.com/andrewrabert/asus-flow-x13-linux/tree/main/dsdt
---
 drivers/acpi/ac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 1cd7482bc0246..b014028555de9 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -172,6 +172,18 @@ static int __init ac_only_quirk(const struct dmi_system_id *d)
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id ac_dmi_table[]  __initconst = {
+	{
+		/*
+		 * ASUS ROG Flow X13 GV301Q notifies AC on a plug-in about 400ms
+		 * before _PSR reports it online. Seen on the GV301QH, and the
+		 * GV301QE runs the same EC handler
+		 */
+		.callback = ac_sleep_quirk,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow X13 GV301Q"),
+		},
+	},
 	{
 		/* Kodlix GK45 returning incorrect state */
 		.callback = ac_only_quirk,
-- 
2.56.0

