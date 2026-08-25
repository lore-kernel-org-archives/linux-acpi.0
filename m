Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5038A706
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691740; cv=pass; b=sdRd4loelmZoWeCF0K2QFh9N3NwlhSqejTMhdtuLyN2fSn53axZLpPECPr6GErNDjupnvszXbyAOosfSudeR5XuUc9oG2f/VV9Cm6+Mpim0eLCS2iRYenA0qPe2xlAIDFJxHC8mF/FQaCnFVRegsKx3R7rYW7qmolXl8/xWuwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691740; c=relaxed/simple;
	bh=8Z55nOfNecibBt1FEq+yGBsNqq8Hmyzrvp9hgj4mrb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAtnNxhG6elTTkCOhyR5GJNIxqW5wATJ6gv/aSRDcQX/oJpF1F8fFIrLjOE2ShUv8SDQ1m9O7mo8+0jfPP93xMi+z5Cbf2rENVSAAz0q2E7eDr3kPtmLRns65CzMoxb3SDgqIHbrlXzrEGlxhXNd7280+O/fDftGDDOtNnJwJFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjJHZerG; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjJHZerG"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecd7216cso178344a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 14:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787691737; cv=none;
        d=google.com; s=arc-20260327;
        b=Zr4bjJVqyI6WuJlOpkIb2gpNeJIiOxx3DNbXMoaNyM2Q7ZheNjkdpEvKA/TtL7LL/c
         uzEmvV1/2dnbdXpo3Cc8WyY1RF147wua17+HNA2CN4TOh/bDG7JsKDim6J3a4zQX1AZF
         l021qQTvjmNNyaUIM6UrV243Y5JAhPdmZBO9rPp4wjoQ2lTk3EVqPKChlROVq5h2tuC/
         D6504wBqiWTL0cZ28asiNLbzWZykWduOc6UEioBhfxzmaDNo6vxWUb+B4BuxTcCGDCyy
         Aqk0SizdnqNpJ5zbtYPDLVv+bMNG0LcYbB55yk49tXfZuCfTIxtDG0PQByl9LW2HogmX
         vtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5e1R7iDOVBGqKm4i7gvnb2yeuebWqXJlNe86yECIkaQ=;
        fh=cCGEs66M7+o0ifO4DW5uIOYjP0bb9JKWE0B9OpX2OcU=;
        b=Tx8E+clEMpHEHZKblIJHjqmjP9qmpvNMH4FLfLzxl6ivWifYxsDBuK+LQGVY4pVdQq
         GHZXNFZCldOYEeJ1dLXS9dBEZUKpOFi5F7KMibTL+47VeWoie1efnrtnY1PtuTDeUG7M
         ySLhZtPd2QDdBYqsCOwxjfgxsIkWwBD6AH5p3G7BxPZXyHgI48tnOEz520dhpAjwVNX9
         2nw/V8qo4CI+MMUXFI6QLyhoIYaKzxAtK1+ZsWYHzR3WeoACuoNvrcTH9GkpHgKqc+hk
         tI3xw/LKsrDJaOAUvIXJOkL/iT2fOK17KBoXkQVF5SYlHxp+9TLTXIa0svn7YpgOttKv
         4bCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691737; x=1788296537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5e1R7iDOVBGqKm4i7gvnb2yeuebWqXJlNe86yECIkaQ=;
        b=FjJHZerGwdz1KbdMN1v7UFWRNLc09OOaK62LEnHhDLBlhPA/3w0L0B8R8zPCHluvoO
         XSCIVOQfcozsCPlO26pjylh630XvmB67uasVxTqoU8AVPwWBbp6MnRyQeCFADzpDArtC
         V0WPyz1LfWY1msGfChcFK9jRTzz6o3Xv4A/X75EEjAMmrju5d0QPF1QponqLrlmbqR0w
         jNmLkNkq5I5aVGrGeoOgmGjzbsTR0oxxR5OfntVXwUnPpycthGUQfBdQpvDZahvXqFKR
         A9OAHfPdK7ilBzRIswyDgHMVwV8QQogR4xIR8qG7/KCXu/ENLMX6hz1Q8vhxdBHUMjnX
         HQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691737; x=1788296537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5e1R7iDOVBGqKm4i7gvnb2yeuebWqXJlNe86yECIkaQ=;
        b=TFsCNgylGg4fWiOlqN42rTmwVSdhj0skpl6C5na/g4+0lfr3hjYCBtV3lzuXjZ3OTI
         oF91sdlJiaD4ANh16TQJgKiC9PfaSXSPZdbVMYUx0il5JjWgkktEQuy1toXD5oV2Zeib
         0PSPQkaWFeMqqZQTeeXuCpJmo5/g1Kig2aNQ7mLjHKCTai5s+87Hp1pVdbDUkhoVEjDQ
         0gadgCherBfY56qwRvK7+hiq6sIBUYrpBju/kJUtyaKCWoeVWPyiNqRXuGcvW8EuHDx4
         k3HmIMiJuJhA5/GYqdKdbiAHn/LeOJoFjpZaUzB3tmX06T+WsScLSCUP+r5cdHD1AVvp
         ZzvA==
