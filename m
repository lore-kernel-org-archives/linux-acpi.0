Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510493;
	b=V/qjtU3oUJFK5aYkCqO7G1PQyZQX2zMaTv3fYeLkRQ9Vd+imFjUyn1ileAUzfqb298S6
	 9RmN517C+FcFaCW62zJgTpTkGPE5/WFvWchSZhGQEd2dMwPiiAr2MHuNQACFXTnjCGukA
	 LKCCooAWusUHGwr7xMyPhevkayBnWRxYZrocDNwKekygR7mDrm3i6IB0muCX5J7t6owAm
	 KBLwI6N45jnpUvbEFY8B+LX+rUOvnpapHEkjJK4K4/NtzovXlft/kZ9u+Qfoo42YmPPV2
	 OcBlj3hHvfrKJB/SWPVEucQzoNPNpFEcDQZwDy7rNXUS7IHn4igZQjLFbGtjGYlcmRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510493;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spamd-Result;
	bh=FXOWBPmOf21F5XJZl5ItIlWjS1sUT59gcr713iMgN/Q=;
	b=fBkKMMZ9F0ztCFM/xNyLOxeKe7NMXqCipuGQP3GFPbtlqumw6vB9EsbCa68rFMvomcaB
	 rm2M7Y3b72rTRQcCBrsaleve4q/CSdAXFJzRD7pmxaZpQXR/j6JzPuNR52r/El0QD399y
	 IIWTYrAsuaPZrvwqWwYtQv0Wuqy7UsaQc7fG1DFW2pGLMEu/ZRptb4ZM50ogwlb+Zd1Jg
	 UXop3oFIv9L2BV2nbBR+vEprWicKkT3EEg7/LKmW8cz6KMdF+GKkA6dMcU1zA3Z0ojD5W
	 cTyt6QgjnyA6HFgDQRZAJRBekofT/NUjr2x+NBlWA2pP3U3lQhc/0XPQxxfZOOdHcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="fbc/LIL4";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W14fTtIT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="fbc/LIL4";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W14fTtIT;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FB606A31D;
	Tue, 20 Oct 2026 15:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8FB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fbc/LIL4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W14fTtIT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fbc/LIL4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W14fTtIT
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BD871F7C1;
	Tue, 20 Oct 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792510491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXOWBPmOf21F5XJZl5ItIlWjS1sUT59gcr713iMgN/Q=;
	b=fbc/LIL4fvrsVJUpJE5F0nTx6ucltOQ0cQXf35uqPkFY1xVej0jYrY1BOf1NWOuE0JUhtQ
	QjGt+hEK37rOxX2QCpWIAqpGIZJv7V/T/Ei/SQypCAairOLKFnksGiZo+Sq0Iqqxrq2bei
	LikHbKYd41mF1OwxDRnefAGh1SonXik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792510491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXOWBPmOf21F5XJZl5ItIlWjS1sUT59gcr713iMgN/Q=;
	b=W14fTtITfJHq4faXSQxi5vOY1S3rXhePNfH5jUHcPMlIWu1uEThsmTQP+6n/xiPb9AROj9
	ANvIvkkCvNXv/rBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792510491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXOWBPmOf21F5XJZl5ItIlWjS1sUT59gcr713iMgN/Q=;
	b=fbc/LIL4fvrsVJUpJE5F0nTx6ucltOQ0cQXf35uqPkFY1xVej0jYrY1BOf1NWOuE0JUhtQ
	QjGt+hEK37rOxX2QCpWIAqpGIZJv7V/T/Ei/SQypCAairOLKFnksGiZo+Sq0Iqqxrq2bei
	LikHbKYd41mF1OwxDRnefAGh1SonXik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792510491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXOWBPmOf21F5XJZl5ItIlWjS1sUT59gcr713iMgN/Q=;
	b=W14fTtITfJHq4faXSQxi5vOY1S3rXhePNfH5jUHcPMlIWu1uEThsmTQP+6n/xiPb9AROj9
	ANvIvkkCvNXv/rBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A508F136C6;
	Tue, 20 Oct 2026 15:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nEjVHBqK12p9BgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Oct 2026 15:34:50 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/cper: Fix forgotten type check in cper_print_arm_err_info()
Date: Tue, 20 Oct 2026 17:34:29 +0200
Message-ID: <20261020153449.419646-1-tiwai@suse.de>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

In the previous conversion of CPER type to bitmap in the commit
96b010536ee0 ("efi/cper: align ARM CPER type with UEFI 2.9A/2.10
specs"), one place was forgotten to be replaced, ended up with the
incorrect comparison.  Fix it to the bitmap comparison.

Fixes: 96b010536ee0 ("efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Just spotted by a code review, not really tested

 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index b21cb1232d82..b620cc9f8b5d 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -181,7 +181,7 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	}
 
 	/* The rest of the fields are specific to bus errors */
-	if (type != CPER_ARM_BUS_ERROR)
+	if (!(type & CPER_ARM_BUS_ERROR))
 		return;
 
 	if (error_info & CPER_ARM_ERR_VALID_PARTICIPATION_TYPE) {
-- 
2.55.0

