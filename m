Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794060394;
	b=qBY2VOH2OoEUoym3ratNObpC8qWkpxhGv0B6Ck6mm1pV4Uklqs0+SwV0pa4YCuwcavxw
	 HFTa2LXcr85Ckbz2+UDsiWSuOtOq8Lcf8AwXdhvr51XiMZVw7qUYSDAePouT1mN4KbdOg
	 0jyUJE6ukaSvmSwrHFJ9LoiBMZG9i6vtjawCh4lzQL9eeBrEkq1IjBsNi74Gsoqj98m6C
	 IFABYigwDtz19AyTkk6d09D9LjSd7ENZ+qKAWH+bnjuPQda4wMimA4O2+5VeTMSoq7O/x
	 sYd9aixbrqe0jX32Y3ynuKD/ZqlTZMOS6c0nbAeV7jDn6Z7x/jK+xBfSnzDE/ShCDOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
	b=y/4MQjjp8vgaN1a+ekfCy5ECTNjW6IxYM8CY/CR1mQUuNge7X9jsMjQv9ofFcAepXl8l
	 FuP4ECEqTnMH70qRiFXq1P7UoFHUXleyXofpYN68n3RXTCidzbVaApcYwOn8JOOjSepFF
	 yc3uyltKEoWXIOfVK8/oMxyjekRRZmIKj/20kDu+szaeftU1t1azfmfXVDfnrK6l25PJ4
	 7womfW17ltfUIYKtR0JMfVakIBJFnSXytgKE0MGe7cWam3sGUmoWjpISuiHUpSy7k6vtn
	 Ufly8yh71nkP4AMVMY5u2qXZVhSWvBetqMKSyhwFJdWXuG11HqFENKSfOa3VJ6fvBOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDBlyIAS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E8606D81A
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B48E8606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDBlyIAS
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so971590b3a.3
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2026 06:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794060393; cv=none;
        d=google.com; s=arc-20260327;
        b=EPuxINFg4tqinVcoKO345aF7+dD8izh2Jhq+LR6d3mDhlJdPeJYFXflaPOfAoktwks
         OKoWeK+i0Jmzgvp839crtWJpNeyK7Abustvzn6CG7Bh3wLsfyL+PCQlPJzinm59BIkMm
         DeKJnFqRzqEPXA2IfIQYk3CidAlZCJD6kPpTOXVHBtTVtVJ2PCDMQseqmhtlnB+AeztZ
         Tvrtrlbp8rrmi9HwmJLfrYwMnoR8n/a+rq+CahDRHBGvdByK+8Lje0zhXTMng9C4kpRE
         /K8w9q5T9ZOfzINm9Lzuq/zxrITvBYAfV2d/KLkvwbbXyqnWItZqWSuYOmNynjrpPUfO
         wsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        fh=mJqUc7HTT9K4XcNqw1i4V3k3H+hRHAS0KeGchcy7wVs=;
        b=IwB4iEHAaNyUxvdNYK7FaJIiOowU5SziWdbK7HH3C5vIjcdA199rq5YGpsefGKROqG
         2XysZwDqp1xMw/NXAcpMSkzlZ1y8Q2ROqNQ9msFmxgoVrL+E1yqn3r/7E2wspeigCt8O
         OWun37bR4cJ78js5iLjX1bVaeX/TZElKUQpeDbbAxnQvOJBkCCqsLorl/aEvrStID9qQ
         O40jhTs1CGym638UNG2bB5nL0NKCDEUqEz15Y+0VacS2CI7POoCYaKSVFqS8hjfjn0+K
         3C6UDD+LUS7JjtcylNN6i0Px44kZ5nPOOTGm1rohtA4FKE5OdZD8oyXgp6WAof9lXAow
         twfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060393; x=1794665193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        b=dDBlyIASGe87airtRsC6OYAtSLt8d6JrbobgkmqzvHZG4f9MUAgKofmlBTqz06bmf7
         X6/cLnOfY0szRdLNS3X2edK4IKxHbjdDSXYPSt31ow1YyWXi1Kqjjm0QF8nHW2t4qXvA
         0NYnlBfL3p280jC12DBHa5hRcP3rn5qi3RG7leKLPOtEEwGOwBz4i3puzoxLu0A/ERDn
         tEb/Fe4tigaNJLz1eYJOyd+QMI2kRSEuRujtP7juCjFLv+Kx9QXavedEeGOPrXGBfMZd
         CXpWZX3fCI3edsCjV2z66r0g7h11SLsxjerD+lVx8K9D+fefPaf9swx/sLCRgFYnFBR9
         wFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060393; x=1794665193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        b=LThFwKgB6HnNGr+01SYlUCVdHw5ZCqVSMf25wE8hlpMcU33e/C0v6/4MTJjLO4YQ2a
         va1rp7e4Nq+dkUdHkUHl6zV45gzENa6/SAlANwI8OfgZnFY/Q3yQBdLfAzqVpw+5kKq2
         dOUZwAGFG/3xbuCafggFC67htateuacCypZTVtNyJXS42ySqK5N9F3OMsC0bfog7GLAZ
         U7HQQmy1fVMLda0tlbqayb/635Lq6/xgaQC7paIqHOt6m3iG3k4bySbbrXyLoKphzotU
         Abjajm0lexL4ddG1wTSyxSXZxt775obcW9VDWTo8sXtDjJEkmlfwVFkme9qdV9dWlyAt
         TzXQ==
