Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792636000;
	b=crwqXrjNFgrswsNmvwAXfYbh+r18avA1NCWl2E5aM2l3+5QsKcXJLLTJIOd9Y/5sDnZ9
	 eRKlHxeO+UCPajXH+VXMStx0U9jqTLXa7tOJ1sn9v7CHIxzQGrwflFDgAyJDsZ4djRcoq
	 kh+sqcXuiHgL4X0hpH6GJ+NtKv5fwTXUqnjTKfgwvQZVGCk4hzIhV4DHtq9YpKbg8V9dS
	 /DCIfl6Pm8oNq1m1jtpECjtA6d4pWu5uuV/71E3wI2buuN+TU/lxpXv5ZBETTZhe6CVcZ
	 nDau1DhjqPpTLPJKtNOZiRBcxlDJlRRaChbQfZ515196JqF/vVBzbD2s9RqKrE99Mcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RkEzU0XAuh1vSOwF/onrhvMr4uvIUAAzgM9QJxDqjro=;
	b=2fs5YgaoiX1kFUtpIUKydwUjmBamfiNAfONrVMtfjYCsc1AGHxleJ1hhRguZP0PKfVEz
	 RI+FEVwhNvVJpOlO7jCiz5MED7cnJfkpLDD5ej+6evS7gqQO5Qn1NLstBZLey68vplQxn
	 vFbUapM+WWSuUjZoNrFzXhBWHW6cDa54llqAzrWqwg73PbQPlBwGb2ur65acPB08x9QSw
	 uUurOcHX8kzY6bI/NiPYDCq2gr+pq6KZl4xWCVm32fgH2gbsnfVfRvAOulwa89pyBXnR2
	 /Z9XUdustJTlehWNUUpiXYa+TYQN+GRmDgoFeuT0e0jcnf9gnl1pzmpTwHF0YsGJUQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nq1uL+F9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AA606A31A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 02:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B27AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nq1uL+F9
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so727465fac.2
        for <linux-acpi@vger.kernel.org>; Wed, 21 Oct 2026 19:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792635999; cv=none;
        d=google.com; s=arc-20260327;
        b=lcZha3HzfdHPC9NKFDK7enlzi0HX2sSWF+PiIkPgLE7VGixtslib95bOYsinOtk7UH
         c9I5iRi4oxFaZIbhbP8qWqq9VC3KQbINM28izA7ZDw1rlM19TjsNl17hHQSX08k+KVnA
         LK0LSCXkKaMDISunl/RE2DYf6lewUi41h1bOD8eXhLI12w6JtlJh8d0G4i3gosl3jsav
         UxrME48qGVWatFvUr+erX7GsE5hDbTfjO0HPTYIX4k1PyTw21WDNCuAUfudQWTq0pP/S
         X/IT5WEK1mW55p30hDVJP5gyHz3KWQ52IKtd5crI9oTuli+V4S1CAdDxMfy5xRx/yoAY
         YoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RkEzU0XAuh1vSOwF/onrhvMr4uvIUAAzgM9QJxDqjro=;
        fh=7khfBheXSdFcGi9VfpXDLNlP+JuSg/kRetVyLn34vdw=;
        b=U2ZQLTha+VHLosgMABfC2KPwre2u3carlPfKfTGw4QYsQZ3GohjMjM+epk0LlKuBdS
         YBFnD0eymNPUWIXDrrBNDuUOhyU2XBJutPcORaWzs0j7hu210VeCEhbZkZu03KXnlvAM
         yEtrEZ8pCYzFOgLwbbS/EOSQppTSU8ZfWx2vdlvI3tPmIfbJSsJiK+IM/JZ3NklPQug0
         hWzm+lTi5YRFdgRjwjdYWc4n1mWVGIlr7RJTD9PMdd/v+VfKEl6K5kG6uwfQlgFs1qvO
         PgcEItsUiVuj8AypuWvTQ+5i5ZWoh75FG8f4y2QzTYhPqT7AhNGNBz4uZiu1Otg3fLj1
         DoQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635999; x=1793240799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RkEzU0XAuh1vSOwF/onrhvMr4uvIUAAzgM9QJxDqjro=;
        b=nq1uL+F9Okn1CXc8t4yx1SbF4+JT8PrpTHkqnecA4IjbVzJJj409gqdQ+Khkji8m7N
         xXD7luovmX1tTZG92UrAOK+L3HkBnaCzTrcZJCykO/IBNse0Xpw19j5HCgj8Eoilsu1o
         FNJv0z+XYe9XXz9v3dFsZXcfiCxwf8nXiDT9hPPxJxRRsxx1NDkrvhY0wQnZR9jmTq+i
         C+yNT5smNGpJ0ivjw3ZyqmafevZBSN+9E3EoGCHqq/O3eOS7t1cfk8U+dgJPNPMBSjeG
         kZmhoUH1/30oPxszThf2xVtrA6WRUfKekQyNll14BiL9vLNiUVLio1JGM7Xtut0U5hpf
         3Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635999; x=1793240799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RkEzU0XAuh1vSOwF/onrhvMr4uvIUAAzgM9QJxDqjro=;
        b=vwHpDWs5/7K/kiQxjrt93wC1msIz8RLqL/XqhVG1/yO0NqIwPLzcnuICXnlZFlKV8T
         vMTOaVPQ1d3HIecv95k1WMXm0BR8FBKmoBz0Ne5ZUU3aCG3ht1MVCHqKWPl8/yTbyQBO
         6SChXArd/i+vQys2Y9Gp0fIzrfepej12wZjMOIrR1xiNPYdU9kILRvGJT9Tg487rMbOv
         KBtdI78QuPBxuzO9NBmpunYxs/O4TIjklNk6ww9YFuP233omzb3ulMQbFMAJVVYTS3zt
         n0U+UPqgooS0OcnzC0GlJfnBm3QStkZc67dEam6fjJQgBLC+IwW+hXditSV7FfV/pIGD
         o9Rw==
