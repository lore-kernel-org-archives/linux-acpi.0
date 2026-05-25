Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD53E16A5
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697405; cv=pass; b=XrkT1jjbiMU0XrG9n7fp39Kv8gCo9BukhDohtu+kmFYx6k+EOVFHQRZml+1jTezk5GLzvfbLGvPMd6oKgsVPsyEZCvfREBgN7reRZnlNs1dKDavAa5GII8doSBtZoPg2y8KTOxayO3iRFo/sGr1saFv7PqB67SxTkpxxCC///I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697405; c=relaxed/simple;
	bh=0achz9n+qw0t1Oo82cOOIyvX9+EU24sy7AuCwSzREkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFIvnDoKFqCLnu6aZEVR2rGE1gwISb/wAOKO0ta+kO/1TlI/2gOb6UyH/1DJ7cQgGhNmkw9YrupinTmiNXlU7S3pxww9G35U+w6eSfKzxB4CGB+HbZjC5SxadQgR6VFQwoDDs18lUDttnZ/cDgZzl9DBEScOryA8THtVIhSpXqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnS3UKKI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WWGu9FHY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnS3UKKI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WWGu9FHY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P2usYA1180567
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 08:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Y00jVBsOO5l3g5o3U2vjZ9VsbHwpeMj0hXubWYDZVoE=; b=dn
	S3UKKIUaiBLrAZwS0idvEBG9uLwSe38I9zNIU0aBjXqnXXGFennybsL2PX9kvf4y
	XBPwDUKGPZUe/E+Sl2FBLU2WYdrHRyBoibT9UiLwlGuI0/9kZlQld+nbNDhgUPlO
	X6RdacDuhzmD1uULNM1A4NkKZjcjvldfHFaiVDgfVHc3TWf2ofXypIW8ZBawLv7x
	bWLg5Yaib53OBZXheovHkGqWKmCmBCCNuknxrjX32gJjLCW5p/QCzqvU32kEZBv4
	nuPHrAxHPt1ONgp6dJIiIqkGFIpITz1VgqMczdrxZKV8fjhLZ2WYO7BPjS4fx14n
	gMVF8uufE8IIZqeVWr8w==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9nkt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 08:23:21 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bdecb2f4a7so51606247b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 01:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779697401; cv=none;
        d=google.com; s=arc-20240605;
        b=WA2r87JNHd9pZY5KZMTuQ7TV7zPYrrnK39G3j9xuTZ/+a2hBi3xQ0yD2FIkp6vGOe9
         Ra9p5g5SG6MGtd/veqzobpQhIk4cGGpHXccVBBJsuCA2w/4SxO1q1rhG7dekAPVGJHVv
         D8MSlHjfPLE0FV5heeh2llDHxB7GJ3oSeNGgVzAmTwk1BdH69SVy8ZlGjINm3uUeYBTX
         hvNjPtUy04xi9RvauOuNXeYlxTOxCyHzcbc6juiNu7yCsN9L7/JHumswN18oqf6+Dz59
         g83d8c05W2M9WKpTHt+BJlkz5aL6Iw1GAFcJqWCL8bSqF/J8gRKLfPTdGqYz4hTkhwID
         wplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Y00jVBsOO5l3g5o3U2vjZ9VsbHwpeMj0hXubWYDZVoE=;
        fh=WWkqo+KWa4eEpJTQKQ9w+zOZNwzJuKPBpCAMeTE26FA=;
        b=km4xQsRsBcNPhU+pg9z6w6twJvALYKsl+31oeA/QlpLmPvIV+l3qSzVyYTwYFwg0kc
         Vtt3ILaoVQb5e3VVegrl8SUjfn5216yOW5UcXG36LAut926a+nwl0+W0u2GeWCvHGMLl
         XmaAXmbAG5A5BmM8TpOw5BJAauSxAxACEzxK5lrOlmP+SeE0dvdKkZfXtAz2M8h5eiu9
         mb0ITHgaRbsrVN940OMaQQTGyZu5rFIOTxqyBX4HexmZqlxBKJ87QRjl/XTtzwXYD2Nf
         g+aJHyYxFqDjoSkDVAYMWzEA9v3aR0Z8hCvYS5BuzlPaPjZVkJEcTPoeo2itvRgFKGtJ
         BWtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779697401; x=1780302201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y00jVBsOO5l3g5o3U2vjZ9VsbHwpeMj0hXubWYDZVoE=;
        b=WWGu9FHYdit781ZHLrkIWGZqnw2QsmIJg6I1bT/lZqXLNT9pctH1Uo6eQTVO1DxQac
         M6BuupWsMUdH8cuhuDVbfe/PRaM8zrxAYjda2IDY82LKaWQTkZB72rQVNZiZJMXkhhDc
         fvUqcwczHwUwUVsFtIGxznEzqqYuWi1ZDVYYgxs06iRXY+r/XlTfePZdEWt3ga/nVMtZ
         0nO7T6OR3RsJoy9jJhHCnILH4XHcofLKrbnHeGmU+wWq2oHCcrUCXdpYmQwqnVNR+cig
         3SZm8ctSenARvfVHHpxINDUF3VhmflNDxcfORyXOpYd8Kr9tpwrZmdMFbymZcpPo4oQ0
         RndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697401; x=1780302201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y00jVBsOO5l3g5o3U2vjZ9VsbHwpeMj0hXubWYDZVoE=;
        b=oElydGfO2eqylm7gq+NYOC7g8k/FJTWTVWfwCoOs7xabSsqScDLedxjPM8Omh2zDTk
         cRfjeCq0qgvNsAtlZYwZpRs+8lAflanu605w6USa7miQIblsVn1CTG/MM+DKtv4MkCr6
         5S871IDPJ1efBhDqXbujxSC61Oia2SylfB2/86hTOslLMz0mJk49qY6fvZnfK5T3CZ48
         IVVMdjlo3bsXo4hXhS0RoqBY9FgKu5+UZB2RT9hHuT5n3lUfy3DHjd5/n2pyyDVTj6LM
         gXupoNodA/4IW418BhTXq2cXzg0kVVNgcH9KWFr3yihr5CyInzheM3+U2jqol0qEP8Ej
         zrUA==
