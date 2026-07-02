Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6838E8B7
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987905; cv=none; b=teGNGUQ9osj88B2VYHsfPOM/ticTICT6bFogygQxmEV8ntZwx4xFWmEkn1gKi+SoY385aNhpMMZXgYeJHfr636s0ndFbcgYYyRKILW4pr997Ez91TiJVO5+qqZcd32iVDOSjOEfGtB3XDmrXOjrK1qHx/RlWvJ7B/ipwSAlmZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987905; c=relaxed/simple;
	bh=2rNwoyE23k8p6TjFhIe1ZNDvsY6wNFfuQUQ6rt4mxB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgoHILn23+wYAyBKwkd4T7MS5lwKMKH8HLLsanKS23kldpPvpLtP/9RYGmA19F2GutgRbGTUXQrRII/S8qc25EGIJB6AZV66cCAAV2EarOiGxSLThvNtGoNbWe5K6nt7ftXZT48oXXrHdrEytQk+IWDe4Epm4uBufLYi82GapdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdnOh8Pj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdnOh8Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3681F000E9;
	Thu,  2 Jul 2026 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987903;
	bh=1j+IPYjqAjXItJ1ccDg2YxEejrAuFj8azFPOIgERnP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OdnOh8PjBa91vS/0fNCvOCjZKRnmojVrDLhxi7+Ycw0EVkKY06kQph7ZlD4o7ROg7
	 Va5/UnhwyJn88c66RhQ1N66a9YmyFWoHlL+LyPw4B8hZ7M4R9KaqQx1ezcIZ/6Ibia
	 VC+ItwaoTtF2NuvF9pEIvM1QeZpvE51GnaHq6VSDN1+yizIb2KrTwXpY7wzNeIYFFv
	 4YGBKycXxQgxnZikC1LxI7/yppLowYscr2fK8wj0Z/KCiwyq5eWJsbPZfMqDn0hOeD
	 7vFdXMEsGSZMP4l50C65oaIBH+mMUZTmLgsBoj3Hlk2YZV9pe/KhCm1g3DSdeVUrkX
	 HCk21bajYAjIQ==
Date: Thu, 2 Jul 2026 11:25:00 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/6] devfreq: hisi_uncore: Preserve PCC shared memory
 signature
Message-ID: <20260702-nondescript-scrupulous-dalmatian-da23be@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-4-c1b7268d4fdc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627-acpi_pcc_signature-v1-4-c1b7268d4fdc@kernel.org>

On Sat, Jun 27, 2026 at 05:37:32PM +0100, Sudeep Holla wrote:
> ACPI specification defines the generic PCC shared memory signature as
> the PCC base signature ORed with the subspace ID.
> 
> ACPI 6.6 added clarification that the signature is populated by the
> platform and verified by OSPM.
> 
> The PCC mailbox controller now validates the signature when the channel
> is requested. Stop copying a complete local PCC header into shared
> memory and write only the command, status and payload fields, leaving
> the platform-populated signature intact.
> 

Based on the discussions in 1/6, I assume 4/6 and 5/6 doesn't work well
for Hisilicon platforms. So I will drop them. I will just post 1/6 reducing
it to a warning.

-- 
Regards,
Sudeep
