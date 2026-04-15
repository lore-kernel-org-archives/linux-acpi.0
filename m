Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B5349AF6;
	Wed, 15 Apr 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249905; cv=none; b=k5FE1oVoirBkRCQo69qOoYAkWuk8/fWwPX2YEEBDl6ZEgplymRXF8NqvPBQOzWpGNG9CL76KK+QMRdu4WVokHTjjROrwwE+0gv7xaNIjRe6oWdrljQHvzUjZ0n30yLuVnJZy5UXf05fMek6MWYPth5m7FUgJIS9Wn8nwCCj+wPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249905; c=relaxed/simple;
	bh=hqnG4hX/P4XDjZ09ai6m0Bt1CykyK6IVFaXnGLoQAHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKPC1O8pcrQkYNUiI8rp7QI0W+xxLv23nD5ITm4/sIzqnEiXghs950iO0KRm4zl1TSSVC4MdC1yDhe5ox23qyEib4N1sVEUJW/2+h7RIIVe1egbiLlihIJqKB5s5XcdlkEELagvUf1VQoyFKPZIdU2gjA8M1zWRDO36eGtUsDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si7HF6Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si7HF6Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75204C19424;
	Wed, 15 Apr 2026 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776249905;
	bh=hqnG4hX/P4XDjZ09ai6m0Bt1CykyK6IVFaXnGLoQAHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Si7HF6EiHZeqSbXx+pG2SFAPkv0tzI0zpjPtkXkTmkuQRs0Ag7124vDq0zOd91yI4
	 biniQGqHajZdlqN79sbcuEZa+OYMBIIvnQFwHw7O0xZoWRbqNDx2ZOj34AdRP/aGCb
	 /42Zws8hrS3Qn+dQGOCHRVUutbgXcW6HFCr+mzXPxiYsb6Fp0pe1sVrq2Wi9kswmX7
	 ZjXU5topfauCq9CIpW5iB4nViLRk5mvbOJRQm0fkR19NKINblyvdQNuab3NeEqOi2C
	 gCjxpEAdLGlG5FEEPizEjkllt3LrdNdtd8X25Sq9VpHwb8LuLfIfkG3zeiHnIkLtZY
	 hsgB5yxGG16Rw==
Date: Wed, 15 Apr 2026 11:45:00 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>, Len Brown <lenb@kernel.org>,
	lpieralisi@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	pjaroszynski@nvidia.com, guohanjun@huawei.com,
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Message-ID: <20260415-ostrich-of-immortal-order-5697cd@sudeepholla>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
 <ad48gItCwrC-ar34@gmail.com>
 <20260414-excellent-hidden-dodo-5bb98e@sudeepholla>
 <ad5qxncafOiTeLNg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5qxncafOiTeLNg@gmail.com>

On Tue, Apr 14, 2026 at 09:31:33AM -0700, Breno Leitao wrote:
> Hello Sudeep,
> 
> On Tue, Apr 14, 2026 at 03:10:03PM +0100, Sudeep Holla wrote:
> > On Tue, Apr 14, 2026 at 06:14:19AM -0700, Breno Leitao wrote:
> > > Hello Sudeep,
> > >
> > > On Tue, Apr 14, 2026 at 01:25:53PM +0100, Sudeep Holla wrote:
> > > > So while I understand that the kernel did not report an error previously, that
> > > > does not mean the _LPI table is merely moot on this platform when it contains
> > > > only a WFI state.
> > >
> > > Can you clarify whether datacenter ARM systems are expected to expose
> > > deeper idle states beyond WFI in their _LPI tables?
> > >
> >
> > Of course any system that prefers to save power when its idling must have
> > these _LPI deeper idle states.
> >
> > > Backing up, I'm observing 72 pr_err() messages during boot on these
> > > hosts and trying to determine whether this indicates a firmware issue or
> > > if the kernel needs adjustment.
> >
> > I consider this a firmware issue, but not a fatal one. What matters more is
> > the behavior after those errors are reported.
> 
> I understand. While I'm not a hardware or firmware vendor myself, I can
> see how they might consider power management features _optional_ for certain
> server configurations.
> 
> > If you force success, either through your change or through the PSCI approach
> > suggested by lihuisong, then in practice you are only enabling a cpuidle
> > driver with a single usable state: WFI. That is not inherently wrong, but it
> > also does not provide much benefit.
> 
> Given that this isn't a critical error, would it make sense to downgrade
> the pr_err() to pr_debug()? is it a reasonable compromise. I just want
> to avoid these pr_err() all accross the board, affecting kernel health
> metrics in large fleets.
> 
> My proposal:
> 
> commit c98007f9e10fe229672d29c3844c96705cecaed5
> Author: Breno Leitao <leitao@debian.org>
> Date:   Tue Apr 14 05:28:28 2026 -0700
> 
>     ACPI: processor: idle: Downgrade FFH LPI probe failure message to pr_debug()
>     
>     The "Invalid FFH LPI data" message is printed at pr_err() level for every
>     CPU when acpi_processor_ffh_lpi_probe() fails. On platforms where the FFH
>     probe legitimately returns an error (e.g., no deep idle states beyond
>     WFI), this floods the kernel log with per-CPU error messages that are not
>     actionable.
>     
>     Downgrade to pr_debug() since this is a diagnostic message, not a
>     critical error.
>     
>     Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ee5facccbe10c..ab93a2c10a9ad 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1259,7 +1259,7 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>  	if (pr->flags.has_lpi) {
>  		ret = acpi_processor_ffh_lpi_probe(pr->id);
>  		if (ret)
> -			pr_err("CPU%u: Invalid FFH LPI data\n", pr->id);
> +			pr_debug("CPU%u: Invalid FFH LPI data\n", pr->id);

I am afraid if this might mask the real _LPI table entry errors.
Need to think, I am still of the opinion that we need warn on that system
as _LPI with just WFI is simply useless.

-- 
Regards,
Sudeep
