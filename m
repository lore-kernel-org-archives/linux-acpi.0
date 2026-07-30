Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834633CB2D4
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403863; cv=none; b=pT+i0t1HefBUdNHki5sNpz7GagmUe8W1Ay1gzMibatoub04RNdklN45su0+pqVc1rGV0p2i2jUuZbDi+H8kCcxYDa69SHpBGlgcejqO7Wq5W6jATrFMEpAzGRYTnON23tdoQC/zkPnROs5X1u/dHbyPTG4YCx2RtUC0psFbr7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403863; c=relaxed/simple;
	bh=zs3QU+dq2GcENmuDjWUK8IbtiCWzGXyicvPpa0u/zhI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5L/pjdncF/eYf9ed0rD6yDdci7nZbUdkCheRgY1/ODxY1uYpJvgCKIEjh+oZhSYHNsLsS9I+oPFf6FZQZriZ6dyYPrQGa91DOGpsDKB2TkmLKMmC2y8esOAqa00kn5MQHFzPlRx7KmJ99VE9MG0kzQOB9AckEstrwxylJ6ikl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9dT+SaL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FmgGmpWA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WMJ+VmOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wUV3TVHN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9dT+SaL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FmgGmpWA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WMJ+VmOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wUV3TVHN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 888E37D3CE;
	Thu, 30 Jul 2026 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785403855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTz+y25ThCGpXPPOyWATbxwbeIYAgs65SRtjmyHZ8o=;
	b=k9dT+SaL2UIixwFNOpNKfXqHffAfBk3yEvRoA8i6+9Mr7m7GOE6CgxYPjSTJBnhBGM7sDM
	DwI2Pb11oyVUygweYHCZ/UJhgAfVn9kpLl+2/njYQ+T8zcjoFREMuepSl+uOahd2yRkLHG
	5aEtr/HeJiHtypAOXD5lCRYo6pkSFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785403855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTz+y25ThCGpXPPOyWATbxwbeIYAgs65SRtjmyHZ8o=;
	b=FmgGmpWAQ3PYFlUA9cB7UDMr+rkmbclIWV/F4gVllyAaWcOImY1Dlk0QzvDBjpVQoJIvcG
	rE0y8IK+frKgkGCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785403851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTz+y25ThCGpXPPOyWATbxwbeIYAgs65SRtjmyHZ8o=;
	b=WMJ+VmOiJziF5WjTJp3ePd5xpmsmNB1exukWS6TiSvcrVRhuFWFymRfMCoAN9ESvUeiz1l
	Y8+NC3S5HSWNSIGbBtzHth5H+nG3XfvjrvHGq7a3STpvR9/NOtdjRrfjLsBx6xZH5Xuftx
	7d20y15b2N+0XdgMnCak9XuXqVCgrlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785403851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTz+y25ThCGpXPPOyWATbxwbeIYAgs65SRtjmyHZ8o=;
	b=wUV3TVHNldOa7y3IVmijdqW5+ghFH6CtYTkQ7OEqcbJ2gKKZ5fJK/cpTRpQlL1wNf+TiRb
	NYB+eP87UEWqtACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16661779CC;
	Thu, 30 Jul 2026 09:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G345BMsZa2r0dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jul 2026 09:30:51 +0000
Date: Thu, 30 Jul 2026 11:30:50 +0200
Message-ID: <87qzkk3jud.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Marco Giunta <marco_giunta@outlook.it>
Cc: Takashi Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	Liam
 Girdwood <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,	linux-sound@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,	Len Brown <lenb@kernel.org>,	Hans
 de Goede <hansg@kernel.org>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,	Weidong Wang
 <wangweidong.a@awinic.com>,	Nadim Kobeissi <nadim@symbolic.software>,	Xia
 Yun'an <imitoy@imitoy.top>,	Munzir Taha <munzirtaha@gmail.com>,	Yakov Till
 <yakov.till@gmail.com>
Subject: Re: [PATCH v2 0/3] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
In-Reply-To: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.it];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,kernel.org,vger.kernel.org,linux.intel.com,awinic.com,symbolic.software,imitoy.top];
	FREEMAIL_TO(0.00)[outlook.it];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Wed, 29 Jul 2026 11:33:12 +0200,
Marco Giunta wrote:
> 
> This is v2 of the AW88399 HDA side codec driver series. Patches 1-5
> from v1 (ASoC library preparation) were applied by Mark Brown and
> merged into tiwai/sound via broonie/sound. This series contains the
> remaining three patches.
> 
> Changes since v1:
> * Fixed memory leak of acpi_subsystem_id string on probe error paths
>   by switching to devm_kstrdup (bug reported by Sashiko, confirmed
>   by Takashi Iwai)
> * Added Acked-by tags from Rafael J. Wysocki and Ilpo Järvinen
>   for the ACPI/platform changes
> 
> Patch 1 registers the AWINIC ACPI HID "AWDZ8399" with the ACPI
> scan ignore list and the serial-multi-instantiate driver.
> 
> Patch 2 adds the HDA side codec driver: I2C bus driver and core
> driver with HDA component binding, playback hooks, power management,
> and per-model quirk matching.
> 
> Patch 3 enables the driver on Lenovo Legion Pro models with Realtek
> ALC287 fixups and AW88399 per-model quirks.
> 
> Link to v1: https://lore.kernel.org/linux-sound/DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com/T/#t
> 
> Marco Giunta (3):
>   ACPI/platform: add AWDZ8399 to serial-multi-instantiate
>   ALSA: hda/scodec: add AW88399 HDA side codec driver
>   ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro

Now applied all 3 patches to for-next branch.
If any, let's fix on top of this.


Thanks!

Takashi