X-Forwarded-Encrypted: i=1; AFNElJ8s0cs95CzbxzZ7TCCghG0LjeamCfYT4F0q12y73BiN6K1XWkkSQnLfvGJgXTW3bqqJu6Ct2MMmifXR@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWTMFz+Ae055iYRcHX89qunFu/TuMOAHxcm04dd1yQ+M11n5P
	Ux0J1QZYA8WdrrqI+fqjYNy5lyoRxvqA32O70Ogu2uTzEKYZAoDkw6m6hW13d6ikDqLsgv4Zgux
	PjFNRiXsfs1+QcahqCL7SfmqxSlDG51hToeo+bpqb6DbBSM1EH3IlJqkesWlV47N2btsnLI/vLO
	jIy55evBZO8nc5mjNdq6BH1H0uicAGle8j8igYvMk=
X-Gm-Gg: Acq92OGLXDNfxepdWpwfIuv9q/KPz8vSNoYalZHS4kwtcTD3W4eKhzsUNELTIkCSSAF
	KRQyhRZhy7VZxkFo0s8EVQaQBy245/RANDl09sS4Y7vJJorlo0USNpC8B3z5Dt9Za7XytWZ9Fax
	cW/R+ShjGxfr4hWkLVr/FRcO7iT0rXEDXSKjlgC46Nqq6tJfe8OA9fCQm+7ZpRcToRO2N+9lZwR
	k7bhU15
