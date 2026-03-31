Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A940DFCA;
	Tue, 31 Mar 2026 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936676; cv=none; b=dd68RNzZfiwcRD8kw0U02EzOwRddOTy2hQvGmvcORcnB0SeS/jHQqKlrY7OXps3jWiv0iSN3FFZsEJDFHUqvH1afD2jDwEm6vuxxk0eOFlBACWFM88Sh9ZaKNFBRVaWvtpuzdOJ5NZI974GQiEFR3Ps4h0pDGTE4Co/Z7ZAx1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936676; c=relaxed/simple;
	bh=5hADumHSBXCjIT1+LmAVrQVfEhe+8GDNiqeARvyfA+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVgqoDF18OlAaJO3kGNOZsoD+tTZIGp2+CyKCF04dLchWBWCM6kTzcPW1QcTYDXKetPbs5P4qUQgwAij6coPLCm/CwkmTC7L97pPJ7Y72EpVksZpLwXjb3MiWTXqMJ3tkpbVZ8+b0VQ5NfXcVZcKDDmq0qdIeeKITvyxrZ7ofLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIyEdRjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIyEdRjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5CC19423;
	Tue, 31 Mar 2026 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936676;
	bh=5hADumHSBXCjIT1+LmAVrQVfEhe+8GDNiqeARvyfA+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIyEdRjMgpcYCfx8c2wkR1g9VBqLaIM+JUvM94CrucqM8dJfEWLApjrIuG5eqArjg
	 QorgFLXDc6ZfIpx7w254FmJvjd01xC6pC7lMhDgaf6fuUDhUM/sRpCv+1AtfEn49Gz
	 ems2dTvkV+doldKZL09o+HBJ3cIncReLiFwIG8KKbIcCDzBJMhEHJJAhTJj6nICM48
	 kHAGWQ/MTlrcniA/NcP3wMs2DOnN1+VpqCKRoyyXGUnWFc8TCnZRduI6DtNBYySZft
	 VOOmZEM5sNsGsXdH1kCX1imhiqJg9AS1s53HKHLn5KWxbVRfd69xa6gIk4QdZKELRC
	 B2WhVDvepMeqQ==
Date: Mon, 30 Mar 2026 22:57:54 -0700
From: Drew Fustini <fustini@kernel.org>
To: guo.wenjia23@zte.com.cn
Cc: dave.martin@arm.com, acpica-devel@lists.linux.dev, alex@ghiti.fr,
	aou@eecs.berkeley.edu, aricciardi@baylibre.com,
	atish.patra@linux.dev, atishp@rivosinc.com, babu.moger@amd.com,
	ben.horgan@arm.com, conor+dt@kernel.org, cp0613@linux.alibaba.com,
	cuiyunhui@bytedance.com, devicetree@vger.kernel.org,
	fenghua.yu@intel.com, james.morse@arm.com, krzk+dt@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.qingtao2@zte.com.cn, liwei1518@gmail.com, mindal@semihalf.com,
	npitre@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peternewman@google.com, pjw@kernel.org, rafael@kernel.org,
	reinette.chatre@intel.com, rkrcmar@ventanamicro.com,
	robert.moore@intel.com, robh@kernel.org, samuel.holland@sifive.com,
	sunilvl@ventanamicro.com, tony.luck@intel.com, vasu@rivosinc.com,
	ved@rivosinc.com, x86@kernel.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RFC 08/19] RISC-V: QoS: add resctrl interface for CBQRI
 controllers
Message-ID: <actiYi6ACcOrvz9J@gen8>
References: <20260119-ssqosid-cbqri-v1-8-aa2a75153832@kernel.org>
 <202603261113.62QBDn8T007047@mse-db.zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202603261113.62QBDn8T007047@mse-db.zte.com.cn>

On Thu, Mar 26, 2026 at 07:05:48PM +0800, guo.wenjia23@zte.com.cn wrote:
> Hi Drew,
> 
> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:>
> > Add interface for CBQRI controller drivers to make use of the resctrl
> > filesystem.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  arch/riscv/kernel/qos/qos_resctrl.c | 1192 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 1192 insertions(+)
> >
> > ...
> >
> > +
> > +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> > +                           u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> > +{
> > +       struct cbqri_controller *ctrl;
> > +       struct cbqri_resctrl_dom *dom;
> > +       struct cbqri_config cfg;
> > +       int err = 0;
> > +
> > +       dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> > +       ctrl = dom->hw_ctrl;
> > +
> > +       if (!r->alloc_capable)
> > +               return -EINVAL;
> > +
> > +       switch (r->rid) {
> > +       case RDT_RESOURCE_L2:
> > +       case RDT_RESOURCE_L3:
> > +               cfg.cbm = cfg_val;
> > +               err = cbqri_apply_cache_config(dom, closid, t, &cfg);
> > +               break;
> > +       case RDT_RESOURCE_MBA:
> > +               /* covert from percentage to bandwidth blocks */
> > +               cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;
> 
> Should use bc.mrbwb to calculate rbwb? 
> I think bc.nbwblks represent the available bw blks in the controller.
> It should should decrease as they are allocated.

The resctrl MBA resource is supposed to be the percentage of total
memory bandwidth. nbwblks is the total number of bandwidth blocks, so I
think the existing calucation is correct.

From the example SoC configuration, the number of bandwidth blocks is
1024, and mrbwb is meant to be 80% of nbwblks which is 819.

Setting MB to 80% in schemata would yield: 80 * 1024 / 100 = 819

Thanks,
Drew
