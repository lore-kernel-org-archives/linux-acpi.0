Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426F11CBA
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248508; cv=pass; b=RdnDIBvohi26d3XEFWA9wmZP2ikbG7qnIY4WfX+YRaHdG9WpPFPcXDfWjrxFEHy6xuTpi4T27/jggWy2OetN60bD/zHIGhFttSXsvNRnHK+c3b4l5bIx+OkPTZVMjIM3CI3EsUc2g06FJdQYx2rzJ6liqT8og51awjwjHimjwQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248508; c=relaxed/simple;
	bh=4Llf24Rq5gbGoGQgBv92mhqOcp2s6wJw400QrggoOSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afsrrUdm3qY6HXmqT27d5h8r2DdsxrzyycW4zG6bsAnrarqXy6R0Lf5eP8Km3G5hIjM19WBlf0emL1qnSC1POb3Ew++EBsubgEdu+HvLOINLWlBj+SiQZEB6yu8ppFGP6OsZdi6wUY5crmJr/InvTJoCZ4q+0cXa2aWMGB0INic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMCX23EV; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMCX23EV"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64eb84d1e37so7420821d50.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 17:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777248506; cv=none;
        d=google.com; s=arc-20240605;
        b=dZ06RZZy8mZeoTHpl+YhxAA6owyZPGaTOJAttQhImTQuVGhrUVYICzrjjSgFxcDbl+
         ujtglL0VZcc34szMAywrJRIj8psEdaIppRuK+7yRNJunFq3iX9NlsvUvWdA+ubsVF/Bw
         XH/s2cqkEcTXAcIQNX/8AWrboELGgNk10GFor0/aN5khkfYu12yoVKkoftzU7djYqZwm
         nBaKFCWxKaZqDyeUzJ40ElkJiJQrONlxLa3uitO+h2Y6pcD/qUG207FC+r49ZrhP2Dvn
         nP2UcAlapko0q9jIVey8jqMIHN+bgPQhFMTXmkfa0Y1T2ga0j9YUbbQ9/nwp7NfSLg2p
         BF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fn0nQu0AhqbXb2m4Jhb/hvmlLwGs+FouPqdON64qf/Y=;
        fh=4lDKASfad1QHCUT4l51ecuRJflDYNKEkQjNvMZ5JDI0=;
        b=SGsUYXCIQDjOo8vW00WYLO7s496amoOvRQUadU/nIqVeuLm0tyFnF4mr1kpgsxW5AP
         Lqt02R6EoPHbO5ttRWRQw0NZbvzLRPjfyCXx2KjkGWQkYEgZRZ8AOGE2b87sCeDrlBet
         hPxMcgcqsbXY5oYBIhpicyn0JRgm6O7yTcCxAIXh6/+lXArsQldC/9xtcvdpArfr5mqt
         +0gUGOqwWpqoL/QvL4ipbY7b/lVJXUjTT4VoKa91lChPbMMP8l5klSe7aqv+Z1V6Ez3E
         Gtq4q8KK7TfuBkwjT+TvcGY3ikSPigFhXJVPlOc7VrCuOJcIDdtZjaYKTIQfz2NmdfJI
         FQyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248506; x=1777853306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn0nQu0AhqbXb2m4Jhb/hvmlLwGs+FouPqdON64qf/Y=;
        b=KMCX23EVRu/+qhQu728lOI1JQeJlIjXMzwVAqoN2kkCNg8iVziFwKUkopAPCSqh/xw
         9JdYmi/jY7Ei1sVBzl26srbFvu8/6umQBGHON8THZzZAq67pV7vCrZEQ0X4v+gbzSz+s
         Piq+RVMDvT+6PP2Xd9tXScF3Z6RBVTfoeZ8hPT3Twq77gtWTnn7nmd8PXKBhiBxbV0/U
         8dXvpGr2x1btNG/gQhR1DDUdj4/yVm/VTZKSXKukvXXiAgoz5eabsVQD4gIfXHm/IYv0
         yaD4hlUCSv6H8uIG40kS6qWCMicbdJ4gOYkL04E6sDoCrdBEV399FBCA45gz8PMG3Qrt
         joMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248506; x=1777853306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fn0nQu0AhqbXb2m4Jhb/hvmlLwGs+FouPqdON64qf/Y=;
        b=qULzW6ImfIcLDzpjGrTo6neeVxJWyDkX2ldLPN4AA+yrUmuMlDQOD7A0hj+CQiMddo
         AdwULwtKVKCvmC8bsk3ZSFw4fqtO2AG4VlmHw0r5WvcY0Wx4RDpcipWwxZTSYownNLou
         w3oory0xVXqN6WWUw3M9nfOL4BG+6CVUeHNrcb3wVzuHwSL3FvQN6vdhKySg+oxYMA9W
         VRncUyfJ58x0Xp8cg+qKIK8dATFkZ+fjIbOmP7sLUCqa57bUwmXZAD/SSpuUCzV+7JWS
         GTwJkzQ7I9edcuIQ5AaFyqbYrwRlqxrvuiT3X+Yuhd+08QNJkikbbprZQ9NEZ6ZeYFef
         NJRw==