X-Forwarded-Encrypted: i=1; AHgh+RpVZRkvmGHFUgE88RFyJZSPty0v3p5ArIqFs2VHcjyC3YrtTVmH4nXHjVPLDvcF95PWlue1U8mwkMqv@vger.kernel.org
X-Gm-Message-State: AFuF++nJ4WYN6Xr+JXngVLXoOttYS9uKoRLufYlSnGduTsuJDtSF1ERX
	InGJEpAiUCI10z4bughSJBIrAfgC8plwqum8KbdEu3YB3dNHkHUH21dk32oSUOKDgH1+/GEovqt
	jdbTUku8Hmj3RZatXNKFbV3xio7waJGM=
X-Gm-Gg: AR+sD13roNwuP+yIwhyw3L/kignJN9uNw5rKq1UBQIcKvBvJRgk/CD4j2cuaOK4OXOm
	KwpdxBZE46xAYmkLXZYXwCSy5xCkafz7TXNaS1XaFtxLjYkXNE7cBVnBz8xLbtLflZENqISuKF1
	wA8ZgSiPUItGz760rHb4REuqazjf881X3S0RoLCgOtiAhz8p7pZZzHQVBVbUnGPc/gDc6ljsNRJ
	NQIaKP06Xn4jpMrpiJDFx9aRohvxhB7z7wO7vRPAiccrDP47y1OWN4r+HWNBScvX6UCvk7Ssz/I
	fKGwf6nkP5hPUncNFtidbLPXntA1mqIOfjGkbPFuvmZxKbEbGyoHB4CLehWWNW+JagJQvCaIUBY
	=
X-Received: by 2002:a05:6830:6017:b0:7ee:38af:b195 with SMTP id
 46e09a7af769-7f4c4dc57e0mr1972094a34.2.1787691737171; Tue, 25 Aug 2026
 14:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com> <20260825203553.3725132-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20260825203553.3725132-2-sakari.ailus@linux.intel.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 25 Aug 2026 23:01:59 +0200
X-Gm-Features: AcwNN1VtAJclNRsrkPgeHaIrL9qzOn516dlDtkbrCWTLTGf5OgwIn6sak7oDRMw
Message-ID: <CAPybu_3JSL5qAUTpL27GotvQfSzMtcJGGC68eRsCiZ0YwNBNaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/x86: int3472: Address Coccinelle warning
 on an error print
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:36=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Fix the following Coccinelle warning:
>
> ./tps68470.c:164:58-65: WARNING: Consider using %pe to print PTR_ERR()
>
> by using %pe specifier for printing an error code.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/platform/x86/intel/int3472/tps68470.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/plat=
form/x86/intel/int3472/tps68470.c
> index a77ed32abe55..dc777dbac61f 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@ -161,7 +161,7 @@ static int skl_int3472_tps68470_probe(struct i2c_clie=
nt *client)
>
>         regmap =3D devm_regmap_init_i2c(client, &tps68470_regmap_config);
>         if (IS_ERR(regmap)) {
> -               dev_err(&client->dev, "Failed to create regmap: %ld\n", P=
TR_ERR(regmap));
> +               dev_err(&client->dev, "Failed to create regmap: %pe\n", r=
egmap);
>                 return PTR_ERR(regmap);
>         }
>
> --
> 2.47.3
>
>


--=20
Ricardo Ribalda
