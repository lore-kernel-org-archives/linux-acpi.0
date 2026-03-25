Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BF2773E5
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403332; cv=pass; b=qx6771d3A2eqWGjDL7ZHEFDfmym2VJK/BrLmbRqXTDOlHqbgzazKa6/4ktZO2X68OqrMuadGOQXBKj4xKS6eTIT8xA/7D7XhghbM/J0eXiXmQiB2rh5tLFe2mumC0kQ44ZOFF40vegaam6T0bATa0U7U22itssTdjmC2u7U/e/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403332; c=relaxed/simple;
	bh=8j/1RkEqSK8cDEtrMb0SmRPLJt1HSounD9iRf5VcPkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbYPJbGP49YyHapkwPMGOOYvLovZcOopo2ffteCeYq3/M5akJCX4ZUGPaUb9hQL1JTBfcGspT5FDS7ZbsYj/Ex3a9tEImrcrD2an//MPRJPuU1A40j6AxfDenqpF4L/vjZuHzSXSFoQAH5ifupORScGW4C/PqSe5EfSwkyIcaDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q5jGkkB5; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q5jGkkB5"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d86eb7c854so1970768a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 18:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403328; cv=none;
        d=google.com; s=arc-20240605;
        b=ElWfdYzME+d2x8W/pZpwKECeInibuurKUIeRmsJv2i5F3hORkXTpLstdpLMyzLBrQP
         VwUKDizoUyZcNBecZRHdjMo069/8Fpwz5UrwxlFt6BN7rd+2AHmF5mJgGqxQGbdDwlcN
         LREoUz+LJLpqprfSFP6eaqKhaIYRYYKnQxtwqMNnSKWLoggJQbSgF3aielmWrxjACxnp
         go2Yprs6DYEl0YoOO44fi1jAB5iMBaaJYp8jRwtZof2Hf4qIEJ6B9fBmbV+NJ0OL67s+
         jsoETZcug2oeNr6Cl0DDP6BJKb1Cx4oDpZYO0JA3E2HOGKx2UAHeLiF4ZSc597Kanpw+
         wahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        fh=hsvGdBCY3ywT3wyotOJlfH9iwwIBdA71r9DNDVL2AQM=;
        b=e5v5hYCCLoSMAoe07Z2BNa/2ij+wSucNewc0rf/4yeHUCI+CsRLC9z+QUcaiGnBLut
         xGR3l1gwNROaes8bQy9GbzX+tv/NxPSWR73HpxcDme1DCojD92fLKFL+zPdxJ9HMdMG/
         l1k8PDa5p1hQWytCbGEmp0WQILburJmC6T9w7mnAbOeCRv8uryZP7rUI+sYRcABxc7+F
         RpnHyXeLDfKsCaM5BMAOfLabeXfGz0mx9EiizpiDvZSqTkBCXJZEKKS1HqUv7e2a0yNt
         KYA0P63AycB+xQ9oTY9nWjzDt/nBqYHC+k/UpyxjX/atxbQpQoEUF7k6FnfnIKQFiHKU
         marQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774403328; x=1775008128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        b=Q5jGkkB5llpionInOIj+O4ompG5Atw4xxbCrSL37xMUiCORZ7FQ2cuyLzxuJm1+vRc
         q7aBKK2bNp9lClMZUclvLWPPgeeT33bYhhr4IwmdxxCrG1jBvKqin+4cmLWOse3heu1K
         WZIEGoMAsNdtBrtA09vcTWlJjPfTHlduxTdPCkC1Rdk0THgJYds4n9YvXwUIURWuOJny
         r/rKDqWwhC9ywskIxnH2N0A28zl3ygoFf3wqcuN8byxROlQNUG7tXzHJAP6hYUgugk5W
         iRvc5GepeE+fMNOPSIsZPJugj6j/iRilFRJ4ip1AVNIsKFNazZWaLASZN7HqqHMOtENc
         HSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403328; x=1775008128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        b=aRtdcdLpgXspQ6dpG48YS7IoVb5WGwXS/ohjXBa9qVdvU/uuJDQp5Q3vVUjZmuHyyS
         1lpsOBBWkhNCxYOIXRfr8hYBczAdEodzQbZjmTQMcIkoV1QvmZba6Ae22+wzBIadGwiM
         PiDwELT4zu5a8bnpnlmwGAU6oRLpo2r0HuMC7ppJt6ksFwEE5Wj4dcmVZeQ8bp9fJnK/
         Ik9fnaj14c+At39PNPn5w7xTkdqIQh9ACXplIISLagutjuJo5LGRmSJSeUbtlaOLRxiE
         uSghsBb9B16huvnRpWjn/r97a1vm2Y9V35AWr+VrTuiu4MFfsl3KV/bI8OJrkXYq/hv8
         ZjFw==
