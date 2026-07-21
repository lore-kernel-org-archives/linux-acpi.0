Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CA47AF6C
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633561; cv=none; b=N6ZtLH2AXUDAq9aoqAc5+5aU9fgsEdc0SF92tsPKA6K2F+x4t2v7Pu+Nn7Exs+BCu0n/l016a1BE9NBQhE4fER/f/3HUdmuMdA00/TkSVjV7JXrjOiqnp1fO+uOMoKP4nsNurdVAzf19hFHvVyJiOQczvq5QaejDOSBjw8jDmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633561; c=relaxed/simple;
	bh=tAqk8hjz2KhRCfWYHnmmPRXfK4YAB4YOmX5TxoFX3Qs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RduMd2tbSoVIaM1Te6j6EbTMMhL+zaf8zZUq4Nc4vvc8uI5eX7h37LVtMKbQIsRGWUSMHh8Izd8o35ufAz6nK1tchqQW6cVeZOvdemgEYujgUu5UlVsz96oP4w8GZB/nBDpez5NHjf/Gf0VoHbDH0G3Qg5f/yfDijpMappIMZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ISPoKgua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=djeYcD6J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ISPoKgua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=djeYcD6J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ISPoKgua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="djeYcD6J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ISPoKgua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="djeYcD6J"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51D327A4BF;
	Tue, 21 Jul 2026 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784633554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L8kHg02VLrI1YxiKjnStMs53qmSbWqVJ2XvVN4UDbA=;
	b=ISPoKguaaJoOzMSa4owILcETh6tFg7ZZUppYlcD3bqtMBOI/resmUVxukbEhZ9bqq+u4as
	T6bWirLD8Ha0qfUwQpXoT/FMF7tVAFa3r9XKn2rgyID/wekn/BYYDNlCDmJvw2Vnnr7tkM
	eyADW/oMiIYjUr+1uCvVTp10WWlDh5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784633554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L8kHg02VLrI1YxiKjnStMs53qmSbWqVJ2XvVN4UDbA=;
	b=djeYcD6Jw4miOtmqNKNDJa+nhX/Z063jxcyEmcgm55FeCAUjBdJ1PJ207Zburyl4ZEuvWH
	GdyRVvJCTD1a7VCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ISPoKgua;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=djeYcD6J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784633554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L8kHg02VLrI1YxiKjnStMs53qmSbWqVJ2XvVN4UDbA=;
	b=ISPoKguaaJoOzMSa4owILcETh6tFg7ZZUppYlcD3bqtMBOI/resmUVxukbEhZ9bqq+u4as
	T6bWirLD8Ha0qfUwQpXoT/FMF7tVAFa3r9XKn2rgyID/wekn/BYYDNlCDmJvw2Vnnr7tkM
	eyADW/oMiIYjUr+1uCvVTp10WWlDh5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784633554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L8kHg02VLrI1YxiKjnStMs53qmSbWqVJ2XvVN4UDbA=;
	b=djeYcD6Jw4miOtmqNKNDJa+nhX/Z063jxcyEmcgm55FeCAUjBdJ1PJ207Zburyl4ZEuvWH
	GdyRVvJCTD1a7VCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AACE779AA;
	Tue, 21 Jul 2026 11:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UwjpBdJYX2rBFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Jul 2026 11:32:34 +0000
Date: Tue, 21 Jul 2026 13:32:33 +0200
Message-ID: <87h5lsinn2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Marco Giunta <marco_giunta@outlook.it>
Cc: tiwai@suse.com,
	perex@perex.cz,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	wangweidong.a@awinic.com,
	nadim@symbolic.software,
	imitoy@imitoy.top,
	munzirtaha@gmail.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[outlook.it];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.it];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,kernel.org,vger.kernel.org,linux.intel.com,awinic.com,symbolic.software,imitoy.top];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sashiko.dev:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 51D327A4BF
X-Spam-Score: -2.01

