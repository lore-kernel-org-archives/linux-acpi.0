Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB215ECCC
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402477; cv=pass; b=dt0vPx2c4VeN/aJGQPqyA71dNrth3JWmaQ46ORM2pPCs9Ktrue3ml6DoJ0rV0Ql/9YtDVBSa/NbsOuJEqDCxrKIJjafuvQ29FBhvEIysIHUNPUxZbDPwb0rmWYjRT8pzZN+QNJ5n3PGT9MfoaMZ5xR3BHwBoRY5EFnHhmtHW4K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402477; c=relaxed/simple;
	bh=rdSvCP52jZz7SDxDuWHrEpzIrkFP71B3BSjjo54bZpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE0y4yh9ea0SPhID+XhhrRNWhGqOGDGfKHD1Yx251XdnJVHGqhoiEyITcd+GmZ2w7Qa0EbPo2ix97KRWU90vVBKKwwiY9fMmHRxzzu+De13ikzzdp79sab/yL2edKdr6Z32EirfO6OTfuWM9OwlRHHdz8H6YRKSmic7xVFji2Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WBenOCrX; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WBenOCrX"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7eb85fb81so2102498a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 18:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402474; cv=none;
        d=google.com; s=arc-20240605;
        b=LvxU7yIQ2xyqzP/D+V2R3nGEaKo/RcYwzHwWn0G9jip30KiRKpnIuGTJQaCb637Omi
         ywWVjc2A9V1/Gkiid0shhj6UCoQt1xo/8TQTBD3Hl+zUxIiUOLHMg0px2i2yaNv3UGjS
         sADbo6nCA+DQbzTLqnnYlNdFbIzvesxy4cCD/zNFpiHpIehD1FQY3rIK116FMv7i/E/D
         dOlOeJ3uh21sDyEShVV5qYkeKGpBNfWMwngq/DuiTcdk47Cza4Z7Ne97vUimfcXpshnE
         yhxRHVDs2IReGBA1hqbBmDpw2oCBuCmW728Mm9A2c7mACF4gd9Nsfv5VOb6gx7Sqsz0L
         2YzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        fh=zMM9oAttF52vc/wC00zV87kHO1fUdog9fk8JSwH+VEg=;
        b=izJfIKLUIO6X6l6H5Rh9lGWUr/uUycJAv+LosDx0j2WAeUEtoCg5mK9BTWh9raojgW
         0NzrOIwdBos1lnZOlrZ0Nta1AADl16IKLPMVpGSdfHUPZ4E9MHOBNE5HkEMZyLCJ51v/
         6W4wUMQisYSJpi4xh7ZnOVXlNyLwsF3W4U/vKnYlpXyq71JR822Ds9TVq33jHabVC1PJ
         h6txjoe6cQ9xK0ducTsHzIwjKT/IJ4W8+3gUBvH0fRWEWgoOntuOnWdbnDQDTJrY7dJO
         CQnizCQyLw5ZPVm3Vis6Ck1oAngQlT0y8jX40toC2s6k+Qs+RPrYEGtO6hvI05l5AFzT
         Vd/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774402474; x=1775007274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        b=WBenOCrXnoa+h7DNAg7AN2od2WNw2ODn5uiVHl32LOAk0cJLIKcbtJyrp4oYobz66k
         htENFHrNOd2XjwYiFc0Gi0gBmTNrNLCv9C6M2EW+auQketqk9cN64XXLIwsXXfClITUY
         lYm0G5W2feJy+7bnDXg1N3UY9BtRyr66HJ87kFBI+M8q8lU/Gu0dTXXzCdTKIH2e4wi6
         Hv7GWTaEOz1637xSBZHxIODGbbwQE3ZeNiVr6FlCf1asE2A7U1E+8Dw4aY0xBon9AU8n
         OwBwHLgNMwMp6d5OTG3WhyHTQsOLBRtaQtDkcLC7YnsYIVokw4lnD0fdtWPs/r1RMA0u
         FJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402474; x=1775007274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        b=PwgQdP7uDvVAV1mmwFCcSet2TmLaIXDbAHYUYKsUo/bclKB3D4SwL/oZ8h1tvxEv4P
         vpt93Ck/b4y8pW3VqwlZz2axkWbOuhC9pq/g6ML69Gt3v8bb2Tc0OE4agq9wjbqmgQ4G
         vGR4ElAfcp4lLvAJWVo8wh6I1a1sKFKB1dIomzSgylacs3BFUbIwkzk92qCLL6XJ/maB
         Vc/YrtWKVWWkGCgwQG4OsxBWlavQdIXvE0j2P3TYoMiYuuyKkp5hMVBpBMCgQrPwxncw
         jFzt0rQ0mXjGtOBr7mAYiWrUAOIuug0upAeheyFaKgYSoV1Toc9JEPSMvcX2rX49UJiu
         rHKg==
X-Forwarded-Encrypted: i=1; AJvYcCVfewQvyYwfLZ8R77t3kygguQik/LPBkOul9LPpZcXo2AGA3NfgpQ8yfgLHDwBca1x8A7iP5jCX6Y8X@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDUo+WKPo1GAIFvIV+VXtkTyQv2PxbgBEAaNPE2/+zUSIIUr6
	ZJX6LbK0Ew/unAxHxn69qrvkiBToyw5P9tseTh7iGrjWrG+q4Z0cBagHyPUQHUwrxZrfj1MahYc
	MRAs2X6qucbVJKnWmUixiM2gcrLm9jktQVGJ1aolgXw==
