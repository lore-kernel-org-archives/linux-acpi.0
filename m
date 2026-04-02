Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA191DC985;
	Thu,  2 Apr 2026 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097894; cv=none; b=Zgtlnzg/G+/Mj+VmTqZP7lqLT2hMsiVOagrFLqLp4OUt8lUY2aTBR+rC0GEDPSRZxNmDp8X/qGPMSKcAEWqpWwlT3IZnz4t44C7x1qh+v2cGCC72VdylyrGZpzBLMPO6xLoUuXBU2PbEkWiLnkNuB1YMBdtB3w7hwqsbAosAZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097894; c=relaxed/simple;
	bh=rx9xKdXJN71RUiaBeg38q4nVQgqAHlUDWmMLMw+OMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK60UGCX0+pNzjmPC6/YMDU13rvyPJQ6ymYQp4Vl2MHQsvf8A80jfY6xnpOhAu7RbxKJywJkAkytnPaJPPsfuyvW0h1RHb1oGlny2jsOk2QmsJyiGRFA3bSH8gZBScZUDTQhgwTIcib8LERW1qQJSI0LkZdLdxBTfGTNpnbP8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqZ01y7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqZ01y7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73027C4CEF7;
	Thu,  2 Apr 2026 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775097894;
	bh=rx9xKdXJN71RUiaBeg38q4nVQgqAHlUDWmMLMw+OMRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqZ01y7BcMo3KNVYIEoZ/bcbwlHEokEwhhP0jPfvq21ZKJyXPqQSPvlCtu3in1Llm
	 r637XNyzJfxmLlAfwJc+24ZWBv9J2TF94o8vWKzbabJAn9WVwBatdRj+nbD1tV56AG
	 4qRQ2hzzEDNQcuTivUkNrbuJuQIrXBD9gJvICz1tmjEXft+nwWzIDdX/RwEJgne9SQ
	 5iQcbhGhE/k19kAQCbBVixW1hI/i8d82XPkU+m1Zlzv4wi9PsSitNGj4vwAPjo8EPs
	 Fi70xhpMEtUfnS5C814UiFgshcw1xajJx8y1Z42Vlqn5VkZ11sN+ZrH3Qt7hb+355c
	 o3NGYS2O/Ga4A==
Date: Wed, 1 Apr 2026 19:44:52 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for
 CBQRI controllers
Message-ID: <ac3YJMI2U/zGEBM0@x1>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <DHH5NGQGQYBE.31X8OI8AKTYRU@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DHH5NGQGQYBE.31X8OI8AKTYRU@oss.qualcomm.com>

On Tue, Mar 31, 2026 at 07:48:27PM +0200, Radim Krčmář wrote:
> 2026-01-28T12:27:29-08:00, Drew Fustini <fustini@kernel.org>:
> > Add interface for CBQRI controller drivers to make use of the resctrl
> > filesystem.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> 
> Hi Drew, I have just a few minor comments as I noticed that you plan to
> send a new version soon, so I'll try for a review then...

Thanks for reviewing.

> > diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> > +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_info,
> > +				  struct cbqri_controller *ctrl)
> > +{
> > +	int err = 0, status;
> > +	u64 reg;
> [...]
> > +	ctrl->base = ioremap(ctrl_info->addr, ctrl_info->size);
> > +	if (!ctrl->base) {
> > +		pr_warn("%s(): goto err_release_mem_region", __func__);
> 
> Missing "err = -E...".

Good point, I will fix.

> 
> > +		goto err_release_mem_region;
> > +	}
> [...]
> > +		ctrl->ver_minor = reg & CBQRI_CC_CAPABILITIES_VER_MINOR_MASK;
> > +		ctrl->ver_major = reg & CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK;
> 
> Major version is shifted.

Thanks, I will fix.

> 
> > +
> > +		ctrl->cc.supports_alloc_op_flush_rcid = (reg >> CBQRI_CC_CAPABILITIES_FRCID_SHIFT)
> > +			& CBQRI_CC_CAPABILITIES_FRCID_MASK;
> 
> FIELD_GET() could be used to make the mask+shift pattern nicer when
> defined by GENMASK().

Good point, I will switch to GENMASK and FIELD_GET.

Thanks,
Drew
