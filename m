Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524F3D47DA;
	Tue, 29 Sep 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693075; cv=none; b=h7UOYMlzZAp+DjMIhdkoRm/2WHV3KcLj0gXi4UqOuXgM3ibF2PoXRwVKbXFrqDyJBOJ5hq2Q6VnxUgds6KHa0dty5dVeONarumZWwEbWDjrT3PwkV7foMN3TLJmUA5SnPeXVXqk/uQS9gslR7se94rRCLcu12NSS69tqZvGNQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693075; c=relaxed/simple;
	bh=IBivVthD/Ugs6+e9U2MOvI4k1mQbfDqv4RyAKNSKTok=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6VXee63Fsd8NAEFKPScRKJdI+RjXYcFjR76d1AEYCHXlXzooEtOA4MdGnWKXcDtNttoFfu7yQQaOY/tOIZaGfJCVuETaZEYYb/e/oFYms97x61FlBu195XIl2YPr4wdYPpFCEKJBNm+nd6of8AcmKTrSGDpM4GN9qu0T9y//sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HsyNOqIL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kcbJtTWw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A+V53BaP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vH5vAmfl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HsyNOqIL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kcbJtTWw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A+V53BaP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vH5vAmfl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC17021D20;
	Tue, 29 Sep 2026 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790693056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YILb/eLgFyt3BW9U3MzwkC5amjY5rBbHrDWNoL5EAGo=;
	b=HsyNOqILQHuPvpxJXvxaHajvIxE04B6AU6CAFEP/MHUkNRbyldugk3D6K3HudxMlRqoW12
	JOORELwX/96kCam0deFqXlfBN2QVDjH/oKOSGBq8ZdSNzzsm7FWCccSiJpiLj6KsDRtVOB
	MltIvy21zTUP1bX9hJEK0EdxQ6EbJSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790693056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YILb/eLgFyt3BW9U3MzwkC5amjY5rBbHrDWNoL5EAGo=;
	b=kcbJtTWwfzCABmFI8ItuisGt4roWB76CcoD/x0Jj2FQN/GwBKA7akGb1baZiQwrjdITIky
	gw6/Fs+R9av2jOBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790693052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YILb/eLgFyt3BW9U3MzwkC5amjY5rBbHrDWNoL5EAGo=;
	b=A+V53BaPm9ZrUzV/V0uEwhwIYW4vTQKqJyR8EQxhpr2CkdQnVWOWSS/qN9hQM29CKpgk8j
	jNl8mW9a/C7tRvCsLAT5ouGWAs8sqC824rs0lsRnBfB8W2Vkz9Q+B0o0zMsXjwi10d8apY
	kS1RmNhSRyVTix2F00009KYY1WVtfZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790693052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YILb/eLgFyt3BW9U3MzwkC5amjY5rBbHrDWNoL5EAGo=;
	b=vH5vAmfl9nGd/kah3RnT6+O6S8dcfUHOJEQMpaYox6EoyBUQfDUe3KpuP8ihrTmM2rme75
	0NU4iNvYnxpBKCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A9C1133F1;
	Tue, 29 Sep 2026 14:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uFQ6EbzOu2oRbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 14:44:12 +0000
Date: Tue, 29 Sep 2026 16:44:12 +0200
Message-ID: <87tsn8yv5v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>,	Ilya Pavlukhin <i.pavluhin@ya.ru>,	Takashi
 Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	David Rhodes
 <david.rhodes@cirrus.com>,	Richard Fitzgerald <rf@opensource.cirrus.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,	Len Brown <lenb@kernel.org>,	Hans
 de Goede <hansg@kernel.org>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for the bass speakers of Lenovo Yoga Slim 7 Carbon 14ACN6
In-Reply-To: <764f8a2d-c949-4297-bb26-af0ba791f331@opensource.cirrus.com>
References: <20260920092808.17234-1-i.pavluhin@ya.ru>
	<87a4p02xxs.wl-tiwai@suse.de>
	<764f8a2d-c949-4297-bb26-af0ba791f331@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[ya.ru];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,ya.ru,suse.com,perex.cz,cirrus.com,opensource.cirrus.com,kernel.org,linux.intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 29 Sep 2026 16:30:42 +0200,
Stefan Binding wrote:
> 
> On 29/09/2026 10:45, Takashi Iwai wrote:
> > On Sun, 20 Sep 2026 11:28:04 +0200,
> > Ilya Pavlukhin wrote:
> >> The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0, Ryzen 5000) has four
> >> speakers. The two tweeters are driven directly by the ALC287, the two
> >> bass speakers by a pair of CS35L41 amplifiers on I2C. On Linux only
> >> the tweeters work [1].
> >>
> >> The amplifiers are described by ACPI HID CLSA0102, without _DSD, in a
> >> single node with both I2C addresses, the same way as CLSA0100/CLSA0101
> >> on the Legion 7. Patches 1-3 add CLSA0102 next to them. The Windows
> >> Cirrus driver configures CLSA0102 with an external speaker supply, so
> >> external boost is used.
> >>
> >> Patch 4 adds the codec quirk. The ALC287 only clocks the I2S bus to the
> >> amplifiers while pin 0x17 is enabled, and the BIOS marks that pin as
> >> unconnected.
> >>
> >> Tested on a Yoga Slim 7 Carbon 14ACN6 (BIOS H5CN42WW) with all four
> >> speakers playing. The DSP firmware (cs35l41-dsp1-spk-prot-17aa3856*)
> >> is not in linux-firmware yet. For testing it was taken from the Lenovo
> >> Windows driver package (tuning "Lenovo-S760-17AA383D"). Without it the
> >> driver falls back to the default spk-prot firmware.
> >>
> >> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215632
> >>
> >> Ilya Pavlukhin (4):
> >>   ACPI: scan: Add CLSA0102 to the serial bus ignore list
> >>   platform/x86: serial-multi-instantiate: Add CLSA0102
> >>   ALSA: hda: cs35l41: Add support for CLSA0102
> >>   ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 Carbon 14ACN6
> > I can take the series, but before that, I'd like hear a confirmation
> > from Cirrus people.
> 
> Looks all OK to me.
> I'm going to send up firmware to linux-firmware for this laptop shortly.

Thanks for confirmation.

Now I applied all patches to sound git tree for-next branch.


Takashi
