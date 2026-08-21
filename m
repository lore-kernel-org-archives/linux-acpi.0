Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360B2DE709
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348834; cv=pass; b=hqKywDLTUR0OTZecgG+hHTS1KnTmZTaebMviV2//wVNXZo3UmTxnDoFnOxt8K7JltySuNRfSsku+Mqw18W1Uy3QZlemZ64homQ9ih8UoXXHFJPV42M9TRYgtWRofU1HnS0asXvBwSChdGaiCDqCEn8lZ2kvUuEIKVdSlstmy6u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348834; c=relaxed/simple;
	bh=NZLPbEn7VyX5cG7VSKErkfmUY76epadoj9amqzL5JfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5dk0dFFkL61wXDoMfzc4J89a1IHqg5m7RH50wBjuD++CHG2TyKjEE5ZRox6CI69FTiqKCRwJFA1W7sbYlGQmkQZmi8nWHLwSMCpF0GHkBf/A/LThruF2xcsp9OF7Xfx3tlj3IH62WZWkjyBMiRXJlkCi2yOU03oM1SWHEJtGlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJH6Qt2Q; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJH6Qt2Q"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6b5737bb2so1891604a34.1
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 14:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787348832; cv=none;
        d=google.com; s=arc-20260327;
        b=WSyZb8FkFLTH5I4PmG0pw1XV9glN0lmt7raZc2Fz1/nGG5d+FcwvV0taoPl24ZptHK
         atRDS2TxOouJ75zj3Bjnxh+AuL57A4qSvxBMHUtaRDY4MywtXn9aoy6xBg4wbUzcti08
         XKHEoXTiOfHT4pkcvkMubr47Pd7QMLrPEoj1TDS5VGZr0u4VDOnXuc/YfbDvySp5gW2L
         gexgGG1u2xZmaXYmpoj7jt5N+Tk5iKvlq+WIDtMVTDdg+ZkZT3VBQntBViUcPg92yKbL
         9aLxJ3gbUck8g+UfjhICedESt1YsA0CFPKBTdRuegaXkaoRECLvV6CioT7CMNwIAlk0q
         uBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+ubHCMHtfeb++dsYIZ6AaDOtRT8vE24MQm6y+Pt5X8=;
        fh=WIhdSGloTv18o9RQe28RIBvUWvgVG5EvjpOXLTv6K9w=;
        b=l9yYKci9NHDHXtRboF5EkGhU1BmsZTdkLC48XOX9Y+YV8iNBY9dyoz9d21OLOrnkt6
         3tg42f4/R9pQ5kkbTj5Rtem10lcXdvQdceCcrFlM0mckFBk37vtGDWnmyCKO3HRhKp5g
         rVaPaXlMJP+UUyQcI3NZyfO6AYuUUf/SRBaknnfpiAKhrtCRbxY45K1q73AoFq/mjZpd
         dudupzS3jSFNDxs16Amj7rDnLZIyob4/e4iVwUgG8w2e/5zfOXD6NzYVWOjyUSdPWpzO
         fPdPdAWEaVt3aK5nlQyzJYd7jdl8aJbYXdLmMhjNRYLHtfdx6Bzs4ViyizuvZbuYt3mj
         0Nug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348832; x=1787953632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h+ubHCMHtfeb++dsYIZ6AaDOtRT8vE24MQm6y+Pt5X8=;
        b=QJH6Qt2Qdkl/3Y+wUfum2PUCE4lVZXlckMfaTeaReIaPl5GeLLEZs3hl866wt9NXL3
         r3sJibk7qerxBOQuGBKTiu5wn1djyGASQFuLMLtuwwnJfxRgAYJ6E+zXCqj8Vqxtp0xm
         p78F4XRUznknkSY40KEhWIXMQGiutRDejCeCKnH6C7Vq3s7U96qov7DWgCG4Bh2Re310
         MVavN+bR5dkKJP4o8CDy+0PrywsCKgTucU88n6T3218alWDVwI9nVCDYta2sUx3X2ku5
         trNDY2OsebB874YwZwfaSSYF4HX+BLpnIXZKXzk4xNT8SVo0G3lqJYeVRkw9PCfo3Zua
         8p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348832; x=1787953632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+ubHCMHtfeb++dsYIZ6AaDOtRT8vE24MQm6y+Pt5X8=;
        b=G9clacoRq3MU0tp+auQJkDZxW8SarYgJawgG1IbekL3GljzLs4qATCYMHCQIWMm7DL
         ZdTa/Xl+x6i0sdttEq30yAQEKLsHn4Xmc2Qmpq1HAXhk3pfDLYpqa+fcUGtfM6NXzIzP
         EwTJTd5Q6tJC0k1QpWClhPU6WJZJksPPc8J1g6h6zw8Nzp1MyYlgYLzAEYc2W9zuwSgW
         /asvRijijxnbbWQZ5g8PurAWON51VgZ8UTEJ9afZRm7LeIsMfjT10TWL4JCCOZJeRFRl
         NEiYesTpKjl/k9wfOBK1vUqQpzSvJuj2xah4HwyGMDvVBSuN3NcGSPgSwdVZVlgZ5zin
         pskg==
