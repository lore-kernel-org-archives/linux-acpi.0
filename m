Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB691A683D;
	Mon, 29 Jun 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782696895; cv=none; b=mJYfTKYpmypYuOi3G/yTEZjbu3aZWz66ATM1M+rA+esyuz0pAHLqJvIhxjg0gk9qBXuyyFroONbmh2wf7zrJy0FzbxFTnCDiJFKbxWLXr7H6TjuhaAuXR0ONw9ZkDLIUZB4bUoVm18hyQOznnXlvQrF+Q4IOKe1P0J0aXZEiLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782696895; c=relaxed/simple;
	bh=it4WTs50OHWh3oRcFIMVblsQhkVAmd8+K1FhC4skm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYA+x6KHbSf+zR8Q9XB+h4CfN46Ypst3ezZSuKgiui0t0+MjCpq+ADpjDqb/4UfUBdWkKDZLI5XFWHchmJTwikM1aPyq63vFn8hK7/f/80AOY9a2ZVqfO+MAI6yFMt2Ei3GniGR7ZzrqgsQVYoC+O3bmmwNXLyE99cWFNA0syoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O71nDWX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O71nDWX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC951F000E9;
	Mon, 29 Jun 2026 01:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782696894;
	bh=5o9vzQ5awf5chQlqEeray9rTDpmHaB2X2kxgT1murzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O71nDWX1ZkYb2WN0n9CBMnWIz1/OD4O0CquIbW2H7xVvy9TWeitAG0DQdTL8+YRV9
	 gPXsLMkZ1CLXUNrmjgTxLHwpPtrdTllEu4kFv0qaG3JzeZ0tYnYsECcebJJ9eqYbn2
	 bZsp66UVr7uBpEs0fliuveSdvJ6DPU/Ryaqxuuf186YRF0qBFbxsswlF6A+XKOWJxC
	 6TeiylPszTA9EjpX1UKz2BTIQw1qIlQBNabohw7Safzg72ZGpGnXJyaFEpcpk9zaPp
	 b0AixmzcSe2cs3Y1s9kwGI8UvAB3vrOlZ4uVM6Sn2or7wg7YegG4XnWo18ve+BHHL5
	 rslJ9od4uj6nA==
Date: Sun, 28 Jun 2026 20:34:35 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
Message-ID: <akHHCx0MLYu3vfbq@baldur>
References: <pskkNka1-QtLVb1tcyyUSjNNeMAWUUOLyvn0XSpq55AyeqXnEjOWDCXF1pWVAufJEya52NTx6ZCXz5dMHcMlyQ==@protonmail.internalid>
 <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <asD5eIxx2ppKOwrwsxHV3d3olpLk5MF9C3Upf_lVo_MWzsiSilQZ2obgX-IAL0Zmv_Pxd3d1zyBV2tSH4ramsw==@protonmail.internalid>
 <04b4f1b0-4d8f-41eb-9b6f-d90b88aec2ff@kernel.org>
 <b5283758-bf75-4906-b821-d6bd7a81e3cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5283758-bf75-4906-b821-d6bd7a81e3cd@kernel.org>

On Fri, Jun 26, 2026 at 03:43:59PM +0100, Bryan O'Donoghue wrote:
> On 26/06/2026 15:33, Bryan O'Donoghue wrote:
> > On 23/06/2026 15:52, Hans de Goede wrote:
> > > Comments, thoughts ?
> > 
> > Throw out DT and just do this...
> > 
> > One thing I like about this approach TBH is that you don't do the easy
> > thing of presuming to push the hard work into the bootloader - thus
> > creating a dependency on bootloader.
> > 
> > We've had _alot_ of problems doing DT selectivity to get OSes installed
> > on arm64 laptops. You mentioned I2C-HID devices and EC controllers which
> > I agree are a good and obvious targets.
> > 
> > I don't think this can replace a full and complete DT but, then I don't
> > think that should be the objective.
> > 
> > Much like installing cursed OSes like Windows on "normal" laptops or x86
> > machines, you'd expect to boot in ACPI mode have enough of the OS
> > running to install more of the OS - which I think _can_ be a viable
> > objective with an ACPI-DT translator.
> > 
> > Sadly OpenBSD could boot all the way to console on the Qcom laptops
> > where Linux could not - because ACPI support was better there.
> > 
> > And, we have Nvidia laptops coming too, Windows laptops which will parse
> > ACPI tables to boot.
> > 
> > There's almost no upside in having ACPI data and not trying to make
> > maximal use of it, especially if you don't have a DT supplied by
> > antecedent boot stages.
> > 
> > ---
> > bod
> > 
> 
> I'm going to agree with myself some more on the boot story.
> 

Good for you.

> If you can boot Linux _at_all_ and dump out ACPI tables from the booted
> system you are way further along than not being able to boot without a
> "real" DT.
> 
> Again, bootloaders have had to be educated on how to make that DT selection
> - a problem that isn't well solved or converged on - and even if such an
> agreed method were present, exactly 100% useless to you without the DT to go
> with it.
> 

The problem of selecting "after-market hardware description" will remain
as long as "BIOS" ships without upstream-compliant descriptions. I'm not
sure I understand in what way your comment relate to the patchset at
hand though.

> As a Linux user I don't expect everything to work, especially so on aarch64
> but, if I can get to a boot console with a screen and keyboard - I have
> scope to play in a way I otherwise don't - parsing DSDT from Windows and
> walking backwards to DT.
> 

We supported this on SDM850 and 8cx, we had sufficient amount of
support/quirks in Linux to allow you to boot and run the Debian
installer - but that's how far it was possible to push things without
improving ACPI specification and tables.

Given that you couldn't run any real use cases, this was not adequately
maintained and as we moved on to 8cx Gen3 I argued that we should
prioritize the DT-effort.

> DT _should_ be the landing zone of course but, ACPI-DT hybrid to "just boot"
> seems like an obvious yes to me.
> 

But this proposal doesn't give you ACPI+DT, it gives you DT+ACPI, you
still need a base DT that is somewhat functional - and then you
explicitly need to make references to the external ACPI representation.

Quite nice for experimentation, but I don't think it will solve either
of your problems.

Regards,
Bjorn

> ---
> bod
