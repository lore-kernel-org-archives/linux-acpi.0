Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74651A13B;
	Tue, 22 Sep 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066825; cv=none; b=mOQEh/CMigo/sj2nhzVf+zmjawNZf7/DLPJx140AVj+V3moQD6FqFyT8NAXRCRP2Ei9B/52W4dnPfC5mwdRQSqazOAKxXyWYEK2ga7BNDu+yz7w+/9NOduafwmGnj0JQS1GBMriBNRoLBazFakT/EMm1Eq0twpMjMx7pKU/Q928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066825; c=relaxed/simple;
	bh=V5qw8MoSNcM+bGVK2QswyocmxOoD9O9Av2nEmh1uZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMYXhL5OovV78W2CAXIv3g3kc3OmeJ8KojqXRzHqd5/3sQKZFUU60xw1fMhz+uS0bLiO6Kcdxe6FA7MC72XhNgO7kzPdJAfzp+gwgeWwzjRFR/EM8MQG5bruDXm1MUGmOQgepS4ginEBQZFLDnbBlaCpCww+yRHDHdT67+Q0jJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1/V7Sqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1/V7Sqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6E71F00893;
	Tue, 22 Sep 2026 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066823;
	bh=024UKuRDI5/VbeqGV5UeGGlIhQ+AaGozhVsQGZ0ZvBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b1/V7SqsQ1JPANMx2UcQSx/57Lolu5s3EBU52BsacvpU5aLebkSERqS0Hj9puN8Lj
	 yi+zNrXR9coPd+ABJnp1xayLl+DvfIYXt81k7omFsa2aN4YFVl83N9c9qMWqB/qNwF
	 kJ0xGy0EBnoitd252KTbSSOwm35vQtrg+d4Y7DOaQLsw0JbtC37HNhpVy5v4EUlRjd
	 hRySyzhjGGpjiDtHwpG3O0cDj1RdpK6fqfbO4HkRu4+FONJyos+TPVLFsck90sxqPn
	 SQAXyXlKyLO+vOhdOASbLYuM2SKZP8fAEv4WbN2km2y6LyK+bBixtqb0BXHH1uEo+z
	 JRdlLtsC75fmQ==
Date: Tue, 22 Sep 2026 09:46:59 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for
 FF-A (offset 2)
Message-ID: <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901192906.133670-1-jamien@nvidia.com>

On Tue, Sep 01, 2026 at 12:29:03PM -0700, Jamie Nguyen wrote:
> Arm DEN0048D (Functional Fixed Hardware Specification v1.3), published in
> March 2026, adds a third FFH Operation Region flavour:
> 
>   https://developer.arm.com/documentation/den0048/latest/
> 
> An Operation Region declared with an Offset of 0x2 triggers an
> FFA_MSG_SEND_DIRECT_REQ2 call instead of a bare SMC or HVC:
> 
>   OperationRegion (AFFH, FFixedHW, 2, 40)
>   Field (AFFH, BufferAcc, NoLock, Preserve) { FFAD, 320 }
> 
> Each 64-bit field is one register, ordered from X0. X0 carries the call
> status on return, X1[15:0] the receiver endpoint ID (or zero, which asks
> OSPM to resolve it from the UUID), X2-X3 the service UUID written with
> ToUUID(), and X4-X17 the payload. The region Length is 32 + 8 * N bytes
> with 1 <= N <= 14, so X0-X4 at minimum and X0-X17 at most.
> 
> The spec recommends offset 0x2 for new platforms on the grounds that not
> every OSPM implements offsets 0x0 and 0x1. Linux has had both since v6.2
> but nothing for 0x2, so AML using the recommended encoding currently gets
> AE_ERROR back.
> 
> These patches implement it. I could not find any prior posting of this on
> linux-acpi or linux-arm-kernel, so apologies if I have missed one and
> duplicated someone's work.
> 
> All three patches are co-developed with Dat Mach.
> 
> Design
> ------
> 
> drivers/acpi/arm64/ffh.c holds the DEN0048D side: region length
> validation, the X0-X17 layout, the ToUUID() to FF-A UUID byte order
> conversion, and the table 3 status codes. drivers/firmware/arm_ffa/ holds
> the FF-A side: resolving a service UUID to an endpoint, and the call
> itself, including the FFA_YIELD and FFA_INTERRUPT re-invocation DEN0048D
> asks for.
>

I have concerns regarding the new dependency on the FF-A driver.

Could you clarify how the build and runtime behavior are protected when the
FF-A driver is disabled? The current patchset introduces a strict dependency
without explicit configuration checks or guards, which will likely cause
compilation or execution failures in environments where FF-A is not enabled.

> The two talk through an ops structure the FF-A driver registers rather
> than a direct call, because ffh.c is built in under a bool Kconfig symbol
> while CONFIG_ARM_FFA_TRANSPORT is a tristate. Unregistration takes the
> rwsem for writing, so it cannot race with an access already in flight.
> 

We need to explicitly document the reasons for establishing a hard dependency
between the ACPI FFH and the FF-A driver. In my view, this FFH mechanism (0x2)
simply issues an SMC call with the FFA_MSG_SEND_DIRECT_REQ2 FID. While I
understand the specification assigns extra responsibility to the OSPM to
populate the partition ID, are there any other technical justifications for
this tight coupling?

> None of what the handler needs was reachable through the existing
> ffa_device interface. ffa_sync_send_receive2() always addresses
> dev->vm_id, so a receiver endpoint ID supplied by AML cannot be honoured.
> UUID to endpoint resolution had no in-kernel user at all. And
> ffa_msg_send_direct_req2() throws away the response registers DEN0048D
> wants copied back to AML. Patch 1 splits those out, leaving what existing
> callers see unchanged.
>

I see above as one reason why they need to be separate.

> Testing
> -------
> 
> Built on arm64 with CONFIG_ACPI_FFH=y and CONFIG_ARM_FFA_TRANSPORT both =y
> and =m, and with CONFIG_ACPI_FFH=n, W=1 clean. Every patch builds on its
> own.
> 

How about CONFIG_ARM_FFA_TRANSPORT=n and CONFIG_ACPI_FFH=y ? Is that
blocked in someway I am failing to see ?

-- 
Regards,
Sudeep
