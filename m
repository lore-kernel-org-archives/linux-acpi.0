Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037500;
	b=M9SCspe4DAYAfFrGl+R54PCJHrps9NSLVzpP43r5xWLJUXJeVvk+kya7jq03g01Hbyso
	 j66tDOUEBlIBfOCgOgw177Wq7L/lSCO9OuqpEAW5kidXW48df0T3+q7BrRQisowlwTqit
	 JZGsnIYZRYAqTfE4bFCWfMLtX96NQD9PCDf3PLlf9biiDgXaTJwNQvuIdqI1jHmbRMlPX
	 CrBdrtAEI5SQ8SOK8icJxbu22r0klKZkgW6uVu+++6rPwl5pblSplRmxEr2e6pT/RE3qD
	 wCj6OjXrahOKJcW+nisBYXPRaSND0JcuhGthMz83iCCl3QWOqdlucuisCr2f79WTdDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037500;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GSXnf5nv2fVeS5LQVArcdIaVDjGKR2SGDo/49eE5VD8=;
	b=QnGkc6MxUTzsDYAYycll1wNoDbZvOn1ep++sLSr1zmwgmyWN5QZvG3iSP2g3ZpmKbt+4
	 hUe8PCK9dn9VtAnMHBLcbIvKmDFJttnbek+vXtuTO7ctWMHmlyOnU655J94it4JDc93vj
	 95jLvm1vpPZWV6RjqpONfDvJIz9eoKekPeZGjqrnPPbMCnyKJ6nAb+3GGKHT1uZJBKTKm
	 a8evXvHa+whYNHP7LmxRKng+FTIffy4gOC2TucQ5AO0WXE7faB18fBY/oSVrYrq7jHs8/
	 AREcdAK2u+rTa6tFbhBNa0UU9gFZQu43hCj7Dyk6ITLhST9fPQeNQ4QjmI7dRFSresg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5lNybHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D81606A31C;
	Wed, 18 Nov 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5lNybHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061851F000C4;
	Wed, 18 Nov 2026 21:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037500;
	bh=GSXnf5nv2fVeS5LQVArcdIaVDjGKR2SGDo/49eE5VD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P5lNybHMuD6Ekep+qjOOYc6sl3PHNLdnYPfYZyQ1uE2BnPeGNnzG4BydUZkEkz/T8
	 o6JiNvkd3IOWksfr5dM+8skk0y/tMbPsXpKkjOLUjnB3ux4BQxO/D5hVeGsKY0SA0V
	 RHVuG95PBlhip1caxtUlq4FaFQUkKjySL8m6yNLPTKAnMI4uIE8JsC0Axh+vcnpuzm
	 66ylyS1Kr6zXxYPpnpM3ZQuTbCXO4OWkgwMK1DbaKDaUUA1kH0nwZKevV9E/UK8vFy
	 HS0rSqb9uUIWJ4kYeAEAwtRy6mpZmbdmrWV5dSShKFantoFIrUu+pfqQSFy32VxrVC
	 9CEcRFlaWYbDQ==
Date: Wed, 18 Nov 2026 13:31:38 -0800
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
Subject: Re: [PATCH 1/3] ACPI: RISC-V: Add RQSC table definitions
Message-ID: <av4ZOllAbNJ9v+rn@x1>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
 <20261117-acpi-rqsc-v1-1-381ce645751e@kernel.org>
 <20261118203744.6201beaf@jic23-hlaptop>
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
In-Reply-To: <20261118203744.6201beaf@jic23-hlaptop>

On Wed, Nov 18, 2026 at 08:37:44PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 14:11:27 -0800
> "Drew Fustini (Tenstorrent)" <fustini@kernel.org> wrote:
> 
> > The RISC-V Quality of Service Controllers (RQSC) table describes the
> > CBQRI capacity and bandwidth controllers in a system. RQSC v1.0 was
> > ratified in June 2026. Add structure definitions for RQSC.
> > 
> > The definitions stay in drivers/acpi/riscv until ACPICA carries them
> > in actbl2.h.
> Hi Drew,
> 
> This seems unusual.  Normal path for this has been to
> put them in the right place and just flag the pull request as
> you have done.  Then no one merges the series until acpica
> pick them up and Rafael pulls that in.  That way it 'should'
> not require a change, Rafael just ignores that patch and
> picks up the rest.
> 
> I haven't been paying attention so maybe this is being
> done differently here for some reason.
> 
> Has added benefit that no one reads the patch as it is another
> projects problem :)

Thanks for taking a look at this series. There is no special reason,
just my lack of experience with ACPI. I will switch to the actbl2.h
patch generated by the ACPICA linuxize process.

Drew
