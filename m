Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE213D2FFB;
	Thu, 30 Apr 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592241; cv=none; b=PKB1NYqZAZolMX17jhZXth863KVhM8YiZvO4mJ2CnXCRAYGTBQ6HRvUDCxNZyebZRUmrS6Wrb7/V16+i0+yV5MtNO1RcW0Rk0SoSdfG20vL4J5Es3X4rrJL1cWtkyHWgr/WvU5ipM0YhTRqAQSt18bUOcEl82/vmQ0DVlLG18lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592241; c=relaxed/simple;
	bh=EshY6j1HpzMOQVRhy5fZwtjSoZH1Z4wUejGMVerDcaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjM9kWcmuSaskvK2ajTUXAHwsahW4yKsH3C2ZcNdnQUnLipifmWOvFd3jpZsxuqNjNlfWDZJSpht/GFqU2/4ks2MIvEmHU55YjgFYMO2Qt5OJPXyPIxyvSxQ04VbCkqA1iwBE0D5iM0U0L85C/3wlJo4Dyw3rlEgm+MQlGDZ5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7mvH4Jw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7mvH4Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12042C2BCB3;
	Thu, 30 Apr 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592240;
	bh=EshY6j1HpzMOQVRhy5fZwtjSoZH1Z4wUejGMVerDcaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7mvH4Jw8CiQC3zExgrtpYVedQ2T2406qeW6wbB/25ge6k2hFasdM5MGJEqqtgIPL
	 kSHl2r4KQODOpZQFNBPZU8W/KggG/BOa5gyIgrQ+4gSQdMbTGjozmxTWiyYhxRh3Bc
	 t/XnrjFbSKd9BeRpSMXaFCkr87wTYLuIqmolV0tUnO0SuTe2UR9j9IszXUkotFTB1o
	 n1pqt9PMVVPKOeONyiZgVbjW+fOcTZLr+80ntv3RtQWxnqZaToaQ5IOnHhqcixVCrS
	 Ahe3mGMozxdDP9oBEt+rR16XIWFPy6c8GaIPLyPaWDm89+zMJ9WrDC/eHicoPrqCQf
	 gJPkTc56d011A==
Date: Thu, 30 Apr 2026 16:37:18 -0700
From: Drew Fustini <fustini@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
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
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn,
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
Subject: Re: [PATCH RFC v3 05/11] RISC-V: QoS: add resctrl arch callbacks for
 CBQRI controllers
Message-ID: <afPnrjAseS00a8k9@x1>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-5-b3b2e7e9847a@kernel.org>
 <03085c36-315a-47c8-85aa-f3de88fa43bd@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03085c36-315a-47c8-85aa-f3de88fa43bd@intel.com>

On Thu, Apr 30, 2026 at 04:17:22PM -0700, Reinette Chatre wrote:
> Hi Drew,
> 
> On 4/14/26 6:53 PM, Drew Fustini wrote:
> 
> > +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> > +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> > +{
> > +	struct cbqri_controller *ctrl;
> > +	struct cbqri_resctrl_dom *dom;
> > +	struct cbqri_config cfg;
> > +	int err = 0;
> > +
> > +	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> > +	ctrl = dom->hw_ctrl;
> > +
> > +	if (!r->alloc_capable)
> > +		return -EINVAL;
> > +
> > +	switch (r->rid) {
> > +	case RDT_RESOURCE_L2:
> > +	case RDT_RESOURCE_L3:
> > +		cfg.cbm = cfg_val;
> > +		err = cbqri_apply_cache_config(dom, closid, t, &cfg);
> > +		break;
> > +	case RDT_RESOURCE_MBA:
> > +		/* convert from percentage to bandwidth blocks */
> > +		cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;
> > +		cfg.rbwb = min_t(u64, cfg.rbwb, ctrl->bc.mrbwb);
> > +		err = cbqri_apply_bw_config(dom, closid, t, &cfg);
> 
> (Earlier comment wondered about whether rbwb cannot just be provided
> directly to cbqri_apply_bw_config().)
> 
> Apart from that it looks like this can benefit from "emulated controls"
> that we mused about at https://lore.kernel.org/lkml/e788ca62-ec63-4552-978b-9569f369afd5@intel.com/
> 
> At this time this MBA resource is constrained by the 1% steps that the
> default MB control supports and clearly it is emulated with a control that
> can support finer granularities. I am currently working on a PoC of the
> base schema descriptions on which the support for emulated controls can
> be built that should be able to expose full hardware capability.
> 
> Reinette

Thank you for your review. I have been working on a large overhaul to
the series in v4 and was about to send it. I finally realized the
sematic mismatch between resctl MB resource and what the RISC-V CBQRI
spec offers. I decided to create MB_MIN for reserved bandwidth and
MB_WGHT (weight) for shared bandwidth porpotional weight.

I didn't expect adding two new resources to be the best solution but I
wanted to offer something tangible to move the discussion forward. I
look forward to your proof of concept as I expect I can then build
proper support CBQRI bandwidth allocation (reservation and proportional
share) on top of that.

Thanks,
Drew
