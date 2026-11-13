Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562714;
	b=Pe9S5Kn+TK1CLWKKkWJ39/Add3aF71QHuhgOtEHjSZ3PejBQK5q3MVsuXmT60R+jeFoE
	 IY3nKHzbAKm8Jy6NAYDs7i4iy0ZBdbzF1OGKwhBMhfYFULV366eFDLzOt8eB50Rm/TSJV
	 +phZhHmFYdHSPpw2XtP8AxBNvsMYHc9Tp1NvYV1YtNRzkh2oz6S3AM4D6tmhMKh9jl9Tq
	 Ihopsnw+ejk9NYSaWx8jDuWSiWuqXxHk/yS39jCQM08ZKeJ+q1gpZasZUHsugkkPRw9k1
	 Bc3sYvGScz4rlW3GmM8do95cWA6BZMU2R4gYNVeWWQEz5YJhcbukLYh96teDM7hLiJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fDlgPTYiBve6ac0EYBh5ooi40MgDxOWxlCucyVyeQqE=;
	b=0EejR0AbYoVUnMgAZT3jOP+f7/kRvhj7wFbVLO4WrdebpFu2PNYzC3klRQz23QLHC3ht
	 dB43j2UQQITbT0G5LU5C9nclssEp0s5z9yoIq+bbKQyoGODpDlePC+QKQjyqD8B31Vjxt
	 XI1uwF1XkNKCZzBvSwxTzyIfdHA3xMsHd5VrFWAk23uei0uwxzlak8iNHjBVX2//NVoej
	 Z7LbNbhwCJbOQyPG8v6+0zkpnvQxBkRoMRA1YmJlsGGYuuyNlLFr/Epo0tjsbMyqO3clK
	 zzahI8gojVjY+yNBmZ+t8A9moEPd/FEXPDLaN+kQ640tXXjZfla6mUkQVy7RAfdoTvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrdtmNVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE54606A33F
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrdtmNVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EC71F000C8;
	Fri, 13 Nov 2026 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562714;
	bh=fDlgPTYiBve6ac0EYBh5ooi40MgDxOWxlCucyVyeQqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrdtmNVEX6vFWYNrugRtAcCWWH2zt84rUMn8ClUP5nviTGWbxAz2VBxvTHUuf1zlQ
	 4ZTOeLMB88Vi9xHdNM/uS3gOHhy4wSu0awpqaDpyLg7NvaI1TcfVa2e5qsnNrAwAFP
	 +Q+PTfgXSQI49l+xdNmuI/87bKJHbEkjfBQyF+E5WbXDepbXPCCnuL1ftPXC+KBgtN
	 cCiP1XdFu0MKrVOkG0aSQuYCu9ggDcEBcCVgkTD76Q5NxW+wHgKGEFmOSz3L5cKtIE
	 HEHNauuNQ4b0ceq+JEp8P0I/SRqEtY8MiXGGJsu8cGVN0wq/LK8Ey9OLGVmUQoB6ve
	 XjCx4/Ah3QlEA==
Date: Fri, 13 Nov 2026 09:38:30 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dat Mach <dmach@nvidia.com>
Subject: Re: [PATCH v2 3/3] firmware: arm_ffa: Share FF-A version negotiation
Message-ID: <20261113-innocent-cockatrice-of-fragrance-ffb1dd@sudeepholla>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
 <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>
 <20261112163047.575186-1-jamien@nvidia.com>
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
In-Reply-To: <20261112163047.575186-1-jamien@nvidia.com>

On Thu, Nov 12, 2026 at 08:30:47AM -0800, Jamie Nguyen wrote:
> On Thu, Nov 12, 2026 at 11:14:08AM +0000, Sudeep Holla wrote:
> [...]
> > +	guard(mutex)(&ffa_version_lock);
> > +	if (!ffa_version) {
> > +		invoke(&args, &res);
> 
> Can this scenario happen?
> 
> 1) pKVM is enabled but not yet initialised, and offset-2 AML runs
>    (e.g. during the initial ACPI scan), so ffh.c gets here first and
>    negotiates directly with EL3.
> 2) The result is cached.
> 3) Once pKVM is up, ffa_version_check() gets the cached version and
>    never sends FFA_VERSION through the proxy.
> 
> If so, then I think kvm_host_ffa_handler() would reject the transport's
> calls, since has_version_negotiated is never set.
> 
> Should we decline here instead, without caching, while
> is_protected_kvm_enabled() && !is_pkvm_initialized(), like ffa_probe()
> already does?

Yes, I had already considered this, which is why I kept it separate.
That way, we can easily drop this part if we want core ACPI FFH Offset2
OpRegion support without the extra complexity. Even with this added
logic, we are still constrained by the requirement that the bootloader
(such as UEFI) negotiates the exact same version. Given that this
doesn't provide a complete or reliable fix, I'm inclined to drop it
rather than introduce complexity that only gives the appearance of
solving the problem.

-- 
Regards,
Sudeep
