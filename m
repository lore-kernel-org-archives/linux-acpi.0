Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133154;
	b=MXYdrSmAr70JITlwEL4pgdfFJbIZIeDf9v98K0DvAnAPm9TAyBbGLVjlAzTns2+ZotKG
	 iXiIE4B44+mibaigZ9mGLv1pi/tDvIpEUyiNcLiVC7hG9ayLAcgRbeX1ycAStqo+xcL/z
	 d1efNnJuTpaPOHWrvFs23u7Z6j6n2cmCvlgaZxzeTh+v/cng+AOjg7t31MpXaVfEMvuN0
	 LlBIzzkX33lPmzC72+7I8CfrH7SJw37X5vjwC3NVrEh5PHpFJ0Z4Wl2kJKy4cwrQ2GcmU
	 3ndI0YIQVerQJGhs/cMHA+VG1hJnZuJpQMnwrcgWz4CINH6iOEznntGtyBY2mIqO3KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133154;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aPMvV6uAMyUnxRWvODLxRgeAeThvvI3YGxLfT12eNJ4=;
	b=4iGiUjtSYdzxJb83ClZ4XSHcLdgGsTyViZHcekj+v/OVpGiulOHqyxuJrbzcWMhuk+fd
	 8vhegnuV02TkBgRdPXIc5GgZAJG1TI3ph9FBzSy7/3IKE9CJmvdbsi6bebwRmvA3HLZkd
	 qLqNmjZ3H+tNQi6b7sSNutGFMq/V89ogyKaInYmunuqE49KLWwga7ORKrqlSlrc9WGA64
	 K+JETC1URryEOYv/BkC34aOTQ0mslyRi6r8Nw3cZWx+9QJhSpSTX1Z/5MX9PmNGUWOz5D
	 rS0HGSwsQRhEN4Ssa6ffG7Ru1iq6PXBvEC2fteb7DN9x1YyL3AY5pw674xSjX/eem7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zo6RDrTH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39060A260C;
	Fri, 20 Nov 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zo6RDrTH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A61F000C6;
	Fri, 20 Nov 2026 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133154;
	bh=aPMvV6uAMyUnxRWvODLxRgeAeThvvI3YGxLfT12eNJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zo6RDrTHjY6al3VoeDmjDNSMCEZL/DL0AE39Hi6ZO2FvCCzWFtyPdYkGQLH4oAh/m
	 BbVgYDQvNI8/q9/WJ7pU/wq6pyZAQ9Ds8IfqMifGTUeAmoNt4im7fEIVPHsF2ZwouF
	 DzIwYlkdTOuo48OOr/mNwBKzFc653k7d+qknd9W+G5PIm7K+/03IY8rV30/R23vvhL
	 7ZWpBIaQhlCs7UNmMYw4QhvSENWMVYqiXivFhLUxIJ7VE2DzxdqbJBnonf8ATdJjVj
	 ov0rXmWw6HlhvN/iyvkW70GrjAxAT3bY+heZ9xKz6Y/Sq1xaRjqN/nlcY0YPtTgKgV
	 fQ6cN4FzhkYBQ==
Date: Thu, 19 Nov 2026 16:05:52 -0800
From: Drew Fustini <fustini@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sunil V L <sunilvl@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup.patel@oss.qualcomm.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
	Zeng Heng <zengheng@picoheart.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ben Horgan <ben.horgan@arm.com>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Samuel Holland <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>,
	Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Peter Newman <peternewman@google.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv_cbqri: Bind to RQSC platform devices
Message-ID: <av-O4EoModkN73WK@thelio>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
 <20261117-acpi-rqsc-v1-3-381ce645751e@kernel.org>
 <20261118234904.0f6a0f17@jic23-hlaptop>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118234904.0f6a0f17@jic23-hlaptop>

On Wed, Nov 18, 2026 at 11:49:04PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 14:11:29 -0800
> "Drew Fustini (Tenstorrent)" <fustini@kernel.org> wrote:
> 
> > Let the capacity controller driver probe the "cbqri-capacity" platform
> > devices created from the RQSC table. The cache is named by its PPTT
> > Cache ID and the PPTT gives its level. Select ACPI_RQSC so the table is
> > parsed and drop the OF dependency.
> > 
> > No change for device tree systems.
> > 
> > Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
> 
> Has the DT support landed? If not feels like a few tweaks in that
> would make this less noisy.
>
> If not, see below for one tidy up I'd make here if you can't push
> it back to that series.

Sure, I will roll the changes around cbqri_capacity_of_cache() into a
v13 and leave that out of this patch.

> You almost never want to do manual device_node puts these days!
> 
> It's one of the nicest places to use the cleanup.h magic.

Good idea, I will use it for device_node.

> >  	cache_np = of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
> Whilst you are here.
> 	struct device_node *cache_np __free(device_node) =
> 		of_parse_phandle();
> and drop all the gotos. I haven't checked but if there is
> a path where you want to hang on to it, no_free_ptr() that.

Will do. There should not be a need for no_free_ptr() for this one.

Thanks,
Drew

