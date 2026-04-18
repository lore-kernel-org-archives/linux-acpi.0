Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C3199D8;
	Sat, 18 Apr 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776549678; cv=none; b=O38tdUA8XIkiGjZI8wKvEd+P6F6zXKxnSzz1ofF6i5QAI59oWNsshTZxTJ/DE2MM6ucrNBB/scKlLimcJv5LHW/Il/c7u7BdLZwb8jPPPjXTN1P4EYC1Z5cOEXV4BfMYXn9VeZrJxHDwYCwSpT4SQ8UEQN9ga94+vmjZr01FaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776549678; c=relaxed/simple;
	bh=A5nAfY0NCQpH7+XTQGibmLwo/DHt2HJgZy3T+nc98RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl14aWEJw9tZQaOSKqxMsbaS9CBjmvJJ/JB258Qb0/pXY6VtTLnE+IoY0GVZRY3SS2zUk6ZjjvIdcklTU6yqClmUCqdtxWgZ7JOMjMKBL5YxeEsyA5hDsbB5Fi9U+VtuJd902dyQ/7hn8zneGonMypFO/FXQoTV+yxBHmvz1jRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov6I0C9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov6I0C9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0758C19424;
	Sat, 18 Apr 2026 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776549677;
	bh=A5nAfY0NCQpH7+XTQGibmLwo/DHt2HJgZy3T+nc98RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ov6I0C9WO+pvVeHHF8+eA1mVy/+nfpXNloSzyhX3q7T0ksZvQ8V1V3A63tcjeaDnY
	 /bFBmlsemI4DRs1nKLBBXsmeVlYp1t2d96Uy6e04cwlpKK4Firh3X6VRDNIMszsVnn
	 Kv7DSmLdGRXNK6envCiqUlGHxk9k6VHlnMc8gFSpsPtxYr4W4tNOI4RkTs1GU65LQI
	 6/7Antf6xdT9gPXzY97fNCOsspL70XTzbTiwmtpFD+cdjR4Wcr2ldzoNkRsCKxQnGH
	 //Pt9Pt60iTtFp6f8R4dKTd6jMGXq93OMWOlwaJKQOqNs6lMf+UwDwCAnGCcx02voi
	 Bb/kPWTBSpApw==
Date: Sat, 18 Apr 2026 15:01:12 -0700
From: Drew Fustini <fustini@kernel.org>
To: guo.wenjia23@zte.com.cn
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, rkrcmar@ventanamicro.com, samuel.holland@sifive.com,
	aricciardi@baylibre.com, npitre@baylibre.com, mindal@semihalf.com,
	atish.patra@linux.dev, atishp@rivosinc.com, vasu@rivosinc.com,
	ved@rivosinc.com, conor.dooley@microchip.com,
	cuiyunhui@bytedance.com, cp0613@linux.alibaba.com,
	zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
	gong.shuai@sanechips.com.cn, gsh517@gmail.com,
	liu.qingtao2@zte.com.cn, reinette.chatre@intel.com,
	tony.luck@intel.com, babu.moger@amd.com, peternewman@google.com,
	fenghua.yu@intel.com, james.morse@arm.com, ben.horgan@arm.com,
	Dave.Martin@arm.com, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, rafael@kernel.org, lenb@kernel.org,
	robert.moore@intel.com, sunilvl@ventanamicro.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org,
	paul.walmsley@sifive.com
Subject: Re: [PATCH RFC v3 06/11] RISC-V: QoS: add resctrl setup and domain
 management
Message-ID: <aeP_KJz07WnkqVTP@gen8>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org>
 <202604180028.63I0Svo8029922@mse-fl1.zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202604180028.63I0Svo8029922@mse-fl1.zte.com.cn>

On Fri, Apr 17, 2026 at 06:52:27PM +0800, guo.wenjia23@zte.com.cn wrote:
> Hi Drew,
> 
> On Wed, Apr 15, 2026 at 9:57 AM Drew Fustini <fustini@kernel.org> wrote:
> 
> > Add the setup and domain management layer: domain allocation
> > (qos_new_domain), controller value initialization
> > (qos_init_domain_ctrlval), resource struct initialization for cache and
> > bandwidth resources, domain registration with the resctrl filesystem
> > (qos_resctrl_add_controller_domain), and the top-level setup function
> > (qos_resctrl_setup) that probes all controllers and calls resctrl_init().
> >
> > Also add qos_resctrl_online_cpu() and qos_resctrl_offline_cpu() for CPU
> > hotplug integration.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  arch/riscv/kernel/qos/qos_resctrl.c | 295 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 294 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> > index a4a120f89840..8d7e3b0abb75 100644
> > --- a/arch/riscv/kernel/qos/qos_resctrl.c
> > +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> > @@ -675,7 +675,23 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domai
> >  
> >  void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> >  {
> > -    /* not implemented for the RISC-V resctrl implementation */
> > +    struct cbqri_resctrl_res *hw_res;
> > +    struct rdt_ctrl_domain *d;
> > +    enum resctrl_conf_type t;
> > +    u32 default_ctrl;
> > +    int i;
> > +
> > +    lockdep_assert_cpus_held();
> > +
> > +    hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
> > +    default_ctrl = resctrl_get_default_ctrl(r);
> > +
> > +    list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> > +        for (i = 0; i < hw_res->max_rcid; i++) {
> > +            for (t = 0; t < CDP_NUM_TYPES; t++)
> > +                resctrl_arch_update_one(r, d, i, t, default_ctrl);
> 
> For the bw controller, default_ctrl = max_bw, and
> resctrl_arch_update_one will set the rbwb of all RCIDs to max_bw.
> According to the spec: The sum of Rbwb allocated across all rcids must
> not exceed MRBWB value. 
> 
> Does this conflict with the spec?

Good point. Yeah, this is not being done correctly. I had been doing
similar to what is done on x86 but the big difference is that CBQRI is
reservation based.

Each RCID must have at least 1 Rbwb, and the remainder should be
assigned to default group, RCID 0. It'll update the implementation.

Thanks,
Drew