X-Forwarded-Encrypted: i=1; AHgh+RpBApUA1CK4JJWKfLVJUIOj+o5q7tp07cPo6Q6z+gNiYX1WZ7JN0xjxFc23qG9L3dha831PQXZL8HY6@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHkQkQtsrcm/t8KyPjX0+u6jUqMb+WoxBhv5kyb43VjL/qErm
	d48ta6qJpZmiXo02zvN0e3PWqPdAFdkUuNjaZeUfkjRXFbaVt0qscvEvkeTNJMVElxyDgzKMNLm
	66B7ePjENvL5VhXv7YZYyRguOQDw66VU=
X-Gm-Gg: AR+sD12qukeLexuhgeE8PURc3nNB6AFm2zDpXeoW4rt/1kv0TJF4Nc5o2095Iqz7zXL
	4oyNb7eqvuZANdgon1r1hDjGX1TKTA49X30Jo2+w4L52ZKlaL8brf10rBSJ1M6u/GZa/dhd5fIL
	ytTakNwDhiwtcJOwOxhtqTcf/F0jfwhHm9gSHPC/YXMQc+QAShs26gY7oW5/ZTbfToMco5DWAdY
	mvQJ3Lgn5JrCxx772uO97zuAlHlN2fzqZYKLKSNfPWWzZmrVK+Dloy40f/SKUwv0aU5jdeFbrf3
	FzE21Sh3VPXF3Go297TaKHJAwhF0D9CxwlXVPaV5sPTsmVWD1pkDv7LXJgcD8+pTohZ7wWuz5li
	DaW4niPfJjBi5ntFik61btOexMtpzu5ii0LfwhXD+doT5CinHtUDqc8aVZv8WPQ==
X-Received: by 2002:a05:6830:6a87:b0:7e9:c102:333d with SMTP id
 46e09a7af769-7f4619572c8mr11634924a34.9.1787348832205; Fri, 21 Aug 2026
 14:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821070651.39763-1-vaknins33@gmail.com> <52e55283-f628-4a85-851b-fe33dcdd9c47@amd.com>
In-Reply-To: <52e55283-f628-4a85-851b-fe33dcdd9c47@amd.com>
From: Aviv <vaknins33@gmail.com>
Date: Sat, 22 Aug 2026 00:46:35 +0300
X-Gm-Features: AcwNN1VZoQoLMVYyn4SzQV1Ts9hv-6bzyKM30_TolLriSbfFXa_qUlqvxbu1yFM
Message-ID: <CAMpL-YwbRe7A+wLxi9gi=q7VuufHtaoLDiLTm1fe_jK7J3D8Ww@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

Nothing is physically connected to GPP3. The bridge (00:02.1 /
\_SB.PCI0.GPP3) is unpopulated on this board (the ZenBook UX425UA has
no Ethernet or secondary PCIe devices there).

The DSDT seems to have leftover definitions for RTL8/RUSB on GPP3 from
a shared BIOS base, and routes GPIO pin 24 to it in _EVT, causing
phantom wake events during s2idle.

Here is the acpidump:
https://gist.github.com/vaknin/142f5cbad15958e9025cd81960114f6e

Thanks,
Kivan


On Fri, Aug 21, 2026 at 11:49=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> What is connected to this GPP3?
>
> Can you please share your acpidump somewhere?
>
> On 8/21/26 02:06, Kivan wrote:
> > The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
> > to stay suspended in s2idle (Modern Standby), prematurely waking
> > after 1-3 seconds with 0% hardware sleep achieved.
> >
> > In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
> > defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
> > \_SB.PCI0.GPP3:
> >
> >      GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
> >               "\\_SB.GPIO", ...) { 0x0018 }
> >
> > When the SoC powers down PCIe root ports into low-power states during
> > s2idle, an electrical edge transition triggers a spurious wake interrup=
t
> > on GPIO Pin 24. This signals the AMD GPIO controller (AMDI0030:00 / IRQ=
 7
> > via pinctrl_amd), aborting sleep across the system.
> >
> > Booting with kernel parameter "gpiolib_acpi.ignore_wake=3DAMDI0030:00@2=
4"
> > completely resolves the issue: amd_gpio reports ignoring the wakeup on
> > pin 24, and interrupt counts in /proc/interrupts remain at 0 during sle=
ep
> > cycles, allowing uninterrupted s2idle until intentionally woken by the
> > user.
> >
> > Add a DMI quirk entry to ignore wake events on AMDI0030:00@24 for this
> > system.
> >
> > Signed-off-by: Kivan <vaknins33@gmail.com>
> > ---
> >   drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-=
acpi-quirks.c
> > index a0116f0..dd4db58 100644
> > --- a/drivers/gpio/gpiolib-acpi-quirks.c
> > +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> > @@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
> >                       .ignore_wake =3D "VEN_0488:00@355",
> >               },
> >       },
> > +     {
> > +             /*
> > +              * Spurious wakeups from GPP3 PCIe bridge interrupt
> > +              * Found in BIOS UX425UA.301
> > +              */
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA_UM42=
5UA"),
> > +             },
> > +             .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> > +                     .ignore_wake =3D "AMDI0030:00@24",
> > +             },
> > +     },
> >       {} /* Terminating entry */
> >   };
> >
>
