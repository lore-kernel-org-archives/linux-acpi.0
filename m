Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3314BF92;
	Mon, 27 Jul 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156537; cv=none; b=nV3uyP9ZFZkXp5w8NxC2LNb0LvJiEEfKG59+k6YMbz3MRH0BOpt/MB2foGpni3xEeemRX4WpumzroDzCuwQ1EFzx3sLn2htJzoZfBRRRbT8pzbYiXrZl8JQ/mglK+QWZ4qhUJ85LqORhjUPkoSVdvS1yni5kuiakyFtrIQV8ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156537; c=relaxed/simple;
	bh=aqREQQmKRGC8m1uoinAQ/bnhnt0KrzUoGzZaD8xIepg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPvA5dAQcQ86LxLBAg24JENVKq5so9QX7O+L3AHid5MclO9NEC0n5i6q2R3D9kyEENTlYzgdYHudKpyeImySYaU2a4Ffa1FyK0/1XCsCUYEZEkOoX7LqoNRtXmG+ntNxhvCFaUDBOcw88SxjuBDv3mps3Emnb5SrJvilrHNFDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIXuJZnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIXuJZnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B41F00A3A;
	Mon, 27 Jul 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156535;
	bh=3idJSMzXZsFWAkGapFJSZFIUVk1ucWaPK87pZycQbG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TIXuJZnUjqBGi2hczJgb3s36qAubWbk1lO5lhu0QQPlxrhviAQobavlu0GO/0vosr
	 +6u9vSMywmZcOP1H4IKtXSNRXv6gKdmOoHQCEmo6LqG2B60mw92OUjfc9Oa8Drv8nK
	 am1HwPhLMJOqtqaC6xFy53gxIq/kJM//t+KPyTiHQ3RvYPOAAXuZUR27l7oBtfMPHo
	 b7s2U/oajqfFiMDJdUIyqc04laJUWwsI9Xnt+oHaHToAnH1yJTZ4kZO9L6aMIX7Uk2
	 wfYItDQfDUuuzJMn2SzmyoShGJPmN0x2ogD/726mpdzFuxIx8ierwyY9TyLEx2S9qX
	 CohC6mHwSeHMQ==
Date: Mon, 27 Jul 2026 14:48:47 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
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
Message-ID: <amdTr8Sxw9024CN7@lpieralisi>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
 <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>

On Fri, Jul 24, 2026 at 11:18:32AM +0100, Sudeep Holla wrote:
> On Thu, Jul 23, 2026 at 05:54:54PM +0200, Andre Przywara wrote:
> > The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> > registers through a firmware interface. This requires a shared memory
> > region to hold the message, and a mailbox to trigger the access.
> > For ACPI this is wrapped as a PCC channel, described using existing
> > ACPI abstractions.
> > 
> > Add code to parse those PCC table descriptions associated with an MSC,
> > and store the parsed information in the MSC struct.
> > There can be multiple PCC channels, and each channel can serve multiple
> > MSCs, so we need to keep track of the channel usage, using a list and
> > a refcount.
> > This will be used by the MPAM-Fb access wrapper code.
> > 
> > [1] https://developer.arm.com/documentation/den0144/latest
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/acpi/arm64/mpam.c      |   6 +-
> >  drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 129 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> > index 84963a20c3e7..ca9b8754ae5f 100644
> > --- a/drivers/acpi/arm64/mpam.c
> > +++ b/drivers/acpi/arm64/mpam.c
> > @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> >  	struct platform_device *pdev __free(platform_device_put) =
> >  		platform_device_alloc("mpam_msc", tbl_msc->identifier);
> 
> Looks like tbl_msc->identifier is getting stashed as pdev->id...
> 
> 
> >  	int next_res = 0, next_prop = 0, err;
> > -	/* pcc, nrdy, affinity and a sentinel */
> > -	struct property_entry props[4] = { 0 };
> > +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> > +	struct property_entry props[5] = { 0 };
> >  	/* mmio, 2xirq, no sentinel. */
> >  	struct resource res[3] = { 0 };
> >  	struct acpi_device *companion;
> > @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> >  	} else if (iface == MPAM_IFACE_PCC) {
> >  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> >  							tbl_msc->base_address);
> > +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> > +							tbl_msc->identifier);
> 
> Why is this needed then as you can fetch it as pdev->id ?

I suppose it is to have properties parity between OF and ACPI without
having to change the driver property parsing path.

Lorenzo
