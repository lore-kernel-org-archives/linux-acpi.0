Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609463D4131
	for <linux-acpi@vger.kernel.org>; Thu,  8 Oct 2026 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443912; cv=pass; b=SkD2Hcmbuk+blS/HXTnuCDQRgK6BhEBfeCVwyeXMFeN1zW6LINsf7QxUzkOMMxPVCwzKAz8EQgGdNkliag1roJV1B1kX4I267dU6o8HuqRKnEMpC76akoRYYfiKWr09vvWZxmINNghSoMvmqMz+tstdSOSq30az/WFscdJqNBn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443912; c=relaxed/simple;
	bh=mEfZs82VT+qdUvxddu4QZb3styi2rIzs8l6ABw4Qllo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yek9x4v17APW6MQu7ozQ5TNzCghrIFfotB+fADRKN4nvrzIslEEoi3HC0dEn9EDyURl0QwjiRo2gQ+RpPhIdTs1kJu/BO7Mx732HTah5eQyTzOKkI4njSSWzA6NxRz60e2WJwbbb/6CJvnzhbt3vyM1LxbJ489X+pdBtK5QQ1AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8r4URmw; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8r4URmw"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6df1eeb43feso1122588eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2026 00:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791443909; cv=none;
        d=google.com; s=arc-20260327;
        b=HAmpPf4LzvTARNLDrQw1rh08L3Kbra9jn9sLHkax3xMWTTDzNcAUYxxiCe918eAIeD
         clPo/5221DCZ2DkTRAHi2KHgp39lNoK715bD0Xf5xsZcn6/NQQx4YsCl6YlrtNyermo+
         2d7gnBOSNq/oi0J9cnbnM2JGj2vztvTfNzWyRtCRFjlN1AX5NQQRnBOnyigksuTt5dAH
         fn4bv7EQCNh/tImQ4gqKmx34lzUdIEOgbRQMyaYx7cxonIvPxIwRW6Olkyh/v/pcxD04
         +BEpy/acbk3UtaX0evuA6FS+6nPW5XMNNk3xlJ01QUmcBusoE7dS6fumNtgMmgQijFRf
         uKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70ywZ2AyEe7ncaX3K+b5VsGq7joUvo2qDjp4zFNieZQ=;
        fh=zA4iivPTjqldcJVTl8zWZHiBjiadlS81QeRJHuFhlyk=;
        b=Ye38OAs+fbYbmtziclDVHflI3ouaZHPHDQZOQA08DjoXBHnvcxEAtCzNsan2eCn+uN
         CvB4r5tsEyYcxufkTkmM0y8Ua4ObiP9er2SGpB9FC4kZODqfKZQ9SqOuz6/KZDjQnjIK
         PchOAk/MgzOLG0pLnVolDTsH6W3lA/uxP7XhrDoQyiI5T6ni9CKESPHCze0troctpEhd
         dTd78zxai1nKrEcyomjFMjqxVp7VlGPfli5Rg8jncB8mwpH+QQQDdtRz9eOG5LRP/oHu
         MbnbTnKwRHwy9BgrpuKiM0iqrzejdaZ2EoecR8Prf5Ujt2a8wH27+64kCmFB5h6heXvN
         3AVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791443909; x=1792048709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=70ywZ2AyEe7ncaX3K+b5VsGq7joUvo2qDjp4zFNieZQ=;
        b=l8r4URmwE6Pqf05rXr098yyUPpb0lPIsiCToQANmesWZw04HT6qBAsBWeE63M2Ftd2
         6ZnU0ZFm5fVVkw9PJ7zeU2S0ubWbK8a8dtxjz9anI4pN8sWr9WjYll7VIJdgWxUKRZcE
         CzYAE/e7oyx73INhV9UZr9cCz+4zHyK48ShE5TNmNK/eo7+ZH+lmBR7Yd0QMqwwf/RFJ
         Qp09hJzek5jHZZTgE0RIawPjlk1BAkm8EqCdTW5lVyJAwuOkwrNozXmI97OiNX98g4ja
         GI0Eait86lFnirEPX+RrTGL88K1JaT+amRpGPzg1DUNmHtsPURU7feScxkskttJ8LVpN
         AztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791443909; x=1792048709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70ywZ2AyEe7ncaX3K+b5VsGq7joUvo2qDjp4zFNieZQ=;
        b=IJ3hrtihoenolpzr4eUYIb+P0nm8nMbtpSpvgdL5jhU1dnr3EJ4v/Qvke6FsRG7xDR
         v+tObku3vkK83k20DWZ3eBTIESCaParNdQMokeGqffCkSttbtsmwqtFR6P6BYlc8Ynyc
         touo/qShpWJgDDh0verGpXn7haplPFHROIiz21gQmPN7WPPOWe0Y2mEi6q5U0/RcbuUG
         LsQaYWTD3C90gvUJHkBhh/4YVjUvZboSW4yG+qQyTGMTW+355xJjPZ3BRtLmh4cAD5as
         FT5C41DHV9BTnI7dQNHEuH+iQ90uJMoHWx8fRdUHaLv8vHTEPFTn7GV1wcoYbJHTnDdr
         c2/A==