X-Received: by 2002:a05:690c:6b04:b0:7d0:3bbc:c81 with SMTP id 00721157ae682-7d335fbcccamr151395097b3.13.1779697400727;
        Mon, 25 May 2026 01:23:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6b04:b0:7d0:3bbc:c81 with SMTP id
 00721157ae682-7d335fbcccamr151394667b3.13.1779697400112; Mon, 25 May 2026
 01:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org> <20260524-ssqosid-cbqri-rqsc-v7-0-v5-16-78d3a7ba9dbe@kernel.org>
In-Reply-To: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-16-78d3a7ba9dbe@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 25 May 2026 13:53:09 +0530
X-Gm-Features: AVHnY4I5dwBeqtX2znAoYje4xvPMK0mJtZxt7UsaZlw7JojvDtp7xcPyAAfXdI0
Message-ID: <CAB19ukE9r_V=0eop3=f8zohhnCavd=9GjDEK1VMMbOb0ReOtDA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 16/18] ACPI: RISC-V: Parse RISC-V Quality of
 Service Controller (RQSC) table
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
        Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>, linux-rt-devel@lists.linux.dev,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vDEEHlA09oSPaSUmu7eOaFMmO6MPYtrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NCBTYWx0ZWRfX/bAw7wnCi2v4
 TKg28Q4gLDfMZaOjP1JTkQVuvRqvtuOABry8cQylPWrhWTQsAADdwH9OExbAGks5mzlhEn+/VJd
 yXB0Dm4BXD7TmZnjKdKYJpUe5i63V1IzD2ZD5BpJ7aPN8E/SZrEFc8hR7nYNvgvVK6yKdBGvP5/
 HvvwZlRG0tUVcv7G8I5LUo7fjsdOdE5LS6REaucWjL4gV21fx5hPhDi7Vspj33Y+VJRM/b1q2x9
 T/ySFLGgeJiKZ1tmR0FkFBhiIkgIvQ2V63a9SWGVgn2lWIn66VVYhsUjv6PGsv3MWU5TQOTW5Wr
 nwOihJRQrNrr10FfzmRS7J5WipZD40BKXaCUGrxwgTdb6/cw10QlBwif7iFXjPL9qI9YF2t/7qc
 5ShYWtV6PYeULcDOjFD0vmVd8E3rC448Xgj14zt925lcPns4AsYSNjVcQExoApZY9K1NGTnyg5Y
 3JiAElarmE7ZeTAtOpQ==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a1406f9 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=V1jnuoLLAAAA:20 a=VwQbUJbxAAAA:8
 a=oLomzfTcYbT1FT28YPsA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: vDEEHlA09oSPaSUmu7eOaFMmO6MPYtrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250084

Hi Drew,

