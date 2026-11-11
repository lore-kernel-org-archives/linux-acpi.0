Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392920;
	b=dH5TkIg0WlR4YVOkc5ImBTbA5lJ0mkBurJx0T5ryjoBSBLboQsdkwwtezMRaXqTOO2rh
	 qrHMaMaM3x9H6H7feBcwbkEQOJxbTnJvarFTpottrQUYed0nnY/FhY1yjazABSjIxBxwt
	 qWmTKL1FtL5OEmMm/NvfR9C/RSsXfu9lKHitFccSlzJN8WgJViQo9U0q2Aevtj+TZqHEo
	 mY3Ctl0mnajfE/NgHYvmQZfZoDGlyGq8OYReTi9TltACpjN1YzgNYcneAtyFStVFnpSz4
	 KmC5V2Db5+QiiOWzfi/6RZQna3WLpWyaTMMzBV+GcVh2ccWiXMw4jEcj8eCQAa3NTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
	b=N0pg7nv2exi2tbxkQcxxBv9Lo0KFVZHM1WqS/fmDGU5WSd1dq/wTeM8AWCYjsCJu9gTa
	 sbR33vf9Y71HG21Oem8ozeKRq0NZoVsbJA3S2eXkU+h1YhKxMKPatVb/z7pF47DqUaJuC
	 GgqtNPdhWhs6xFBapKvYAvkTc7I0fm8pW7I7VrAsyV/+UnHuJgF9v4NQrE8XvfULHQsAZ
	 +HeMEiMCvZGkInya2jcv/mq0qNR4NNwICnd3T0ES2U1hqa1Bi3Beh+UTAhjUSj3AnJEYT
	 RcnQjMITIpil/Cdbuy0phmvOK3Doxvko85dGU7uBO3e38uuoXYBxx7mV77W2UEPendw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWDbBcPl;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37243606A884
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 10:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37243606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWDbBcPl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e47347279so1931968f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392918; x=1794997718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
        b=zWDbBcPlqS1AC19c/HKVJJivTF+W3QDFDNQtIKOvb3hEChlZ4gd3uHJGRCqzbATgi+
         4WA95HRAW2CM31vuAQddh7JXzptPeou2EnYnKEFZGeKj3eOKR3tQjEXWHFnPKbtomdzT
         qYebL4M08+kzm+fecTEfuUPhgT3cf2mQl38aA0zBrA/RVjVllPMR7+CI+ypkaVRyCVHv
         JyASfAk8iIqtIvzNX4yFl994GJnBbETlTTUETK2oIjy7wEOHZ2MHdtCi1gKcVIEdxh/5
         IXw9112LmYt355Rq2qfFzl+8sFHcxLKC9TnUDf617SM9jDHfoqgOW4LLz/zDpS2v6VsY
         vYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392918; x=1794997718;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
        b=gJz1hqzHeXY73wPtUZSeC83YGza4cpwFMvgDY2f3PukeivrzbfNkRi63Hwm/wSHt+P
         99YJfWMcTaO2gr1SfSMvSDwHRRPiZGCHKTxsZ87LYXtxPobryyaoV6WrKD03U5y+PNCE
         7sppb6pBDmlCa5iDXC+i8+a8OMf8FhYD5vJNzIv5LWvyBdwtOAmoV3k/5jI78fSO0b4F
         qBPp88g9lt1GEyyw8K3xULlFUb6SBCTmIXmQ/vx/CAKKNP7IMo818IAS7FA/p+fCvmRw
         6pLaVZ18qSlY8/r4t0ZFywYiyXD8Vu8S7Syf6WsGlRb3nO4A7nnDWk+J1ZShbf0GZhbU
         WHew==
