Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393284;
	b=yDIJXvCjfnbr95wUVUc7yhl+APYqrL2+wXPPKfCdEotKLe2cU/hRIfx5uSUKQqLI+4wk
	 /+qg0ePx964rNCiN7vVcUplQkNYOKkOVkzP2jg2Uz0t8tMdAa/2JVYZbksUUbC5NXB/F/
	 WVOIeMNpo/fNTgP94iq52T48yax0h/viuGk3TM/BqMJ8cddneSX0DsoZ79tEXWvp8njdL
	 Tfakjnla6kwDQG8AY20Q3ZeXB4kc1lgkx4oWRmi97z3U3PQLTNTLz2B6dmpgLYdyEXKTf
	 fPGrkv2kPe2O1FsNc2iah8V1m6A3A1vJgWTvYZEUkw3ByIL8W9B6qxR3LIgWBlZVU2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
	b=2f9oz9ll9SN7qNc/k3yBDa8DIOpd3tk1C7Nex1ue9eCiW2fjjkgnetM6LyMVp5Jchyf0
	 tsUTjvk7BUo2Lytx26/n0EOFbmyCKtqGQaVI7uPqW82bzFUj/aIq7SODUTlHrEErE5fd3
	 OYXh87aI+OtMjs0MBwIJ7ZEi2AanUm3Gq+mTJMHXBHe9Wt15ylUHwlqM6IkbklTmeSHu9
	 xoXt9VakyaUYA8yq1XJ03SRj+HMCeyBYeN3yB3m0+SvOWJQlg3MEXLJMke4kHmjjdQ6g6
	 4KQ7LcZ9/nsJTs7+0tTTclQ0N3fYbRpD8QuxFNQ9Tze7f0H2BvkLg1l2NMJCdyTiY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wo4+YNlr;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B838606A32A
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 10:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B838606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wo4+YNlr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so38256525e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794393281; x=1794998081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
        b=Wo4+YNlrKrnltc3dTrFhFyp8o565rovrnVKvkcx3eVzs7mE3qiNP4os9f3zKzIUO7q
         Mo/E6HxBENrz/Twy6Hr0jn0S9RD9and66fqE4mLAn/XVoQ9oGhz/5FprThWZmcB1lSHC
         Xw3GiW0FU0e05EIYsy/TOTtxkzFOG4Rc7Et1sma46iXKPmLCVl1BoEbBdP3bAJIvboW5
         RDrss8nRI9XAY9vaYK8uPgGc9tmFypYAcAnxtmeiIEQdKL+6MGcergbBBIDQPsOYUs9v
         8reLcEbCJIqvaqTXvPspIf7k32+QOuydWVQAkHaiFp6OoRWnSK1pNXkuh2Jp185lV3Xr
         MWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393281; x=1794998081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
        b=eotke4pqMsGbeCkP77/qPV9TcBRygklI9tomMqj1VlT6cuao6V3/vbREHGq/De4EMi
         vsMNQCRanO3PHEXsbvNm4moj0AoOZwm6HQ/qiyaOUIcuGbmnhyS3w2J1S/Vedr8MQXjN
         CkFL7XEumvwh0gQt2rBTx7SuNjCn+AKgqCSQFG8VCsUqJijGPInielgKO0uNYsboaQoK
         +lDiYz5U+FJFApyi2lA4KsrG1a+AR/3zr883Bbm8Lxywz/K30/twxnv0z89JGdNoZaHO
         ikAmTECC86QPJ4es5AszQ5z0Ok/wtdhOPhhpo9SnvUyu4OaKvKMnbpT/hecI091442h3
         wXdA==
X-Forwarded-Encrypted: i=1; AL+hErHOmichS7bZrLzYGU+X+38NewmDqsfv/Xvn0ZZ/B5GAJ85xNI+bRm4nGpXDdruSdMhKrwxWkH6mCa8x@vger.kernel.org
X-Gm-Message-State: APuU4Z8F/qilO8NVbM1vv5kSCAUoBByfRBxKzIGYvZJGGNXupI2kyFL8
	Bi0fL5WEMz2bWlICQ3ACIa9DYlLjjpXMdQl5Hl7NSZPehty8tQ+ZiQ9s
X-Gm-Gg: AYBFou0NSdn6aZPSLNSvmPyjulT8S8cFzy8pQ3LS1Mq5muDnPjdi+Aoh85stG8w+/kc
	tXE7FVzxkZ9l+yxX6M87uib+9LQVO1Z5T41tm6bnlY+JPA2e9rbrLhPlBATi3+YNtjWZbyEcE0J
	x6DRJYp7m0KZGJw1OHmNIk1NP7FAcu4uuYBwDYu74FWrYCipbfTmEaffJd78Gxtmvb2ntJd+4pJ
	E/1LquPnF3PNUdNEX/PNCcyrrtPAfriN3GOxByBVmuEz5y53Xe2y0JM88KNfjgvpgb2kfow6lI8
	uzl+puHp/y/aJlqXvPImKvDPk8yOFxyn65Aju2BtiiZPLj5WQJconM2Qj7sl0P0RYilKLEGo4L2
	k9tBdKK2AJDgMqLZ+6Uvcf2JjERC+8Cp6uPcNBlsEPDvUivFUZ3a8DOx8LIpS98bkh7CIDNzhx1
	7fpif3rQzpaR1LpcY9aY4NQlOIxABAQ+OMYfTUCFxpLzytUORXvLfzh2QifWX0ypacfQZyidO0Z
	lFvLX4czm7xnGzg3ggxeF1ybJK/00d8/90U1OBRuPyDLCZIftRLAw6vzQP3AJ4ARiQGt4+bxwbr
	7bEhXRcj1KE3Mbd92ve+xrh1ov+cZS0HJZSRQmWxXTNDbxWCyStTQr+TrWdnYrlRNPQ=
X-Received: by 2002:a05:600c:b86:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4ba09377b2amr30972055e9.10.1794393281331;
        Wed, 11 Nov 2026 02:34:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm157078915e9.2.2026.11.11.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:34:40 -0800 (PST)
Date: Wed, 11 Nov 2026 10:34:38 +0000
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
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <20261111103438.2f822202@pumpkin>
In-Reply-To: <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
	<35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
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

On Tue, 10 Nov 2026 16:33:56 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/string.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 9e59f9697c9e..55ca4cb5122c 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>   * *  @s+strlen(@prefix) if @s starts with @prefix
>   * *  NULL if @s does not start with @prefix
>   */
> -static inline char *strprefix(const char *s, const char *prefix)
> +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))

Isn't in enough to do:
#define strprefix(s, pfx) ((typeof(s))strprefix(s, pfx))

which correctly preserves all qualifiers.

David

> +
> +static inline char *(strprefix)(const char *s, const char *prefix)
>  {
>  	size_t len = strlen(prefix);
>  	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;

