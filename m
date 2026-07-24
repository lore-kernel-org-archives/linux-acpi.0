Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77053DB328
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897705; cv=none; b=MczlRarWbZTJtmi0mZi7KK6bub3BUPBCtmt3u0lrlTaXj7fgxHBQCC6oC1G0tyzKbD5Zzj744fD2x+e54QriEzfUUGS/5oqd0uv3V2gYBRfys/yMwl5bGhe7/wvoNwhYetwBVwhCYv3SBWsp5hI6TfTbzTr1BBlgHr5m0NQM98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897705; c=relaxed/simple;
	bh=lwxpPIN8j39nvFu3zxHRLmtlQFRoBkeVuQmk4WyK5r4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ8qUjJyL7SG6HNBoiiiZawGRsoae2ZZw3KYlABlzkmzsd/Soe6n0xFRTtvpTEowKcr5tGp9rNZcmgsIoPGY1S9tdFRS1Rjwa1vg6G/zcMRIzQwbLSgZlN5pMq8jiQnNSsM278ccRaY570mly3LSmOKLovpFVH74AJDC+QJ/KT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NR+JSjz3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbevJ7nY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NR+JSjz3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbevJ7nY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NR+JSjz3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbevJ7nY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NR+JSjz3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbevJ7nY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 069FC4014;
	Fri, 24 Jul 2026 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784897696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGSEa7Up50XriuwYOmh8/38K+yzbqtjPK9KWNExBa/M=;
	b=NR+JSjz3S7r9dUjqMwVHIUzin5wseXAr+q/Yh37DnHxQ2d1oNSVJ0OYxekJan8QUsGJ5SF
	0NfJQgW8t1G1Z+2sHVtahvZDHCbFhIAcOqpBrsHAdas2yf8RYd5rj73JXlJSEHKBuRVx/H
	2zoZpdCpcLTC16C/R7cCEtn6nRQWHtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784897696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGSEa7Up50XriuwYOmh8/38K+yzbqtjPK9KWNExBa/M=;
	b=fbevJ7nY1SHsBNvxwpwWFIYq/rPL31S3lJItgG7b1DUC7AWwFl0WygTDHOYRjjwW+Ve5vK
	q0QJIOEIJD+dfSCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NR+JSjz3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fbevJ7nY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784897696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGSEa7Up50XriuwYOmh8/38K+yzbqtjPK9KWNExBa/M=;
	b=NR+JSjz3S7r9dUjqMwVHIUzin5wseXAr+q/Yh37DnHxQ2d1oNSVJ0OYxekJan8QUsGJ5SF
	0NfJQgW8t1G1Z+2sHVtahvZDHCbFhIAcOqpBrsHAdas2yf8RYd5rj73JXlJSEHKBuRVx/H
	2zoZpdCpcLTC16C/R7cCEtn6nRQWHtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784897696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGSEa7Up50XriuwYOmh8/38K+yzbqtjPK9KWNExBa/M=;
	b=fbevJ7nY1SHsBNvxwpwWFIYq/rPL31S3lJItgG7b1DUC7AWwFl0WygTDHOYRjjwW+Ve5vK
	q0QJIOEIJD+dfSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C900779BA;
	Fri, 24 Jul 2026 12:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RWeJGJ9gY2rMfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 24 Jul 2026 12:54:55 +0000
Date: Fri, 24 Jul 2026 14:54:54 +0200
Message-ID: <87qzkscztt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Marco Giunta <marco_giunta@outlook.it>,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	imitoy@imitoy.top,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	munzirtaha@gmail.com,
	nadim@symbolic.software,
	perex@perex.cz,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
In-Reply-To: <amNfREFfIkZIsnB_@sirena.co.uk>
References: <87h5lsinn2.wl-tiwai@suse.de>
	<DS7PR19MB7724E1F838E331DDE7A99E5CFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
	<87o6fxeukj.wl-tiwai@suse.de>
	<amNfREFfIkZIsnB_@sirena.co.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.it];
	FREEMAIL_CC(0.00)[suse.de,outlook.it,kernel.org,linux.intel.com,imitoy.top,gmail.com,vger.kernel.org,symbolic.software,perex.cz,suse.com,awinic.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 069FC4014
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri, 24 Jul 2026 14:49:08 +0200,
Mark Brown wrote:
> 
> On Thu, Jul 23, 2026 at 02:53:16PM +0200, Takashi Iwai wrote:
> 
> > Mark, could you send a pull request including your merged stuff, so
> > that I can apply on the top?
> 
> I'll send this on Sunday, I can't generate a PR until then unfortunately.

No problem, I still wait for Marco's new version :)


thanks,

Takashi
