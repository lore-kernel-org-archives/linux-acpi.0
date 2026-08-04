Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E617483BEB
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865230; cv=pass; b=bOUQk3AfkCQaDEv018haAuvdK4yaeyUmS8R05iwwrumUx8w6kUrwzCXSf0DyO0aZcpxp3cP+yYX79gKXAQWHAjL5zgsI3cmKuKdL57ZWopvGlFDJ2Bu3Jo8B5MrwLTOk+9eE7qPAwqyxTPuy385ROrYBYPooh4WnOsbp0npeRCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865230; c=relaxed/simple;
	bh=/IIOf1LRn4cZ7cLe7C7MqIZby+JNCMqATkgVL6FpH68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtpIrD1rHxkOhZVNX0iE8mV1eng2Tc/ShikjFnjPy5Q6XvpJQPG1GYV6RD9dwC5ONzGhuiy2jYXIZydARSoRV7lS7ztPo4HKVVu/NiGc9AuV2nKFxUO/sHIrxT8veqT7qZHQCQUlrbvu65nR+IRaCvA44+/95BzS9EDgjcbZKPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDEp3hqs; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDEp3hqs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so90362a91.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 10:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865225; cv=none;
        d=google.com; s=arc-20260327;
        b=Ft5YC/MSDbWbLHZI5+klkLtQhzs56eYqZW+06jxGsf0I5AwhE/vGc8tRJkcJSSWiZz
         EL7dzTlAbsQh36/fMOM+xaU5sa7z6cHkr6OrLv6Jtvyth6m07f65qoz9QKdPkwXH4v9K
         HEG8JzorIzx0kWX406XnML4W+2fqZoYerHj2Alko5oqN3ODY/+/4/gQGa0UNJBN8xakQ
         oA2+DXUJsf4uqPQzUiSOT7k2Op3ipcQQdKm+CZIgZEigE+Em84UIMmAr+70ZjjD8fSAb
         A/qsDNr2LHW+23qzog+6OsPmE/OCw899t0Cp6o1Zruad6JpaTClZRYOLM86hspHOG856
         TvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8njJI/rAaIfvIPPJzr3Bu1isDaX7e2NA+lrhxf8xWsY=;
        fh=ROrmq0rRunfzuhA2x+htFkD12K+1x7SqKdVmiv5Y3pY=;
        b=NQwr9k85dwtGKm1+8sRGv+yKkVRhab+vS90s4DOCIIErgrSUPiMeVDBhbUrZndKMkK
         nSp/Y9mq+6iyebuepFBGkONO81AgycFAG1GhbKTgF3ghRiRU/aQnHkijUGClu5SB8ejD
         VPPrbcanSepp0I51DH2MNitNm07xt/vwfDsrkwQky7mYxAXKyKuOgyo7YyPWR2ItNJfd
         SeaoPbPI3SsLVNnp0NNpTKh3yxaO4d0i960K1MCBSRKaZMmiIve2oVBCbQVcZRDceJ0o
         btDBIMe+oaxhUArhuERUg9PkDHimBY9X16bqCyNcrY3TaWV3Y81iqCy5YwveP+mz6dC+
         uUoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785865225; x=1786470025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8njJI/rAaIfvIPPJzr3Bu1isDaX7e2NA+lrhxf8xWsY=;
        b=DDEp3hqsrBkLXyY6+WTAyg/K/sKkMwFfqnaEHu0fpmReidSpeYiJgrhxaoB9ROBLnm
         KUnHMfI790a9wHKa0wzk0HKA6uLis1FxJfSkziuahgAsEoU5XW7j3o+ZbCqLZwDO6wBK
         mD4h6J3RE9vj6N0xe2/Afz0hSU3W2QTRhuF50Ag1ffF9JPbTb85zrQZmzbBZkjzC+fNA
         T3gbigUqDxdy7lxLUi3ruoaVpsokZ8O5xFPmN/vfoJsvOXGYbGtvfhIsPTDlm0kxDRQ7
         Q/T9TYxUsnTANyfGjH4xkZAp+5S5/4FRWmpy3DfDdQX/G71CrecduSOsX516m/W7GxwX
         O45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865225; x=1786470025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8njJI/rAaIfvIPPJzr3Bu1isDaX7e2NA+lrhxf8xWsY=;
        b=bDsjJEVjs8j3d3POAWaUAQwfwlaJmhTbw4hBZ08Q66lrv8v5ddSgtNZaDXB/zBp9Va
         F0e+ggKH4AN5+9JRSNbQYbrOg2GAAWqkDl4cboMsdUf4MTcLYw5n3AqZb9rxsxLHodqo
         kshG7OqkHydQwJvCuwwA5cB+27R6qbCrzPypPEkIEfjPWfZZ9iBmaakR//vbKuRO61b6
         HLkwKKbRC6O+xvww+vgRW7LkiG9qbYbqxFMT9yo4X65pBZv278TqDkMcTOSMSQTLDCdA
         fTFiN0yR8XfFbObcs7T3uy7oXiWT7FohkM2fhW+z5wlF0Yg/TjQgQE9jE2ae0rJ5EDIJ
         kQZw==
