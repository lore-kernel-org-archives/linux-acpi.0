Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2C3C4562;
	Mon, 27 Jul 2026 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194581; cv=none; b=DidesHsigPR3rPRAQW3Bz8YfNCVlCA3sb1UlwY7Y1+TnBU/8gqUd6oV7BE3imu1GBlh9ECtzzUbJilamTOV8v8keo6V8AlCupgFumjFFOik0xdHiWEdCVh4t1QvnT9ta9ykcQOo4IiCy0VVqbh+COAdgPxOecg8RdgNDVp9GkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194581; c=relaxed/simple;
	bh=/vtscHkpkvZPLvmZtBX0+a3KQTPEDZm7+Ybp6eNbrds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzP0heij6ahvQhXSRnb1ioiCGnYspBzuPwmL83XJsu4eSoHEY7ElQM0y17S9BvT+3j4vToOVKajuHcY490ZuRFLf7A6SkCsD3wrbxD94sTEvxVPaeaznybz6TUqJAA2jfToERlyAeYZYcYrEOL39pekm3eaEYwit6FayHJ1q2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agluquQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agluquQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BBE1F000E9;
	Mon, 27 Jul 2026 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785194579;
	bh=lVr5Cr9nWLKIbHjqu5Qu6E+br23QI9KJofBsQ+CVWf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=agluquQPSC9RXPmNnIZK76eXD/aftYt5jG2hrCU6ozy+Yvs/Hh9rZGjs6btQxiqIv
	 twQV0i+1Q8oErKN0d+v9+G8dbZK3y1NMb6IrMx/bDpdzUro2AD+i/+R00EWmYEmYNA
	 ZL7242R45VkJ5vsiY/8g0ebJHTreb+qmnNdeDPb3264ff2GwkqBHgvEJRfYUbeG1gg
	 glJjGxM/3anTbs6WOcvQnTpNcS17WRNT3kU4/tHHYnqIJeTrgxlbjOW6hGf1HcJ0eK
	 ZyIdAvcMLXjvg1rYhULKdxcPAm5bXjQ5EF05kvD7YoP1OXAYBmmwEMQjaGCGxRidrQ
	 ByDhL/v/hPyGw==
Date: Tue, 28 Jul 2026 00:22:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
Message-ID: <20260728002252.77064c3b@jic23-huawei>
In-Reply-To: <20260723155454.1760823-9-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-9-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:52 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> 
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> (simple) SCMI message generation, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Just a couple of suggestions that you can ignore if you like

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..ec4bf0dd9182
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.

Arm has either been working on this for rather a long time or that's a cut
and paste.  Even if 2024 is a good start given changes during revisions
seems reasonable to include 2026 as well.

> +struct mpam_fb_read_payload {
> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +} __packed;
> +
> +struct mpam_fb_write_payload {

Given these are only used in the specific functions that build the
messages you could move the structure definitions to be local to those
functions.

Alternatively you could move all these to the header and get the advantage
of using a union to get the maximum message size rather than a number
currently picked out of the air.

> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +	u32 value;
> +} __packed;



> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index b3a6ed9ed175..e4686ff0ba2e 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h

...

> +#define MPAM_FB_PROT_HEADER_LEN	sizeof(u32)
> +#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))

Doesn't seem to be used until patch 10.  Might be more sensible to bring it
in there. A spec reference might also be good for this.  I think longest
is current the MPAM_MSC_WRITE.  A note above that one option would be
to make this explicit by having the message structure definitions in this
header.


> +

