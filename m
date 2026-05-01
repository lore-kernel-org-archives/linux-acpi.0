Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711E3FE64C;
	Fri,  1 May 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654420; cv=none; b=AgBh8C5pmy6aVpan+fbLLuNMnUpyTbq2vav6y18QlSWCIl0FYbvYtHoAPHdfoaf2R6NwKSML8BsVSkvnaIugN+fv+JFJOoYIRc0ait0MHZ1Vd4D9eTYzhWW3jw+J69FJOTBMbxBOzCO3BREKNKFDQtNeTrVpHazcNB3tpbRo4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654420; c=relaxed/simple;
	bh=770+8GY90hKXMI2cf/tU09CcDPFp31skm8cGJkor5Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LErY971TJZ2AO8G7vBPH/mZGUFTfjJqSYJAxfpkov2jOWIEorxBLubf7ffzK1Aae+EEXJUzj4UMssXI2LWQvtTntFNZPwtQ6cYHaZVqSKzfbmodjU/wYiKYkHcOj3sNCDvcPEDXFEeTw+JvXINO1eSWEP86S2pNZFyCfDKObxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkXj+jS2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkXj+jS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A75C2BCB4;
	Fri,  1 May 2026 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654419;
	bh=770+8GY90hKXMI2cf/tU09CcDPFp31skm8cGJkor5Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkXj+jS2LplYgGAK4wvAUye2IaRpCnPJDQAQhmbsG69HyzLr+DwT+cT2oPLv2a4ei
	 oa4YDx9ewMfhDjvjLqXokbgHXB/UbKkZOh2Wltx8vg+7nDp+OcKuR4bPkqDykFjcot
	 072Kyo2CPHCHWrEKHCJgcwpo0DeOTf8wKLIArreW35oSITduJtl8qM0XdiUgAsOWnn
	 yH1hA8FOMsAMJjZ/yyB7qQoXtCYjMf6PqMAOHLamiRi3ZJTpYn0qvkYZ+iUI50QeD3
	 DV3vqcv8X34eLeVHiYuhqWKCqEeuFZW83MpjlvPxZ2Qt08ZbNe4Kcxj5e7/FnvWcCk
	 IutKrj4hIdvyw==
Date: Fri, 1 May 2026 09:53:37 -0700
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
Subject: Re: [PATCH RFC v3 08/11] ACPI: PPTT: Add
 acpi_pptt_get_cache_size_from_id helper
Message-ID: <afTakYFbm45hYNqT@x1>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-8-b3b2e7e9847a@kernel.org>
 <4fa25edf-65eb-4ff6-bb52-a7087490e81d@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa25edf-65eb-4ff6-bb52-a7087490e81d@intel.com>

On Thu, Apr 30, 2026 at 04:20:23PM -0700, Reinette Chatre wrote:
> Hi Drew,
> 
> On 4/14/26 6:54 PM, Drew Fustini wrote:
> > Add helper to look up a cache's size from its cache ID in the PPTT
> > table. This is needed by the RISC-V RQSC parser to determine the cache
> > size for CBQRI capacity controllers.
> > 
> > The implementation follows the pattern established by
> > find_acpi_cache_level_from_id() and acpi_pptt_get_cpumask_from_cache_id():
> > uses acpi_get_pptt(), upgrade_pptt_cache(), checks all three cache types,
> > and uses the do/while empty-detection loop.
> 
> I see how this helper is used to initialize cbqri_controller::cache::cache_size
> but I am not able to determine where this value is used.
> resctrl does need the cache size but it currently relies on struct cacheinfo returned
> by the get_cpu_cacheinfo_level() helper to obtain it.
> 
> Reinette

I will drop this patch and try get_cpu_cacheinfo_level() once I have
moved domain creation to the cpu online/offline handlers.

Thanks,
Drew
