Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50240911B;
	Mon, 27 Jul 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159210; cv=none; b=GSaGUFoM6BqmCQrXrzTz6IXkKpbc1RHJuN6tTaOxbq2I1ZlLAnfMCe9ewL2Dzrz/PQaSVGu4mvVOE6EO05kM+MrEprzNwED9nMHPbWCyjsC6lCJx+12GRWUvzR6+MCReianiiAscTEH0/uQSKQ7RwHk+/zbidA4DXbz+FGTwVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159210; c=relaxed/simple;
	bh=4N0L48R7/vJPIMtrVEC8jWKGZojPV+4q8qTsyW4+uAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPjLOIxXfs9CJLPnTkeis01OaiUCpuhZZMcXuvfILga4uS/S1oDPV3UNJeOvMCcaoqgzC1+adI1iIryPYPtNxxkatRq3hlkGzQTRovBZAFsVciFQFDeEkhqb7z2pzMsoBIeGaU9YftcV9WvW35XU0Bb6JgkIm4FQofpbx3I/I04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/eNk6Jf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/eNk6Jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01D1F000E9;
	Mon, 27 Jul 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159209;
	bh=M8nUzlLmfXp3qz99nL6j1GxwtUSQQcbp5H3gxqfjjPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/eNk6JfuND17CvbyXfdUgOQNertYWeeMl0v3MYZhga6vr54jB5KRMXiW1Tqikg1p
	 F7kdnd9eSaMXC06+aPEayqUSGl/sfq3afrwOlSucbMyLCHZBs3ZnrpANJ2nTEtPHEM
	 3JcPFNtLyj46eA7KyFovAHHtAXvY/Z2Gon2f7i0RBOSHtRLeDn5u0//PS5B/aVX171
	 bjC1H/ftlq9id7cWRndK3Hm0BhimEZzRrPb/NzLbdqsQTzpfC4rP0m+Dwfiz/PFuYp
	 EmGiqg1h+nUFIbYgLqCUOHM2+mVVlOVWzgntd0XmLEO5qn9wZLIIyqYJ/HXSaWqonT
	 VRCrTwdIC+JDQ==
Date: Mon, 27 Jul 2026 15:33:21 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <amdeITt0wL4FG2Am@red-moon>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
 <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
 <amdTr8Sxw9024CN7@lpieralisi>
 <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>

On Mon, Jul 27, 2026 at 02:20:02PM +0100, Sudeep Holla wrote:
> On Mon, Jul 27, 2026 at 02:48:47PM +0200, Lorenzo Pieralisi wrote:
> > On Fri, Jul 24, 2026 at 11:18:32AM +0100, Sudeep Holla wrote:
> > > On Thu, Jul 23, 2026 at 05:54:54PM +0200, Andre Przywara wrote:
> > > > The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> > > > registers through a firmware interface. This requires a shared memory
> > > > region to hold the message, and a mailbox to trigger the access.
> > > > For ACPI this is wrapped as a PCC channel, described using existing
> > > > ACPI abstractions.
> > > > 
> > > > Add code to parse those PCC table descriptions associated with an MSC,
> > > > and store the parsed information in the MSC struct.
> > > > There can be multiple PCC channels, and each channel can serve multiple
> > > > MSCs, so we need to keep track of the channel usage, using a list and
> > > > a refcount.
> > > > This will be used by the MPAM-Fb access wrapper code.
> > > > 
> > > > [1] https://developer.arm.com/documentation/den0144/latest
> > > > 
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > >  drivers/acpi/arm64/mpam.c      |   6 +-
> > > >  drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
> > > >  2 files changed, 129 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> > > > index 84963a20c3e7..ca9b8754ae5f 100644
> > > > --- a/drivers/acpi/arm64/mpam.c
> > > > +++ b/drivers/acpi/arm64/mpam.c
> > > > @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> > > >  	struct platform_device *pdev __free(platform_device_put) =
> > > >  		platform_device_alloc("mpam_msc", tbl_msc->identifier);
> > > 
> > > Looks like tbl_msc->identifier is getting stashed as pdev->id...
> > > 
> > > 
> > > >  	int next_res = 0, next_prop = 0, err;
> > > > -	/* pcc, nrdy, affinity and a sentinel */
> > > > -	struct property_entry props[4] = { 0 };
> > > > +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> > > > +	struct property_entry props[5] = { 0 };
> > > >  	/* mmio, 2xirq, no sentinel. */
> > > >  	struct resource res[3] = { 0 };
> > > >  	struct acpi_device *companion;
> > > > @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> > > >  	} else if (iface == MPAM_IFACE_PCC) {
> > > >  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> > > >  							tbl_msc->base_address);
> > > > +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> > > > +							tbl_msc->identifier);
> > > 
> > > Why is this needed then as you can fetch it as pdev->id ?
> > 
> > I suppose it is to have properties parity between OF and ACPI without
> > having to change the driver property parsing path.
> > 
> 
> Yes, that was my initial thought as well. However, after looking into it
> further, I could not find any device tree bindings in the upstream tree.
> I am therefore unsure whether MPAM is supported on DT platforms.
> 
> The use of these device properties appears to have been based on DT bindings
> that may never have been upstreamed. As [1] suggests, the bindings were
> dropped before the initial merge.
> 
> Although we could rename these properties later to align with any DT bindings
> that are introduced, I think it would be preferable to avoid adding new
> properties unless they are strictly necessary.

Ah. That makes sense, if DT bindings get published the driver can be
reworked accordingly (if we want to improve how the code looks), this is
just Linux kernel internals anyway.

As it stands the "msc-id" property is churn, that's what you are saying.

Lorenzo

> -- 
> Regards,
> Sudeep
> 
> [1] https://lore.kernel.org/all/20251107123450.664001-1-ben.horgan@arm.com/
