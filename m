Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EBF3C3453;
	Wed, 25 Mar 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452850; cv=none; b=ibyJJyzgT7+QxL0zqFtoR2AMSRu/ibDI0jKdncrCtbtTB8MiSfdo4MXyi91c+ToaS9UweD2V42mSJiDYiq5P6bqoe3iLlsmKum+fmjShZG/N4qQXxB1DXhFICmDfJC6fxLUndd6om3Vd2mwIOtaRVBidkUt3A8ZZMzxsW6l6038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452850; c=relaxed/simple;
	bh=f9jaznsHkQ6eQ3uxI7m1xC7+Ih5y7TfyeuZuT5BHfgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VacsP4roLFSB+kHbrrn9F+7WGTjJRZ6gt7FPjnEMnO92F/zXivObhpdXP+6gi+V/LUUZIiM/CdLiSDkC1zu5SNTDn7q80JpA6ZPcarf7MHiozuMm2qohIbCCyufKB4FGO1VbNzMhDFMC4wxcMXnCELQbqxsLX4vKc2wjN1qBJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msAm3Nbg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msAm3Nbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D9C4CEF7;
	Wed, 25 Mar 2026 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774452849;
	bh=f9jaznsHkQ6eQ3uxI7m1xC7+Ih5y7TfyeuZuT5BHfgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msAm3Nbgm423KOsIX3Y9pHC3T5vMA5LemDo9gvY2+2dwZnt6LUbF6ETcYuN0VKjVo
	 FPKbN9sxszXJElxFksMM7hNUlGRN4FNizxoMH68SvTTPy3TwHQpo6Dfac3sYRFUZEV
	 eLXvmEvgwRwFKrziDBLr9eHrNg9RldsYXJrwAC6eFkBq3pJ6RaLQOq5kW6HVyoSGJA
	 uAXIIM5/EvWUApkoljXVCozWZz+Z6vgJuxS4lfbRhwxIRhMm6xSBV/yf5mXc6aWjSh
	 5p9MTjkLbNNlhwMT5Y0Zhdz1xMOa0BDLODxLA8g9G76SyJNc0gqP+tlROobwAVZUVw
	 bM+K0lcoKcMDA==
Date: Wed, 25 Mar 2026 15:34:06 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure,
 acpi_pptt_cache_v1_full
Message-ID: <20260325-outstanding-vagabond-sambar-0148c1@sudeepholla>
References: <20260324113300.1002569-1-ben.horgan@arm.com>
 <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
 <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com>
 <20260325-laughing-coot-of-piety-e2bdff@sudeepholla>
 <CAJZ5v0jcf0tQ-Ghdi=FZE7gsKXEVjjbfJ7_csnm3_+DG0FzPBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcf0tQ-Ghdi=FZE7gsKXEVjjbfJ7_csnm3_+DG0FzPBg@mail.gmail.com>

On Wed, Mar 25, 2026 at 02:32:47PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2026 at 12:53 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Wed, Mar 25, 2026 at 12:45:27PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 24, 2026 at 9:43 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 24, 2026 at 11:33:00AM +0000, Ben Horgan wrote:
> > > > > acpi_pptt_cache_v1_full was initially added as a stop gap until the
> > > > > equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
> > > > > contained all the fields of the Cache Type Structure. Since, commit :
> > > > > 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
> > > > > type1"), acpi_pptt_v1 contains all these fields making
> > > > > acpi_pptt_cache_v1_full redundant.
> > > > >
> > > > > Remove acpi_pptt_cache_v1_full.
> > > > >
> > > > > No functional change intended.
> > > > >
> > > >
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> > >
> > > Am I supposed to pick this up?
> >
> > Yes please, IIUC we route only drivers/acpi/arm/* via arm64 tree in general.
> 
> Done, thanks!

Thanks Rafael!

-- 
Regards,
Sudeep
