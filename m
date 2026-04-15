Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83F3E558D
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273114; cv=none; b=Nr1TuzdVVW2t2AHiAqBbVkRdLdMW72E+4IzfpBIAnNJeUwhG9gW6oyEO2u65ELd9M3y2qXInJbMgrMvuxn94uQE8S2QpMVwxk0Jv0uzmWozegiNrGxsudJbuERJKzWKnBZdWOqaXTUN26bmth0Ng3tP/B/I1E60FRKwmlPzO42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273114; c=relaxed/simple;
	bh=n4eKRjTg2wsf8EiKvTV8/wa/jJXdHqUKwGO0Q+tazM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRx+L7FvoeTX8EdL1HbmyjEp0xTE8RRfMqp/uQ4qx6vNTIJev/8/wTnlmjuNCSDng9puGB8kbE5QMpwio50TgbORmzx11/CB3372gpw9abChcNMBCbpDBXQKOAQT0IKQC8iffiEnAwALSyIhHWnaAz3rqKC3jroAQg7qZIP1E40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH6U0cb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH6U0cb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2008C2BCB5
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776273113;
	bh=n4eKRjTg2wsf8EiKvTV8/wa/jJXdHqUKwGO0Q+tazM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kH6U0cb1Z5ateciYoJZp9cOVcuDOsHfii15i6SHxO+LZs90Cm7EYBccgzQ3sFOUWf
	 8e7t1ymjGxzg7asq0DzN7yUEoVfN0QfslUhmsRnP34c4bMN8kICeP2YZtbEqutVjHy
	 XgkBkcNom0NKjMwYUmT5HmfTOliwbqPTEsYqhs4DZc0ppMQWsSUh3DCuVRsmQqqAjt
	 Q7HZD4W/o1cx1yS9zlvsh9VvF8UafwH8o1jhYeW0uowWu2JLNKrg1QYekEyDk5lLWx
	 ufyfZuujDrXxgqrdkp3gvfEvCQ+1s+uM/yxaHyvSvz1/cGcgv63SrLkYHxkz/UIMxo
	 n1J35vLIJbAGw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-685017d0fbcso4194653eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 10:11:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBFk28BBMO8+IdWHT00wtKv4I8voTZ+JEa5Zcv5jhHkOwt7N17
	T79TVBVDOvLiqrT8DVLqNcsTew0pQ216wPcqYAXWi7awocqmyuSzgKZm1IVYHWk1b8fe0P/fiiN
	6FMtX7ILJH8rLQdlEBNAkdJiBFVlXa6M=
X-Received: by 2002:a05:6820:1620:b0:684:9e9e:816c with SMTP id
 006d021491bc7-68be81e16ebmr12289343eaf.41.1776273112920; Wed, 15 Apr 2026
 10:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411092606.47925-1-jan@jschaer.ch> <d0d422ed-5ff2-4523-b145-573146902c9d@kernel.org>
In-Reply-To: <d0d422ed-5ff2-4523-b145-573146902c9d@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 19:11:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jp08euJFsv9du5oyRi5GaeQ2zeKEFAkqTArSW2zfRzmw@mail.gmail.com>
X-Gm-Features: AQROBzB5aXpDm_eKkTIzT27i4iSmfwggg1gD9e_BlfFTAdd2-WIlADEaj6L00_s
Message-ID: <CAJZ5v0jp08euJFsv9du5oyRi5GaeQ2zeKEFAkqTArSW2zfRzmw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native quirk for Dell OptiPlex
 7770 AIO
To: Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Jan_Sch=C3=A4r?= <jan@jschaer.ch>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:04=E2=80=AFAM Hans de Goede <hansg@kernel.org> w=
rote:
>
> Hi,
>
> On 11-Apr-26 11:26 AM, Jan Sch=C3=A4r wrote:
> > The Dell OptiPlex 7770 AIO needs the same quirk as the 7760 AIO. The
> > backlight can be controlled with the native controller, intel_backlight=
,
> > but not with dell_uart_backlight.
> >
> > I dumped the DSDT using acpidump, acpixtract and iasl, and confirmed
> > that it contains the DELL0501 device. When loading the
> > dell_uart_backlight driver with `rmmod dell_uart_backlight`, `modprobe
> > dell_uart_backlight dyndbg`, it reports "Firmware version: GL_Re_V18".
> >
> > Fixes: cd8e468efb4f ("ACPI: video: Add Dell UART backlight controller d=
etection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jan Sch=C3=A4r <jan@jschaer.ch>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied as 7.1-rc material, thanks!

> > ---
> >  drivers/acpi/video_detect.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 4cf74f173c78..4a2132ae28b4 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -878,6 +878,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
> >               DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
> >               },
> >       },
> > +     {
> > +      .callback =3D video_detect_force_native,
> > +      /* Dell OptiPlex 7770 AIO */
> > +      .matches =3D {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +             DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
> > +             },
> > +     },
> >
> >       /*
> >        * Models which have nvidia-ec-wmi support, but should not use it=
.
> >
> > base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
>
