Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5B2FFDF8;
	Wed, 28 Jan 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633055; cv=none; b=pUDhSUoWzq4ll++SNEA9W8UmkSp8YDtn6A0drJJ3eJMcvvzclOdK8Xhyab+Se/FM/MrDJ+bWAK9OJ28Szdngih5lqlv1eu1bS9gIICDRo/DsKwHszvuPkOI3My5d9GsEsz2hWmp2jy376xemu6AqemZoLEVeA+uv/y3zeRr0zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633055; c=relaxed/simple;
	bh=PUO+i4tIhAekqR+Uw8PMdo+dTmbcqsGSIhNXAiYpKjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrHPnDGwP9t3Bcm3Lxx8NdOAXT/rIWvCEqtOP8z/zd0d89zfkmO9/raY/Wz1yciCrEYx2Nn0VwG5wdVHGj/ow69TZvp/fHhr+/32O0ZKKzdGqzdF5wSJwaov0hqnud3RjPujjAlGB3qAvVTGJtEyNMOhw/2H1ar9vEz34prUfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkqWBrga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkqWBrga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5DDC4CEF1;
	Wed, 28 Jan 2026 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769633055;
	bh=PUO+i4tIhAekqR+Uw8PMdo+dTmbcqsGSIhNXAiYpKjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkqWBrgaRSfuHs8ivn8q4kTJKrQLnguldnD19wl29yGjKwQwK16VOdY69XZmtepQy
	 f6MTbt3MGqTWHnUtx+zbAOZgDtDJIfK74e1QGoc44M4sEGdE89P6Ok4TpXwdI39r1B
	 vTNV6SZ5cHidFnuzPlU98NTpPfuvylR2EqTXng9zjK3TA5QnK5YilVmbog2iIuGp7r
	 jqs1oYcdiZQIQKTYihGasQBvCrsqdjLqbQDlrqBn274xoKCc9Y/YcFE0CNoSpPpitQ
	 yBlBJLRPrRwAW+T2WcasSPoV0E1fjLx/L5iSCUiAaALO5IMPklCufSDInkRDbmssYG
	 gis+p6i9FY5tg==
Date: Wed, 28 Jan 2026 12:44:13 -0800
From: Drew Fustini <fustini@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
	Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 14/17] include: acpi: actbl2: Add structs for RQSC
 table
Message-ID: <aXp1HexsqZst1xXu@x1>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
 <CAJZ5v0iSZ6qvhUWHtrWuO5XBviMcLUMfRB_hWn-FxAhe=LoA-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iSZ6qvhUWHtrWuO5XBviMcLUMfRB_hWn-FxAhe=LoA-Q@mail.gmail.com>

On Wed, Jan 28, 2026 at 09:31:16PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 28, 2026 at 9:28 PM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add structs for the RQSC table which describes the properties of the
> > RISC-V QoS controllers (CBQRI) in the system. The table also describes
> > the topological arrangement of the QoS controllers and resources in the
> > system. The topology is expressed in terms of the location of the
> > resources within the system and the relation between the QoS Controller
> > and the resource it manages.
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapter2.adoc
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> 
> Of course, this change needs to go through upstream ACPICA.

Thank you for pointing this out. I've not worked with ACPI prior to
dealing with the RQSC table.

Is the pull request for RISC-V RIMT a good example of how to do that?
https://github.com/acpica/acpica/pull/1003

Thanks,
Drew