X-Gm-Message-State: AOJu0YycLypc+RJY/yQuXW/oah1L1rSMx/i5AagI852nhfwwp1Vpn4hX
	OLYNzrNMmkbGokzTDPJAS4IVLSgtJokMJ7GjnMQ5hUcqawhbaO/M6qR296yAUqG50S3rFL+rkNR
	h8b/Q7DiCPIXD4kUDJQ5O8GNc+2rKCbg=
X-Gm-Gg: AR+sD11xbEjfEzqJ5zu2Kvk5PMtd/rDOOg9QEvOSaeEB0HMvIk9Kch0NklnsumVyxRf
	jIlqz6sJI8wnyp25iFwBDuagajjtWIJy/cVa/1cLglv+NKJ+/CQiWug9x1VH0/bp/Nwe5+hPtyd
	qIBZfoPOfqOoOAaOoXJksfY2SFgpzPv2M+CkrQSBeZN982Ck5fh/bUE8itwX+SIOWEeKiDlBha4
	eYwi5hl4AaQzueeObr84ks8rJX1lzGU0czpHg7ZbAGukWdvg2v9hDaRK8hpempW0BgyJNUujBbF
	6HH74Hw+6yBCOw4SJ9YjfswKY9ZlFFeLUCfxQbMaCUZPzPg=
X-Received: by 2002:a17:90b:2dc1:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-3903c535d79mr951851a91.5.1785865225140; Tue, 04 Aug 2026
 10:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD5TJy-sp0knXTpaBhJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com>
In-Reply-To: <CABD5TJy-sp0knXTpaBhJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com>
From: Anup Keshwani <keshwani.anup@gmail.com>
Date: Tue, 4 Aug 2026 23:10:23 +0530
X-Gm-Features: AUfX_myiT01OL4LtTAUh7J9XeaTHVZ3Tz1CecknIHpAhyFEMc65ZIn0qypn3-xw
Message-ID: <CABD5TJyqC846A1=dL2F540X2rs-t2Xv=uT2SzLLtCnczCYHqeA@mail.gmail.com>
Subject: Re: Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell
 OptiPlex AIO 7410 35W
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael, Len, and Hans,

Just a gentle ping on this backlight quirk patch when you have a moment.

Please let me know if any changes are needed.

Thanks,
Anup

On Tue, Jun 16, 2026 at 12:29=E2=80=AFAM Anup Keshwani <keshwani.anup@gmail=
.com> wrote:
>
> From b289e63d7f44500517dc94b7028b707616fd1dd1 Mon Sep 17 00:00:00 2001
> From: Anup Keshwani <anup.keshwani@dell.com>
> Date: Tue, 16 Jun 2026 02:57:11 +0530
> Subject: [PATCH] ACPI: video: Add backlight=3Dnative quirk for Dell OptiP=
lex AIO
>  7410 35W
>
> Dell All In One (AIO) models released after 2017 may use a backlight
> controller board connected to a UART.
>
> In DSDT this uart port will be defined as:
>
> Name (_HID, "DELL0501")
> Name (_CID, EisaId ("PNP0501")
>
> Signed-off-by: Anup Keshwani <anup.keshwani@dell.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 458efa4fe..10e3c1657 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -886,6 +886,14 @@ static const struct dmi_system_id
> video_detect_dmi_table[] =3D {
>   DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
>   },
>   },
> + {
> + .callback =3D video_detect_force_native,
> + /* Dell OptiPlex AIO 7410 35W */
> + .matches =3D {
> + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
> + },
> + },
>
>   /*
>   * Models which have nvidia-ec-wmi support, but should not use it.
> --
> 2.43.0