X-Forwarded-Encrypted: i=1; AKwUvByqVSXa1PE/OkBv6nL6EFobJWHilz78qnf94iR2IsYCb0p7K53xL3aVEVq+8Vrgn70MhhCVyKnVSf+M@vger.kernel.org
X-Gm-Message-State: AFuF++kSZhSy7jJvpvRWPlvPrQ7kj8mDVmLTYDqXoKZ1Qm4Qn4feeSzs
	YOg+p7aO29u+9HmxvTXqO8etBSMFBKy0kI8l0SNnH+c27AfMJLWvBoJIkuj5YbNyiaVyPVc135s
	YxeBQK5MzakdCczuHdLY4pey1BcscPdY=
X-Gm-Gg: AYBFou22LHbzf02++R/W6dyhwiz0c1YlGl4G6LKoWCPQEInB47lV1K9VpLKz96LxXdM
	D1+WC2AgEXPsMnHbqkGWMKcZlG4DezvZRpWaWv+P+5Te5TDRvyYeqcUyFAHJP5ySFMGaac29452
	BSl9XLFcl9FhgsfSAZ35sjimXf1D2qm0/m0pIoDKvvOXmv6ndav6S4js44bv5KKpyKZuKfDVTP+
	R4ijoqc1YA8Ub9HLRvarXipGrpuOcJe9Q32fWFtFPJsXaFoPgVvXfRZyIfbU6V8pt+/KWDXbzwJ
	2IuHArfC4xwK+xh1v2qRSYH+9aWw4tVM+8/nQVh91gVOw2bTFCecGfJvsDzHMFmpfA==
X-Received: by 2002:a05:6820:618:b0:6e4:1587:d2b9 with SMTP id
 006d021491bc7-6e7aaecda5cmr4190773eaf.35.1791443909157; Thu, 08 Oct 2026
 00:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com> <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
 <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com> <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
In-Reply-To: <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Thu, 8 Oct 2026 08:18:14 +0100
X-Gm-Features: AclHuK_Pa4PSN7Ovd8UjVYuZheIOrKSyX750Qa13rdRkYN_uBxTlt7ZeUcurB5c
Message-ID: <CAG4KcRLhN9=6xeT4qfqKLFdukiZLUc7akGcWwXJUU1-qrfxTUQ@mail.gmail.com>
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature table
To: Borislav Petkov <bp@alien8.de>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, rafael@kernel.org, 
	akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org, 
	Yazen.Ghannam@amd.com, mchehab@kernel.org, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com, ashoraj@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Boris, Hi Ashok,

Thanks Ashok for reporting this issue.

I debug this. nows_txdone used to set before requesting the channel
until v16 and was changed in v17
following a review comment by claude.
Found this issue occurs when txdone_poll set and  setting nows_txdone
before requesting the channel, solved.
In my test setup,  I missed this issue, because txdone_irq was set in
pcc_mbox_probe()
with the acpi pcct flag set to ACPI_PCCT_DOORBELL by the firmware.

Thanks,
Shiju


On Thu, Oct 8, 2026 at 4:06=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, Oct 06, 2026 at 11:19:30AM -0700, Ashok Raj wrote:
> > > +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int p=
cc_id)
> > > +{
> > > +   struct pcc_mbox_chan *pcc_chan;
> > > +   struct ras2_sspcc *sspcc;
> > > +   int ret;
> > > +
> > > +   if (pcc_id < 0)
> > > +           return -EINVAL;
> > > +
> > > +   sspcc =3D sspcc_get(pcc_id);
> > > +   if (sspcc) {
> > > +           ras2_ctx->sspcc     =3D sspcc;
> > > +           ras2_ctx->comm_addr =3D sspcc->comm_addr;
> > > +           ras2_ctx->dev       =3D sspcc->pcc_chan->mchan->mbox->dev=
;
> > > +           ras2_ctx->pcc_lock  =3D &sspcc->pcc_lock;
> > > +
> > > +           return 0;
> > > +   }
> > > +
> > > +   sspcc =3D kzalloc(sizeof(*sspcc), GFP_KERNEL);
> > > +   if (!sspcc)
> > > +           return -ENOMEM;
> > > +
> >       __mbox_bind_client() reads knows_txdone at bind time to promote t=
he
> >       channel off MBOX_TXDONE_BY_POLL. It must be set before requesting=
 the
> >       channel, otherwise the channel stays on polling and mbox_client_t=
xdone()
> >       later hits the mailbox core's "Client can't run the TX ticker" gu=
ard.
> >
> >       sspcc->mbox_client.knows_txdone =3D true;
>
> Yah, I can see that happening but I don't have the hw to even poke at thi=
s.
>
> Shiju, what's up?
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