X-Forwarded-Encrypted: i=1; AKwUvBxNToKigtd2BwlHTBrvlPY/FOTvVuaye0Il7utHEc1FD9nT20hNJ6sf4lfSxM163GKMuwfII6+koWm0@vger.kernel.org
X-Gm-Message-State: AFq9FYK86UAHgxE2lCYh7hhlPqnvqPf7o+gRJjzS0Vrq1Oeg62O+zApB
	RBNcQ2MBbCny0w5FgpUX2rWunDnxJUh24rFas/s4RaY93nv2X8Y91XYfq0KYNdNbmw/oW11PJJA
	Ds7C0hVvq0d3GYdmsLbsK9z6Ha51+C2M=
X-Gm-Gg: AYBFou3x32ihQkJpD76kI+yT2J7yRWQ/4dVey5g3lXtpBpETCGZnl997jOsQQ/eTbeZ
	gmHLCHIV27tvKTkDBLD9xV6nS/8b5uFTefCQ+RErP/LMfpttSOLLBwWcOL1uj/907ZKHGYp9qS0
	kho0JN2L1lSM2lKC3qbloIulnPS6AOU2RH4ZGXBTp0/AZzytHjMreBnEE0SMHiEBFrrJHMAYZAq
	pO5dO0mBAiLV20T7KOiNxQZnfwQr71Vuv8MvlVqBjE/GICf+pqIv+mrCPKwaEbrsz2dO3iDZDt4
	9KWz4A3Mrk0RhK17otoM2hEhHuwazFYPQmTjscQ/nu1gVFrVnaQH6qCLPc/73Cwxwi9hNZRHMOa
	DbPYPtqFMeEpAFbK3rw3ZKFd01FvDu9yo18tF
X-Received: by 2002:a05:6871:714:b0:49d:c9c2:b770 with SMTP id
 586e51a60fabf-4a7dc1b09cdmr2662108fac.18.1792635998696; Wed, 21 Oct 2026
 19:26:38 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016141530.2795073-1-yaojiale02@163.com>
In-Reply-To: <20261016141530.2795073-1-yaojiale02@163.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 21 Oct 2026 21:26:27 -0500
X-Gm-Features: AclHuK-jXqJkBjkEEmv9deo3rIxZRsdXYZM_Ept_W2pqwSlhYahgFGW5jEMZIdc
Message-ID: <CABb+yY0s=eHDyW-=5++9zetFid_oVGCQkhqSWBQs+ty4Bnb-EA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: pcc: validate PCCT subspaces before parsing
To: Jiale Yao <yaojiale02@163.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 9:15=E2=80=AFAM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> The PCC mailbox probe walks PCCT entries by their declared lengths
> without checking that each entry is contained in the table. It also
> passes generic headers to type-specific parsers without establishing the
> required record size. Malformed firmware can therefore move the cursor
> outside the PCCT or cause out-of-bounds field reads.
>
> Validate the table header, each subspace range, and the minimum size for
> supported subspace types during both the counting and probe passes.
>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/mailbox/pcc.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 9888dab64639..37b2ddb44bda 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -553,6 +553,42 @@ static const struct mbox_chan_ops pcc_chan_ops =3D {
>         .last_tx_done =3D pcc_last_tx_done,
>  };
>
> +static bool pcc_subspace_is_valid(struct acpi_subtable_header *entry,
> +                                 unsigned long end)
> +{
> +       unsigned long start =3D (unsigned long)entry;
> +       size_t length, min_length;
> +
> +       if (start >=3D end || end - start < sizeof(*entry))
> +               return false;

(end - start < sizeof(*entry)) is implied by the two length  checks
below, so only "start >=3D end" is needed here.

> +       length =3D entry->length;
> +       if (length < sizeof(*entry) || length > end - start)
> +               return false;
> +
> +       switch (entry->type) {
> +       case ACPI_PCCT_TYPE_GENERIC_SUBSPACE:
> +               min_length =3D sizeof(struct acpi_pcct_subspace);
> +               break;
> +       case ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE:
> +               min_length =3D sizeof(struct acpi_pcct_hw_reduced);
> +               break;
> +       case ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2:
> +               min_length =3D sizeof(struct acpi_pcct_hw_reduced_type2);
> +               break;
> +       case ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE:
> +               min_length =3D sizeof(struct acpi_pcct_ext_pcc_master);
> +               break;
> +       case ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE:
> +               min_length =3D sizeof(struct acpi_pcct_ext_pcc_slave);
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       return length >=3D min_length;

How about something like

static const u16 pcc_subspace_min_len[ACPI_PCCT_TYPE_RESERVED] =3D {
    [ACPI_PCCT_TYPE_GENERIC_SUBSPACE] =3D
    sizeof(struct acpi_pcct_subspace),
    [ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE] =3D
    sizeof(struct acpi_pcct_hw_reduced),
    [ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2] =3D
    sizeof(struct acpi_pcct_hw_reduced_type2),
    [ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE] =3D
    sizeof(struct acpi_pcct_ext_pcc_master),
    [ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE] =3D
    sizeof(struct acpi_pcct_ext_pcc_slave),
};

return entry->length >=3D pcc_subspace_min_len[entry->type];

Cheers
Jassi
