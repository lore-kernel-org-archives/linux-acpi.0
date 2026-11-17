Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933544;
	b=wSP7YDwQFXt0D3g10w5jbJ9dSLU/OBZ4aC4rcuhW47CpQl/SL4Vaz4LR1/nJUoARIpjz
	 yoQz7415iwSqVVNh9/hL9NwDXnyf7bb1MqPRPtI4uTSR34QNe3XLPW/pB6gghVe/ohphq
	 Iqd5RSxBSIwjr48yDovtxosR8osctZN/ZUQbyRlcfM0+Dt+PdJDyB58c8R9f10uTjL53d
	 Jfu9UzF2aXxAxgZ2irf8r8lPlQtnXe79xnSe63G3SkRR2xlLoclieID7EhmX5qIgpwuXr
	 oI3+FwuiL4SioGO0Y315wXASX8kXJ7myL+b9YTu3PD9IE3skN47WPHX2++mK0z4o8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933544;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Z/XV0mK39zFS7JOXvDWInmC0g759RMa7DDlWP4M3P5A=;
	b=fH7V735hFB/AmA14x+7VdRmNafiSBYvCM32UEvOfOU7PbN6kOwuwd+elbO/MaR7k7iKu
	 So7fgF2IJTLbZxJnTbbz+h1MsiDOL0zztsIq56DyCDyERmOdcRESb+6wQeuFeGhbjYRyX
	 6uq3Rito+yNO4G757dAR4bFybf7dDjZWdGSz3COoecrnwWIlITArrXLb9EJrbfQlOV4uR
	 MyJ+14jJRie/PFaZeNlC1/NkRqz9hLW6CCEQABYUbVexeHUnHR9A4PMzF/1mR4OdMhtpo
	 5yJEoxa/lUuNf6yjjxYILWl3GK4VnFRlnJC/kOsuJQD6J06SPJw1POW1nx1p9P3sdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D36606A31C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 16:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D36606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ece3ab2e91so1657031e0c.2
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 08:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933542; x=1795538342;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z/XV0mK39zFS7JOXvDWInmC0g759RMa7DDlWP4M3P5A=;
        b=ClXR414nr+MyQJWrFib+cHbGXq0VZ3T32rAtlqwEa7dn0Dio/79Na+FrW8ISnBPGNf
         j1Df8zis1bJfpioNDYSIH4lSYhjHvPpzy8wXOmmsUCkrWWaT+uDJnGmuRvTvA6raAL2J
         3YpiIILStftq3NiQKfpD8SmjRau3DH+myM+ynDDMuGzVQeH1ICN98MLU7kTHFH6/aGVf
         X+uiOVaWpUFpXAmwNqmJDh3epkq4GKgkSDP9na4hDqWgtEhIhiRcW2GEJg7b2mjyz4Li
         Nyt7vlZWPo1GKGGn9d8iOvGvwUU1qRCvkXYlq+Tg2UkrIlBCcCKUVSynXH4MUeaIzAH2
         Uzvw==
X-Forwarded-Encrypted: i=1; AL+hErHMwf9sMKWZkDOq9MsqrLtpsCDML/t1Gd79xDOBJ3DejyqriLJ7p2/YpPZCJhFgbAsNCotNHpWTlfuM@vger.kernel.org
X-Gm-Message-State: APuU4Z8lKiWFjyOtkam50vPK2g/D41gDyu7DgoTa86R2uorFmmJPpAGY
	BjGPTqRgU9JysgBq9Bo/1XBzJkMKNE7zbDnoqL717QYWrM1JRct7sV/8Wi61g3Wp
