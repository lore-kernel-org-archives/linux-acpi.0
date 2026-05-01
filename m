Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2E36A030;
	Fri,  1 May 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777676167; cv=none; b=JnoJhTHFXSbWwTSvR4VKrkwHxNSoZUqpTVVcmU0dAKpSlZJFNux7v4g1Ohs0zvU+wmuue7l61P/i70j70ko4oXmEGKyf371M7pJkT5V9NatlHSJwH8pW/dhP56GP+7xRo7fEVrSlb+uCLSKglMTB23NjbPuZZa6sW0PuntqEe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777676167; c=relaxed/simple;
	bh=1iwI2aafpKey+TcNpyfdl6cbDQtnncXbzDesvM+TRLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpEvm/ygj9URzhMN9J/BzYeW9EOTWjOLtHH96S9gOl3nIROpCk3gkfZwmREu8Lx/2/cQrFmC1ZF5AVKj3YfeDUz4IOwEXokV8a/PERzeJUnmd4m+xOYI7ekDrG4d/GlrFVrDu+ntjbzxp0aqkmqvYuHHXmALnOyELTgT1ILo9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVWaxZw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVWaxZw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C758C2BCB4;
	Fri,  1 May 2026 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777676167;
	bh=1iwI2aafpKey+TcNpyfdl6cbDQtnncXbzDesvM+TRLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVWaxZw91EPxSiL0niMsYUnvbV+iahQvNTUpd2iooPHMe2tXk4F+76ugSAQB+ZfyL
	 83MAIleVOYBCp16xg9ptRPFXaa5CCJuvu0ZZT7oNDHUKJwO13e2CEPYgPbFUQqDyCu
	 KGhC6IMSFarh6xghANHhjuz2NVGGt4GF2uKMpgc7LstKNdacnhtV6vveZoHzetcClP
	 M0hfNwdQnIFUvxOAcHaldKZsxFP3wAa74ssiZqk67KGHol/SyCHyPq0cZ1s9gtwFCN
	 dWeB8uLQgq9hWxQYORvT72I2PTp6YmIWELyLBEs7VvsM9aFg076a15zuwo1Pq2ACAW
	 FRSa9mf8D8Caw==
Date: Fri, 1 May 2026 15:56:05 -0700
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
Subject: Re: [PATCH RFC v3 06/11] RISC-V: QoS: add resctrl setup and domain
 management
Message-ID: <afUvhf4SdKVjLqfk@x1>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org>
 <9a8860a5-f63f-497c-ade9-6f64286abff0@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8860a5-f63f-497c-ade9-6f64286abff0@intel.com>

On Thu, Apr 30, 2026 at 04:20:09PM -0700, Reinette Chatre wrote:
> Hi Drew,
> 
> On 4/14/26 6:54 PM, Drew Fustini wrote:
> > +
> > +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl)
> > +{
> > +	struct rdt_ctrl_domain *domain;
> > +	struct cbqri_resctrl_res *cbqri_res = NULL;
> > +	struct rdt_resource *res = NULL;
> > +	struct list_head *pos = NULL;
> > +	int err;
> > +
> > +	domain = qos_new_domain(ctrl);
> > +	if (!domain)
> > +		return -ENOSPC;
> > +
> > +	switch (ctrl->type) {
> > +	case CBQRI_CONTROLLER_TYPE_CAPACITY:
> > +		cpumask_copy(&domain->hdr.cpu_mask, &ctrl->cache.cpu_mask);
> 
> Looking at patch #10 ctrl->cache.cpu_mask contains all CPUs associated with cache
> even if they are offline. This is not what resctrl expects. Instead the expectation is
> that a domain exists and is online (hence "resctrl_online_ctrl_domain()") if at least one CPU
> belonging to that domain is online and domain->hdr.cpu_mask lists all the *online* CPUs
> associated with that domain.
> This is why resctrl always takes the CPU hotplug lock when traversing the domain
> lists.
> 
> I thus expected this initialization to be split between an early initialization of
> resource capabilities and then domain initialization as part of the CPU online/offline
> handlers.

Good point. I'll rework this so that domain allocation moves to the cpu
online/offline handlers.

[..]
> > +	if (pos)
> > +		list_add_tail(&domain->hdr.list, pos);
> > +	else
> > +		list_add_tail(&domain->hdr.list, &res->ctrl_domains);
> 
> resctrl_find_domain() returns NULL if it cannot find an existing domain, in that
> case it initializes "pos" to support adding a new domain in a sorted list.
> Expectation is that domains are managed as part of CPU hotplug handlers. When
> a CPU comes online then handler can check if the domain it belongs to already exists,
> if it does then the CPU can just be added to that domain's cpu_mask, if it does
> not then a new domain is created and added in the the appropriate spot in the
> sorted list (based on domain ID) of domains. 

Okay, I'll move this from probe to qos_resctrl_online_cpu().

> > +int qos_resctrl_online_cpu(unsigned int cpu)
> > +{
> > +	resctrl_online_cpu(cpu);
> 
> This is where a domain is expected to be added when its first CPU comes online.
[..]
> > +int qos_resctrl_offline_cpu(unsigned int cpu)
> > +{
> > +	resctrl_offline_cpu(cpu);
> 
> This is where a domain is expected to be removed when its last CPU goes offline.

Okay, I'll update v4 to add and remove domains in these hooks.

Thanks,
Drew