X-Forwarded-Encrypted: i=1; AL+hErEqLRrAh4S0eM4Op1jBRbTIGp9MvIRJL5tQjrnPs5hbG9q47OkMDASeXuWUk2NOd3G9WBqMRsSo9W8H@vger.kernel.org
X-Gm-Message-State: APuU4Z8pYDiGqcyu/W28rDunIGGeRqe62/Mv3Vo/e667xLxjQFuuFzLq
	2F6frkqqg96OnwYNd5yhi8SCB6CwIQ+9850rj0VEwl2qOhKHGbJS2nkvCyelTYX85ywaeiu/77g
	PWxGz/Y3swlac9D2M0awr6iL9iN/LLBM=
X-Gm-Gg: AYBFou2VodeeQHK2v0edLosSRVzO09aaHiBByqjsNPg06gqZXgkM7RqZGsfOv3TJu9p
	LqOFd8vSzm4NsBgcJz4UjWk81shkVZVT9EjNWaQ4ViNRu0LFZ/eDodKeFGkOsJUk74TejZhRvHm
	n7z/sSxQndRfn+xNERlBuhJqYw7UBjrbJu/q+ov5nXvE7zjp15K76c7UH5zQYjaPOx5TlH0znfG
	WsHriO+t1a88qH9wbkNCRScFeKGvhFLxy4RNGk0YUhfwRhPGiOgf800E6+WDL/u/fZ/tC8yJcWV
	fmaL3r3niYkXgUr8IG8lVzsTp+5Ca7mOdzVf+1Ar7xz8ALCbq19FNq4kDa49PugzLEB+dCzPQh3
	0gULdzCCpqghNavQGUmksLdE6qTDX/WVw1wqZcKQslstXpQzBH4U0mRZ3sAyLn5MRutCpgfSI1y
	0Ahb7O+KTJ62KSok2dXcN3nvzKIPhACMLp2JUhtNi0n9Wa3e0JIPZWdytnhF8DGJAXjgmxwKb05
	UDD0BPCqumKaddM4YNWTzlLXa1SsASJ46OI1w4NKurnhiOVZFu3ULGtA2VLSQ==
X-Received: by 2002:a05:6a00:13a4:b0:8a0:21b2:7c7d with SMTP id
 d2e1a72fcca58-8b37525709bmr5141902b3a.0.1794060392907; Sat, 07 Nov 2026
 06:06:32 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan> <auyV47xUCr1EJ7A3@ashevche-desk.local> <alpine.DEB.2.21.2611070239050.17804@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2611070239050.17804@angie.orcam.me.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Nov 2026 16:05:54 +0200
X-Gm-Features: AclHuK-WBq_EIF1I_SsYN7csCkMj3s3jbsrjUQ08xBHpkztbklIxJpPZrjAee2s
Message-ID: <CAHp75VcVT2kQO+URZbrH_3-A=4DMZU1KfcQsjDf6bNdtjf=t+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Alejandro Colomar <alx+linux-hardening@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 4:42=E2=80=AFAM Maciej W. Rozycki <macro@orcam.me.uk=
> wrote:
> On Thu, 5 Nov 2026, Andy Shevchenko wrote:
>
> > > But yeah, I can send them as separate threads, if that's the preferen=
ce
> > > here.
> >
> > Yes, in Linux kernel majority of the maintainers (a bit of speculation,
> > I haven't counted, but it feels like this to me) do want separate threa=
ds.
>
>  Cf. Documentation/process/submitting-patches.rst, section "Explicit
> In-Reply-To headers".

Even better! Thanks, Maciej, for the pointer!

--=20
With Best Regards,
Andy Shevchenko
