Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47731ED7C;
	Thu,  8 Oct 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428827; cv=none; b=QSCgv9IEHrv0hrUVlD7CTMS+pk4Ujd5H7IlmXJWc6+15SS/FteVY1FBvC50r4CBQxw8arCTgZXxqcwNzE5YVRd99Y6/WVaHVnKLr2peNrwRxrBH7wO065zWrCEmYjOdAlK5bjruCO8bg/6JrkyOYSoFoHAKDMxgRx+utyRLsuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428827; c=relaxed/simple;
	bh=IzLKLBvBJvQ90dp5Fr7AoL4y/c6CHUQCMulASK2sAN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USw+jF66sv5sVGFfhpwMd34JkFYog5ZJWF2y9pFwh2xj+G/0Z3dPbKeAuzZITx6JEm2XsAYmOO79NpSzFf4+wGK4vqL1H2VHC/722KJLwwJg9Z/jqRMq0DECzTcyzKfg6GfQp+Bndg2VM02XNPIK/BcLjSYIPzdsVVOXiF4Ywds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MTvM4QRE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MTvM4QRE"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE0B840E00E5;
	Thu,  8 Oct 2026 03:06:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mgqvtUb_NHYt; Thu,  8 Oct 2026 03:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791428804; bh=cyhM1nUNozz0bBiV0uhM/z9n5mfCAa1GSAZkjkT7ZwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTvM4QRENWPPyXa1ccOMqG0xWEftwSJsaexQPCdfxBkXP7aZz3Em5whU2pQk5U3et
	 G+uyGfmeEELkGkv+0ctFdA81yHntZDUoz4GPNiRNbGWn5VIaI7rw28qh8cX08XPtY0
	 m3V+1VmUS2w/Ua3WMxQzU38Kc6eCVUT1YCfM7qq+Uq2x45slABOTqqLuA+FNRdHTMg
	 gOfTMGMnSd+YlKNdxUoyIdYWOWwKGJOBMLiVSZAzhO3EZTFBHKOFduhuvZhHzIywWv
	 aK3/lZ3bo5qaaeSkaegusJbhR+Ij2ZdbsRvOEB5Exrbwlnt1WhZgmrWgGAgVDQg7Rh
	 p8LBRs2ECOzNSXNfJGtnTqEmy2XqWiUglM1iHXsNTo/T7LcVABevxKWAXggygRJUN8
	 WndUwCBiS7EvIW77HYvqxGuTi1tPhLBGCuBkVCDzEskMRaviNtXGckj9unOsth17KZ
	 DsjhwknwklTzWaCtfOR9k1uvCQgcJ/QuBCfEsSDJGuycQ2GeLCPG+31za9DrnM3r9Y
	 9OI5AdS0SYsRO1sUZnE6vX3sk2Q/a9iu2TtHC/326UTNyOvlUSoHNclJf0WEkMcfYp
	 uQtJUSOhCCCJIlpg8tKX4tYXYfBgAxG8kVbecegnZmJI+es8vUz6myXMDT3AgzcbqQ
	 JVbpZWFtomeYaCZJInqDT6xs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1C9940E021A;
	Thu,  8 Oct 2026 03:06:06 +0000 (UTC)
Date: Wed, 7 Oct 2026 20:06:03 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: shijujose2008@gmail.com, rafael@kernel.org, akpm@linux-foundation.org,
	rppt@kernel.org, dferguson@amperecomputing.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, tony.luck@intel.com,
	lenb@kernel.org, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jic23@kernel.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	ashoraj@qti.qualcomm.com
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com>
 <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
 <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com>

On Tue, Oct 06, 2026 at 11:19:30AM -0700, Ashok Raj wrote:
> > +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> > +{
> > +	struct pcc_mbox_chan *pcc_chan;
> > +	struct ras2_sspcc *sspcc;
> > +	int ret;
> > +
> > +	if (pcc_id < 0)
> > +		return -EINVAL;
> > +
> > +	sspcc = sspcc_get(pcc_id);
> > +	if (sspcc) {
> > +		ras2_ctx->sspcc	    = sspcc;
> > +		ras2_ctx->comm_addr = sspcc->comm_addr;
> > +		ras2_ctx->dev	    = sspcc->pcc_chan->mchan->mbox->dev;
> > +		ras2_ctx->pcc_lock  = &sspcc->pcc_lock;
> > +
> > +		return 0;
> > +	}
> > +
> > +	sspcc = kzalloc(sizeof(*sspcc), GFP_KERNEL);
> > +	if (!sspcc)
> > +		return -ENOMEM;
> > +
> 	__mbox_bind_client() reads knows_txdone at bind time to promote the
> 	channel off MBOX_TXDONE_BY_POLL. It must be set before requesting the
> 	channel, otherwise the channel stays on polling and mbox_client_txdone()
> 	later hits the mailbox core's "Client can't run the TX ticker" guard.
> 
> 	sspcc->mbox_client.knows_txdone = true;

Yah, I can see that happening but I don't have the hw to even poke at this.

Shiju, what's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
