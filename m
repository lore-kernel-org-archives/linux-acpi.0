Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A022EBBAF;
	Sat, 14 Feb 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086288; cv=none; b=hFILJdNRI+naXwH11lxZfAC+XeUrFYJdPph059cJPF/PkASX+HW5W7QVrKoxVK05BSlTbZ0UiqQ91ZrKBMEMw91Y21hgv1wX8PtlFzJehog2SWeVP9LyXirXGH6iZRsJ/G676Y4cp+2IvZUb0j3ZwwB2BSR3o0IttyvtiFrnO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086288; c=relaxed/simple;
	bh=b2fAA/6LiIRnE5uC+fyY6XY1BAVSpPQMAo5szwC5qS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0aaCjFRvW5wC8omoUNY7eVs5Mb7NgZ5zEXRLxepGrhRVEsW65ajfT2FUL0KbO2oxILiS/KeFW5X5p+UYJ5TdwMXpZpY2tiP3NswCR7UGdTHlOFjXrAPaTtQBbg57FmWPOzEObj36ih1Yh3j067uMxPhm7G82P67Z5Qi3Cs5b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSuljZt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSuljZt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FEDC16AAE;
	Sat, 14 Feb 2026 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771086288;
	bh=b2fAA/6LiIRnE5uC+fyY6XY1BAVSpPQMAo5szwC5qS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSuljZt07B+CaREOkzyeuVoDOVGRuiv8ypd6iBLKVG+gQRSOVdFo72/dlOAoX5Q8q
	 y8kx1kuEZSLtIfmVo6RPrr68Jk5UXObQXEXY2Rnc33INnOp/SnY9TEZcmObRlTHrXW
	 Nar/oSM3CsWXW+wSyyMfEsZy2hKnDgoj1TU0Xj7Uy2iCdkjWrpLPK1qbVRtRRo5iLW
	 OzSqFr8wRvf6Fw1pfHGKuCqlTDdD5QT3xz1YTFw9tu7UCmbSmn8xkSLiRNUEEty4RF
	 2kG4YNYTx/YvKPad++FCYm+7BcLi3BZQ2Ddf3naU+PFffzJG/GhFlgzEovIKnRAOZS
	 USVUhvBHe+BGg==
Date: Sat, 14 Feb 2026 08:25:00 -0800
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
Message-ID: <aZCh3JaS2V0pLWXm@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
 <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com>

On Fri, Feb 13, 2026 at 03:13:42PM -0800, Reinette Chatre wrote:
> Hi Drew,

Hi! Thanks for your detailed feedback on this series.

> On 1/28/26 12:27 PM, Drew Fustini wrote:
> > Define data structures to store the capacity and bandwidth capabilities
> > that are discovered for a CBQRI-capable controller.
> > 
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  arch/riscv/kernel/qos/internal.h | 128 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> > 
> > diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> > new file mode 100644
> > index 000000000000..ff2c7eff50be
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos/internal.h
> > @@ -0,0 +1,128 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _ASM_RISCV_QOS_INTERNAL_H
> > +#define _ASM_RISCV_QOS_INTERNAL_H
> > +
> > +#include <linux/resctrl.h>
> 
> The include caught my eye but I did not notice any additions in this patch
> refer to it.
> 
> Reinette
> 

I was using this to make resctrl structs available in the code that
includdes this header:

arch/riscv/kernel/qos/qos.c
arch/riscv/kernel/qos/qos_resctrl.c

Should I rearrange to include resctrl.h directly where it is needed?

Thanks,
Drew
