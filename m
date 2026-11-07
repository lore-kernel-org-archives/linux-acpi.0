Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794012268;
	b=b9NcGvgJKW6BCihD1ahg9HR3Yt3/y6MqRcbkefYqTeSG1/oLQqNyT2Gs+FJ7ef251oXY
	 LHc6lQwcQmec7xIyLwwE97pKOPdhL9F5zLdsgrlFWDPJJi2q90X+gUwh+rt8YMs9HCTnh
	 oPpgb6tExOSyu74NN9OHkfQntpWM48gFjvwZLcdJ1upzP5GBk+hv6oyjkjQXkvsiL72kK
	 QbnYehkqqRuu1dQI1FTiezJSghSOXl+NUzsTFj/w2kX3eO9g5yYVPw9hMTfGhZxFukdwE
	 c3hsjUf3uUz6yMWqkS5JKdwqJjQudZBy21Gt0F5GD8v6No7a0hc0LGGMYBBxoNGybrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
	b=PtioFRAMkxMtRxzayV0eSw484TQ852U3A6iPFfVSV9nLy4IBfI9IrRdWkqFTvOt5ZITW
	 qJDDZUVhrt6pJfPKO5KzkCPD4ACvyTCV2uAaHxqbsN/b4NRbg0fIvEF6qOuTTPK3moqnp
	 WBJpZgFU1DeMNCpJmC0ET8OD75wuOjOV6PUQBsA7ThYG70pYRx7ANWN1CwaczGMboSxvN
	 IGSZkxLH026iGfIDaheVyMkZ289lbTrM7NRrYak42+mIYlASeJdCejwjgJni94XXBUZeo
	 1bYnjWcaXZ77DtgG9GmGph189DVXBRrPSru6Zq3lmrbqGdZP3G6VVK8ygtT4PUUXq6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOiLZodl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9D606A32C
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 00:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD9D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOiLZodl
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b32daac9d7so1825877b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 16:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794012267; cv=none;
        d=google.com; s=arc-20260327;
        b=FoCk+LOqSQa9t5S3N4OdZpJDuuaQtu7idhVRMxLTCWB2wvDY3R2iEjWHPRZg0RC+Qe
         FgCTf22AwBM8fx1XjEAj3ELQq1bF0i+rdOROef2mat6990P94sws/9fvgqjcIvfOEFEr
         wUpNX3oegIVGJ+Z9c6A+bfKATNTOj/TSqCCKT5Laai1Hg0pN1N9ppEQgkYzJA2NDK1gC
         6+s2jlPVCk5MkZMM/66Yqe8qZSiDqczbjio9aOJWPYXUzVjMZjO+szSnnmQKnTomwFMt
         vvYeKpHufEzilooXILgnNNkSNCXVsvdcvAk9IephsZnV+j6xYLydNgkfUp+xx3LARO+i
         5QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        fh=rsidluMiD02w7xm45F9JPGNSKez8I1Pye0fD3Fe16zI=;
        b=lsdmm35zB7T3+Sg/8M1D+DKWSK5IMdJQcnVju4nE/KSwUNKjrSUNv9OCq2FWW1wQ/7
         HdX2b7PHgPOedSFK8NF5vm8gqFFHSkUC2xBqPToOlsLlHxpPpwJKeonTyWS4sj3+q6zj
         vjueqJPxCka1Y1pZTjLKntpGfHKfRJEZiH95iIR1KJrPlzUeOypm3Bn9ouNewP6ZP5O2
         XD5LUmsk5I38u5xBCOkm7ZImhoNYtiPt/F1caaW+pjhvydSGH9ydqLVoLMlX9JfLzV0k
         piySqwqV732ANdkVyVf005uzqhU2HAAx723URlQMFtbVlM22T87a2ddVeKk72PloBhf2
         tOog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794012267; x=1794617067; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        b=nOiLZodl15ocN+6iPF96n7YgQF16GvHtJCdXQpeUJ+at04+nc5dH5YSLMve7zunCNR
         ySvKXv/yTNJ/9IhuisdrAm5RXeLq9yGCKc7NLECfVd2bq1U+YFjONLwTsHJMM/Vx76AM
         /9J/fEnHkLMoBF54qQGcaub3pxzcWGNQm+hDwtl0syhIO1zDwDXoX4QI63NtWabBixMb
         gwn1yD+iwB/4y9RUkLUBI+YFkzrdo/CVm/VMdXwicheAWG88N4ZPVXzLrZlPr/tM9Bw/
         IVTu5LFLgYh1uEbsdyrFi5FA7gJkpmfWL9/TWxlX06RjuVl8a19PwWiLWkGo4cXBbr+b
         89dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012267; x=1794617067;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        b=ducu3fZ97+5zUwLQq9QQD3qtNCGJVjj2Ra4dD/v5BRh5nWlnTg9sF0lhwpEK0Pta/I
         1MlK6DUNWYGS8OTT30z/9LUHIQJztFSIbQU0EEXXtFs2wZg7fXdPUxHodrKwaxQ1eHxx
         7x/GImgaNFgmTFkQaogct2/23QxSJImqAwDYU5/z2akyB1y96FFKXCoAguUJlgfUDhkl
         r2vfnOsVqv3e8JACrFp1G70QQKTtzMrowJmzx9CFoq5rt8E83RTF8+Wk/GLdF5G5UvAU
         0fT4HL5rrrRQAEXOVKraVUqel7fhiQwsQ6ARdji7zyu2D00w4HDv3Uyb1PehUiNkmp68
         BsyQ==
