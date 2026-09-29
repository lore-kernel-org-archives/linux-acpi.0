Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694C4F93DF;
	Tue, 29 Sep 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675132; cv=none; b=OL8/ezyf7iuioeItDptvp96nMhPHDQslxZV0aV6jeIypZTceYa7vdtF3ewIMPyVTB7F+JlKgZ/PKPRs6Y6WDR7KWqPXfAZPW7GnKaUvGww0lBAtMKS8rOYhBHl/0tDnEWFeoh6F8qIjh4Fpc3oik7VUfRLpObP0Ri7EnQJ8WPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675132; c=relaxed/simple;
	bh=xCk8+uaXP7T6Kpiv52zlt/8t8w7jCD8xBmg98UngIVk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5DjeycAS5syEQ+ecjCUPICFKoPCg429yEYC6oKpTOC4ccRjfsXKU7zxtj7ahnxCkLzSia1qSiN0SOyqDNX5mUVIeaeSZxEHnBIg0yhzdKmUDj9PGohvPxjL4Cv1AN73W8iODJBGKwHP/8T6Z8Tzd5Z2CpCMNAKVvdfTWIr9Aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YlhzKY0r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y06NhwlQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ibp9aJgX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sJ9yDfPQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YlhzKY0r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y06NhwlQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ibp9aJgX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sJ9yDfPQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0146321BF1;
	Tue, 29 Sep 2026 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790675124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCHbnM642LxLoPuBofIdnowrOGEBuwjMHDXxKBWOHvs=;
	b=YlhzKY0rGmNeNTf76Gqxx+JLeKPvtfBNyEGanUxW53eEjcjLYe0KT/Jw6xWLhC/9jhSO19
	J9UpDCBm7g62oet5FobKA0tCTVnDjY7XnyUrdRkjUXnWBnLDU3g0x9SQhZFFmJcamORj6J
	AKSw8UxgFpKnsVHeD+UVJUfW9n4sYY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790675124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCHbnM642LxLoPuBofIdnowrOGEBuwjMHDXxKBWOHvs=;
	b=Y06NhwlQ7pkqBVOy5ZzZUeQ7HPuY1ELZI4PMYGF+j+N0RrqsLhPV+7bCBd35H3mdsBYYc5
	APoakbmXLrfe2cAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ibp9aJgX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sJ9yDfPQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790675120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCHbnM642LxLoPuBofIdnowrOGEBuwjMHDXxKBWOHvs=;
	b=Ibp9aJgXuf76GoWelzxdo5jreczgycPE2vQgqcbSoFjQmfXj9/6lALIe85MBxh1XJ4W60J
	eE2yWcXajb6wRUu4SoT3tGB2IOoKP60KWEgnFW1xzkoIQTBgxLapJlooykOvT2CWMTiPKv
	SusYEoe4Q4ILLjdx3c4hZuRSeoBB5S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790675120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCHbnM642LxLoPuBofIdnowrOGEBuwjMHDXxKBWOHvs=;
	b=sJ9yDfPQr5tWhdG646IXNLldrnCT7BCGKbjMLUhlAUZZjTIOUr4bblOQFecKlIuVsmhb9Q
	RYBLplKri2Hb6vAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA491133F1;
	Tue, 29 Sep 2026 09:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RN6eIK+Iu2pmJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 09:45:19 +0000
Date: Tue, 29 Sep 2026 11:45:19 +0200
Message-ID: <87a4p02xxs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ilya Pavlukhin <i.pavluhin@ya.ru>
Cc: Takashi Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	David
 Rhodes <david.rhodes@cirrus.com>,	Richard Fitzgerald
 <rf@opensource.cirrus.com>,	"Rafael J . Wysocki" <rafael@kernel.org>,	Len
 Brown <lenb@kernel.org>,	Hans de Goede <hansg@kernel.org>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-sound@vger.kernel.org,	patches@opensource.cirrus.com,
	linux-acpi@vger.kernel.org,	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for the bass speakers of Lenovo Yoga Slim 7 Carbon 14ACN6
In-Reply-To: <20260920092808.17234-1-i.pavluhin@ya.ru>
References: <20260920092808.17234-1-i.pavluhin@ya.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0146321BF1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[ya.ru];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[ya.ru];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Sun, 20 Sep 2026 11:28:04 +0200,
Ilya Pavlukhin wrote:
> 
> The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0, Ryzen 5000) has four
> speakers. The two tweeters are driven directly by the ALC287, the two
> bass speakers by a pair of CS35L41 amplifiers on I2C. On Linux only
> the tweeters work [1].
> 
> The amplifiers are described by ACPI HID CLSA0102, without _DSD, in a
> single node with both I2C addresses, the same way as CLSA0100/CLSA0101
> on the Legion 7. Patches 1-3 add CLSA0102 next to them. The Windows
> Cirrus driver configures CLSA0102 with an external speaker supply, so
> external boost is used.
> 
> Patch 4 adds the codec quirk. The ALC287 only clocks the I2S bus to the
> amplifiers while pin 0x17 is enabled, and the BIOS marks that pin as
> unconnected.
> 
> Tested on a Yoga Slim 7 Carbon 14ACN6 (BIOS H5CN42WW) with all four
> speakers playing. The DSP firmware (cs35l41-dsp1-spk-prot-17aa3856*)
> is not in linux-firmware yet. For testing it was taken from the Lenovo
> Windows driver package (tuning "Lenovo-S760-17AA383D"). Without it the
> driver falls back to the default spk-prot firmware.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215632
> 
> Ilya Pavlukhin (4):
>   ACPI: scan: Add CLSA0102 to the serial bus ignore list
>   platform/x86: serial-multi-instantiate: Add CLSA0102
>   ALSA: hda: cs35l41: Add support for CLSA0102
>   ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 Carbon 14ACN6

I can take the series, but before that, I'd like hear a confirmation
from Cirrus people.


thanks,

Takashi
