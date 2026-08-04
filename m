Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB849552D
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865898; cv=pass; b=KaQbaQcg+Vvlz5ZP5SkXq/rV/O0eK9KLX6gx0dTj3Tn1kfYSL0OdP1aAg5koYaHAsTvXELDqV8mspAhtLjChRejaEN7+ssLWSqx7PNdl+0p6hWTz/H9b2CUNcMdWqySeWKHwDNzC/XO1BSqyi9vEhBszyfbwTiaI7vPssc106XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865898; c=relaxed/simple;
	bh=U25kZmVMMLJq43pO8WrH9lzuBC5fqAtDhAS7v0NLkF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElvMUjtjxl75zTzGcPFi9pmxxv9z1i+lmxWUN4omqIy+7ZG2iIisBBTL/HI662d9TQTW1qVSFHqsQMxEi5yZHdU2koqydb+zQsPXpYqXA3fxcBgDdvzEMik6Ss80/A7+FqISS+IBxs0AfS0eqYmokYBUKMG9xMws7Ymj4AHkP94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px7K8VtO; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px7K8VtO"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb973e6749so60012a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 10:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865893; cv=none;
        d=google.com; s=arc-20260327;
        b=QJfTf3Ps58ZqbZ8r6ChWnK8uQfQqzwEAVu66LhP1mul4U7QSBNbWSbtx515Nw8/woq
         GE0t5i2IxTNEeoZXY6vjrJz16yBMT6hh3qPWCNtUCfpY8XrPzO7fFxqwKZJJ0pG5KVWX
         KeO/LRCsFy61sJfKOcEJqwV32wy2jqpADRLxvfD54IYhZcccS+biRIS8om8sbgr1DwB/
         5tvYmnQGTOkKTjlDdvjbohArXvJtMJtnMCBMN8MAf4GQkAEA6OiM5GW1A8u/QSrkkCmn
         Ab9RnL7l4lCu2aVhbxqULFR3rnzaJJmt/MMcAWU3seQ+1OPZDZ6sfGkQTzdurYb0U6vG
         G8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSBJQ9x4eObm8icvkzRw/tEor71oIaoq9o/i2eQsLQ0=;
        fh=Ded3CDYp8m8soj+4rOcLi/KskkuxQKrHR8VSbnwJUHs=;
        b=OLO3pOEF1g0/bkuAeeWasENoT/2Rl0+eXeN40mLCa360U9SNDVGBVBMGrNLEyi18IB
         SCVPlmb1CjsBXpkwd23Y4PbUBs+QjnG6uEYyNMMhKYu1hipJLp4svOOB/k9JmupFU40/
         eZDP89a35t//t6sIvwEFESGyw3+YHbM5XQXB0FABxHBFSCdpCTBS1BFshmd/zn0GwUmx
         yYqOfv9mFrHD4txCBZofPu9SG9VYyCOEEnKIAN/cegOoTitPbGz0sNfqXr9IwfuJ045z
         SC/Hui3utg3ALnwbNnePKZkLe2BPX5dU2CH0ujUYe27ov8qcz5tsCS4q+t6UnVUT9Pen
         pOBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785865893; x=1786470693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSBJQ9x4eObm8icvkzRw/tEor71oIaoq9o/i2eQsLQ0=;
        b=Px7K8VtOnR5rcC273KKRsIPskYdzBLGVpCZ+LQ+0m0xI9RP1qQlEntHV+EbBhicfp2
         MzzL0p9YRqQ3pcFdKM73jr08xbetY4BBR23ZmUf5cEFuw+abdonvxlHh7bP+54Dr9jCE
         hZbUbcYwsYu/8vjua0TQ8bYi03V3TxSjMjj+kt/gwpbx2+OQ/EP1viQDqF4dmlkCq7CB
         KEmwf6d80I7K47I6Gi2LpW2LjYsWFy0Oo6RWb8Ck2YZfzcGY9eK6jOP28PyUEMSRRGlG
         mzcagtPJSG3S1kasYTr6V5y8QYCex7xH+hFsariqWrH07ZpDQpBOAnKTYOCoFXGkrYaU
         wZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865893; x=1786470693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSBJQ9x4eObm8icvkzRw/tEor71oIaoq9o/i2eQsLQ0=;
        b=o21GmB7GeE9yxUrS9qxbQ/d3OLdh28uD0JZX4qimR8jXNN6J09eLBZdlFdydiL7hDC
         i0RYR9zmSAIhI8BEipEHbaz63uyUuSWGMCuiebEoFTm984EQ2Seer/zuPWamJwQ6lqjJ
         EjLIk10aUK5aUTDpaD/Yae40L4WTsjSXcvO+k/AgqEFWhGTd1MybFnd29uvC1S/DsJSn
         SkmmR6cYdb6lv2zD9P6FZKe27eLbxQB0nLYxgLFZ2WzXti01nLdzbzr4ClaFY55FtJ5K
         7c0wrWhdtLg9SNgiNP1623a+6dzqZl7DXv78jLC0Y7/KZZ3wM7L+mhUKMKCPIBpOBTd2
         MDVg==
