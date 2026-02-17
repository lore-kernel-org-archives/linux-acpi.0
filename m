Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7C381C4;
	Tue, 17 Feb 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367780; cv=none; b=fxpZraV838DobD27btyGyQoKzTJsNilKpzmetiD+ZNoZzC0i2FIq9ZEzK5j8fWAZ4CWbc5kg3yt8Z+aCfMgs8kZmoB32TGHnc60Hb6d1+QupQ1xfj4IcAIeRKVazEyEIHI+SgQgJPyu2dawiH3wih0ZKHK16VBTGYP7rIahBIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367780; c=relaxed/simple;
	bh=fpWLMGake2nbfxsw2JifRPbV4C4cu+jMNO44Y5INPqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcMLf4/36wFoBK4F47qq1Ql4s7o0/B3JUBEK8WbwuTajgVFZFn+76Gq/ngdafpUugGxCn+URCyC7vyvDECEMs1pBgjYosgiL0Jy155FzxspCx23Tf+HKkg5zCXZrpfTqv8Z2kpNbn/lUAWZW+k7ntvzWvGG5PsWa6ux14BzBlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVDxJWBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVDxJWBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C88FC4CEF7;
	Tue, 17 Feb 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367780;
	bh=fpWLMGake2nbfxsw2JifRPbV4C4cu+jMNO44Y5INPqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVDxJWBgs59sS3DNxLuPVsiywvYc5gg06lYoYmr4QUYlSsVuXX7xjFE8AjIVTS8Vb
	 7cdlbqo9AwPlF6Ad4qfJ0RLNh3nDI/NbARpWf7V7NHJ4aQWhITLrAGimkdW1PX6Gx0
	 qBmOkOpQWTVNsJ+k8KIfBGVGtC2g/PRXTtlqQVPC2Kh+5LbPxcy929mC4IZvcepjcO
	 sqMJ9IPoPgqwmcJ138AWW8AFx+Tgl52SSCZcd2riPmJrMh217bRCxpxsFNo3apBXiW
	 7X46IAKqZHHvHWRTSdxaZlGVdootEufHv7cBSJn2jgoe1onumUHeHa/WBYMvyAE3Ta
	 6c1veuC92kKqg==
Date: Tue, 17 Feb 2026 14:36:23 -0800
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
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, Tony Luck <tony.luck@intel.com>,
	Babu Moger <babu.moger@amd.com>,
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/17] RISC-V: QoS: define CBQRI capacity and
 bandwidth capabilities
Message-ID: <aZTtZwE03nHj0S98@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
 <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com>
 <aZCh3JaS2V0pLWXm@gen8>
 <0ba158fc-0c44-4b83-b733-9fc00c4d7f3a@intel.com>
 <aZSzZChSrjXeZmf1@gen8>
 <538dcb97-2699-4220-9df2-0bc6d5f64412@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538dcb97-2699-4220-9df2-0bc6d5f64412@intel.com>

On Tue, Feb 17, 2026 at 11:02:30AM -0800, Reinette Chatre wrote:
> Hi Drew,
> 
> On 2/17/26 10:28 AM, Drew Fustini wrote:
>  
> > BTW, I'm working through all the comments in patch 8. In short, there
> > are a lot of shortcomings in my current implementation that need to be
> > fixed and I will explain in my reply how I plan to address them.
> 
> Thank you very much for considering the feedback. Could you please also
> consider splitting patch 8 up into more manageable chunks that have
> descriptive changelogs? Even for an RFC it would help digest this work.

That's a good idea. I'll think about how I can divide up the code into a
larger series.

Thanks,
Drew
