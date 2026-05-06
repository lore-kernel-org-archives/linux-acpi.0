Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5138735A;
	Wed,  6 May 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057307; cv=none; b=k/1GN6bAYKAtuxZHMeCLqulSqOHLG2tJAWYisTG/KTRJAPs/hBFy3p2s7AXmN9MPIR+jBS0GGIUEunlHXCoTPgpmNjDDS4B5AtL/ysdCV2KJNr5CEzIkHv9CMy5fzJV8rhsqBye/jj92dcIq9IyWR/sajX2rxsOlnygHL2CfGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057307; c=relaxed/simple;
	bh=IUO5lXUDkT4nvUBviJejZvM9e4p1qGcE/fMZ5yRqht4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6jvbGtKQp+Wfu0pcWyazd7vxa9vQaxojJgrvMM0xfE6IWYNNN5/qnj9G0i2AoFrESIKE32J7zXoGFf/n8Wk3VOjFEj4wRwDzL28Rn/uMkQodyMxZ7bC0ruIo8jkxHYXq5RmmSXT355S4V6UOo1f8S98dvwm0uxULdsF8LLWpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyYTCfoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyYTCfoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A17C2BCC4;
	Wed,  6 May 2026 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778057306;
	bh=IUO5lXUDkT4nvUBviJejZvM9e4p1qGcE/fMZ5yRqht4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyYTCfoLxt9bBadi2EzSMoURTPGCD/lKkFKebSQF7LnOtBPR7VpN5fo8iYNGExYVa
	 pzOx4fSjkWAUmltCJw7h9vFz4ijQnMvAm1HfN1G3MPdgeGBbcpUuo3/7au0nR0YPik
	 QP0PIXAdZ0urf5mL1ZHZpMfa3ImOrTwCrDGS6rGzzuXKml0O331yQiC2f/f/zdkqUb
	 icnkpvTei2+s4rP+rPmBhJDOyhpeHek2fYHa5d41MUUvOCZVLneiy8qWgxAQTW/q3p
	 aDLeYpf2toLXyU3+GN4x4R8CHJovyT4t6/+1ytZyodVy0KkHqIds6KcxOgk8aI6cBi
	 YCO2FlL2Ct/SA==
Date: Wed, 6 May 2026 10:48:20 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] irqchip/gic-v5: Add IWB to ACPI probe dependency
 control
Message-ID: <afsAVO+vTQp2r/EI@lpieralisi>
References: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org>
 <20260505-gic-v5-acpi-iwb-probe-deferral-v1-2-b37b85998362@kernel.org>
 <875x51y6gi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x51y6gi.ffs@tglx>

On Tue, May 05, 2026 at 09:58:05PM +0200, Thomas Gleixner wrote:
> On Tue, May 05 2026 at 10:48, Lorenzo Pieralisi wrote:
> > On Arm GICv5 systems, wired IRQs routed to an IWB may require resolving
> 
> S/IRQs/interrupts/g
> 
> Changelogs are prose and not an acronym dump ground.
> 
> >  drivers/acpi/arm64/iort.c        | 22 +++++++++++++++++++---
> >  drivers/acpi/scan.c              |  1 +
> >  drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
> >  drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
> >  include/linux/acpi_iort.h        |  3 ++-
> 
> I'm confused about the conglomerate of files affected by an irqchip
> change...

True, I can split the ACPI changes into a separate patch though on its
own it would not be that useful because the resulting code would have
no user - I will do what you and Rafael prefer.

Thanks,
Lorenzo

> Thanks,
> 
>         tglx
