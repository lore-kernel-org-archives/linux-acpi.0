Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DA481AA5;
	Wed, 22 Jul 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709953; cv=none; b=MnZlQ8/7oiiuDLypW5S9p0JXt5LONNB47QK5JqICfynMsSyQqbETELFcih895Z031vNzY57eeK6gC9OmnEmvh/EnPYfBM9lfAZrUtrbdLwpV6ianDpFC9TIhr1gFII9LhAQD2khVT5G1pfV/CjRE58ngMKzbUJUR7zST/hJ7iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709953; c=relaxed/simple;
	bh=oNymRQHpPQ41yGbKILJPRbN2OTOIj39nT+vil4TB+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHm2GOlsPUXgQllTMq86CQNURk19o/LljsDuFzr11Th/QX0/yyjWnB5Hd52l+FcZDjPbRUaKaRoJEgQHAldiULlyohPViFmUmxMLhSV28OIrZS4nqTXfvKsif68/z8pjFwohGGoptZqGnCJCTIvCLuQL9qqlZfzJP7M1kET9CAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnG44NP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnG44NP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCCD1F000E9;
	Wed, 22 Jul 2026 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784709951;
	bh=e0h1z+7tWqs4BZ2exNi5sf3y25/tSU3PDuHluuN2ke0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JnG44NP+PNxXAt+98ZuRcRmvEV5sxObiVmvj7fgDwQuBORR5Zm9tDg1xNIZqQp92P
	 cL72xv9HFYPE8QxkNJG3Sn+w5LO4FtwzklPq2IdlRwzPBCJc1CGL1T8Pa3qyp1bbHO
	 aMm4y/ICyKwMYgoSypT0nQRVdmMJ7S2aXQ7cehIwTpUi1GyJa7WFTwkhG4Xn11n5oQ
	 S8qwYNMHBSIadi206k0bxAUtNYfxOLEDKgOhZkmaRdieSJaJNeoI7fInuLBVYt1pRr
	 /p4kXhVOsAEyUbmZ+QdgIGWTpEYCEJAYoHG35BVchXl2bfBCa0IAAzqU3yQYKn6pka
	 rO6dKsuszh+gg==
Date: Wed, 22 Jul 2026 09:45:48 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: acpica-devel@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI: PCC: Free channel on OpRegion deactivation
Message-ID: <20260722-advanced-economic-tench-aa8a08@sudeepholla>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-4-sudeep.holla@kernel.org>
 <fcedb818-fb09-4a0b-a916-d65f762e5905@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcedb818-fb09-4a0b-a916-d65f762e5905@huawei.com>

On Wed, Jul 22, 2026 at 09:15:40AM +0800, lihuisong (C) wrote:
> 
> On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> > ACPICA calls the address space setup callback with
> > ACPI_REGION_DEACTIVATE when a PCC OperationRegion is torn down.
> > 
> > The PCC setup callback currently allocates a fresh pcc_data and requests
> > the mailbox channel before looking at the function argument. If ACPICA
> > deactivates a region, this can leave the existing region context and
> > mailbox channel unreleased, and may also request a channel during
> > teardown.
> > 
> > Handle ACPI_REGION_DEACTIVATE before allocation. Free the PCC mailbox
> > channel, release the region context and clear the context pointer.
> > 
> > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > ---
> How to trigger this region deactivate at runtime?
> 

I haven't tried it myself. I wasn't even aware of ACPI_REGION_DEACTIVATE
until sashiko pointed it out and then did some digging in the code.

> Overall looks good to me.
> Reviewed-by: Huisong Li <lihuisong@huawei.com>

Thanks!

-- 
Regards,
Sudeep
