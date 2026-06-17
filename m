Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02B3C13E5
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683025; cv=none; b=eKdHjs4S/tvH9y4AUoZx2zuIQp3m/9Py1duWdcGQGqKcg3IDOyhQ6kpoXMtQOf2FPEzo0WZeL0o/bCg+f3MrUmfIuDhN/P/CzkTX3UJwDqW3TFk92mewi1v9bDjLuSkTYTuZxus3oNgIa862O98cRsw/5s/jYwKuixqgWx8wXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683025; c=relaxed/simple;
	bh=PU7S2i+Wk0xFcfcPTOKSjaXanq5SO/8MKtZyGjPFJcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSpu8dMwGSm0Z7Q0+8t+Xinkc8bWGmz9I7GZdf7i/Vec1jDa+e41wqVnkdsut+LjRd9jgaDpjxwTPA61/NwEJ5Kl3i9u2fPxhr7octBkltVYMgmuH01swqHWSCR/pqq3mGcJCmdiAXk2udbYiSYATgipMT8w4DGTyMgGcFhN/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pSJcEOoy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xt1qecKF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pSJcEOoy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xt1qecKF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSJcEOoy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xt1qecKF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSJcEOoy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xt1qecKF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F38175CFB;
	Wed, 17 Jun 2026 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781683020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK/bR89l4xACF693IWwh4lDg/LXGmyrcZAmpxuDxHKo=;
	b=pSJcEOoypr/Q508lhNnBkRRZmzxLVKggjYEYI1OQwqHRd/do7SjmeWEXN0E9bvnyKxH/Sv
	VBBYxSFw15lq1mBUWiM3beyZ51Ca2ARM/SH7aSY1hwvB1XUjmof3EFAxnq60pkWz3KO9Oy
	xLm5dLLuWClt5wLXOeAL9TCipjDnlE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781683020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK/bR89l4xACF693IWwh4lDg/LXGmyrcZAmpxuDxHKo=;
	b=Xt1qecKFo8V7w0jSf/1nglJcPOZahRIkvoVuggWeTCRTjkAMzwmxCAO/jXAZHi1y1/NxyC
	IrBqV7sg8lVwGKAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pSJcEOoy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xt1qecKF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781683020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK/bR89l4xACF693IWwh4lDg/LXGmyrcZAmpxuDxHKo=;
	b=pSJcEOoypr/Q508lhNnBkRRZmzxLVKggjYEYI1OQwqHRd/do7SjmeWEXN0E9bvnyKxH/Sv
	VBBYxSFw15lq1mBUWiM3beyZ51Ca2ARM/SH7aSY1hwvB1XUjmof3EFAxnq60pkWz3KO9Oy
	xLm5dLLuWClt5wLXOeAL9TCipjDnlE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781683020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK/bR89l4xACF693IWwh4lDg/LXGmyrcZAmpxuDxHKo=;
	b=Xt1qecKFo8V7w0jSf/1nglJcPOZahRIkvoVuggWeTCRTjkAMzwmxCAO/jXAZHi1y1/NxyC
	IrBqV7sg8lVwGKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0772C779A8;
	Wed, 17 Jun 2026 07:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3aOAExTMmqhCwAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 17 Jun 2026 07:57:00 +0000
From: Thomas Renninger <trenn@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>,
	linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thomas Renninger <trenn@suse.com>
Subject: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()"
Date: Wed, 17 Jun 2026 09:56:15 +0200
Message-ID: <20260617075633.534689-1-trenn@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3F38175CFB
X-Spam-Flag: NO
X-Spam-Score: -2.48
X-Spam-Level: 
X-Spamd-Result: default: False [-2.48 / 50.00];
	BAYES_HAM(-2.47)[97.59%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.

acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
and must not use kernel's strscpy_pad.

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 drivers/acpi/acpica/utnonansi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 3a7952be6545..ff0802ace19b 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,7 +168,8 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
 
-	strscpy_pad(dest, source, dest_size);
+	strncpy(dest, source, dest_size);
+	dest[dest_size - 1] = 0;
 }
 
 #endif
-- 
2.54.0

