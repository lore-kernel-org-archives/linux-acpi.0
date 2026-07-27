Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5C3C2B8D;
	Mon, 27 Jul 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190360; cv=none; b=k+Gnwak7/se4zEqv6F3mOX5McpaKp1ncalGw7NQlZRAYLHG+vuQR4V2b0o1fS5fnabAL2KN+l/uv575JkoNw4lgGo2TfW2rBWxe8ygCfQh/D4r8KHV1A9/0H+tMDE+brJB8DDXoktcW9LDfZLd8QLmsZCofwRcCirA3eBDKDSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190360; c=relaxed/simple;
	bh=6vh+fUw+b/Myxxbro+uF8KisVBh9Y7Exs3obXlR20eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0D9l/5loCvXa8VxtViV13MyTE66Tbe7ow8FUZeyKdi9wJcMtTk+z8HJpqvOeTBuOO6YGKIpSHZvTYlQK30qj0f4Qy2XWgY/W6DFtkJPjwlNe1aTZnB6PKRhQH0kkf1MUTUJEoWEyx5JJW3aKBO5euH759zP9HJMaQt6gQQPob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiiS4PSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiiS4PSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E871F000E9;
	Mon, 27 Jul 2026 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190359;
	bh=ZlVSQ0WoHFkexgSj1nLjs/bQmryo/c++WltacVP9aBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eiiS4PStWn+tXhuPrRrMk7VoRFpWq1n1elSpWgSkRTuQGNFaWowc6DsfPEaeVOtFc
	 REfPvHWAFL2fbIwhcoMuSMxi7gQRGQFLODkAEaSyuSL4JWuAiF5bzdkEnlK27adg2V
	 1RjCxEmHoqH1NDqzeuf4KavoLA/OvoeZoaXJVp5TIkDvCXXNA0jAFIDSHIGgFC9y8H
	 aBhzSMoO4yrElYXUUA7lQubvt7x6omw8qCB6bWYNTGOusLtRPEwr7hEgCvm0KKmZYo
	 vngxTbnHiGR/9j8qzu1nH2q1ZeLFqrIwHp5pjTuiE9+fyJXfQMBonIpEWtCy6341Uy
	 2lDmwzIK4XjBw==
Date: Mon, 27 Jul 2026 23:12:31 +0100
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
Subject: Re: [PATCH v4 01/10] arm_mpam: let low level MSC accessors return
 an error
Message-ID: <20260727231231.62baa831@jic23-huawei>
In-Reply-To: <20260723155454.1760823-2-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-2-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:45 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The upcoming MPAM-Fb support does not use MMIO primitives to access an
> MSC, but employs a shared-memory/doorbell based firmware protocol.
> Its complexity means that is must be able to handle errors, whereas we

that it must

> always assume an MMIO based MSC access succeeds today.
> 
> Change the __mpam_read_reg() low level accessor function to return the
> requested data through a pointer, and return an error code instead.
> Also change the __mpam_write_reg() accessor function to return an error
> code. At the moment this is always 0, but this will change with alternative
> MSC access methods.

Be consistent on paragraph formatting.  So blank line here.  Check whole
series for such tiny consistency problems.

> Change all direct users of those MSC wrappers to comply with the new
> prototypes, though the errors are not propagated all the way up yet.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Some comments inline.  A few are 'whilst you are here let us make this
more readable'.  I was in two minds about the temporary lack of handling
of uninitialised (looking) variables but in the interests of expediency
I suppose we can rely on the functions never actually failing at this
point in the series.

I will note that if you did adding the returns from outer calls to inner
you wouldn't get this problem.  However you might get other problems!

> ---
>  drivers/resctrl/mpam_devices.c | 204 +++++++++++++++++++++------------
>  1 file changed, 130 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b69f99488111..912c21ce7f9f 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c



> -static u64 mpam_msc_read_idr(struct mpam_msc *msc)
> +static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
>  {
> -	u64 idr_high = 0, idr_low;
> +	u32 idr_high = 0, idr_low;
> +	int ret;
>  
>  	lockdep_assert_held(&msc->part_sel_lock);
>  
> -	idr_low = mpam_read_partsel_reg(msc, IDR);
> -	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
> -		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
> +	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(MPAMF_IDR_EXT, idr_low)) {
> +		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
> +		if (ret)
> +			return ret;
> +	} 
As a whilst you are here type of comment. I'd find this more obvious if it were

	} else {
		idr_high = 0;
	}

rather than assign a default at top of what is now a rather more complex function.

>  
> -	return (idr_high << 32) | idr_low;
> +	*res = ((u64)idr_high << 32) | idr_low;
> +
> +	return 0;
>  }


>  
> -static u64 mpam_msc_read_esr(struct mpam_msc *msc)
> +static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
>  {
> -	u64 esr_high = 0, esr_low;
> +	u32 esr_high = 0, esr_low;
> +	int ret;
>  
> -	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
> -	if (msc->has_extd_esr)
> -		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	if (ret)
> +		return ret;
>  
> -	return (esr_high << 32) | esr_low;
> +	if (msc->has_extd_esr) {
> +		ret = __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
> +		if (ret)
> +			return ret;
> +	}

Same as the other example above.  } else { esr_high = 0; }
would be slightly clearer now this whole function has gotten more complex.

> +
> +	*res = ((u64)esr_high << 32) | esr_low;
> +
> +	return 0;
>  }
>  

>  int mpam_register_requestor(u16 partid_max, u8 pmg_max)
> @@ -774,13 +810,13 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
> -	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
> +	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);

If an error were to occur and "now" not get assigned, would this being
accessing undefined data?  If checking return values doesn't make sense
in here it should still not result in something static analysis might
get annoyed by.  This gets cleaned up in next patch so maybe that
is just about ok.  Alternative would be to just initialize any such
variables in this patch and drop those initializations in next.
Doing it just above the code that is going to change anyway would be cleanest.

	now = 0;
	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);

for example.

Hmm. I suppose this is a bit of a special case because we know the
calls don't return errors at this point in the set.

So whilst I don't like it I'll not insist that you fix all the
instances of this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>





>  	can_set = now & MSMON___NRDY;
>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
>  	/* Configuration change to try and coax hardware into setting nrdy */
>  	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
> -	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
> +	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
>  	can_clear = !(now & MSMON___NRDY);