X-Gm-Message-State: AOJu0YzV299P+XyW5/q2a3BifUmXtGryl2PvLXxKqOzC9Is+FCc75qo+
	8+yPT6FgME7BRmJ6brIwW+YVVy2f+z0sSt0X7InpHSSDqc9mEQ0ws8RgsA1d/3BR29+49k0y31N
	XRW1pTAScQWAYzD/PCNdecQQbydy6gPM=
X-Gm-Gg: AR+sD11k4lzawMGst0nlLJs0Mgm1M6eI7KQU5Ti20h4DJzaxX8z9fpGfQcY0Nlx6WJp
	Y4xX+z7bURF5BFc+ZDdfjRzu11O52qBRR1nDd+VeQRY5c/cnTZG+dcqhbrNOMDASpUs7KnNa2Fk
	ChNAfMQre0ZvE9hFK48YJArHGtfRuOx92MrlStoLDiLtztkNt59X9cVEyZjVxyqi9PVijvjXTFL
	j1KXWsW+lo5NZ/cgr3qmeNUH5U9hDw0ORaT6iCwc4tmWY3Wh547qlYkSulQYp6G4aZ1GCAhfAzo
	Q1E9Bzv3wb4PpDgzW8LbG0k72fYEWcENP3hPZwQTbcO1u4Y=
X-Received: by 2002:a05:6a21:10c:b0:3b3:223f:d3fc with SMTP id
 adf61e73a8af0-3cb85faf8c2mr523391637.45.1785865893399; Tue, 04 Aug 2026
 10:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD5TJy-sp0knXTpaBhJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com>
 <CABD5TJyqC846A1=dL2F540X2rs-t2Xv=uT2SzLLtCnczCYHqeA@mail.gmail.com>
In-Reply-To: <CABD5TJyqC846A1=dL2F540X2rs-t2Xv=uT2SzLLtCnczCYHqeA@mail.gmail.com>
From: Anup Keshwani <keshwani.anup@gmail.com>
Date: Tue, 4 Aug 2026 23:21:32 +0530
X-Gm-Features: AUfX_myXXwIk5TApyok9ePu-ZlNn6EVsyzQ1lE53MU43bKEr0w9BQ_qKA_nXzxM
Message-ID: <CABD5TJxfTaNfLvPEjyGwrTb9Jn-bqq0mjXjUn7Vv7dCeLD_6pQ@mail.gmail.com>
Subject: Re: Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell
 OptiPlex AIO 7410 35W
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael, len, and Hans,

Resending this reminder to Hans' updated kernel.org address (apologies
for the bounce).
Just a gentle ping on this backlight quirk patch when you have a moment.

Please let me know if any changes are needed.

Thanks,
Anup

On Tue, Aug 4, 2026 at 11:10=E2=80=AFPM Anup Keshwani <keshwani.anup@gmail.=
com> wrote:
>
> Hi Rafael, Len, and Hans,
>
> Just a gentle ping on this backlight quirk patch when you have a moment.
>
> Please let me know if any changes are needed.
>
> Thanks,
> Anup
>
> On Tue, Jun 16, 2026 at 12:29=E2=80=AFAM Anup Keshwani <keshwani.anup@gma=
il.com> wrote:
> >
> > From b289e63d7f44500517dc94b7028b707616fd1dd1 Mon Sep 17 00:00:00 2001
> > From: Anup Keshwani <anup.keshwani@dell.com>
> > Date: Tue, 16 Jun 2026 02:57:11 +0530
> > Subject: [PATCH] ACPI: video: Add backlight=3Dnative quirk for Dell Opt=
iPlex AIO
> >  7410 35W
> >
> > Dell All In One (AIO) models released after 2017 may use a backlight
> > controller board connected to a UART.
> >
> > In DSDT this uart port will be defined as:
> >
> > Name (_HID, "DELL0501")
> > Name (_CID, EisaId ("PNP0501")
> >
> > Signed-off-by: Anup Keshwani <anup.keshwani@dell.com>
> > ---
> >  drivers/acpi/video_detect.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 458efa4fe..10e3c1657 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -886,6 +886,14 @@ static const struct dmi_system_id
> > video_detect_dmi_table[] =3D {
> >   DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
> >   },
> >   },
> > + {
> > + .callback =3D video_detect_force_native,
> > + /* Dell OptiPlex AIO 7410 35W */
> > + .matches =3D {
> > + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
> > + },
> > + },
> >
> >   /*
> >   * Models which have nvidia-ec-wmi support, but should not use it.
> > --
> > 2.43.0