On Fri, 17 Jul 2026 15:25:02 +0200,
Marco Giunta wrote:
> 
> Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
> Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
> to drive their bass woofers, connected via I2C as side codecs
> to a Realtek ALC287 HDA codec.
> 
> Without a driver for these amplifiers, only the tweeters produce
> sound, resulting in quiet and tinny audio.
> 
> An ASoC driver for the AW88399 already exists in-tree
> (sound/soc/codecs/aw88399.c), contributed by AWINIC, but it targets
> ASoC topologies and cannot drive the chip when it sits behind an
> HDA controller. This series adds a proper HDA side codec driver,
> following the established pattern used by the CS35L41, CS35L56,
> and TAS2781 drivers.
> 
> Patch 1 extracts the device-level functions from the existing ASoC
> driver into a shared library module (SND_SOC_AW88399_LIB) with a
> shared header at include/sound/aw88399.h, following the CS35L41
> precedent (SND_SOC_CS35L41_LIB / include/sound/cs35l41.h). This
> avoids a build-time dependency on the full ASoC codec module and
> ensures clean separation between the ASoC and HDA drivers.
> 
> Patches 2 through 5 prepare the shared library for use on ACPI-based
> HDA systems: patch 2 extends channel assignment to work without
> Device Tree properties, patch 3 adds a per-instance flag to bypass
> an unreliable hardware status bit on certain boards, patch 4 adds
> a firmware reload flag so that the HDA driver can signal that DSP
> firmware needs to be re-uploaded after system sleep, and patch 5
> adds a channel setter so that the HDA driver can configure the
> amplifier without depending on ASoC-internal device headers.
> 
> Patch 6 registers the AWINIC ACPI HID "AWDZ8399" with the ACPI scan
> ignore list and the serial-multi-instantiate driver for correct
> enumeration of the two amplifier instances.
> 
> Patch 7 adds the HDA side codec driver itself, structured after the
> CS35L41 HDA driver: an I2C bus driver, and a core driver implementing
> HDA component binding, playback hooks, power management, and per-model
> quirk matching using ACPI subsystem ID.
> 
> Patch 8 enables the driver on Lenovo Legion Pro models by adding
> the necessary Realtek ALC287 fixups (DAC rerouting for bass speaker
> volume control, internal microphone calibration) and AW88399 per-model
> quirks (I2C channel swap correction, BSTS status check bypass).
> 
> NOTE ON FIRMWARE: This driver requires the firmware file
> aw88399_acf.bin, which uses the same format and request path as the
> existing ASoC driver. This firmware is not yet available in the
> linux-firmware repository. We intend to coordinate with the AWINIC
> maintainers (CC'd) to arrange its inclusion. In the meantime, users
> can extract the firmware from the Windows driver and place it in
> /lib/firmware/.
> 
> This work builds on the initial driver development by Yakov Till
> ("Lyapsus") and the bounty effort organized by Nadim Kobeissi:
> https://github.com/nadimkobeissi/16iax10h-linux-sound-saga
> 
> Marco Giunta (8):
>   ASoC: aw88399: extract shared device library
>   ASoC: aw88399: derive channel from I2C address on ACPI systems
>   ASoC: aw88399: add per-instance BSTS status bypass flag
>   ASoC: aw88399: add firmware reload flag for resume
>   ASoC: aw88399: add channel setter for HDA side codec
>   ACPI/platform: add AWDZ8399 to serial-multi-instantiate
>   ALSA: hda/scodec: add AW88399 HDA side codec driver
>   ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro

Through a quick glance, the code changes look mostly OK.
But I believe the potential memory leak Sashiko suggested in the patch
7 is a real issue, and it should be fixed.
  https://sashiko.dev/#/patchset/DS7PR19MB77247D9AD698CF0FF37DB58BFCC62%40DS7PR19MB7724.namprd19.prod.outlook.com

In anyway, as this series spans over different areas, we'd need proper
ACK's from ASoC, ACPI and platform people in order to get those merged
to the upstream.


thanks,

Takashi
