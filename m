Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29E363096;
	Wed, 25 Mar 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422579; cv=none; b=Ju9CnbbABAavQ1H6VP1tbizWvoocrG4vHNWos3P4rCVohZTNPFu6k1xH+49Hy2ebEG8msFF1chqNXoFoXnQTafo6wh8PZ0YOZd4KYPnij1u33bzUTlxdd7Dq+nZIlTCdGt1VsLSqDNCHZ6IOXHTg1TdkLKcN+fG6Jm44lQzeHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422579; c=relaxed/simple;
	bh=mS4AlmtdQO5unW1ujVzPNe76jLRg5c+lEpiONNOY3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaSoz9t9kzLXsHws5TqVo8Hl3ldWJ48Wl5cwvvjfWWkuteBlPsOKN9BW9VGcQlwTlCTpryTGZn233b2nnC+I8CKhWWm5G+bPx7VTPNbVkEeueKzAay/7Aj5UEIErTrEgshfK+FyT96XQC9eA61jRwT2EAMrh0q7GRviFBVSuEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWl1aj+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWl1aj+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85219C4CEF7;
	Wed, 25 Mar 2026 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774422579;
	bh=mS4AlmtdQO5unW1ujVzPNe76jLRg5c+lEpiONNOY3YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWl1aj+hMh6h4t0m3jMjOf7MkAqJN3eJK3E/elgvAuwbcouB5b4f+qhY5/9VnMEcQ
	 b8t5gq/x8WDzj0tOcu0C6a3HGs4VDcK3+i0s5j6vJc/GXztxhfa9zvYcscfyjuUYBf
	 mozWwgqXkyKpKm/gapq4YtqGj2ofAOw284zknCE4658BBAWO5mdwbTkAgq71P0ZFEl
	 2yVKj1pFqmFiXgcpPTgzRy6D7nl3WHgFTsopwKdB+ZKMzMjgGxYfHq4tD+bmWHYOh/
	 Gd3Pj6W/1Nsc0uI1JmOQggcVbgizHBBXJ4fP3/usFxjD5amQmJqrj+uvQXyqO0BB1L
	 MJzlJDCmqPcbQ==
Date: Wed, 25 Mar 2026 00:09:37 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
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
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [External] [PATCH RFC v2 14/17] include: acpi: actbl2: Add
 structs for RQSC table
Message-ID: <acOKMewjzc-KH3F1@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
 <CAEEQ3wm4vGcOChkj+z58nP3mjG8hvQmAhQLcLxqxwdvoo_8q6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wm4vGcOChkj+z58nP3mjG8hvQmAhQLcLxqxwdvoo_8q6Q@mail.gmail.com>

On Wed, Mar 25, 2026 at 09:43:07AM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:
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
> > ---
> >  include/acpi/actbl2.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> > index f726bce3eb84..7367990349ee 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -53,6 +53,7 @@
> >  #define ACPI_SIG_RGRT           "RGRT" /* Regulatory Graphics Resource Table */
> >  #define ACPI_SIG_RHCT           "RHCT" /* RISC-V Hart Capabilities Table */
> >  #define ACPI_SIG_RIMT           "RIMT" /* RISC-V IO Mapping Table */
> > +#define ACPI_SIG_RQSC           "RQSC" /* RISC-V RISC-V Quality of Service Controller */
> >  #define ACPI_SIG_SBST           "SBST" /* Smart Battery Specification Table */
> >  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception Interface Table */
> >  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
> > @@ -3165,6 +3166,97 @@ enum acpi_rgrt_image_type {
> >         ACPI_RGRT_TYPE_RESERVED = 2     /* 2 and greater are reserved */
> >  };
> >
> > +/*******************************************************************************
> > + *
> > + * RQSC - RISC-V Quality of Service Controller
> > + *        Version 1
> > + *
> > + ******************************************************************************/
> > +
> > +struct acpi_table_rqsc_fields_res {
> > +       u8 type;        // 1
> > +       u8 resv;        // 1
> > +       u16 length;     // 2
> > +       u16 flags;      // 2
> > +       u8 resv2;       // 1
> > +       u8 id_type;     // 1
> > +       u64 id1;        // 8
> > +       u32 id2;        // 4
> > +};
> > +
> > +struct acpi_table_rqsc_fields {
> > +       u8 type;        //  1
> > +       u8 resv;        //  1
> > +       u16 length;     //  2
> > +       u32 reg[3];     // 12
> > +       u32 rcid;       //  4
> > +       u32 mcid;       //  4
> > +       u16 flags;      //  2
> > +       u16 nres;       //  2
> > +       struct acpi_table_rqsc_fields_res res; // 20
> > +};
> > +
> > +struct acpi_table_rqsc {
> > +       struct acpi_table_header header;        /* Common ACPI table header */
> > +       u32 num;
> > +       struct acpi_table_rqsc_fields f[6];
> 
> Is a fixed array f[6] appropriate here ?

This was a flaw in the proof of concept where it assumed 6 controllers.
My work-in-progress has solved that problem:
https://github.com/tt-fustini/linux/blob/b4/ssqosid-cbqri/include/acpi/actbl2.h

> > +};
> > +
> > +/* RQSC Flags */
> > +#define ACPI_RQSC_TIMER_CANNOT_WAKEUP_CPU       (1)
> > +
> > +/*
> > + * RQSC subtables
> > + */
> > +struct acpi_rqsc_node_header {
> > +       u16 type;
> > +       u16 length;
> > +       u16 revision;
> > +};
> > +
> > +/* Values for RQSC subtable Type above */
> > +enum acpi_rqsc_node_type {
> > +       ACPI_RQSC_NODE_TYPE_ISA_STRING = 0x0000,
> > +       ACPI_RQSC_NODE_TYPE_CMO = 0x0001,
> > +       ACPI_RQSC_NODE_TYPE_MMU = 0x0002,
> > +       ACPI_RQSC_NODE_TYPE_RESERVED = 0x0003,
> > +       ACPI_RQSC_NODE_TYPE_HART_INFO = 0xFFFF,
> > +};
> > +
> > +/*
> > + * RQSC node specific subtables
> > + */
> > +
> > +/* ISA string node structure */
> > +struct acpi_rqsc_isa_string {
> > +       u16 isa_length;
> > +       char isa[];
> > +};
> > +
> > +struct acpi_rqsc_cmo_node {
> > +       u8 reserved;            /* Must be zero */
> > +       u8 cbom_size;           /* CBOM size in powerof 2 */
> > +       u8 cbop_size;           /* CBOP size in powerof 2 */
> > +       u8 cboz_size;           /* CBOZ size in powerof 2 */
> > +};
> > +
> > +struct acpi_rqsc_mmu_node {
> > +       u8 reserved;            /* Must be zero */
> > +       u8 mmu_type;            /* Virtual Address Scheme */
> > +};
> > +
> > +enum acpi_rqsc_mmu_type {
> > +       ACPI_RQSC_MMU_TYPE_SV39 = 0,
> > +       ACPI_RQSC_MMU_TYPE_SV48 = 1,
> > +       ACPI__MMU_TYPE_SV57 = 2
> 
> ACPI_RQSC_MMU_TYPE_SV57 = 2  ?

These fields were all included by mistake. The only structs that rqsc
needs are: acpi_table_rqsc_fields_res, struct acpi_table_rqsc_fields and
struct acpi_table_rqsc

Thanks,
Drew
