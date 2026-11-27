Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804552;
	b=HFI8GtT0JLnwn7/bAATte1Vl4GBDf53vFmd9UQt9sv41N9syOoLkXYBMADMB8zNjLyOd
	 l9sKYdRc0zRDtcZelPDG2Vvt9zrplSkQtGAZ4jv6kAsj4ai7sf7Z7sflc7Q49hu/eKzzh
	 wTTX0OlXinmPIj1kia6kO0ul33aTlXoh6P4EPRE1XznVa0nJ3D8g7WA3taojBSE8z0wZk
	 V4FCbFlAe5dZCKq1J5gb5EfZY5gLCAhDxEZz8mMSCbPiVu33OWaWONtKIFPoGM4jCdCUx
	 XpU1c6/UtaeXv6KVgWRP+NNVYIy89Bz0uDcjvUci7AjLVxOHvY5od1vTBERuGP0oRJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
	b=X4TWcNUngHsrG2r+I+WslQSlUp2NcZjYmk+Hdc0X0L56+Rfp1S+hIWpngtj/I4LSVLl2
	 mIpM3tYw/cIKyHp5x0DEgp90HFhYQ7LSuzrrbJOgasQSATsMTmY1jtlzFP/89xWo5xqIx
	 7GEIFHx/Ze7hLZzi02PfrAvZYwkFkp6M4EUmPaIxeFhrPubomg8CBePsmcLlpVvVOUe+k
	 DfCW2RIxXnH2riMzYbcU49zWKkzO/v09n7I+YoN3wxl/slElbnAw6dE/OtIZw/C3/8uKm
	 tpDJKI1bwVNUH3T6rgoVXIUVdix4+uMMuAyfBc5kIhUZKVTtjhUOSoGm3SfFAoMrNqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Fj1bJxJ0;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E960606A324
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 18:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E960606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Fj1bJxJ0
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55d360ca878so75456691cf.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795804551; x=1796409351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
        b=Fj1bJxJ0/q+RCXCL+ngrgkwcF9vPXRG9KyQ+E82YNMaBs0oRjulHVQ/26cv0e4+b5u
         W754HR+EZ/XzS6ncfOunsPe7plYOuq6Cmoi8KQxSetFUApHaQJBxC+t6H0KCBnkZOfsz
         e8MzgoFJrAWOL9ZPB8FvGhj8ABGzeXR2CBOotSDjuJVbw8fsP9btqkcAthJ1icYxSdvi
         2ocIY2FYVJVe18nQMXSHybxY/PTXbTs6O22AyLJayF3ptX1w05wnFQwkfCn0yt744AYQ
         lK0Oteoy7D1yLBAWeZRG6EZ+P87QYxG0zQrm0ak9iXwE0TKzbiMZ6oHR7WgLupm8OkQc
         iEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804551; x=1796409351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
        b=0MY9SVZzNEL1XZeFy2c3lQC9snQ0Z2K+iBWMTlCaOS88HBiV0i+hhlEp/oVclLHrKo
         uLNoCCHOyQpyLJ6+4bJv+Be6G9CSgqkdIGhPafdybYuNrsDoJRV5HtslJjwDtgA2K7Pw
         KQwO140zarOyZ3DH3WNUN5Jj4yzvutUa0RviB62ibjTctcIwoi/1PcGpt0jp7MfjTvkX
         iaK+n5cRveq/YzKQsPL4AVoplyvjLSBSwGun6fvagWOIX/wny2kvdZeae3WSvSgo5+5N
         AefF0oqcl2ULnX1WIq8Q3scJiZ5plEzCRgOTlYMl9DLfN+yYicscNoJC6MtxPQYAOpcr
         DPcQ==
X-Forwarded-Encrypted: i=1; AL+hErGveE7kW91fjY52OjdbI9zeuG4HLqNpIyIhHg3kFc9XLYyr6qZ2qDfaT6pQ1+qVWZSAhWW2+x8lKkOF@vger.kernel.org
X-Gm-Message-State: APuU4Z/CjSNgb5hdngxFDBE6IeyWuacfGXAsWxny6MwC9glSU2oev7NJ
	4YNeZnm9XdJIX8F9CaKeOQNE/PUTezAdBlTL6YknTjxQOaDK6PxVpagyr7YLP6Ss6yk=
