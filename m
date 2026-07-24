Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC5433BC1;
	Fri, 24 Jul 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916219; cv=none; b=oYxYDHeVNqas74+uTxjHcfkx8CHJMsBHU6Z+udqxoLyofNYcjCfMjRhGRiad00uyHZZY5wCWGAmI1vYlGAA2PSMTUbB4EI7K7tg+8qMEb+eeaXMR3r/6AM1teNhEEFYRVEAmvLJWIOx9u9VfZRfaUsp298lyVtbWFSVtHAcdzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916219; c=relaxed/simple;
	bh=xAJhR7ZwHbkxVapfJDDUTijbnAyNS/cWv706kMRTat4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAiolG6+n5di4lvK4dOoZ6M+zaAb2QyRHPiP3PHDB7mvVsUNkleBQwAS8tJQ30/JhoULC//Rl53BREqA1oDxLSjn8F52vhMvgDUq0/+fy+pN0TT5D7Yby2/EA+9B7M/Z+v5u6x4tPA8tsGkBoDwGGSDfrbcCyNa6cdg7JTtJrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5VijKBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5VijKBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D201F00A3E;
	Fri, 24 Jul 2026 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916217;
	bh=h29FIGiUjpEHTorSXfmfMa//yK70Tzyv2X9zmySyLSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5VijKBRarcOk1zHZZvy7ZXcsyzsJhP591q0jZzPZgB46XSCxWBrj2sjnJzQCmm/7
	 FqYa3iTAU6FRTyuqq2x3Vyk7PGb/C4jOm9QUz5X3w2FrTF7Z+LIRyuF2Nea6CivxoP
	 l4zeg7oRnxQziJt6j8XBiB/zYOXmojzJm5E49M/X4D774aDPz2ky+5D52IiPtQbSvN
	 TR+cq83ytDmAbkF7s+7mVbGlq6Jg/pFKd4Sy0Gxz4iGSWg4qUWXfGTM+Ob/kbemUHP
	 OhoLy7UAo28ytPwkYYvCC1ZK0UInLoS05tjmADXqOLl3LjiTffSZsRWQiia9BGx24r
	 sEvY9wwXwYlww==
Date: Fri, 24 Jul 2026 19:03:31 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
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
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
Message-ID: <20260724-mule-of-sudden-gaiety-9e3933@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
 <b9502a40-8075-48fc-8ff1-3ae17741ea73@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9502a40-8075-48fc-8ff1-3ae17741ea73@arm.com>

On Fri, Jul 24, 2026 at 06:08:52PM +0100, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/23/26 16:54, Andre Przywara wrote:
> > The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> > alternative way of accessing the "Memory System Components" (MSC) in an
> > MPAM enabled system.
> > 
> > Normally the MSCs are MMIO mapped, but in some implementations this
> > might not be possible (MSC located outside of the local socket, MSC
> > mapped secure-only) or desirable (direct MMIO access too slow or needs
> > to be mediated through a control processor). MPAM-fb standardises a
> > protocol to abstract MSC accesses, building on the SCMI protocol.
> > 
> > Add functions that do an MSC read or write access by redirecting the
> > request through a firmware interface. For now this done via an ACPI
> > PCC shared memory and mailbox combination.
> > 
> > Since the protocol used is only a small subset of the full SCMI spec,
> > and the SCMI protocol has no full ACPI support anyway, open-code the
> > (simple) SCMI message generation, for just the fields we need.
> > 
> > [1] https://developer.arm.com/documentation/den0144/latest
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/resctrl/Makefile        |   2 +-
> >  drivers/resctrl/mpam_devices.c  |  27 ++++-
> >  drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
> >  drivers/resctrl/mpam_internal.h |  20 ++++
> >  include/linux/arm_mpam.h        |   2 +-
> >  5 files changed, 240 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/resctrl/mpam_fb.c
> > 

[...]

> > +struct mpam_fb_read_payload {
> > +	u32 msc_id;
> > +	u32 flags;
> > +	u32 reg_offset;
> > +} __packed;
> > +
> > +struct mpam_fb_write_payload {
> > +	u32 msc_id;
> > +	u32 flags;
> > +	u32 reg_offset;
> > +	u32 value;
> > +} __packed;
> > +
> > +#define PCC_CHAN_FLAGS_IRQ	BIT(0)
>
> Isn't this the same as PCC_CMD_COMPLETION_NOTIFY in include/acpi/pcc.h?
>

Yes, where ever possible, one must use that. I have TODO to unify the
loads of duplication we have amongst the users of PCC channels. That's
the reason I ignored more duplications in this driver in absence of any
alternatives.

> > +
> > +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> > +
> > +static void mpam_fb_build_version_message(unsigned int token,
> > +					  void __iomem *msg_buf)
> > +{
> > +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
>
> What's the deal with .signature?
>

No, it's written by the platform firmware when the channel is ready to be used
by OSPM and OSPM just needs to verify. It will be soon part of the PCC core
driver and it will shout if that's not the case.

> > +
> > +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
>
> Are you sure it's ok to unconditionally set this irq bit? I know we found out that we do need it set
> sometimes. What does setting it actually based on what the platform does look like?
>

You need to set it if you are not polling the PCC channels for completions.

--
Regards,
Sudeep

