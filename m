Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982623;
	b=KlmUy6EQbHHkCGmBWyMUjGUYfsVYQV14ye7AFmCYq79hyoRlifyDDRb1DIwuFN6SNqX8
	 y8KvMiU7IpiMMDfvZV+C/ZmjGhz1HknPtQCdGK8+mJDeQEGBL32Lrp/5dg2T9Dk5rt7qm
	 AqfZxqHlEJXNi1eOqXZ5cBZ+IO5RaaPhskMZvHxA5uIKjWMVEzI4Mgfo/bxMBjcO6dhAx
	 jhr3KNPiEBx1i5ex7tECDRJU17bYFF0oarBLH4akw9lCXeip/twij9YYL/gpxdMBs0/wN
	 zBvSRejbLzVWXSqWy1bl1BYjg0cxi3vjTCa8k4eQgguGXDBHejSkjnU8bgjjyvcm6CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
	b=E3z1l3oezU0qWkPljLYWhVk8xvemba9guRz4racMv4gYgXPeN2PpJxZpqkJ/o2lV31MQ
	 Aq4qWCAg8sNPLbRUdFKsOpL/6E1+oTfzpKW7IyJ1k6ALBjXpj16etfU3yAmhXOL4pxKxu
	 AXTnR/HZXK+3votyH7Jh+AA+3sYk1lfbgdP0AU5v/Yb82Z2T6XrFFKSq7jkC/jQJeqqUn
	 +QfdXixctZy2pbh1uwyL9zS7Y0oGSLvg3QKtstSL24KnSbehvfvxt50U22UL75PRr/PU2
	 R8orqEFhXNCgxAginZROsPgu1/TKE7dIJVp+KNWaqRmLeYOnehgS/BiJli1xV2OHRkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLWr6qql;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAED606A32E
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 16:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAED606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLWr6qql
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b305d38bafso7044027b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 08:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982622; cv=none;
        d=google.com; s=arc-20260327;
        b=DPeWC9nP3Zt5ztpnarDgv9HT7cyTnrmFAiZ/rJ/yp1A8LdKwHDdmbUfdkoREzv1sPu
         //TXyDxXL7ysOhD0jMJv2sgEFWfE+ZMaqHrCtjjmbVrK95MOkxdHUA7StXmX0TQMn5qk
         Q/pBao2H189zTVmEmpKzhK2PSpnlwcyOowuxaGE87ArcOcB8iXcfsvQtq+2+u/XJfbnp
         axxpobPGzB7H7200l/I23sm809ByDjmpKUNS4sFLXTLu6kpzTD/gNQ9LSlPaxVtLCzN9
         cPcUwYkJYsBH/2p1Oo0qVijcumsSdQofGf55fZ+q3BShgVBXLVA3Lt2DBZvcS78feVWP
         CM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        fh=Mf+88lVarrWOC+WOrXqEKeIi8ZKxDEmBfxfJ7xhFDvI=;
        b=W2y9eC0hZFgoP7jPmIQ4HSQDDo0sZ0i5JD4ysj2Y1d1KXEOx4GRimkSmRTiLZDrT69
         JBvrYVfuQOL/0gi1KA3mwVaYN12WR2ebI4Q4A19/RgbO1XWyKv1tL+4xjdFzrC1snDib
         O47EGsmEdmHBDmklUTZuIVkwGDKE4tXNkFjTAmqPB93CtMPbP90fjntwF8DSXuXeaQux
         FxEiXaQ6EYu2bQoYFZyUK1MEjTkXp5CaQAcg+T2mttuy9lQH5Bcrk1A7wvwDMLsWmqZZ
         YjXajJG2ksTUxoGx5yM5wP5ZcIeZu3YfBH2IRYLZzBHVwCQDaPPilGJSIZ+eKVNK26xF
         pwOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982622; x=1794587422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        b=wLWr6qql15sYV7yiDKmkPjELYkTZb/66URjn1f3hxyT0hfMfrTHYj6R9jF4Jg2Z/T4
         JX0m1zI3ekCQKQM5FjcxDA2mIZkzQvOAuT7mctFngOk+DqyjFnBnWOCNocsox+V1XC0s
         YGzT4jWsYWF/m7bzwuHjF6gNzCRxKJN90QvgGaAixCTtvmf/6nMu47piDMfMxMKWvRpe
         Ecv/PmkSSAC5ntPknEXG7I+vIME/9hd+gU2CkNsQJPMF9H6h6PqZ4Ev2dxOWq7LQoCCZ
         ECuDOxENpMvmipGcC4aJfcqe+xwrM61m//apdM/wFpvlOZabhnsXSIYmB6TkdVXgAhrq
         Szow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982622; x=1794587422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        b=OolEo48U06PXuo2nXt7g9LVXfz27InjQcYNTIQ4yFIgJfHVs78FAg2L0E1aAHVusPQ
         jc6/xZFL0e/MAVTxI6PPzVRCVvRy1viYo7WQa5i34SKn9+bvdguVdzun1lyq+4KjugJk
         q0uJPm4L9oP+NgNSo99IV3f2gD/Uvv6aaZA66AwPHP/WxeAvul5XRh5qBPLHd/jS9uQ8
         ZhVInd54J+9OW+4EzjkwAuPJkXHG6kHYH58mXFivH8bCJ2b7wAPLZya1sW4nK3JDCyho
         SefJ+gniT48vWq4Z0XYwuqZZhuYqD3w+YZ83dNYB6NwdA4unfZOLqFNV9biXXEat05bX
         K/kQ==
