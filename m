Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8183E7BA6;
	Mon,  6 Jul 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327632; cv=none; b=UaFwrknVJX+lWjA7pFr5h9voY4LoFq/Ld4gFhbaajywygJIyjU6iMhR990uhJIMzwTabB97GGy3A3WrzZj8E/4+LWqGUNrq5IPMLyDnLDXaIQ1DP95esS8MCgKBoS+a3rGHuDqAO0eWidkE0X7uLR9toHZdKTOm8JdSTh3x9j4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327632; c=relaxed/simple;
	bh=TaMB352Qr0mZhdAcp7ifrSFaJu+UeDQ9SA/4lSGaQbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGBWtOrGtYVml/gz9ThnuTpO4PbV783/hbSl4Ja3ZpMwLLaZdA5BcxTPQ2FiG8V3GldnykEQFUZ0zZOUwF7XTlBx5vk05D1wniu7zR/EJZAtUKsmRjfPzCDVof4R8W89GTzMivDjQgQlJMTVHg6DZ3SlJ2+lvS0DgUu3e3dCzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InZqhSUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InZqhSUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABB91F00A3A;
	Mon,  6 Jul 2026 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327622;
	bh=UGILdGIqq+1IKf9yow+nP7y57LK2rfH/A9Z6IA5aPb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=InZqhSUj695xT8151QVlSgvSGozgmRqrqPlRN2PvXVEEtO9zST/H3OxPkj30S6yaY
	 df8jJSnuAmgMXe/bdfXiQJlywBHbBAIEmuz43lTQYBf4lj4GfvWxUxP8aVPbmZA7D4
	 t3TUek+erMuQZ382Dqaef1EXQpDuxmOgtjFm/K1zidRcOrNexyxKmGElpl/Jq+mdh7
	 AdeYW/PKYBZdx8qDlmm4/BH4NFWcr4bumSVDkq4/n/Ua7VnnJIr5L0RgJhHGeaymYd
	 /9pOER+OfAX+MJMw3yhAkIXIkXy78z7fjvGEHJ8BW5CBIdhrlbcannRN6sBR1HP+xv
	 cSRaozu9sWEoA==
Date: Mon, 6 Jul 2026 10:46:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 1/7] ACPI: Add acpi_device_clear_dep() helper function
Message-ID: <aktrfyXrIeCL1eqp@lpieralisi>
References: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
 <20260701-gic-v5-acpi-iwb-probe-deferral-v3-1-c5562cf0fe29@kernel.org>
 <87jyrd6q0o.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyrd6q0o.wl-maz@kernel.org>

On Thu, Jul 02, 2026 at 10:27:35PM +0100, Marc Zyngier wrote:
> On Wed, 01 Jul 2026 15:38:49 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > Code clearing device dependencies in ACPI in drivers through
> > 
> > acpi_dev_clear_dependencies()
> > 
> > requires annoying ifdeffery to make sure it is compiled out on
> > !CONFIG_ACPI configurations.
> > 
> > Implement a wrapper function to clear device dependencies that can be used
> > in device drivers without conditional compilation.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > ---
> >  include/linux/acpi.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 10d6c6c11bdf..4f950f5386d7 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -94,6 +94,12 @@ static inline void acpi_preset_companion(struct device *dev,
> >  	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
> >  }
> >  
> > +static inline void acpi_device_clear_dep(struct device *dev)
> 
> uber nit: "clear_dep" is singular, while "clear_dependencies" is
> obviously plural. acpi_device_clear_deps() would look slightly
> clearer.

Hi Marc,

sure I will update it and respin a final version.

Thanks,
Lorenzo