X-Gm-Gg: ATEYQzyk1cGJY394xuKAXdSje12DnlbjALtrhwJ5Hdr/opoE2riYToC6IW/8dnHv16E
	cYGfJ6qYvNkDGOCWyqE7dxGEtCrukYvOhLBeTUBoNooNyIsaeyGTE69Br+qZzfNKcBxEvq0X1Nq
	bXynkkXJ80MtZ5E/czZBC5ZqRnOFN3b9E5/ZjY41a9GuPClpJfxzhX0/6cuPxgUTLjr3SxB0huR
	O/Ga2FArI2NdpVIQUhS3mm98etMYiUNVS7iEiCCJ79wFtn4PFR3Ikfx5IwDMQImxNLFOVgsWKxK
	4Y/pvZnppyOe+E0gkW6Pb/hj
X-Received: by 2002:a05:6808:1786:b0:467:254:ba8 with SMTP id
 5614622812f47-46a5c559a3fmr976022b6e.11.1774402473754; Tue, 24 Mar 2026
 18:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-13-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-13-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 09:34:22 +0800
X-Gm-Features: AaiRm50-EQhX5eRfy8n3fhONNShK5GtzIxF13pcKegKveCXY8vae28POGPRFJcE
Message-ID: <CAEEQ3wka26n8koB3tErRE=rgE1Bxnn7PDCjnXp2j67gdkp-=Zg@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 13/17] acpi: pptt: Add helper to find a
 cache from id
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
> Add function to find the pointer to an instance of acpi_pptt_cache.
>
> find_acpi_cache_from_id() is based on find_acpi_cache_level_from_id()
> from commit c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID") in
> the morse/mpam/snapshot/v6.14-rc1 branch.
>
> TODO: find_acpi_cache_level_from_id() has changed since then so this
> function should be updated. In additon, there may be a simpler way for
> acpi_parse_rqsc() than adding this function to get a pointer to
> acpi_pptt_cache.
>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/acpi.h |  8 +++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..d1002673dc39 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -1063,3 +1063,66 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_=
id, cpumask_t *cpus)
>
>         return 0;
>  }
> +
> +/*
> + * find_acpi_cache_from_id() is adapted from find_acpi_cache_level_from_=
id()
> + * introduced by c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID=
")
> + * in the morse/mpam/snapshot/v6.14-rc1 branch.
> + *
> + * TODO: find_acpi_cache_level_from_id() has changed since then so this
> + * function should be updated. In additon, there may be a simpler way fo=
r
> + * acpi_parse_rqsc() than adding this function to get a pointer to
> + * acpi_pptt_cache.
> + */
> +struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id)
> +{
> +       u32 acpi_cpu_id;
> +       acpi_status status;
> +       int level, cpu, num_levels;
> +       struct acpi_pptt_cache *cache;
> +       struct acpi_table_header *table;
> +       struct acpi_pptt_cache_v1 *cache_v1;
> +       struct acpi_pptt_processor *cpu_node;
> +
> +       status =3D acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_pptt_warn_missing();
> +               return NULL;
> +       }
> +
> +       if (table->revision < 3) {
> +               acpi_put_table(table);
> +               return NULL;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               num_levels =3D 0;
> +               acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +
> +               cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id)=
;
> +               if (!cpu_node)
> +                       break;

break or continue?


> +               num_levels =3D acpi_count_levels(table, cpu_node, NULL);
> +
> +               for (level =3D 1; level <=3D num_levels; level++) {
> +                       cache =3D acpi_find_cache_node(table, acpi_cpu_id=
,
> +                                                    ACPI_PPTT_CACHE_TYPE=
_UNIFIED,
> +                                                    level, &cpu_node);
> +                       if (!cache)
> +                               continue;
> +
> +                       cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_=
v1,
> +                                               cache,
> +                                               sizeof(struct acpi_pptt_c=
ache));
> +
> +                       if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +                           cache_v1->cache_id =3D=3D cache_id) {
> +                               acpi_put_table(table);
> +                               return cache;
> +                       }
> +               }
> +       }
> +
> +       acpi_put_table(table);
> +       return NULL;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fbf0c3a65f59..fee6a5059a46 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1546,6 +1546,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu=
);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)=
;
>  int find_acpi_cache_level_from_id(u32 cache_id);
> +struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id);
>  int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
> @@ -1570,10 +1571,17 @@ static inline int find_acpi_cpu_topology_hetero_i=
d(unsigned int cpu)
>  }
>  static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>                                                      cpumask_t *cpus) { }
> +
>  static inline int find_acpi_cache_level_from_id(u32 cache_id)
>  {
>         return -ENOENT;
>  }
> +
> +static inline struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_=
id)
> +{
> +       return NULL;
> +}
> +
>  static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
>                                                       cpumask_t *cpus)
>  {
>
> --
> 2.43.0
>

Thanks,
Yunhui
