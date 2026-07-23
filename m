Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427154C77B5
	for <linux-acpi@vger.kernel.org>; Thu, 23 Jul 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811565; cv=none; b=Srpg8hWLYcqPSFn+JzySQmSPmYKXHC2aGk3flqKgx2Ly8ztARrAyrm2HAwSz5hmmOOo5yLO8uJ5Wa0uZWhS0Tx+q86M6WJUUSJRhFqOu9eWabjFyLK7Uz0eCn3ZM070kKqQvhmro4bt1F1fGMqOM1xtYQdhskvGk3GJGYnbAUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811565; c=relaxed/simple;
	bh=bznm588EPa9bJdG64W1UFIfXfyJsjnVPxb28HAqqZrM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0EKULYU5cOCPKj+Y+jkMoZjPv/xRZ6hirzGdhMD/3z7n5xEDcQAg/OZ7XmvInS6nQngqLadXHGeiDwTiNmfJVFNjMDwOAdrZeQ9/MhHpOJDF2SpHygqOQcnHoDBvbNbzGnAQt1s/cc09ExouMNY4EAeNy9ffLAyXTktH6KIJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TegYG/3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5XcEGg9P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TegYG/3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5XcEGg9P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TegYG/3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5XcEGg9P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TegYG/3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5XcEGg9P"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02BD93E4E;
	Thu, 23 Jul 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784811197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxd8CK9aDKgRwaDCc2ZLAd1RnUDdSF3ruOIyzkMi9z0=;
	b=TegYG/3d1m8qblACfpZKWbWaViQPYk5o0bhlZtnphCOjnWa3S6kXKlKYPelESKsb4wgJf+
	o8FanwIRy1Nt9sOjVPEIoKI8PIB9olyyOS7nXvsC3mY49Huo0wEiNlPYONeR4vAdrn1X6I
	2lxp77YN4T3LqbTadOPbnmzKckxrKaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784811197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxd8CK9aDKgRwaDCc2ZLAd1RnUDdSF3ruOIyzkMi9z0=;
	b=5XcEGg9PeBiIhMfAhD0HYj3kA+WdUcBKQ92UfFOSM9TXLP1hHCIo0KdyJBBtRVmZYqsDO6
	xFZFP5nOjEkhgmCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784811197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxd8CK9aDKgRwaDCc2ZLAd1RnUDdSF3ruOIyzkMi9z0=;
	b=TegYG/3d1m8qblACfpZKWbWaViQPYk5o0bhlZtnphCOjnWa3S6kXKlKYPelESKsb4wgJf+
	o8FanwIRy1Nt9sOjVPEIoKI8PIB9olyyOS7nXvsC3mY49Huo0wEiNlPYONeR4vAdrn1X6I
	2lxp77YN4T3LqbTadOPbnmzKckxrKaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784811197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxd8CK9aDKgRwaDCc2ZLAd1RnUDdSF3ruOIyzkMi9z0=;
	b=5XcEGg9PeBiIhMfAhD0HYj3kA+WdUcBKQ92UfFOSM9TXLP1hHCIo0KdyJBBtRVmZYqsDO6
	xFZFP5nOjEkhgmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73AC5779B5;
	Thu, 23 Jul 2026 12:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2xvrGrwOYmo9CwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 23 Jul 2026 12:53:16 +0000
Date: Thu, 23 Jul 2026 14:53:16 +0200
Message-ID: <87o6fxeukj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Marco Giunta <marco_giunta@outlook.it>
Cc: tiwai@suse.de,
	broonie@kernel.org,
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
In-Reply-To: <DS7PR19MB7724E1F838E331DDE7A99E5CFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <87h5lsinn2.wl-tiwai@suse.de>
	<DS7PR19MB7724E1F838E331DDE7A99E5CFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.19)[-0.950];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[outlook.it];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.it];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,imitoy.top,gmail.com,vger.kernel.org,symbolic.software,perex.cz,suse.com,awinic.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Thu, 23 Jul 2026 14:37:09 +0200,
Marco Giunta wrote:
> 
> Hi Takashi,
> 
> Thanks for your useful feedback.
> 
> > Through a quick glance, the code changes look mostly OK.
> > But I believe the potential memory leak Sashiko suggested in the patch
> > 7 is a real issue, and it should be fixed.
> 
> I agree with this point. I will prepare a v2 and send it in a few days.
> 
> > In anyway, as this series spans over different areas, we'd need proper
> > ACK's from ASoC, ACPI and platform people in order to get those merged
> > to the upstream.
> 
> Since Mark has already applied patches 1-5 (ASoC library changes)
> to broonie/sound for-7.3, should I rebase the remaining 3 patches
> (ACPI/platform, HDA driver, realtek fixups) on his tree and send
> a v2 just for those? Or would you prefer I do something different?

Please just resubmit for the remaining parts with the given Acks.

Mark, could you send a pull request including your merged stuff, so
that I can apply on the top?


thanks,

Takashi
