Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F83E51EF;
	Tue, 14 Apr 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168333; cv=none; b=BZ77RubcejJtQ1IJXiUzKGR4nlALaJlN3W1bM9+7RXnvK65BTZ6uRzc6lZ21+msF4B15Shys2d9+Jz5OVKxRFR8tUcjs1wXoLrUxyWmjTX15kZwJYuxkeIT/4JQRmAvZ22r3w4GqzAq2gl8HwirMUxNjQDxXFY6ZHk2mVBg9uRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168333; c=relaxed/simple;
	bh=OxNEG/CrDx/DibAStevPEpUNCEJaJ+cGadlIJZMW30k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7dNUlWsFZO4UOREwGa0ojK7C1DbQZKJ7xS3R4fSSsLNWzlTgT3oSkAJvXiwuR5Wwv8G7mbHrr6DPxUqsfvpvRP13BkN13AgCQSCquQMapqClSlfUPCEA7kiGb8ggJ3iVTpZtGAuKhlsYkH/S5zPUiM/5/8l5mdp3zbqzRDkhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=prh3cNO7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="prh3cNO7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=JBdItcm4SpsvDcMo6VDP8MI5QdRVaF4W043aa/ZGUhQ=; b=prh3cNO7H5DIoCudtpYHbVGQ8z
	95eGPGtTkFLexvqs6odwc4SN9rzEuqkklN8ahwVaX+79xwM49vqQ7z1PtADTAucfFiOTt5uQDo9sa
	OYfJgJYGOUOTssGMffcBJQ24LGrBo6xoPO2Ou1DPx7Kv+82mU2sAaEI6Bsah622mpfCEa6MbeyOrc
	S9fsJCkEn60d/jlrsapqNOmZrdC6QNHORD9oQX0pedBDJ6rV3uzYyC4EgHbD0BE3CTjDZ7Oemadm9
	Nq7Ce8n1QibO23zbDWVXBSHKmMOUIsAiphi1hhgmoqXvn9vlQgGU5XmJ+3WjoGOuBweRbnda0AaT7
	QAeTGLvA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCcW1-00D3Kj-1S;
	Tue, 14 Apr 2026 12:05:13 +0000
Date: Tue, 14 Apr 2026 05:05:07 -0700
From: Breno Leitao <leitao@debian.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	lpieralisi@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pjaroszynski@nvidia.com, guohanjun@huawei.com, sudeep.holla@kernel.org, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Message-ID: <ad4tXOlXITpREkLb@gmail.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
X-Debian-User: leitao

On Tue, Apr 14, 2026 at 07:31:29PM +0800, lihuisong (C) wrote:
> 
> On 4/14/2026 6:21 PM, Breno Leitao wrote:
> > Hello Huisong,
> > 
> > On Tue, Apr 14, 2026 at 05:43:51PM +0800, lihuisong (C) wrote:
> > > But it is a real issue. Thanks for your report.
> > > I think the best way to fix your issue is that remove this verification in
> > > psci_acpi_cpu_init_idle().
> > > Because it is legal for platform to report one LPI state.
> > > This function just needs to verify the LPI states which are FFH.
> > Thank you for the prompt feedback.
> > 
> > Would this approach work?
> > 
> > commit 6c9d52840a4f778cc989838ba76ee51416e85de3
> > Author: Breno Leitao <leitao@debian.org>
> > Date:   Tue Apr 14 03:16:08 2026 -0700
> > 
> >      ACPI: processor: idle: Allow platforms with only one LPI state
> >      psci_acpi_cpu_init_idle() rejects platforms where power.count - 1 <= 0
> >      by returning -ENODEV. However, having a single LPI state (WFI) is a
> >      valid configuration. The function's purpose is to verify FFH idle states,
> >      and when count is zero, there are simply no FFH states to validate —
> >      this is not an error.
> >      On NVIDIA Grace (aarch64) systems with PSCIv1.1, power.count is 1 for
> >      all 72 CPUs, so the probe fails with -ENODEV. After commit cac173bea57d
> >      ("ACPI: processor: idle: Rework the handling of
> >      acpi_processor_ffh_lpi_probe()"), this failure propagates up and prevents
> >      cpuidle registration entirely.
> >      Change the check from (count <= 0) to (count < 0) so that platforms
> >      with only WFI are accepted. The for loop naturally handles count == 0
> >      by not iterating.
> >      Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
> >      Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
> > index 801f9c4501425..7791b751042ce 100644
> > --- a/drivers/acpi/arm64/cpuidle.c
> > +++ b/drivers/acpi/arm64/cpuidle.c
> > @@ -31,7 +31,7 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
> >   		return -EOPNOTSUPP;
> >   	count = pr->power.count - 1;
> > -	if (count <= 0)
> > +	if (count < 0)
> >   		return -ENODEV;
> >   	for (i = 0; i < count; i++) {
> 
> This count already verified in acpi_processor_get_lpi_info.
> 
> I suggest modifing it as below:
> 
> -->
> 
> git diff
> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
> index 801f9c450142..c68a5db8ebba 100644
> --- a/drivers/acpi/arm64/cpuidle.c
> +++ b/drivers/acpi/arm64/cpuidle.c
> @@ -16,7 +16,7 @@
> 
>  static int psci_acpi_cpu_init_idle(unsigned int cpu)
>  {
> -       int i, count;
> +       int i;
>         struct acpi_lpi_state *lpi;
>         struct acpi_processor *pr = per_cpu(processors, cpu);
> 
> @@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>         if (!psci_ops.cpu_suspend)
>                 return -EOPNOTSUPP;
> 
> -       count = pr->power.count - 1;
> -       if (count <= 0)
> -               return -ENODEV;
> -
> -       for (i = 0; i < count; i++) {
> +       for (i = 1; i < pr->power.count; i++) {
>                 u32 state;
> 
> -               lpi = &pr->power.lpi_states[i + 1];
> +               lpi = &pr->power.lpi_states[i];
>                 /*
>                  * Only bits[31:0] represent a PSCI power_state while
>                  * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification

Ack, I will respin.

Thanks for your help,
--breno
