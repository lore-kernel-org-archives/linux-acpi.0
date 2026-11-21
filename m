Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795302629;
	b=mIqpT+uMeoD0Pya4pwk0LWZ1SFEFXJVXJX0okaWJoPfxuLZuvClW9cqB51m8vqPGJYAK
	 cbXr8yXSkWASmcgGevSrDmVfhOP7ke0YYO9yBczdTlyWoLBZczMWbfCE5M8xUcaV1c8zC
	 NFjLd0zuFlwwIGdXEc5XmS1ifWWEAdI/qeh+fcV60qm9BoDAUnjOOYFk/uuTtT+9E8832
	 25ltbq7vFYHVPEJ6Ad0Uyv/VG9EBStkYZdQYd6UHB8ieZNpLnUVSNsy9XQk9VY7Os4RK/
	 rsvuPDIvU2vlfMYryi1ZauydqYPbf5fFTuacxlWaPuDzLqEgcnJCbnCii7jCS5VrITQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795302629;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KUpBP0Xy2iK8BxAyqumEvuIzOsYp/Z0C1HcgAVDz2GQ=;
	b=ta2h29Q75WOTDDcgFxlxqlzxhoGkU1N6A8Xo4zhAPOMK69l7FPu/zhCf/5Qhw7drHDFQ
	 Qq4psalo64kqMYw6oSzjhO6hyxGx53QiLnKJd9Nf272TeYcgBEDWZSMY4ekegekB2FAep
	 DKjvi5kf+tEhaZVa/6U02pPzWY3nuTcGDifxNLCTXbe+yCtZgfqRny626wCzvNtg57aIx
	 8fF+kPStPqsCBg3DxLjJJqIyfpkN/ByqNt1rXm1HZMXUu/l+U/UKY1bH07fYgB+UF7N79
	 dmKPQYSTTrkWFOG2tMq+pNdZGBvRqwpEfeYcEAmpBEEfX0KEGYCIhB1qIDYPuMB41eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=FHniVaW0;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA3606A320;
	Sat, 21 Nov 2026 23:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=FHniVaW0
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEB6640E01E1;
	Sat, 21 Nov 2026 23:10:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FQ6qc95uBY8V; Sat, 21 Nov 2026 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795302622; bh=KUpBP0Xy2iK8BxAyqumEvuIzOsYp/Z0C1HcgAVDz2GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHniVaW0TbDaJdfJuduL0+Gg5CbWKtdEFQHv4NPySjYOj5x35KLTnUI44sCioUC7j
	 QLQFvn7DrkCBXpyeF91H//mzmoK/UYodxPzNNa2VeJUo6nDrmI4uH0GltUppRHLUpq
	 mutb4t6rqIUu0o3/loErqn16UkhwbyYeA56RWmGezODDCFvWV7Jdi12i8pl8wTV0LN
	 9Ehz0z/l0o0GNf/f6lBFPCClhgfn4Co4hFeH4w1it09emZKF579wH/+pXFIuUpRfUh
	 d3J0R5YHEYNtmdUJ5WAjxxZqA91q1IveAuBIefWLTrTrPTMqC6D9u3KiEx12HIAcBA
	 tmPeOpGKoeYByVp4rptpUI3h+ay/Pflty9PPiL4Hmuuq/F5OdnEl+EVXru9NI+TedJ
	 JbOFk7Ns2y+ONmQXqDPPfonErzTpppUyAvuKucMsd8O+Y5zpt+q2lqQZsKm5sDJ8/L
	 z5N24mILDZ6VEbAKe0kNmJHIKo9prkyplhLoEF2+Kj+K611TUYsf9gougjNB1ggyug
	 pcxU4cYGw7LGI0+9kB78NE8HpCNf3TqPZROmFILWxfP3aD32uzCi5bStxRNcmku/ur
	 HYpl2qqYSYByZ2BLW1I32YSxqD91TLxqke69y6/XWJSn77BaZXRwpbMhRc5oLdDven
	 1wbG5E3L6wUqOcFPlQQbrshE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9D9240E00DC;
	Sat, 21 Nov 2026 23:09:45 +0000 (UTC)
Date: Sat, 21 Nov 2026 15:09:42 -0800
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	ashok.raj@oss.qualcomm.com, jic23@kernel.org, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
Message-ID: <20261121230942.GDawIktifTKlYhUlpB@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com>
 <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
 <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
 <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local>
 <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>
 <20261121210749.GCawIIJcidCeWs3ij9@fat_crate.local>
 <CAG4KcRKzXNsvBWuuU2_aX5gO7u4vgKAK+bkrB2vgEFBGu3WJCA@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4KcRKzXNsvBWuuU2_aX5gO7u4vgKAK+bkrB2vgEFBGu3WJCA@mail.gmail.com>

On Sat, Nov 21, 2026 at 10:24:28PM +0000, Shiju Jose wrote:
> Thanks Boris for fixing this and verified by testing.

I cannot test because I don't have the hw. I rely on you to do the testing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
