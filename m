Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511B47ECEF;
	Wed,  6 May 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077709; cv=none; b=eQ+u5UYqcW+VIQCmZ4IFuurwjYVrqQaz5ZsEyVJL9qF2QILX8qfVkrpEKgUTtZfIAk3qTQuY0nXKYTyAPOXs1Kig9FiS+7ZB5AKYTvaWdaiAm67mE1ET+bxit+i9b03TEzKpHLp0VehuDcfTu72N+2isQhpZuNJXR7N6Obnexpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077709; c=relaxed/simple;
	bh=oV6xejldxtF04ynRPRcfaU92DZaX3Oi76voGNDRWSCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKLCR3INRc5mk/1+TWf3jWUOr4lVE01Cu+0TD4MII31HfEGVqnsWckJfYhIED1SkxuXaAGmKGbUK6D7Ws1oC8eqLHUXtk77T9W/TxYLLwIoELGDixox1EjT9wbdDJIjIesvE9/WaZK84DtcNsN4o+8kKzWhFVT8rMFe5KBMQwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B19hnQdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B19hnQdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B67C2BCB0;
	Wed,  6 May 2026 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778077708;
	bh=oV6xejldxtF04ynRPRcfaU92DZaX3Oi76voGNDRWSCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B19hnQdgrh1SU62FLy+Lwehydv01ihEVYs3pik7QMTmtw3CpDkazvCSHcS+SRW9gJ
	 2dzIwCWHVmgljk92iZejREW1xA86yRX1D05e5BkCP4NEJsuEZIQH9wIzufCUWDsu7j
	 +wLBT3l4KXTI+PHIvj/7Sgmz8JjPtrMKLNmLV0A7+kFg4sx0ewmvi51+yzwGBoYmop
	 rOPjhaU9oAPrdGsbha2gDqbIH43krB/2Y7XIYerKt8vhSvwB09qREaxIlqm/+UOvij
	 naqHQWEf3GQAiqXcKWdDMCqcQJu7Iw+xxcbhjMLIBDv7sUZv0BHo3u8FDrAhJZ8kgG
	 wAXLX9bSkmTcA==
Date: Wed, 6 May 2026 07:28:26 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [External] [PATCH RFC v3 04/11] RISC-V: QoS: add CBQRI hardware
 interface
Message-ID: <aftQCk7f+hpBMkl3@x1>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
 <CAEEQ3wmkSyThakHy=fe-uNAZbzGaSM=avsqdgcZ2ZTkPNvCkMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmkSyThakHy=fe-uNAZbzGaSM=avsqdgcZ2ZTkPNvCkMA@mail.gmail.com>

On Tue, May 05, 2026 at 12:43:46PM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Wed, Apr 15, 2026 at 9:57 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add the CBQRI controller hardware interface layer.
> >
> > Define data structures representing CBQRI controller properties
> > (cbqri_controller) and hardware capabilities for capacity and bandwidth
> > controllers (riscv_cbqri_capacity_caps, riscv_cbqri_bandwidth_caps) in
> > include/linux/riscv_qos.h.
> >
> > Define MMIO register offsets, field masks, and internal wrapper structs
> > (cbqri_resctrl_res, cbqri_resctrl_dom, cbqri_config) in internal.h.
> >
> > Implement MMIO helpers for capacity block mask and bandwidth reservation,
> > alloc control operations for capacity and bandwidth controllers, and
> > probe functions to discover controller capabilities. A per-controller
> > spinlock serializes multi-step MMIO sequences.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                         |   1 +
> >  arch/riscv/kernel/qos/internal.h    |  81 +++++++
> >  arch/riscv/kernel/qos/qos_resctrl.c | 432 ++++++++++++++++++++++++++++++++++++
> >  include/linux/riscv_qos.h           |  76 +++++++
> >  4 files changed, 590 insertions(+)
> >
[..]
> > +/* Set capacity block mask (cc_block_mask) */
> > +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> > +{
> > +       iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> > +}
> 
>  CBQRI capacity limits appear to include both cc_block_mask and
> cc_cunits, but only cc_block_mask seems to be modeled here. How is
> cc_cunits expected to be handled?

There was no match for cc_units in the existing resctrl schema so I had
planned to wait until the initial support is reviewed and merged to
propose support for cc_units.

Thanks,
Drew
