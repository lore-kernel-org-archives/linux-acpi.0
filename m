Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B503A4513
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688305; cv=none; b=MRN4xWMDBJ3FN/WZ3s2BjOqML0P3Luf/u5qclUFRXuaH7BdyUkwKsWmmQnmSgn0fv5x8Ui5dYWDQXbHr7knsUfzid6lHuUAC+bNduuRObV+Vig+TdzrLtSZzXpjq6skfhqv7ydNZmFtnabyaL80qEhQX+aSuEAqG2DJ4CFDF1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688305; c=relaxed/simple;
	bh=HoiCR4f6pkBEW1Iy8AqK6nV8+jK6ygtzGwN+BBoALUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHBrfkFHRmErHx5biQxsszFb61XQoy4DeUF9ClUAflp/57YkB5WoJRNS+dj6FD2NgMasiRtL8jskBSjylX2EurKoXet0qdhVlJzLkN4FTHCYcc8G25XoFj3s4QzyU4XR0XCAOV/CTblcoQZBSKdPf6OCatzsVN3qhYs3RIdJSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j1fYrqNO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YNPtTPUJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SLDFRisf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hf/poQKk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j1fYrqNO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YNPtTPUJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SLDFRisf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hf/poQKk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E158275AB1;
	Wed, 17 Jun 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781688299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADM7s+io5aVO+2KuWpEveKxPrmS4DBucyG+ftatvT3s=;
	b=j1fYrqNOIAfuqoEgxyISYQY2ehnAI9Q41icMVSrQXV+YOsHJKgAjARL8t+r77PPFiOePoX
	wWALORsOlicRNLZgk/m0VXcvG/E4GSAAEe4mh40sD7/Q9+t2ORzUuDuIAsCQurih+8uHdG
	+fsUgNgLvxkbvlFq30uw6PPsvf4QxDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781688299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADM7s+io5aVO+2KuWpEveKxPrmS4DBucyG+ftatvT3s=;
	b=YNPtTPUJUA4GguZlU96aVxZC0amdObjyznzD5BNpDBEslXsOLAwTyH4+CAqGzhDvo/e1CF
	297fmGmPDnlCBnBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SLDFRisf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Hf/poQKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781688298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADM7s+io5aVO+2KuWpEveKxPrmS4DBucyG+ftatvT3s=;
	b=SLDFRisfOWRM7fRAdLUh0rwVJPB/KnZH8Hz2WMPFTiQITbzn+vecTFjkpiqKklp0rNLtQx
	NZBPihGAiK5RwhnDXVKUIvB9Hy7c9JOyVbNAQol5jodTI4i9U59Lv/ORv6V/6V1Ss299DD
	o0oKluEM++vmRsfNdhVRV97y7IG/gOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781688298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADM7s+io5aVO+2KuWpEveKxPrmS4DBucyG+ftatvT3s=;
	b=Hf/poQKkYRi3O+knkjRFi+wVsaDSTGPYpuquw+7ypQLLVmpPmVX8mkKUJ6PWP9c00NlSM3
	v7O+o01E+/yBj8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2515779A8;
	Wed, 17 Jun 2026 09:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bBJaKupnMmoGZgAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 17 Jun 2026 09:24:58 +0000
From: Thomas Renninger <trenn@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>,
	linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thomas Renninger <trenn@suse.com>
Subject: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()"
Date: Wed, 17 Jun 2026 11:24:38 +0200
Message-ID: <20260617092448.538721-1-trenn@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617075633.534689-1-trenn@suse.de>
References: <20260617075633.534689-1-trenn@suse.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.90 / 50.00];
	BAYES_HAM(-2.89)[99.55%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E158275AB1
X-Spam-Score: -2.90

This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.

acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
and must not use kernel's strscpy_pad.

Closes: https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@kernel.org
Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>
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