X-Forwarded-Encrypted: i=1; AJvYcCU74N4smTDKuwNpGZ0mq27wtzuoxW+uf5n+EeKgxcO2IJN39+tLsFNP7Q7uRu0FtcfpyVQVltiF5k8d@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/rlqGer6oAT/4/uS42557iRkqcP8poH78s8JKMooYhXM6jz/
	vT/IpUWGK6r32C2Pkervgaq25+EGqtYAIU2AafXhGJSTefr5b3DMAL5/iFFhJuIiabNAyPg+9hx
	T/rdZMYQDEnyiA52MhCD3Psd3hUi1S7wfmkZDoxkIJQ==
X-Gm-Gg: ATEYQzy06D5GGxpQaUWhz6SZrjXCHlR82L6XzO+kPvA95O4On+15M1ytaTbvgYLAxOZ
	ZhFtBKKZPzFHiSmf46cGOkBchWr02/WXmN2eVkkl8iE43QlzfJ3tWwgLKYj3kUS9TImRtnkiw3x
	EMOQP3jrpElD20J2BmAErt9XOv6anS4hGxa9/aSPwjZ4DgUIumPIgloRaBLduLcJ2xzsLP/LWMZ
	cc3KW/0d1zqqGR5fnozdYrv8NY3u5jdnRyAWJlRURStLdwVbWnmkB2i+wzBYpZNRB0+9sC5swAQ
	Atqj7xTQLTNXGQ==
X-Received: by 2002:a05:6830:44a4:b0:7d7:cb13:3fe9 with SMTP id
 46e09a7af769-7d9d66ebce6mr746710a34.19.1774403328448; Tue, 24 Mar 2026
 18:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 09:48:37 +0800
X-Gm-Features: AaiRm50a2XpCtEI0EunEN7ujOM94GRAQRhXw7yAPEIMaeAZSdyGXWlKvSXA68yk
Message-ID: <CAEEQ3wnhvV03FYfqBqz8ihyFCcxKS5ztdvCHDF789ubSQAMw1A@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 14/17] include: acpi: actbl2: Add
 structs for RQSC table
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add structs for the RQSC table which describes the properties of the
> RISC-V QoS controllers (CBQRI) in the system. The table also describes
> the topological arrangement of the QoS controllers and resources in the
> system. The topology is expressed in terms of the location of the
> resources within the system and the relation between the QoS Controller
> and the resource it manages.
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapter2.=
adoc
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  include/acpi/actbl2.h | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index f726bce3eb84..7367990349ee 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -53,6 +53,7 @@
>  #define ACPI_SIG_RGRT           "RGRT" /* Regulatory Graphics Resource T=
able */
>  #define ACPI_SIG_RHCT           "RHCT" /* RISC-V Hart Capabilities Table=
 */
