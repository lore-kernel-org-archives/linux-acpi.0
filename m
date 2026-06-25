Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08730C169
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411754; cv=none; b=KcgyFWIlubdOv5tgqv34hxdIII+qnqr4aMXWLu2+Nvit5vWZM9a3Ow5L1uHTXJgq81xFK4yH9U5iSI6EcCYx1uKjvdgJSMYL4ruaS1lXgXT9Klgq5LhRVj24jXpWaHTVMcaCv7h84GJ+09EO1hR5YIvzCq+cPehpFhgBegcMO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411754; c=relaxed/simple;
	bh=ELVhYR97/56S0xj78jBb6+sh0w2SnVrx/RtPaOUHnwo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zg8VmHPWRR1o5pMcLZpVpIbLnc2DfshK3IHzcCxbW202bLNWwyHNKDtUswJIdUCPfd1QfDSmYJyut6t6aTABHzq5KRZKjUdhzEHi5PxbmwX8Sel0FY6rMp356f6S5bHmlObxS1MGqr+U5sSixkzdT9+VTJqZD7wN8xgYJGD7+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afFn02f4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afFn02f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0021F000E9;
	Thu, 25 Jun 2026 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782411753;
	bh=jV/CxhSLZpkprYeAM4FiNKChRpTe3EY93HVCDlSl8D0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=afFn02f4Qptbu2nMNuryfZzePXzJHLmPYhIL7C3htfchXwvf4ZSHBB5DICPiAzQZA
	 ZrfujR9mZSRcFuV/Tj7VAqFZF4DeDKpBn4RU8hhqosu9p8ySYQH8eoUjz0I2FGi8fX
	 dW7MMtFBnLTepSWVnV+gT219RZgfUxsS23h6ioXtQPpAs+l75KwOcNMC5KsCmqmOmE
	 f1e/oOrtpPVeeiKPtjBOZ9flR2Dh+uXujIU/wRBTdLi5XXkluzlzaThmz4LLtqdJPt
	 o4b50HZr6Qhlw7k7gJ39bddYwbCLm2s/N8SgPTHxZWafUNfxCGuUDC+Gn2CbdTJOAK
	 c9mSdSikl9fcg==
Date: Thu, 25 Jun 2026 12:22:32 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yicong Yang <yang.yicong@picoheart.com>
cc: sunilvl@ventanamicro.com, rafael@kernel.org, 
    linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
    lenb@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    geshijian@picoheart.com, jialilv@picoheart.com
Subject: Re: [PATCH] ACPI: RIMT: Only defer the IOMMU configuration in init
 stage
In-Reply-To: <20260625094702.11558-1-yang.yicong@picoheart.com>
Message-ID: <2d4310e8-2d86-b636-af4a-253c69bae0e2@kernel.org>
References: <20260625094702.11558-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jun 2026, Yicong Yang wrote:

> The IOMMU configuration will be deferred if the IOMMU driver
> isn't probed by the time. Make this deferral only in the
> initialization stage with driver_deferred_probe_check_state().
> Otherwise the devices depends on IOMMU will be deferred forever
> in case the IOMMU device probe failed or it doesn't appear in
> the ACPI namespace.
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>

Thanks, queued for v7.2-rc.


- Paul