X-Forwarded-Encrypted: i=1; AL+hErEqKpHnLrQhlMrjhOCGaW0J97itF5qBN9DtJZGuzUHObcDaB4h0nB+CucTHmMw+GkaCYqaE0mDsA8ae@vger.kernel.org
X-Gm-Message-State: APuU4Z8c0aDZIAmG2pzh8KBHbK+ydvKji8g5PZDj0R2Tjy26iaXj4ZH6
	j9QonYMwb3N3qtC8En1jUA6S0vI9n84TLlND3Xe35TVx3RIYYb7Kdih1g8AB+PB0niXlzwOgPSW
	s0SqBzawcgrz6JRiKdjsiqjKhXg/qHRU=
X-Gm-Gg: AYBFou2WDJtV9UcC35Vauud2jyFYJGu7SUuEZEbE1Os0arZ8C9STPBAen2PZzNEJhTI
	dc2fcxpqx6ic+kXOzfebi+48Dcc7AIuRRcVtwswxLVbvGgSVEXq2Ttr80tj/D+gVVXqaxhG25TD
	JbWwRSFdAlxa0PR6HcJ/9uE5cbpCLApwAtGvb35VIv8QYRhao4Ir44rbFL93Lga4v/l1GuyGnVS
	bpKoOCBAfMOBW6Z9fr8YfK3rE+PkLCDHKGeFq679hNgphczqaUR4zLmi1mBXI8W+fLTeWrgjcq+
	/ReOKyrh64gzALtvbBoMOudy28RsT2/GUJIkYWloHbRIVeE1dzS5yBFrzWSwsbBA3T0dCowkDwP
	p8rxHjFUieSEQaxk9X6Bm2KKZ1YdixjgoCjdGAhUSv+ZDGo+CHtuQuRthXoQ255dzc7k6gRJMUg
	fKsZcicPzwyGqXtx1PDV25RlasF1sMnpfOO7pgeB0uZj3IJK83SudKJTubPnN1/I4tDDIxJoqru
	EVH++UZqw==
X-Received: by 2002:a05:690c:e184:20b0:8b3:310:244a with SMTP id
 00721157ae682-8b3566382bemr2930967b3.9.1794012266766; Fri, 06 Nov 2026
 16:44:26 -0800 (PST)
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
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com> <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
In-Reply-To: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 6 Nov 2026 16:44:16 -0800
X-Gm-Features: AclHuK9IwxmZ3zJg_UWR4NgkA_z56Ff8mEcKQ6deQjlglJnLrk3UFQi4VN7saZA
Message-ID: <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
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

On Fri, 6 Nov 2026 at 08:30, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Thu, 5 Nov 2026 at 13:27, Jarred White
> <jarredwhite@linux.microsoft.com> wrote:
> >
> > > [You don't often get email from sidchintamaneni@gmail.com. Learn why
> > > this is important at https://aka.ms/LearnAboutSenderIdentification
> > > <https://aka.ms/LearnAboutSenderIdentification> ]
> > >
> > > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > > in acpi_apd.c.
> > >
> > > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > > the controller's actual 300 MHz clock.
> > >
> > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> >
> > Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> >
>
> Thanks!
> Do I have to respin the patch?
>
> > > ---
> >  > Cc: Jarred White <jarredwhite@linux.microsoft.com>
> >  > Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
> >  >
> > >   drivers/acpi/acpi_apd.c                     | 6 ++++++
> > >   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> > >   2 files changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > > index 9fc667d6776c8..a1baa056931c4 100644
> > > --- a/drivers/acpi/acpi_apd.c
> > > +++ b/drivers/acpi/acpi_apd.c
> > > @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
> > >          .fixed_clk_rate = 200 * HZ_PER_MHZ,
> > >   };
> > >
> > > +static const struct apd_device_desc msft_i2c_desc = {
> > > +       .setup = acpi_apd_setup,
> > > +       .fixed_clk_rate = 300 * HZ_PER_MHZ,
> > > +};
> > > +
> > >   #endif /* CONFIG_ARM64 */
> > >
> > >   #endif
> > > @@ -272,6 +277,7 @@ static const struct acpi_device_id
> > > acpi_apd_device_ids[] = {
> > >          { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
> > >          { "LECA0002", APD_ADDR(leca_spi_desc) },
> > >          { "LECA0003", APD_ADDR(leca_i2c_desc) },
> > > +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
> > >          { "NXP0001", APD_ADDR(nxp_i2c_desc) },
> > >   #endif
> > >          { }
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/
> > > busses/i2c-designware-platdrv.c
> > > index 1da6b0314b6a0..f359d38cc63c7 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -280,6 +280,7 @@ static const struct acpi_device_id
> > > dw_i2c_acpi_match[] = {
> > >          { .id = "INT3433" },
> > >          { .id = "INTC10EF" },
> > >          { .id = "LECA0003" },
> > > +       { .id = "MSFT0006" },
> > >          { }
> > >   };
> > >   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> > > --
> > > 2.45.4
> > >
> >

Andy,

For Cobalt, the firmware exposes the designware input clock frequency
through the ACPI HCLK object.
Is there an existing way to retrieve or configure this clock frequency
through the ACPI tables, rather than hardcoding it in the driver?
Although the frequency is currently constant, it could change in
future hardware revisions that use the same ACPI HID. Would it make
sense to retrieve the frequency from firmware instead of relying on a
fixed value?
