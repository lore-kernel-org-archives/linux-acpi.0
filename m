Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCC41A4F1
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159723; cv=none; b=bBHpP9xmFjCjy66IVK7oQeLa9zB8KCtX7Sr6nYqSTXaYjuy/PixPlz999ZrLAQVIATlb9Y9lzB1YJxdBsTmH50CjJ+7T4No5dEZiQh7Lv0xQbhVosnEvncoUAY2rym7cfKkzgC1lE3UrnbryNLM+3ZF7Z+Wf8C489UA4tqyQTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159723; c=relaxed/simple;
	bh=cEjTUob3/RMUWLeJdq/fHY7Csz3hUUYlH5zELynpEFw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beqzK18F+syDlboTcCPvi8HOnUim6vtOJebgwSRznkHQo/QrjsxnluIfc8SkSBvJxCpJ2BwVpoFZl0Hwq6asBVg8vf8VWteSC8oOUZF7oSSiZEgUdEkvPzwjpyvNo73ygXaEVrC6QOVfsFuebGjWC9U4oTudRdmFfpo+dMIOUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z8d7Ld/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=myVqyvIY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lWypVjbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Feg9kTHd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z8d7Ld/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="myVqyvIY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lWypVjbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Feg9kTHd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5519D7D3AC;
	Mon, 27 Jul 2026 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785159715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol+wJN7SMQsWClj0GQ/esC3CCeSGLm9ulMH1scVCpK8=;
	b=z8d7Ld/syGosi8JLxQ7l7koNg1leoowl1zGPH97arlxOHbGDfdXKkquMgBtuigODR0f8fc
	67jfHM4/TNTmy23YUqBzIPOIRTwntovJ3jKi0ajKO+am0lGJtphUTh700rUg6G5dKzTNzA
	yvqHSqP8+6rJo1dUO3Tc5yHZh4yCwc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785159715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol+wJN7SMQsWClj0GQ/esC3CCeSGLm9ulMH1scVCpK8=;
	b=myVqyvIYgkYQTbAaOvX1IWUn2XqClf3tnkU2M1Kv5O3WcQVqd+nLrJKiIL4cny5Gy6U2Lo
	etg1duEMmR1idTCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lWypVjbQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Feg9kTHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785159711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol+wJN7SMQsWClj0GQ/esC3CCeSGLm9ulMH1scVCpK8=;
	b=lWypVjbQUPK51Q0VUVHrVkty2bjPRSd4cesGkUUjmZcLyjpAz9zKnUiszj7AAFfDr2/doE
	tDuniYzH865kkFsX4wrpi/5/64cWRcbAQZu+BgwYdhcOjVKD0lpRnfYuHxNx7r8v3ssrpl
	1UAuc5KLqJh1jhto+gggGP7laMiTwBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785159711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol+wJN7SMQsWClj0GQ/esC3CCeSGLm9ulMH1scVCpK8=;
	b=Feg9kTHd4K8BLrZq7OhqQnexoXA/hnXfjjR98mDJOWVVDZU6yLdpkUdoiwJVlpVUWY237S
	hJ21oyFpyGg8jaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D77FC779C1;
	Mon, 27 Jul 2026 13:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KtRoMx5gZ2qMFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Jul 2026 13:41:50 +0000
Date: Mon, 27 Jul 2026 15:41:50 +0200
Message-ID: <87se548s81.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Marco Giunta <marco_giunta@outlook.it>,
	tiwai@suse.com,
	perex@perex.cz,
	lgirdwood@gmail.com,
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
In-Reply-To: <06572961-d2c6-4de5-9102-2b5fc6d5ef5d@sirena.org.uk>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
	<06572961-d2c6-4de5-9102-2b5fc6d5ef5d@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5519D7D3AC
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.it];
	FREEMAIL_CC(0.00)[outlook.it,suse.com,perex.cz,gmail.com,vger.kernel.org,kernel.org,linux.intel.com,awinic.com,symbolic.software,imitoy.top];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, 27 Jul 2026 13:57:06 +0200,
Mark Brown wrote:
> 
> On Fri, Jul 17, 2026 at 03:25:02PM +0200, Marco Giunta wrote:
> > Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
> > Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
> > to drive their bass woofers, connected via I2C as side codecs
> > to a Realtek ALC287 HDA codec.
> 
> The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:
> 
>   Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-aw88339-lib
> 
> for you to fetch changes up to 15c9fdb3c39d5073463ffa746cc64ad9682c875f:
> 
>   ASoC: aw88399: add channel setter for HDA side codec (2026-07-21 19:16:08 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Add AW88399 HDA side codec driver for Lenovo Legion
> 
> In order to support AW88399 HDA side codec used on the Lenovo Legion we
> need updates to it's ASoC driver.

Pulled to for-next branch now.  Thanks.


Takashi
