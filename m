Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785213;
	b=fYj37B1PyaxCIBGXIzO7sUEfAJRsrc6O3i8xB1NKpn+iluGA5XII6ZFlANvAw6DU4bZF
	 6YPTCOR11+O+dmGpe3tIK1PQ+Db6U6q7RSyuFalXhD4s31sMT+QTdb8OU6xww+6THipns
	 wR/+6VKQvAfd8XLygIOxic0lmjy+tK1lH5LKYrws7F9y/apxz2ZL+Q3KM3rKiPsoxa1yA
	 oVEGF5u7K6k4MZOr72xRjwh3Xx7doRHr6BVD4wp+WgxOsxQWviR6Bh6awU6cItr42/eQp
	 cElFeZJOL7v8DN7mo/cDYu5dq2dyp33DSKGI5KkLUbhUUWO9BkhH3K1hpBSlMzm+ICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785213;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AH9jbyRyqYQM8uXEqlVbbyuWAkQCPVJGJ6rXheEFJ/Q=;
	b=0gH0KL98unMqyLWTq0Ugt1IjxqqhrwupKzK6prxe0uoSdS4S18LPmSwf/iuJOaWaJhss
	 R3EwL/SQAOvVko6Jg56k5omvZ+znjrq6uGUEB9bkekXP+vTHxy8LH8IRJ5Glmw+J8rdKQ
	 z1EYf9HGXcYlFNksOg2yUXDupTLrj82Lf0Wxv5QdT4z8xiO3AnKlh8r/b8Mx22ZUOjphn
	 snQk6xGuZNbWeQiHdAekh9SNKMlwd53rZKEhUsRvdFiCiq1CLWa3mV/Fncb8JFW6fzUF2
	 7Bmp6oVYMrYbgDowYbk5rXyCP2PeckS/ybhtZk5+/u8UUzOrxr21AT8Iphj9NM6TMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqUIW910;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689D606A330
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqUIW910
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342E31F00A17;
	Wed,  4 Nov 2026 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785212;
	bh=AH9jbyRyqYQM8uXEqlVbbyuWAkQCPVJGJ6rXheEFJ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RqUIW910dsKAi0PXWO/dMXKS3N7RyvNVQ4qmdXxmLKX5SERn0RLcNeLf8bOQ9WSik
	 ThX4WduNIwDacCxsUSk7lkHcG0W2MO0+cRuMKrsm7ztdTcNfSYfjzYiap8PxHlH+tY
	 9e6QpxChceyBUVV9u/TWPN5U6sdRdW6yfZJfGXfiqevDx+TiqxOA58Io8AShz0qkAd
	 OTMI93uhbQsXCEegJdvz7jp7TJmsmuT4dUt0MsLUEpeuSYlliDzr8t1sjvZE7MlsPm
	 Fuv/IP5YdByBjn1Si7evZHCb3cc9wv/UXxpg6WX1n+L1JJpREEGujQKxFOxF9rj/Rb
	 zUdMFPEEBpGPQ==
Date: Wed, 4 Nov 2026 09:40:08 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dat Mach <dmach@nvidia.com>
Subject: Re: [PATCH 2/2] ACPI: FFH: Support FF-A direct request 2 calls
Message-ID: <20261104-poetic-durable-jaguar-cdf3ee@sudeepholla>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org>
 <20261103173907.1996118-3-sudeep.holla@kernel.org>
 <20261103211136.4122648-1-jamien@nvidia.com>
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
In-Reply-To: <20261103211136.4122648-1-jamien@nvidia.com>

On Tue, Nov 03, 2026 at 01:11:36PM -0800, Jamie Nguyen wrote:
> On Tue, Nov 03, 2026 at 05:39:07PM +0000, Sudeep Holla wrote:
> [...]
> > +	if (!acpi_ffh_ffa_version_negotiated) {
> > +		args.a0 = FFA_VERSION;
> > +		args.a1 = FFA_VERSION_1_2;
> 
> Same question as on the earlier thread: how does this work if the
> transport driver has already negotiated a version?
> 

Handling this coordination is difficult, which prompted my earlier query about
requiring v1.3 as a baseline. On ACPI platforms, this initialization conflict
is already an inherent issue, as the UEFI or early bootloader might negotiate
a version before the kernel FF-A driver probes. I welcome any feedback or
proposals on how we might cleanly resolve or track this pre-negotiated state.

> [...]
> > +	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_PARTITION_INFO_GET_REGS);
> > +	if (ret)
> > +		goto out;
> 
> I think REGS is only needed when X1 is zero, and if I understand
> correctly it's optional at the Non-secure physical instance. Would it
> make sense to check it in the lookup path instead, so an explicit
> receiver ID still works without it?
> 

That is good point. I completely forgot why I didn't add this check in
the RFC patch. Thank you for catching it; I will make sure to include
the proper fallback implementation in the next revision.

> [...]
> > +	memcpy(&args.a4, &buf[4], len - 4 * sizeof(u64));
> 
> I believe this would trip FORTIFY_SOURCE's field-spanning write check.
> So I suggest:
> 
> 	memcpy((void *)&args + offsetof(struct arm_smccc_1_2_regs, a4),
> 	       &buf[4], len - 4 * sizeof(u64));


Apologies for the oversight, as I remember you pointing this out before. I was
rushing to get these patches sent out, but I will make sure it is corrected in
the next revision.

-- 
Regards,
Sudeep