X-Gm-Gg: AZFdTZeIpF+gHCna1x2nIoaAGj0u3y1fhhASDDCrzt4BjpccU0y8t7PG7gds9RpsTYD
	CIK5mvogpWc4t3u+T99+u0dEP/0J91S+cmI13n6+W63hamQxHoi7DsFI7BVHu999F1tOT9wUHPc
	ytdXgVhrpIcqOrU2zXk/OWmcqzKBhCKrF4H1akbZeVrqk1kpfthxD/9VFtyKgqTzzmfW2O16+tB
	kcZ+xaxQ9hKYAGad5z4iI+xxkQ2b8YDqvQgMo2pIJRQDzkVwCpai3ZazFbOzWRsOhVZJLySkbtu
	Fg66ksDeqII0JVp77EV/QOd2t8ME6y6O17zvCwmga+lVhjXHVnkkvbZjgL84bm34Q6BaB4EN9HM
	Uk38MG64j1ZsqfS9ZPo++Hi/g96Pf84y/gvDFpyaw7GFd0nSR89tmoeIa25UqzoXio+njEMnjmy
	eVFRSxq1RtrYN1MhhXjeFUl34j/3DJNsnJntpiwegRL3riy5vNytFQd1ycN6fSSXnakJQ952Upe
	wDbgInZi4zqroKCwnmLH9tZd8kh6g9BXd41CRwaBhoy+DRCchNg91azj3T0YhtdZBD3BC0aF7mq
	PFCB5w==
X-Received: by 2002:a05:622a:5a0c:b0:54d:812b:ac2 with SMTP id d75a77b69052e-55d76aa5123mr463929871cf.28.1795804551241;
        Fri, 27 Nov 2026 10:35:51 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dc8895b8bsm36322411cf.10.2026.11.27.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:35:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX0nW-00000007aGg-0jpi;
	Fri, 27 Nov 2026 14:35:50 -0400
Date: Fri, 27 Nov 2026 14:35:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <20261127183550.GV246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnK2c3kMq8p2a_7@e129823.arm.com>

On Fri, Nov 27, 2026 at 06:24:25PM +0000, Yeoreum Yun wrote:
> > > +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> > > +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> > > +};
> > 
> > should be the generic EAT token type
> 
> Is there?

That's the idea. TDX uses EAT as well.

> but the content seems to be different according to vendor, So would
> it be better to keep it as vendor type format?

EAT is intended to be self describing, so if you parse the EAT then
you should understand what the vendor and content is.

Knowing the EAT came from RMM won't even tell you which ARM profile
version it follows, so I'm feeling like maybe we just need to tell
userspace it is an EAT and then userspace can parse it deeply to learn
exactly what it is??

> > What is this and the related work? That isn't making sense to
> > me. If the token size is not absolutely fixed when the driver starts
> > then it should be fully dynamic and this just streams the variable
> > sized token.
> > 
> > Ideally directly into user memory so we don't need to allocate a kvmalloc.
> 
> In case of live-activation. I think in that case CCA-Realm token could be
> different by activating the new RMM.

Then the size isn't static and you need to just stream it to userspace
whatever you have.

I'm expecting these unsized tokens to work by streaming them into a
memfd so that userspace doesn't have to try to guess how much space is
required.

I also think it is pretty broken if LFA is changing the token for
realms that are already running. How is that even going to work with
an RSI API like that gets the length then tries to fetch into the
allocated buffer? Token silently truncates? You need to loop?

> > This isn't OK.. We only get one struct device per RSI and it gets to
> > bind to only one driver. Given there are other drivers that will need
> > to use the RSI, like the TSM and others, this needs some other
> > solution?
> 
> Currently, this attestation driver is enabled when !ARM_CCA_GUEST only
> (IOW, when this driver can be built only when TSM arm-cca-guest
> disabled).

I saw in your FIRME series a solution to this problem, I think that
would be good to get out on its own and apply it first to RSI as
well. We will have the core RSI stuff, the realm attestation and TSM
driver at a minimum..

Jason
