Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCB3603E0;
	Thu, 12 Mar 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331773; cv=none; b=PmfXLLZ1tR+md4xY7VDn+Tjm9K+uKaXRLMx3+1QDRCFFRqhj0AsxmJEuNInY/657aAdTM22+gE8epDT0wi6cGXjnBbjeVPG7e8kwAYt2INEB2iG3jEnu3jWBukzCqxk52n28a1I53IKF1+2Byvj9qa9fvqAQcZsQ2nZI9wxhepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331773; c=relaxed/simple;
	bh=F6ar+rWQgS3G61fxiElS+OzAVhybDwKcKMteNP1wGxI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vFTFL9jNeowBPlYnMY0XDpwRf/3Ea5JCDkkEQpROzDdrOv+xnES3D5kEDcjmM+6ZqPRa7nh2PvJiLR+6xizFP3XoFQ9GM07fF90QFqxd/Zh8AGM/iBrcEre+z9y2e3o4mrFJgNBD6qZuixJ3Et/GHQWRVzXVCrDVhZemGOtsto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com; spf=pass smtp.mailfrom=system76.com; dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b=c1+Nw0WS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pcOlrNRw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system76.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b="c1+Nw0WS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pcOlrNRw"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85E297A014B;
	Thu, 12 Mar 2026 12:09:30 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 12:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=system76.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773331770;
	 x=1773418170; bh=F6ar+rWQgS3G61fxiElS+OzAVhybDwKcKMteNP1wGxI=; b=
	c1+Nw0WSs9Wvyq2F5aGIjnMq73LAPQY1WbxNn602UHSS85sgPoWhmH/tOWLKM7dH
	dxDKA/NPzf3TO9PCS+vtdb3hwfr/BbJlFoe723MH9x/oFbsoSC8D0NRHyUCll10y
	IVTSD2LDhf6pvVpyWTcHh1dpZtUWMTb59NfeBWdWF79uy5bGjxkETaikugHLUE0p
	LxRpdaY6Kbi6A5ceKsSitgoS8Zh+1BAZ9nIVHJkEG0+0Bfm1U4eT6HI8izjeF5V+
	ol55vZqfrX6LUME5zMRmTHYSgyLoPAg+jBJVOUbeKvVi4uB0vLG+C8NUE9h4OI0V
	NPwAJljYQ6ddfis7o+iNKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773331770; x=
	1773418170; bh=F6ar+rWQgS3G61fxiElS+OzAVhybDwKcKMteNP1wGxI=; b=p
	cOlrNRwiGMLdjNoCplTJZpRUuQj02xVB85uFtTcVveC0HIz7kZAo7jdg1lUet2ty
	zn4tuGKNh6U0XpOV4CFMBTWjIQOaZU6ebxfltVvYXfJj8cy6dJm/vKsZG/oPXvvu
	kbrOsJUS6oHFaq5pCzcT5qng+orJZa0Jr6lRmImDUVbjolrd66uTK9QgZ5KCtEep
	aIaBL8NXH3mNNaVD3OmjPY0HadgBtoxGqEDObBTsntBuVVIicSmTMOY58auIZ3oj
	1etMbknLkgEq2YpqQwjDQsWjKWgrhFesniBYKrhCPuPraDE7Vt08+9oyoXsj6Kcr
	7Ky3Wx++f4fEkptkegVGg==
X-ME-Sender: <xms:OeWyaRlXW2MdAeLw29qWlK2QVCCL0dLwi66aoF3T8HW9L4JQLL1k3A>
    <xme:OeWyaXpfvzI39I1oMCjmbBttQZFfWGXYOd62TG7TO-NUUqnwi9AdtE_-hwrMfuN-4
    uPwpb-ORfMIwwEnhl9ESvarbccEFi2tbyz0zOa05XfooHdfCw4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfgvrhgv
    mhihucfuohhllhgvrhdfuceojhgvrhgvmhihsehshihsthgvmhejiedrtghomheqnecugg
    ftrfgrthhtvghrnheptdefueffkeetfedvhfeileehveejgedvieekgeduieetfeduteev
    hfetieejudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgvrhgvmhihsehshihsthgvmhejiedrtghomhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehi
    lhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    epphhrohguuhgtthguvghvsehshihsthgvmhejiedrtghomhdprhgtphhtthhopehlihhn
    uhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgr
    thhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OeWyaY5m88R_wRv3Y3aVftB8pwLx82O9khrDSF3ybznzypZMB_Fodg>
    <xmx:OeWyaT5cl61L-XNDoJxDXC4WIHRzeXLkqkGRwfoTFhWrt3GmAR67Lg>
    <xmx:OeWyaeGIuNsm_GzEWHgJuIAAi-cNx70vEPbIVIgmngyB-3inSiMzCw>
    <xmx:OeWyabVrsIbTo56Pyt_uPkExoJTKcCQ1vkg6dQPTYD5gJ3qx6CphcA>
    <xmx:OuWyadPoG1pz3cqrWAuOYJ0p03vveAmNiMtTKdp7jqWarQt75PZLD5kl>
Feedback-ID: ic629427b:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 872DCC4006F; Thu, 12 Mar 2026 12:09:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Al-L5pM10uxg
Date: Thu, 12 Mar 2026 10:09:08 -0600
From: "Jeremy Soller" <jeremy@system76.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Linux ACPI" <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 "System76 Product Development" <productdev@system76.com>
Message-Id: <eaa78acf-7baf-4c46-9f7b-70ccd62a188b@app.fastmail.com>
In-Reply-To: <1968431.tdWV9SEqCh@rafael.j.wysocki>
References: <2841136.mvXUDI8C0e@rafael.j.wysocki>
 <1968431.tdWV9SEqCh@rafael.j.wysocki>
Subject: Re: [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to a platform
 one
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Rafael,

This change looks good to me, is there anything else you need from me as the module author?

Thanks,

Jeremy
