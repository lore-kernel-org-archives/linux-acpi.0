Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB041DDEF;
	Fri, 24 Jul 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886918; cv=none; b=ZyNfVWulOeMKYcFNkVUEqD5UX1byk7dDPID54kK9x0KNw2SBFx+c0n3ispjLdT89s/86xRwNkh58+D93kJA6qgtU+6MPhWrQrY9IPfbvKF64+EqkHJHfotEpyngd2y1kais/EVHJxp42Tsac+MbGLDxrRRPA9D52wtx5SzHtXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886918; c=relaxed/simple;
	bh=3CO1hzoHhWqTEJ1ZZCA4ebSGEqB3ONFNpKIZN3ENoco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3dte83/6f9kQZwU7ry9H2EVakrSsDx/v9hoD0/zDJ8VmqsO3KATxwBaltEdK14A0yrL2Iio+CfuW6FxWfOmsJItT/Zh8Zhofwhbb1TsxrVZXa4gwOMBC6v0YGferD5+5+3p/1/CkDjdcao7LeBGyGjZQWbhHEPN15pVeNPd8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3hMcaRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3hMcaRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C7C1F00A3A;
	Fri, 24 Jul 2026 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784886910;
	bh=CZoacX15n1s/wdu2z1dTP72aFcV6AUwO1bgAXZEOsx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3hMcaRQ6kJleShuEits1tOJawoutRF3Q9l30Ffi/RtBR9jVDKXluPTIHNObRWwHa
	 wWDYCY2+fnIbz2DGP++hRmLiBR7AuGKejuEUXfJPNpknSASwec/HybTVieqqFkU5Bt
	 489c2vJyrJ56sQoLKPZxg/osv21akQoXoc20t24C/8lpJFc5Q/LU/c1H7wHtEiY5Nk
	 4rbyEXE3VFL1ZE64EVKm8pIx0fDsndrkLciA3KVq+SENUfgj5zyEqQB0Nl+uwJJuHr
	 k2+xtwTu+YwVswYSQcnLGX03idKkKVvNf2mDlzD0c48AF8ZTeBJxIqzhXtKi4AjOTB
	 pFrrI9Zw0n31g==
Date: Fri, 24 Jul 2026 10:55:04 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
Message-ID: <20260724-imposing-lurking-toucanet-cfe22c@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723155454.1760823-9-andre.przywara@arm.com>

On Thu, Jul 23, 2026 at 05:54:52PM +0200, Andre Przywara wrote:
> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> 
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> (simple) SCMI message generation, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/Makefile        |   2 +-
>  drivers/resctrl/mpam_devices.c  |  27 ++++-
>  drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  20 ++++
>  include/linux/arm_mpam.h        |   2 +-
>  5 files changed, 240 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/resctrl/mpam_fb.c
> 
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..097c036724e9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> -mpam-y						+= mpam_devices.o
> +mpam-y						+= mpam_devices.o mpam_fb.o
>  mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>  
>  ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index e2cb884eacf4..b8108ed4b32c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -181,6 +181,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>  {
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>

The above doesn't make any sense for PCC accesses, perhaps need to be pushed
down ?

> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
>  	*res = readl_relaxed(msc->mapped_hwpage + reg);
>  
>  	return 0;
> @@ -197,9 +200,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>  
>  static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  

Ditto

-- 
Regards,
Sudeep