X-Forwarded-Encrypted: i=1; AFNElJ/BqXv74/yZjpCxtarHP6FV59HG7Ppau0BtuCs6f7fwHL66mZR85EUcRMDvk/v5YPwAyKLpAS6C4sNR@vger.kernel.org
X-Gm-Message-State: AOJu0YxygZTVFiDsIWoM66SjU07U/WrG99yqqC0ISDsuw5yN/OBEhxnL
	du7ZZIc6j7E3stK8KDnEc7o22yOzsxUaDvKs6ojBc5Nu6hNrdc3cW9TsJf7h6lQ6ooFPI04M9Ol
	pfkOYA3ahIfX+glFvs7qjpa56vOjTfYI=
X-Gm-Gg: AeBDiesEv+AogGo++BCkzUJlu9ea0O2v3rjrE8p+HMqrltzJQyP1oIXoxbBtemxfi4I
	VtuE+0cKgmKcB5yZYnW4WIYQi9o9oSodQSafJL0/s736afqNtdqk9j6U+wRmynoSoqH0Ov8LmsY
	EsiyHD/fYspJGmLa+kjJhurNdnT88oGVIWXayhpJDo4Pe+MwEy4xdajvSdVQtAf60BiChZpUQpX
	1mnmvj70nRZyZczgZ2MjJJofGyif65OA3mI8pkaV2GndID4Ruz30BEFh3ux+Eqfo7czBcspIUxv
	FifC0TAzqeAO3G0=
X-Received: by 2002:a53:acd7:0:10b0:650:1bff:602c with SMTP id
 956f58d0204a3-65310a47ab6mr28336710d50.53.1777248505939; Sun, 26 Apr 2026
 17:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424220110.25929-1-m32285159@gmail.com>
In-Reply-To: <20260424220110.25929-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 26 Apr 2026 19:08:15 -0500
X-Gm-Features: AQROBzBFj1FVh3_MLiggkUiyVoadqL1GGjhy86zlXVuUumCAMIA-RvB-Zbmq5bE
Message-ID: <CAKqfh0GL07QvEtma-HztSpDjD01FCW=1PkoWrRw_jak-=udsgQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: rafael@kernel.org, lenb@kernel.org
Cc: andy@kernel.org, westeri@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Apr 24, 2026 at 5:01=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmi=
c.c
> index 134e9ca8eaa2..5c37a8f28e71 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -67,14 +67,12 @@ static acpi_status intel_pmic_power_handler(u32 funct=
ion,
>         if (result =3D=3D -ENOENT)
>                 return AE_BAD_PARAMETER;
>
> -       mutex_lock(&opregion->lock);
> +       guard(&opregion->lock);
>

I noticed I made a syntax error here, I believe it should be
guard(mutex)(&opregion->lock); instead.

[snip]

> @@ -354,30 +347,28 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i=
2c_address, u32 reg_address,
>
>         d =3D intel_pmic_opregion->data;
>
> -       mutex_lock(&intel_pmic_opregion->lock);
> +       guard(&intel_pmic_opregion->lock);

Here as well.

I'm going to get this fixed and I'll send you a v3 shortly. In the
meantime, disregard this version.
