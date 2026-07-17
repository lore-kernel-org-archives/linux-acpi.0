Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7B29B8E1
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271121; cv=none; b=d5YXgeNgWw5EjAW16Vi7IkKxNLbvkzO6MAYivH79x5OOOHmkglDUSzGEds1v8eaPrp76gA6y32AIN4FP+jugr1lh/pQ1wHQcJGRtv2v4Rg5WxP//UdQ+pn8vt0nqTE1xMGycd7xlmkliIb0x1D9LaIFI/w52SNf3MGVMP3v2dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271121; c=relaxed/simple;
	bh=pHRYonI7x2Lo2GR+w49ZjabSphave2Jtgt1LZr1AcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drAF0FDG5oGHCR+VAwzcbrRQnGhoBbNlrjqlkACY2abs8t5PH1OTf/ZuNgThw9tVjBGVXHNoBxZr03tEU61WWAGsnhDf/eGHJVLPhBhDlEzEZ3MvyE2svu32YNL3dYVPMg+mDmQICcCYQVEMWs1PgBQ/eYzLE8Eou6mzC7nvCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mE0Xpplv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w/UxHb1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mE0Xpplv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w/UxHb1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mE0Xpplv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w/UxHb1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mE0Xpplv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w/UxHb1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 584243E44;
	Fri, 17 Jul 2026 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zfikVTWCkR40T95jEZs6KgYlQAvC1Og/9E5NLHDyY=;
	b=mE0XpplvFJ4ieCO91LE+Dn9qtZwMPfMo/2O5+8uhzv0UCETW+jRFohUb3qaYcbzqn9zbKy
	qfPwWfMtR3MzB+8ksAj1LUsyPtYL7nsKYdn/VOTfACzRF7ZQ013Rdr4qPKbXfcaUxbx2cN
	WaqFiDU8lYXCT2ZP4BSHc6rvz5/htvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zfikVTWCkR40T95jEZs6KgYlQAvC1Og/9E5NLHDyY=;
	b=3w/UxHb1771a9tBcz4UAjqfbv8wForJKJ6mk5xqwYac7C7faViYw9pOonc6IelaMdExC7P
	d08OMd9qb6GX/HBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mE0Xpplv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3w/UxHb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zfikVTWCkR40T95jEZs6KgYlQAvC1Og/9E5NLHDyY=;
	b=mE0XpplvFJ4ieCO91LE+Dn9qtZwMPfMo/2O5+8uhzv0UCETW+jRFohUb3qaYcbzqn9zbKy
	qfPwWfMtR3MzB+8ksAj1LUsyPtYL7nsKYdn/VOTfACzRF7ZQ013Rdr4qPKbXfcaUxbx2cN
	WaqFiDU8lYXCT2ZP4BSHc6rvz5/htvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zfikVTWCkR40T95jEZs6KgYlQAvC1Og/9E5NLHDyY=;
	b=3w/UxHb1771a9tBcz4UAjqfbv8wForJKJ6mk5xqwYac7C7faViYw9pOonc6IelaMdExC7P
	d08OMd9qb6GX/HBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F872779AA;
	Fri, 17 Jul 2026 06:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eMBxCg3RWWoCYAAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 17 Jul 2026 06:51:57 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 1/2] ACPI: Use correct region struct for BERT region size check
Date: Fri, 17 Jul 2026 08:51:21 +0200
Message-ID: <20260717065129.72924-2-trenn@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717065129.72924-1-trenn@suse.de>
References: <20260717065129.72924-1-trenn@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 584243E44
X-Spam-Score: -3.01

The structure representing BERT data is struct
acpi_bert_region, so its size should be used in the BERT region size
check.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 908cc5c7e643..8395efbe248b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -447,7 +447,7 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	struct acpi_table_bert *bert = th;
 
 	if (bert->header.length < sizeof(struct acpi_table_bert) ||
-	    bert->region_length < sizeof(struct acpi_hest_generic_status)) {
+	    bert->region_length < sizeof(struct acpi_bert_region)) {
 		kfree(data_attr);
 		return -EINVAL;
 	}
-- 
2.55.0