>  #define ACPI_SIG_RIMT           "RIMT" /* RISC-V IO Mapping Table */
> +#define ACPI_SIG_RQSC           "RQSC" /* RISC-V RISC-V Quality of Servi=
ce Controller */
>  #define ACPI_SIG_SBST           "SBST" /* Smart Battery Specification Ta=
ble */
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception I=
nterface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
> @@ -3165,6 +3166,97 @@ enum acpi_rgrt_image_type {
>         ACPI_RGRT_TYPE_RESERVED =3D 2     /* 2 and greater are reserved *=
/
>  };
>
> +/***********************************************************************=
********
> + *
> + * RQSC - RISC-V Quality of Service Controller
> + *        Version 1
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_rqsc_fields_res {
> +       u8 type;        // 1
> +       u8 resv;        // 1
> +       u16 length;     // 2
> +       u16 flags;      // 2
> +       u8 resv2;       // 1
> +       u8 id_type;     // 1
> +       u64 id1;        // 8
> +       u32 id2;        // 4
> +};
> +
> +struct acpi_table_rqsc_fields {
> +       u8 type;        //  1
> +       u8 resv;        //  1
> +       u16 length;     //  2
> +       u32 reg[3];     // 12
> +       u32 rcid;       //  4
> +       u32 mcid;       //  4

The spec appears to specify a length of 2 bytes for this field?


> +       u16 flags;      //  2
> +       u16 nres;       //  2
> +       struct acpi_table_rqsc_fields_res res; // 20
> +};
> +
> +struct acpi_table_rqsc {
> +       struct acpi_table_header header;        /* Common ACPI table head=
er */
> +       u32 num;
> +       struct acpi_table_rqsc_fields f[6];
> +};
> +
> +/* RQSC Flags */
> +#define ACPI_RQSC_TIMER_CANNOT_WAKEUP_CPU       (1)
> +
> +/*
> + * RQSC subtables
> + */
> +struct acpi_rqsc_node_header {
> +       u16 type;
> +       u16 length;
> +       u16 revision;
> +};
> +
> +/* Values for RQSC subtable Type above */
> +enum acpi_rqsc_node_type {
> +       ACPI_RQSC_NODE_TYPE_ISA_STRING =3D 0x0000,
> +       ACPI_RQSC_NODE_TYPE_CMO =3D 0x0001,
> +       ACPI_RQSC_NODE_TYPE_MMU =3D 0x0002,
> +       ACPI_RQSC_NODE_TYPE_RESERVED =3D 0x0003,
> +       ACPI_RQSC_NODE_TYPE_HART_INFO =3D 0xFFFF,
> +};
> +
> +/*
> + * RQSC node specific subtables
> + */
> +
> +/* ISA string node structure */
> +struct acpi_rqsc_isa_string {
> +       u16 isa_length;
> +       char isa[];
> +};
> +
> +struct acpi_rqsc_cmo_node {
> +       u8 reserved;            /* Must be zero */
> +       u8 cbom_size;           /* CBOM size in powerof 2 */
> +       u8 cbop_size;           /* CBOP size in powerof 2 */
> +       u8 cboz_size;           /* CBOZ size in powerof 2 */
> +};
> +
> +struct acpi_rqsc_mmu_node {
> +       u8 reserved;            /* Must be zero */
> +       u8 mmu_type;            /* Virtual Address Scheme */
> +};
> +
> +enum acpi_rqsc_mmu_type {
> +       ACPI_RQSC_MMU_TYPE_SV39 =3D 0,
> +       ACPI_RQSC_MMU_TYPE_SV48 =3D 1,
> +       ACPI__MMU_TYPE_SV57 =3D 2
> +};
> +
> +/* Hart Info node structure */
> +struct acpi_rqsc_hart_info {
> +       u16 num_offsets;
> +       u32 uid;                /* ACPI processor UID */
> +};
> +
>  /***********************************************************************=
********
>   *
>   * RHCT - RISC-V Hart Capabilities Table
>
> --
> 2.43.0
>

Thanks,
Yunhui
