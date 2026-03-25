Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABF261B8A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405915; cv=pass; b=G9qtwlS/VfDAY3IemcIaeFXSKBbzyMmstmoYp1IqE4PhKKmFX3BkFWpr5L5p8hvVeCdH8l3Z59jy0i3HdmPpcgFoG6lt4TnzRdKG67Lj25Bv2nbO3A4ECbl4z5CtXp9I5Wxg9WPNL1LDfbgFfVfKlohMr0sdSVPFAr7pIygY5N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405915; c=relaxed/simple;
	bh=PyO7nXn0BKvL4OXhMD1Xm1VJSQgBBVytDo/XkUUyNfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBWUg1Jzn0e9GWsMIu3QOcYEcM0UhSqyoeKRfi+CoTA4XvmSC1o2L3B0jcYrDLxmbKq9M0ahTOJv+hvlTuloXzfR614VfZ+QqOdZ/VW6Zoa3R1QFl4C3BHMIL+bS6L8RQETAHmcG3YKm6Z1+qPh43kvt9oD4+KW2zRPcu2y/50k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XxvB7sRH; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XxvB7sRH"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d7f09aa39fso4943730a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 19:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405911; cv=none;
        d=google.com; s=arc-20240605;
        b=IHRIzNnNk1nZXHmhBfoMZzdi4h4H3MSr4uFwWUBsmFy63X7Ev6RNLYTmBBHSVV/HtP
         CES43ytbGQvzbSLZC2QbTetRORq37hF0CufON6zdyOe2XsNhKLmr90797wGs/FR1BnYN
         CntJnSZyFyWDhAVua11SFAG3HPHrXMDEMaPnZ/REw5KUgU0+1uthrgcGUUjKeo00j6VG
         kc9KibQDisZU/fQWlUM8IsITLO8p5fYGuEdD5cC8z7JDR9o1Hw1rEM+b/dJmIKnpV6DG
         G+xDskRbfEMTsfjxrTOnsyjUlFyuex/PjEl9cV8nmzVOr7WcF4vy6MAkW0OfwMhSODOY
         Mikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        fh=clnZYDwv/D/RthlBoCaF3t7vLWZ4cGoyoulCSyImih4=;
        b=DrqY1HJwNG4ALlKgsv4GmUNZGSwuEJtOzooJqfK2yNN20J1dypA1Vx9KeRzXO7N8te
         E3JDpO0KOrXm46T7sjqS64iCMBQVUCINK3HajobwQiiwu0dkR2SBfbstXBHTcvkisqdq
         faS8wfIipWua9eTdmDMBE2F9n3bEv4snt3u74ZuBSUgQc/sNe43ef5+GRQO9+UyDOVsc
         Q86rdwQ4Xop1zHUjzT/WWvU4Cs6VT+DfeK2J2S3w7KPDEuaIJs7gzWC7AO2XQVMWDNC7
         /DcvdWfr7y819mQbh8uhcbHFPE2fJvExcB0XU9Yk2BSejxUAmv0RcrXo5/cb+ROUP17N
         BUTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774405911; x=1775010711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        b=XxvB7sRH0o0pf5O5dAWb3nZX6x9FUXHXuG/0qppIDbNWejWzWXvB1/DpYnc0e8Q9/K
         C7VcgUx4chLdQgG+ePYv8UVXkeZGUFAeXJ/PAB2iVGhx18CKWvHNTEZNb2cJ4L75xZbR
         9Ppte0a1XoIfKh6TXHv46sVxfTzU9lD51vHQf4UA7w3qE5qgWVUocIR8lKGejRFQesTn
         5m7ohp/FXaPWrhLsqk0Yfm3ECBUXPC9UuSQ3M/Q5HrpA8IM18/nt7L2Hwu4cz1aWFsC+
         jKe24WPOwLIrnrufpTZoP4bm3Espw2JGfrO9VJHWdQ+ZHIKBvqXFwXINKQymXXEjFgNu
         T2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774405911; x=1775010711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        b=ksy4Xm3EpyNoTj5hbF55HumRQ+0zjfRhsCGaIKRA8ymcRAPtdfGMgRRDx+/u8dayzq
         8Q6ageh6ZlncJldIX1K+Jt/BhyLBRChFwrGuCXJmeAzqtTi6iDlJXSzgi03hspE2DUDQ
         lPYL4TPJyGdunJSisEVCBVLlRFZLyk3XXIPw3LgRUGLpQ8kt+yNAmYN2+6Vsjsq9q6f+
         wzGUCh+fxyn+DbacSJNnWmuDM1ZeuUr4RDvAmlzZv8w7ur2fvCyvjnuhCF7YM8sr34Cl
         WkH9RFH4On3FkOHEtC0Il+O7R+IZG57qG+noZEegzdLseDBS7UxdVGbpqpw00NEzsbbr
         9zMg==