X-Forwarded-Encrypted: i=1; AL+hErEBOWsLTLOEUqJkJpRsY5nnjLrURDFTWCIa26+XPIOIYv6QhMPtRSnwTUkLiEqr8Vochn8hwCDXZ+EW@vger.kernel.org
X-Gm-Message-State: APuU4Z94u3vlqh7DEXiTQBLgK9RygMBqngMlhDOTXkkG68GdSsqXLhdP
	q7GWsUU4A1yEaid2ctyBDJ1j+cLb8GS5j0HrRJGJMaWwEkmJkUjOKRJ3vjRgaQjTrXEOSU4uN7R
	HWmukJh6lMRP5sT7qRN3zZVs1pQ/JHhs=
X-Gm-Gg: AYBFou3YsAggsouJoK6NlsCAC7wbrQ6Ds8aTOvNz5AMKyVXBHDQ86DfpfDe7fje4PHB
	NN/cXRFNrcqbNU/AoAGXKqykDEQdXtNTCjHebjzAXXwGn6JARwIy7uefkHXtREurWNwHaHs0wIv
	D2TmqJS+viA5s3BpgoLB2sYp2od1WHdsAn6d3mx0wr8bSt3UMVW/Ofrl0NHxxd42Ec36G7p/Zi4
	6rqD+vdziJnRuINEmlwLmmJQ0jDrIvsXazAgy/qGG8iLV+bSAu1XEePizh45WibhCB2r5+Rh+uw
	JYGQLLnDiFbszjAxiye5o8w2UNE5awHczOxIDeL5+uVK1Az/ulvIwbpFtBy5aIUssEDodLwEUOF
	/XeEBIikC9Ju49V8aRAqep03ZixYJrRmdD3rTAwk7SljqDRoTavIdKL9/TTHXVldjIZEaVXqAl7
	8665mA9GcdW2jayRcVbC+3xowNBvDsrJtGpZMuVdvP3bYIlTMwCqK/PfFYYLlo4VADrYt4+nqyE
	J5uKjwruA==
X-Received: by 2002:a05:690c:a006:b0:8ab:3918:33d9 with SMTP id
 00721157ae682-8b341b65b54mr16819607b3.61.1793982621872; Fri, 06 Nov 2026
 08:30:21 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
In-Reply-To: <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 6 Nov 2026 08:30:10 -0800
X-Gm-Features: AclHuK8v0JSVhaJAzidw4U6zc9uGSHU7HDuopjMhviWvbGm_U0W3rhAX7PpRRzM
Message-ID: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Allen Pais <apais@microsoft.com>, 
	"rlmenge@gmail.com" <rlmenge@gmail.com>, 
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 13:27, Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> > [You don't often get email from sidchintamaneni@gmail.com. Learn why
> > this is important at https://aka.ms/LearnAboutSenderIdentification
> > <https://aka.ms/LearnAboutSenderIdentification> ]
> >
> > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > in acpi_apd.c.
> >
> > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > the controller's actual 300 MHz clock.
> >
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
>
> Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
>

Thanks!
Do I have to respin the patch?

> > ---
>  > Cc: Jarred White <jarredwhite@linux.microsoft.com>
>  > Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
>  >
> >   drivers/acpi/acpi_apd.c                     | 6 ++++++
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > index 9fc667d6776c8..a1baa056931c4 100644
> > --- a/drivers/acpi/acpi_apd.c
> > +++ b/drivers/acpi/acpi_apd.c
> > @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
> >          .fixed_clk_rate = 200 * HZ_PER_MHZ,
> >   };
> >
> > +static const struct apd_device_desc msft_i2c_desc = {
> > +       .setup = acpi_apd_setup,
> > +       .fixed_clk_rate = 300 * HZ_PER_MHZ,
> > +};
> > +
> >   #endif /* CONFIG_ARM64 */
> >
> >   #endif
> > @@ -272,6 +277,7 @@ static const struct acpi_device_id
> > acpi_apd_device_ids[] = {
> >          { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
> >          { "LECA0002", APD_ADDR(leca_spi_desc) },
> >          { "LECA0003", APD_ADDR(leca_i2c_desc) },
> > +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
> >          { "NXP0001", APD_ADDR(nxp_i2c_desc) },
> >   #endif
> >          { }
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/
> > busses/i2c-designware-platdrv.c
> > index 1da6b0314b6a0..f359d38cc63c7 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -280,6 +280,7 @@ static const struct acpi_device_id
> > dw_i2c_acpi_match[] = {
> >          { .id = "INT3433" },
> >          { .id = "INTC10EF" },
> >          { .id = "LECA0003" },
> > +       { .id = "MSFT0006" },
> >          { }
> >   };
> >   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> > --
> > 2.45.4
> >
>
