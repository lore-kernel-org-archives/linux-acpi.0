Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392740;
	b=jI2gTR/8WhPEnJ2JfmLvSr1B6KcgNDJv000kIHoa9VUBh1QEn0Hk0TkSVc0dRTw9ujc3
	 5gKfqBfavwxhOanEGOqMQ9VZpgOEDbNOaQIsKHhh/oW2tU1huzGZzeOUe5Yi/E9nuQCt+
	 EtxdPgOgylTbHSNuHWjeglo2tGVG8d6tnwA4PLqQgGU7xO+jkSYxiuyLM02gS18ugiwLe
	 XwzXxFPD3hOK/DUyjQCkNbLETsH0J4MAEqG4TH7IAS3y+mGVan6/XvEU1kLumro8EFq32
	 MTjIUEre/oIRc5e5SNB3HflykvpmVtPBhfFG9Xo/BbFUvagIuhxMVzHobB5aOTSA/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
	b=M7eUYcgDsEINYnPZeq+MfmjRsQBqpJ9uNaJIDOs/mOj4iK1AUGohNcz5am93nwZ4Zna2
	 KCZuaaJPZCx0dQWXexselUJDBUtNOvgsrlPyGV2KBqjiCRLVEHHSD1UaN+ZQeyuAqgLKI
	 2C7TMtey/Q9bxEcPrLHog9XcevbDeF4trrR/Zp/vTVMJfD58hA9rhjBfIBFAWxv7SfEAI
	 AAE+iHyFYGA9DrnD3UWlhXk3Ke1N8gIAVgXN0Ik4Be2JUI5tVJfHGYTPqRXGZmSujBnGb
	 tvLjKL/L7XlBkObIYCXypBLm1ksLOQr1ZJsNzFOhbnJSccWj+bDZjzmHAU8dXNASJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb3uhiUC;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B5606A321
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8B5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb3uhiUC
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so24528975e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392738; x=1794997538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
        b=Mb3uhiUCOo+9OL8nkk0DPqlbHMU+U3YfPJtQRGohaqBLQ8OevIfv8dsETu4ueSqwRn
         NFUTwQnpCyUxKUDcsxzqJiYueO55nV4pkpQgYg9LUK5WPus9n/ERdDgHae8RQ7j2Dw+4
         fM3ibr2Y6ts1e/OTqbgJiTQW3L8WDSaeJuxScEHyWMzPN+bGBiq2tlQqZ+g6LQEpKD58
         mnmah5jGdWJ/FHCGptkaUokAM2nmjVjDMlQqXY1Y0+QNVEBolaI9RZeQ+wAs3afJIVDJ
         0j7wdyVZa4FS6RKopL2kvM92RArS1Tu/5W/MXYkBtd4iocmh7ndrHYxmSyr8Mi6yyFzr
         +H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392738; x=1794997538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
        b=vle69WYLdFPF/NcTHeI/b211wuPTDeDohkndzPHUhFsaLx7WUtdYyXuBQt4EIlVG6U
         cplLtB34n2f5G3gcggM3qODfzEYsPGopxY9rykAJDoNyjikPPpaYGuCJ+iIailaGyBYk
         EdBIla1dgxMlns6IjbpLqlAKB702DCRQ8pGH5ptX5MXXmPxgC+ClPVJ9pTFmgm4ebUtF
         Ry4exo6IRtI4Eqlyew9QImxEG6Tt8win0mkaBLV/R8R6KwmlMYwQaNuxZ7g2RM3e+ZE1
         cHjIsVNB24l00YXebdf63u6rrHsumzdmF1Igg/znocFUJI12qHQyRerqMwutKk1gYmq3
         k0jw==
X-Forwarded-Encrypted: i=1; AL+hErFaVD9mYquou25BzYniq1DWv+WKbtgGXAVdGz0MOSNLdvxsH7UKaR+E1a9p6OIH3EsM2NKyR3gY4Bcm@vger.kernel.org
X-Gm-Message-State: APuU4Z8vUji+41hvZLM9blUrCH41VqsdLn0b0TP0H4/5KrcLy2p4jkDK
	+GpAximlMlpA1V4Ui/QCwEsEn1hdk355s2HAdqLyguUQczV7v8gOEGc9
X-Gm-Gg: AYBFou0eSEuRsEkgydmmQF1qbqzNtj00Mtih0DFgoCa7qxiVon4vffFv/DbW2xM+OZQ
	OMbOZ0KqsCWakZisaMXBOCo3QJqSDvESV0Z5jeGP0zTWGPxl2U8AP5okEVcFkQsxlrKDH+8ZKPZ
	pCGJgQYtVXvSFRDV+5nUpMHBMEZa60fJ3mgp1gLXIML50Gs2+jE3Asjmaa+0Wm7ZQOOmZJEgSqg
	03vJL7ffLXCZdjhO3vMRcUUgzP0cG41/jOjo2I2nBL5StvlKcSIucQaqFG8MMZiIZH4Nm+JhYUm
	BCkCQRGI8Xv1MMrKL8hRdfEd0v8t8pfEXOMupN8gshoyjroCjOpCq1XPlFZ1QGdUE37eZcO9PpG
	XI3nFU526YyFL5gjkxDPQjTjBe1hQ9GltrAovbkA/g2nlgFrcQLI5O/lQOCYYMx3/tmjBAd1BnU
	nLg503uakzGoijBlzrp7Ewrc/m+7b2yotR7Q+/CX6QkaBCY6qjrRdaBhodXeoUL5RRn7hIXnr56
	SHYkxDO1CYladSMcDk7AJKY6u/P5oMZPDvm/GLxj9PGTik1FfRxObldD2HkBfHEmJSQ8pIUxeCP
	/vEoHC7rqpWDRRyw2oT50iVsqqtWKmMnZGvATpZyo7ZmCl59wUxkhFIPRDcdDU6csms=
X-Received: by 2002:a05:600c:4f14:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ba093b5ec4mr41235955e9.29.1794392737707;
        Wed, 11 Nov 2026 02:25:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm8610917f8f.14.2026.11.11.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:25:37 -0800 (PST)
Date: Wed, 11 Nov 2026 10:25:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Andy
 Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan
 Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <20261111102535.434c2eee@pumpkin>
In-Reply-To: <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
	<2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 16:33:40 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> This macro serves to cast const away without risking unwanted
> conversions due to mistakes in the cast.
> 
> It's similar to C++'s const_cast(), but it is more restrictive: it can
> only cast away 'const', and not arbitrary qualifiers.
> 
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/stddef.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b..d79a81406b78 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -194,4 +194,16 @@ enum {
>  #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
>  	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
>  
> +/**
> + * const_cast() - Drop const in the left-most derivation of a pointer
> + *
> + * @T: Type for the cast.
> + * @p: Pointer to be casted.
> + *
> + * If @p is of type const @T, then it is casted to @T.
> + * Otherwise, @p is returned without any casts.
> + * This avoids mistakes that change anything other than 'const' in a cast.
> + */
> +#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))

Should it be de_const_cast(), or just de_const().
It is a shame you need to specify the type, but why not:
	_Generic(p, T: p, const T: (T)(p))
so that you get a compile time error from the _Generic() if the type
is wrong.

David


> +
>  #endif