X-Forwarded-Encrypted: i=1; AJvYcCWWqax7+KYOsAuwe7JZbSSkQnXfJV3joczFwo6VBwqBo2F5BGtzomUeXJDZriMVgyo3K6gbc1tDdnTc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dAeGrEY/FA/sMhKJv43XZqbcYaPQ1IRKXofgRgLkQ/zf+zx8
	jkabJO3ung0mJ3rNXRiNo3Fsrb1qJixnFAhckaTqWhC+uhfuZGk+KnvZvfoxsKZ+lIJbtLuk03S
	ReObSlmXyJ9doNBLWaK48T6J4fPNGIKz4P7ZLUpLjyw==
X-Gm-Gg: ATEYQzwiPoeA7I0/sOrFOW13h5p0BaREGTJZT8H0ggK0NkMTheYLBLWPviy5G1loyKV
	mLmj8OX5p8SkoG1CQVyNyO//fq8dvHo9UeaHBU1h2c65PBHJRpae9EwyRECkek1TjQsmr/qnRLi
	FOJlNmEZA5akknpviEP8oOpKb78Xd96SwubCaH0rgh0yb5AFA0Yp0SD25XygAuLgFCB9q5CKaXM
	2gE8NdHbCAmCbR8Yfk7/EAcfSioBMHI73rE/E5AMPI7WLeG6ZWZRf/E7JaHqWEn5bS56htRrHPy
	X527lsWQKAAxBA==
X-Received: by 2002:a05:6830:82b4:b0:7d9:b46f:ee21 with SMTP id
 46e09a7af769-7d9d69cdf4bmr897075a34.16.1774405910770; Tue, 24 Mar 2026
 19:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 10:31:39 +0800
X-Gm-Features: AaiRm50kmkkX4lpUb-H53j141xOJJF0B4hNLojrNS59qLQl25FnWptD4NwPaAxM
Message-ID: <CAEEQ3wmuAnHU1VBFDwbCBFb8j63ZcizJ3jEC2SiVWnoMPc4=SA@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl
 resources and domains
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
> Define data structures to encapsulate the resctrl resource
> and domain structures.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> [fustini: rebased current upstream]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/int=
ernal.h
> index ff2c7eff50be..c0402dd06cfa 100644
> --- a/arch/riscv/kernel/qos/internal.h
> +++ b/arch/riscv/kernel/qos/internal.h
> @@ -65,6 +65,11 @@
>  #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
>  #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
>
> +int qos_resctrl_setup(void);
> +void qos_resctrl_exit(void);
> +int qos_resctrl_online_cpu(unsigned int cpu);
> +int qos_resctrl_offline_cpu(unsigned int cpu);
> +
>  /* Capacity Controller hardware capabilities */
>  struct riscv_cbqri_capacity_caps {
>         u16 ncblks; /* number of capacity blocks */
> @@ -125,4 +130,26 @@ struct cbqri_controller {
>         bool mon_capable;
>  };
>
> +struct cbqri_resctrl_res {
> +       struct rdt_resource     resctrl_res;
> +       struct cbqri_controller controller;
> +       u32 max_rcid;
> +       u32 max_mcid;
> +};
> +
> +struct cbqri_resctrl_dom {
> +       struct rdt_domain_hdr       resctrl_dom_hdr;
> +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +       struct rdt_mon_domain   resctrl_mon_dom;
> +       u64 cbm;
> +       u64 rbwb;
> +       u64 *ctrl_val;
> +       struct cbqri_controller *hw_ctrl;
> +};
> +

Can we trim down some fields? For example:
 struct cbqri_resctrl_res {
        struct rdt_resource     resctrl_res;
-       struct cbqri_controller controller;
        u32 max_rcid;
        u32 max_mcid;
 };

 struct cbqri_resctrl_dom {
-       struct rdt_domain_hdr       resctrl_dom_hdr;
        struct rdt_ctrl_domain  resctrl_ctrl_dom;
        struct rdt_mon_domain   resctrl_mon_dom;
-       u64 cbm;
-       u64 rbwb;
        u64 *ctrl_val;
        struct cbqri_controller *hw_ctrl;
 };

> +struct cbqri_config {
> +       u64 cbm; /* capacity block mask */
> +       u64 rbwb; /* reserved bandwidth blocks */
> +};
> +
>  #endif /* _ASM_RISCV_QOS_INTERNAL_H */
>
> --
> 2.43.0
>

Thanks,
Yunhui