X-Forwarded-Encrypted: i=1; AL+hErFxuppbJV8KPDcypLScxriqqS4MwUBScFUUAlNU1I7hEvoMNKlH7yl12C09lf/U8JPt7106Y/h1IBTT@vger.kernel.org
X-Gm-Message-State: APuU4Z/KYbkILN6vi+mJEAQ7YAq1HbtDq2ouc0PtJ7ODV/79NLSfnP6N
	hJiJ3Y0DenrqJs/Y+J+7Fro/+16i57DG0JfuRMbirj1xaKA9SNzlwqKa
X-Gm-Gg: AYBFou3lnDntk/6cMwZIq1A3MpfZt5L6S1VlIeaTZIoQ0yfVdE7RG/tHeRBfL/PJQY2
	v5wjs8Fd5IfH6LOKE1Bd47XXIrlMDrhd89ImjMZg2HfELzy01S2Tt9xH3n7EeIVFCSfEvGQV6q6
	gI1MztBAfdgrguLuxHk7/vWFeHwubmRkuNADMC8kQygRElarhwFhT7E4QSmZ1zOEkJVsfGMucLd
	0JZWeNBki2hKZXF39L4lpMo7MwFMvu7YcXZ4PdaGY1Y3nxUi3DR6e3/R3BAR77785ojawb/rY1W
	UuAB08gscGL7uRVmm033UDtJ+VRrazYSoOYQMfPsML3QFoot5IFlxCWGnBLgWkF8jvZ0/sYMVT2
	uNsOrMwdHvZpHUR1Ut2InXnI/Ecruyif911sPM6LJ91vTuuYJIwODUv8OqAXu9DPyVIaq3YHrXh
	qoqAlkTK7ddIew06lNkCZqSbaIaO+NvCOHbZABLboxk5X7uOpYLNm9ClwQuaMTkyFJPGTHkOcJl
	cmcvjBEfb3fLQJC2hMbHxsZGkcAGb84ffGua18hAsh0qWRwN//YKaacbuuN09AJT2mBO/dkU9tG
	MocUVIXj4ZzmGQyM7Twe9WR8OFBqIk6Z9jKEGW5Lm3KI82AEQRxNv6L+nyVID9vDtw==
X-Received: by 2002:a5d:5f47:0:b0:48d:ef7a:e59f with SMTP id ffacd0b85a97d-499c75528cdmr3034821f8f.17.1794392918442;
        Wed, 11 Nov 2026 02:28:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498361f674fsm10337668f8f.33.2026.11.11.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:28:37 -0800 (PST)
Date: Wed, 11 Nov 2026 10:28:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>,
 linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Andy
 Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees
 Cook <kees@kernel.org>, Laurent Pinchart
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
Message-ID: <20261111102836.759ec121@pumpkin>
In-Reply-To: <avOn57pfHntiwcaD@devuan>
References: <cover.1794323750.git.alx@kernel.org>
	<35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
	<64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
	<avOn57pfHntiwcaD@devuan>
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

On Wed, 11 Nov 2026 00:27:28 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Hi Joe,
> 
> > Date: 2026-11-10 08:32:41-0800
> > From: Joe Perches <joe@perches.com>
> >
> > On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
> > 
> > no commit description on proposed patch  
> 
> There isn't much to say, but I'll add something (the explanation of why
> the parentheses are needed around the function name, for example).
> 
> > > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > ---
> > >  include/linux/string.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > index 9e59f9697c9e..55ca4cb5122c 100644
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> > >   * *  @s+strlen(@prefix) if @s starts with @prefix
> > >   * *  NULL if @s does not start with @prefix
> > >   */
> > > -static inline char *strprefix(const char *s, const char *prefix)
> > > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
> > > +
> > > +static inline char *(strprefix)(const char *s, const char *prefix)  
> > 
> > Why introduce a new coding style?  
> 
> It's not style; the parentheses are technically needed to avoid macro
> expansion, since the macro has the same name as the function.
> 
> Alternatively, I could rename the function to __strprefix().

Or put the #define after the function definition.

David

> 
> 
> Have a lovely night!
> Alex
> 