On Mon, May 25, 2026 at 5:32=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add a parser for the ACPI RQSC table, which describes the CBQRI
> controllers in a system. For each table entry, populate a
> cbqri_controller_info descriptor and hand it to the CBQRI driver via
> riscv_cbqri_register_controller(). The driver owns all subsequent state,
> including cpumask resolution at cbqri_resctrl_setup() time.
>
> Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                   |   2 +
>  arch/riscv/include/asm/acpi.h |  10 +++
>  drivers/acpi/riscv/Makefile   |   1 +
>  drivers/acpi/riscv/rqsc.c     | 194 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/acpi/riscv/rqsc.h     |  63 ++++++++++++++
>  5 files changed, 270 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7821dd5159cb..eab31c7b5e91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23025,6 +23025,8 @@ S:      Supported
>  F:     arch/riscv/include/asm/qos.h
>  F:     arch/riscv/include/asm/resctrl.h
>  F:     arch/riscv/kernel/qos.c
> +F:     drivers/acpi/riscv/rqsc.c
> +F:     drivers/acpi/riscv/rqsc.h
>  F:     drivers/resctrl/cbqri_devices.c
>  F:     drivers/resctrl/cbqri_internal.h
>  F:     drivers/resctrl/cbqri_resctrl.c
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 26ab37c171bc..3cfd0102085e 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -67,6 +67,16 @@ int acpi_get_riscv_isa(struct acpi_table_header *table=
,
>
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_=
size,
>                              u32 *cboz_size, u32 *cbop_size);
> +
> +#ifdef CONFIG_RISCV_CBQRI_DRIVER
> +int __init acpi_parse_rqsc(struct acpi_table_header *table);
> +#else
> +static inline int acpi_parse_rqsc(struct acpi_table_header *table)
> +{
> +       return -EINVAL;
> +}
> +#endif /* CONFIG_RISCV_CBQRI_DRIVER */
> +
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 1284a076fa88..77f8f0101b7e 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y                                  +=3D rhct.o init.o irq.o
> +obj-$(CONFIG_RISCV_CBQRI_DRIVER)       +=3D rqsc.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      +=3D cpuidle.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)            +=3D cppc.o
>  obj-$(CONFIG_ACPI_RIMT)                        +=3D rimt.o
> diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
> new file mode 100644
> index 000000000000..1cbc5c07e191
> --- /dev/null
> +++ b/drivers/acpi/riscv/rqsc.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "ACPI: RQSC: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/riscv_cbqri.h>
> +
> +#include "rqsc.h"
> +
> +#define CBQRI_CTRL_SIZE 0x1000
> +
> +int __init acpi_parse_rqsc(struct acpi_table_header *table)
> +{
> +       struct acpi_table_rqsc *rqsc =3D (struct acpi_table_rqsc *)table;
> +       struct acpi_rqsc_node *end, *node;
> +       int num_controllers =3D 0;
> +
> +       /*
> +        * Reject revisions newer than this parser was written against.  =
A
> +        * future revision could extend the fixed RQSC header before the
> +        * first node, which would shift the resource subtables and cause=
 the
> +        * sizeof(*node)-based offset below to point into the wrong place=
.
> +        */
> +       if (rqsc->header.revision !=3D ACPI_RQSC_REVISION) {
> +               pr_err("RQSC table revision %u, expected %u, aborting\n",
> +                      rqsc->header.revision, ACPI_RQSC_REVISION);
> +               return -EINVAL;
> +       }
> +
> +       /* Reject tables shorter than the fixed RQSC header. */
> +       if (rqsc->header.length < sizeof(struct acpi_table_rqsc)) {
> +               pr_err("RQSC table truncated: length %u < %zu, aborting\n=
",
> +                      rqsc->header.length, sizeof(struct acpi_table_rqsc=
));
> +               return -EINVAL;
> +       }
> +
> +       end =3D ACPI_ADD_PTR(struct acpi_rqsc_node, rqsc, rqsc->header.le=
ngth);
> +
> +       for (node =3D ACPI_ADD_PTR(struct acpi_rqsc_node, rqsc,
> +                                sizeof(struct acpi_table_rqsc));
> +            node < end;
> +            node =3D ACPI_ADD_PTR(struct acpi_rqsc_node, node, node->len=
gth)
> +       ) {
> +               const struct acpi_rqsc_resource *res0;
> +               struct cbqri_controller_info info =3D {};
> +               int ret;
> +
> +               if ((void *)node + sizeof(*node) > (void *)end) {
> +                       pr_err("truncated entry at end of table, aborting=
\n");
> +                       riscv_cbqri_unregister_last(num_controllers);
> +                       return -EINVAL;
> +               }
> +
> +               if (node->length < sizeof(*node)) {
> +                       pr_err("malformed RQSC entry: length %u < %zu, ab=
orting\n",
> +                              node->length, sizeof(*node));
> +                       riscv_cbqri_unregister_last(num_controllers);
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * Without this check, a node whose length claims to exte=
nd
> +                * past the end of the table would advance the loop curso=
r
> +                * past `end` and silently terminate.  Flag the corruptio=
n
> +                * explicitly so a malformed firmware table cannot trunca=
te
> +                * the controller list without noise.
> +                */
> +               if ((void *)node + node->length > (void *)end) {
> +                       pr_err("RQSC entry length %u overruns table end, =
aborting\n",
> +                              node->length);
> +                       riscv_cbqri_unregister_last(num_controllers);
> +                       return -EINVAL;
> +               }
> +
> +               /* GAS must describe system memory. ioremap() consumes it=
 later. */
> +               if (node->reg.space_id !=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)=
 {
> +                       pr_warn("controller has unsupported address space=
_id=3D%u, skipping\n",
> +                               node->reg.space_id);
> +                       continue;
> +               }
> +
> +               /* Address 0 would map page 0 (reset vectors, SBI, boot R=
OM). */
> +               if (!node->reg.address) {
> +                       pr_warn("controller has zero address, skipping\n"=
);
> +                       continue;
> +               }
> +
> +               info.type =3D node->type;
> +               /* RQSC v0.9.2 section 2 Table 2: 12-byte GAS-format regi=
ster interface address */
> +               info.addr =3D node->reg.address;
> +               info.size =3D CBQRI_CTRL_SIZE;
> +               info.rcid_count =3D node->rcid;
> +               info.mcid_count =3D node->mcid;
> +
> +               /* See CBQRI_MAX_RCID/MCID in <linux/riscv_cbqri.h> for t=
he rationale. */
> +               if (info.rcid_count > CBQRI_MAX_RCID) {
> +                       pr_warn("controller at %pa: rcid_count %u exceeds=
 CBQRI_MAX_RCID %u, skipping\n",
> +                               &info.addr, info.rcid_count, CBQRI_MAX_RC=
ID);
> +                       continue;
> +               }
> +
> +               if (info.mcid_count > CBQRI_MAX_MCID) {
> +                       pr_warn("controller at %pa: mcid_count %u exceeds=
 CBQRI_MAX_MCID %u, skipping\n",
> +                               &info.addr, info.mcid_count, CBQRI_MAX_MC=
ID);
> +                       continue;
> +               }
> +
Do you also want to add a check for the statement in the spec "At
least one of RCID Count or MCID Count must be non-zero." ?

> +               if (node->nres =3D=3D 0) {
> +                       pr_warn("controller at %pa has no resource descri=
ptors, skipping\n",
> +                               &info.addr);
> +                       continue;
> +               }
> +
> +               /*
> +                * Resources follow the node header in-line. Only res[0] =
is
> +                * consumed. Bound it against end before reading its pref=
ix so
> +                * a table that ends partway through a resource subtable =
is
> +                * rejected rather than read past the mapping.
> +                */
> +               res0 =3D (const struct acpi_rqsc_resource *)
> +                      ((const u8 *)node + sizeof(*node));
> +               if ((void *)res0 + sizeof(*res0) > (void *)end ||
> +                   node->length < sizeof(*node) + sizeof(*res0) ||
> +                   res0->length < sizeof(*res0)) {
> +                       pr_warn("controller at %pa: node too short for re=
source descriptor, skipping\n",
> +                               &info.addr);
> +                       continue;
> +               }
> +
> +               if (node->nres > 1)
> +                       pr_warn("controller at %pa has %u resource descri=
ptors, using first\n",
> +                               &info.addr, node->nres);
> +
> +               /*
> +                * id1 is u64 on the wire but cache_id and prox_dom are u=
32
> +                * downstream (PPTT cache_id, ACPI proximity domain). Rej=
ect
> +                * rather than truncate, so a too-large id is not silentl=
y
> +                * mapped to the wrong PPTT entry or NUMA node.
> +                */
> +               if (res0->id1 > U32_MAX) {
> +                       pr_warn("controller at %pa: id1 0x%llx exceeds u3=
2, skipping\n",
> +                               &info.addr, res0->id1);
> +                       continue;
> +               }
> +
> +               /*
> +                * Pair the QoS controller type with the resource descrip=
tor
> +                * fields that index id1.  RQSC v0.9.2 Table 4 defines th=
e
> +                * mapping: a Capacity controller indexes a Processor Cac=
he
> +                * via PPTT cache_id, a Bandwidth controller indexes a Me=
mory
> +                * Range via SRAT proximity domain.  Mismatched pairings
> +                * (e.g. a CC whose first resource is Memory) would other=
wise
> +                * route id1 into the wrong downstream lookup.
> +                */
> +               switch (info.type) {
> +               case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +                       if (res0->type !=3D ACPI_RQSC_RESOURCE_TYPE_CACHE=
 ||
> +                           res0->id_type !=3D ACPI_RQSC_RESOURCE_ID_TYPE=
_PROCESSOR_CACHE) {
> +                               pr_warn("CC at %pa: resource type=3D%u id=
_type=3D%u not (cache, processor cache), skipping\n",
> +                                       &info.addr, res0->type, res0->id_=
type);
> +                               continue;
> +                       }
> +                       info.cache_id =3D (u32)res0->id1;
> +                       break;
> +               case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
> +                       if (res0->type !=3D ACPI_RQSC_RESOURCE_TYPE_MEMOR=
Y ||
> +                           res0->id_type !=3D ACPI_RQSC_RESOURCE_ID_TYPE=
_MEMORY_RANGE) {
> +                               pr_warn("BC at %pa: resource type=3D%u id=
_type=3D%u not (memory, memory range), skipping\n",
> +                                       &info.addr, res0->type, res0->id_=
type);
> +                               continue;
> +                       }
> +                       info.prox_dom =3D (u32)res0->id1;
> +                       break;
> +               default:
> +                       pr_warn("controller at %pa: unknown type %u, skip=
ping\n",
> +                               &info.addr, info.type);
> +                       continue;
> +               }
> +
> +               pr_debug("registering controller type=3D%u addr=3D%pa rci=
d=3D%u mcid=3D%u\n",
> +                        info.type, &info.addr, info.rcid_count, info.mci=
d_count);
> +
> +               ret =3D riscv_cbqri_register_controller(&info);
> +               if (ret =3D=3D 0)
> +                       num_controllers++;
> +               else
> +                       pr_warn("controller at %pa: registration failed (=
%d), skipping\n",
> +                               &info.addr, ret);
> +       }
> +
> +       pr_info("found %d CBQRI controllers\n", num_controllers);
> +       return 0;
> +}
> diff --git a/drivers/acpi/riscv/rqsc.h b/drivers/acpi/riscv/rqsc.h
> new file mode 100644
> index 000000000000..f7b556f29e16
> --- /dev/null
> +++ b/drivers/acpi/riscv/rqsc.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Local definitions for the RISC-V Quality of Service Controller (RQSC)
> + * ACPI table. Will move to ACPICA's include/acpi/actbl2.h once the spec
> + * is ratified.
> + */
> +#ifndef _DRIVERS_ACPI_RISCV_RQSC_H
> +#define _DRIVERS_ACPI_RISCV_RQSC_H
> +
> +#include <linux/types.h>
> +#include <acpi/actbl.h>
> +
> +#define ACPI_SIG_RQSC  "RQSC"  /* RISC-V Quality of Service Controller *=
/
> +
> +/* RQSC v0.9.2 Table 1: current revision number. */
> +#define ACPI_RQSC_REVISION     1
> +
> +/* RQSC v0.9.2 Table 4: Resource Type values for acpi_rqsc_resource.type=
. */
> +#define ACPI_RQSC_RESOURCE_TYPE_CACHE  0
> +#define ACPI_RQSC_RESOURCE_TYPE_MEMORY 1
> +
> +/* RQSC v0.9.2 Table 4: Resource ID Type values for .id_type. */
> +#define ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE     0
> +#define ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE                1
> +
Memory-Side Cache, ACPI, PCI devices missing?

Thanks,
Sunil