X-Gm-Gg: AYBFou3hHJvBCD6eoHqII9m+oqYbrqoSANLQ7yvYUyaT+HjeamWdR8QPlcggsg9EM8p
	nA66M+eCEqtmxCVlNBB+DSnxrsCQRnDSHy+NVPC2/elSoJbVQIudjVUbp9UxZfNEUhl1oUxGGXP
	FK01xViGKGZaJi8Kw1G8bUxvGshcfOi+S3kePFR5TYbPmv+OXMavtFh3Auphugu1L4ydnqoUjQD
	wY+hrzUJZKjyHRXJISarHzh88Aot11SzgZ7ZURssWMM0E4rT2/FRWdAEfxgUZV9Oi4ThVVYTlUx
	7YRLkKMA7+7Mf6YBqDABjW8KV5zaK82LfLmDRD1z8iPy6DCwzJjCgArwH641WmSsLMlDPOvbYQY
	EK0N+wKUCixtTlA+a1vJSOETV7iKgb2ggp57G8OSTc+LOmSjKYFUhhwFlFQSeTxfJnxQtX5mGmE
	Kz2pkFxbZGW+gVxOiyFAw8BJcuynvLvMIZ44mboFMIHakxCTRPp/3KynrG0mt4aK5AkDHtzQH7p
	evUHjBVMkeRFDRbLTVPGSZKz/JNLJeqWYkgKsZ+R8AVu4ALX3gdnBIV3QW+PgFZqcQezoeckm06
	HVRWmFSeBefVstM0H3/VrDLAafaAs5or1muWPaThc0ZAVGLn/YzT+3ps9esHB/WVv7Q=
X-Received: by 2002:a05:6102:2911:b0:7ce:78f9:adf2 with SMTP id ada2fe7eead31-7d64d7047e1mr4086552137.9.1794933542179;
        Tue, 17 Nov 2026 08:39:02 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e49c6299fsm132166241.0.2026.11.17.08.39.00
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:39:01 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so1347175137.2
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 08:39:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEKPkhjLvA6nsQ8xUohi7Gn80bpdtOd17W9IhtZRQtMMbXGI3zGKAs8MwUQ9BYKvNZjhLE41ng8r05Y@vger.kernel.org
X-Received: by 2002:a05:6102:50a4:b0:7cc:1ace:fd06 with SMTP id
 ada2fe7eead31-7d64d7a9d5amr4459124137.20.1794933540494; Tue, 17 Nov 2026
 08:39:00 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com> <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
In-Reply-To: <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 17:38:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
X-Gm-Features: Aa3M54oLa7UUmy4CFc0JRC-Lz0IWxEH7iP1kR67WyO7NUNvhNNuybpNvCvDbePk
Message-ID: <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Tue, 17 Nov 2026 at 17:03, Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
> On 11/17/26 12:48, Geert Uytterhoeven wrote:
> > On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >> Platform profile providers already use device-based callbacks and do not
> >> need ACPI types. The core is nevertheless confined to the ACPI build and
> >> refuses to initialize when ACPI is disabled.
> >>
> >> Move the implementation to drivers/platform/profile and introduce the
> >> firmware-independent PLATFORM_PROFILE symbol. Update all provider
> >> selectors. Keep provider-specific ACPI dependencies and the
> >> platform_profile module name.
> >>
> >> Isolate access to the legacy ACPI kobject in an optional compatibility
> >> object linked into the same module. Retain the legacy ABI on active ACPI
> >> systems, and initialize the class even when ACPI is absent or disabled.
> >>
> >> Use subsys_initcall_sync so the class is ready before built-in thermal
> >> and CPUFreq providers, but after ACPI has initialized its compatibility
> >> kobject.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> >
> > Thanks for your patch, which is now commit 699041135f75b13a
> > ("platform profile: Extract the core from ACPI") in pm/linux-next/
> >
> >> --- a/drivers/platform/Kconfig
> >> +++ b/drivers/platform/Kconfig
> >> @@ -1,4 +1,20 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >> +config PLATFORM_PROFILE
> >> +       tristate "Platform profile support"
> >
> > I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
> > you have updated all provider selectors?
> >
> > If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
> > configuring kernels for different architectures do not see this option?
>
> The goal of this series is to make the platform profile firmware
> agnostic so it is available for all architectures

Sure... Are there any users of it on these architectures?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
