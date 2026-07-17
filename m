Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3D3BED46
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271095; cv=none; b=T0aMEUyqJcaXlaz8POpGvorRmyvnepAm+nmsOCs2thQuqQqAMZySpjTJKvkxpJgqIWqePrGt3UuMIRk4eefa7YhyTS/K0I1rRRQSi62diOca7qr5hQvXdsvkfhxEPauuL3mk/8E7Z9N3ZRiMb10rztoXwNsMuj5DanyaoDm+CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271095; c=relaxed/simple;
	bh=7xq9fQvIK8JbrQKj8Wal4O+kdlxA6Z5+MMhpLDIZrYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFWcRuKA02+nQff3GRQN0I3taZmy1AoOkfgOzzZWbBxuDtpQN3R6I+6JOfMvnLFi1NWsL4RsJOF7aR6xacwDglEHm5EQ4Ke4xGlbW0F5QKSfmqoUDrCbeYy56AgE1Xxw7SNqJQhKOxa1YxAh2eN3Rh8za2BoZ2HYTyd5XFb/aOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UHos8aoL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VkXfHYFb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UHos8aoL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VkXfHYFb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UHos8aoL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VkXfHYFb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UHos8aoL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VkXfHYFb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44FEB78D74;
	Fri, 17 Jul 2026 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eY1BXOUwZ7/Zl6hTKSj4cgWkD80XYLG5snipLR/bozs=;
	b=UHos8aoLIyAy/njTxcalPhZn4GV096Dib89k6ZjuxbHJoGjCgnU6fFDYtYG4nUbFN0PI9r
	lZZazdbuoKE3QXrlOdanbZIHda78LUNCtVh7f31vFrANYtbIrODVpme39mm8Ls1gYkgjsT
	sbfg6SLXgApJ24Bh4CHgLVQKjf5SQow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eY1BXOUwZ7/Zl6hTKSj4cgWkD80XYLG5snipLR/bozs=;
	b=VkXfHYFbht4V2jsaHpOvjER0I0lqE9nwySNSMndGqtskkFxUzo95USUM/r/yqV/f1Ml0Eh
	3QYXqvnd9CAP15Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UHos8aoL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VkXfHYFb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eY1BXOUwZ7/Zl6hTKSj4cgWkD80XYLG5snipLR/bozs=;
	b=UHos8aoLIyAy/njTxcalPhZn4GV096Dib89k6ZjuxbHJoGjCgnU6fFDYtYG4nUbFN0PI9r
	lZZazdbuoKE3QXrlOdanbZIHda78LUNCtVh7f31vFrANYtbIrODVpme39mm8Ls1gYkgjsT
	sbfg6SLXgApJ24Bh4CHgLVQKjf5SQow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eY1BXOUwZ7/Zl6hTKSj4cgWkD80XYLG5snipLR/bozs=;
	b=VkXfHYFbht4V2jsaHpOvjER0I0lqE9nwySNSMndGqtskkFxUzo95USUM/r/yqV/f1Ml0Eh
	3QYXqvnd9CAP15Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 289D9779AA;
	Fri, 17 Jul 2026 06:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbu3CPTQWWoCYAAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 17 Jul 2026 06:51:32 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 0/2] Fix sysfs duplicate filename if multiple BERT tables exist
Date: Fri, 17 Jul 2026 08:51:20 +0200
Message-ID: <20260717065129.72924-1-trenn@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 44FEB78D74
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Previously sent to linux-pm:
V2: Do not use acpi_get_table, but pass both,
    struct acpi_table_header *th, struct acpi_table_attr *table_attr
    as function parameters.

Cmp with:
https://bugzilla.suse.com/show_bug.cgi?id=1270211

dmesg | grep BERT
ACPI: BERT 0x00000000DD695238 000030 (v01 AMD    AMD BERT 00000000      00000000)
ACPI: BERT 0x00000000DD6955C8 000030 (v01 AMI    AMI.BERT 00000000 AMI. 00000000)
ACPI: Reserving BERT table memory at [mem 0xdd695238-0xdd695267]
ACPI: Reserving BERT table memory at [mem 0xdd6955c8-0xdd6955f7]
sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'


Thomas Renninger (2):
  ACPI: Use correct region struct for BERT region size check
  ACPI: Properly map BERT and CCEL acpi tables to their data tables

 drivers/acpi/sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.55.0

