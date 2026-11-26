Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683609;
	b=eM/6LzH3vMCwJgRJ8jQCrYMgrAsS6SE5wURvtBJtybe1lGUrni4DW4XAHAHHL/+MFz3Y
	 B3pzY5uu538wlim2yQ07ZwuaO6abkbX0fojvyQoFDFQ5ZZn2Cg1Ss+9UC2aA10rS/7Mco
	 ddLkKUvSpYmNR7WU4wm4SXPsetLaRlzvYDsA0/2cjTF4Qm28/0kyF2vqv7ohMt+4GqJS5
	 gQtGAVNBmvIwxQl9T7sbphEEAy9WIRNdfiDEjP+JhJkV+LQASpFlnyKzFWpN2lGD2y+HH
	 V2XTpk69Bewsh/z/Md7lVhgW+FZSZKfwzfHFn+vFnwmXVbWODXi5IeBJf9M5woWbcBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683609;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LQC7n5UB+twTmoKbhuhV7McngclJ8wPtfQsYLymxWtQ=;
	b=vTM1OJhJLGsbZpolmQ5oh0uBa/hpmIKDkdPEGQiVeoqQnlIukFeyKBO7BqjxaB2aiKAj
	 YyroAsJRzzF+LCLVaWtJ7Tb5MIghfU5migTECmV9OR6/xIilMRv7h3B9woTtVZMbNA/tK
	 Aa2KeKDY86YNw+EjoKQqKPpru8Un6b5cfVMo4AS/b7vmvk2itiygTF0k6Hx+bnHfSYxLh
	 TcjTkCHYb3oAHIsYyhOJMNsRxB41vvF6LuXekYNgyd+PMDTWdsuXS+ywKGInL/f3B101e
	 17EE/Ce4pNrGlaPLZ0RYnc3SIJ3mHau4yekjeCnEg2mYtRMBJDiSR4MsqPI41L6G5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C7606A33B
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E2C7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-844a8bf7e25so3650852a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795683608; x=1796288408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQC7n5UB+twTmoKbhuhV7McngclJ8wPtfQsYLymxWtQ=;
        b=KJ1Oud8DH0bWDaibz6ELxauNSHEGM/OBUFp5z4v2CM4MBJ1QrfMFavFNechTKHpJo2
         fflvZ5zjk9Dzy3eW4Z2jFOz4xoIChFv0qe0O7PL1zrsGWRmWJKNa6SV90Y9raH+ikofQ
         TFgfhn7nvtmlu1iO3Mz0IYtbc11XsqwwDC9rwwsi90V9N6p5xQ7JAmt5yWDscuSpxmKk
         bJAWKdyvfhTgBr8mrb2WnbQQkhumnptpeBGOIS23pgf6FqRjf5U242gCL0ipU6GJFnSe
         kDwdypF/26vZwjEzVx0pYktKoIxwZbC/cExPvHQeV6CfHfPrlLeGHMLhCaL5sNHYwcsz
         ZKPw==
X-Forwarded-Encrypted: i=1; AL+hErHwxekKh2giXWNZ9IcDCeGfRhJaIdJNRvS0x9qKQB+CAw448dWhLbwEyhsfALmhQHxW47QUs2w5ILCS@vger.kernel.org
X-Gm-Message-State: APuU4Z8B/QUGmem+7t2AtFREfXlxplZQUiH56WmwyAGKrO8JRVCybpdX
	d3I1Ubxl/nDEpLW1q552qkdD/v0jqWim0q9zqED1zxOON0TBcdwsd1VPAxmGFxa5
X-Gm-Gg: AZFdTZdTcafGSaEJz8QS2ZeYWEi5cyCAyr+Oz4o2cFN9Ol5dlqwaPvY5GvfCyA0tf8E
	5OTzV36SteIHeo+lybCpN83aM6nU5UXN/SLM1GBPXRkI+cSSDTuuN2ovpZeoVW78eBiJD1pfdOc
	9fLYui1x1rKBXVthReUj2A0O7cYrKXXw7DoSeOU15OrvGuiqCkcaExGcifBud+3h50pgQlKSnQe
	cFUu/bATNLsfjokcQPdn0sVwP4fRRJCRYNa7fTjIKetlVKoa9PeAAhhUgv5OiizQMMyhu9UWrA6
	6A2KiFxTfGUYJQsedjKbo/+U+v55ySGkgkL3bkhrwXPnn8AGSMfnedehIFA8vfjg150sLEPyw8s
	JjhQ5lNchHEqUWgKO+K7g8Y7xBxwy178jDPKgZhk6tQpsymq8QZy8BNZ3Lp624lKToUr3gO6eYc
	Sgyslig+dnmh1PgiFSJ4xOpQ70NaSTmkSfMPcVH5ytpYqZB0R+/x1EDwwTR35vvefNLOw/WhYA8
	xAuRAZoI7QvY0FelfLpdx7S2AuzwmjRYgZbVAE3ffkv8ZEHJ4CAoy2MObQWejgimFPnlmXGLAjm
	BXLXdVHNh9NcIzru+ntSWFdrEkp1ybZX+p3Xz4i3TyS4FeyafR0bPAkcJJMy6SwWIio=
X-Received: by 2002:a05:6830:6814:b0:862:e9e6:6297 with SMTP id 46e09a7af769-86315985934mr23811523a34.18.1795683608165;
        Thu, 26 Nov 2026 01:00:08 -0800 (PST)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d9asm15668065a34.17.2026.11.26.01.00.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 01:00:07 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70b875f6f13so5113562eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFKneo/sXnJpPVjdvbkk7ctsMwRNE0Q2CxGpp3Ja2rl+MCe2BSAFYX8R88yLHV92K6RyDoeOK3wImUB@vger.kernel.org
X-Received: by 2002:a05:6122:e16c:b0:5ea:bfe3:6035 with SMTP id
 71dfb90a1353d-5ee8aecb450mr12178985e0c.8.1795683175291; Thu, 26 Nov 2026
 00:52:55 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795639368.git.alx@kernel.org> <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
 <awdaYz9NNVv5fHv9@ashevche-desk.local> <awddHt_xvc-lIygA@devuan>
In-Reply-To: <awddHt_xvc-lIygA@devuan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2026 09:52:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9gnV0beBEoh65FzPCwrQy=WpGtK5qKsOF3Tsv9iUj0w@mail.gmail.com>
X-Gm-Features: Aa3M54rOnub7bCh_NzEEm3acSwF_6HJABwfoziM7rtzTMFRTInpGyKc2wQ19vKo
Message-ID: <CAMuHMdX9gnV0beBEoh65FzPCwrQy=WpGtK5qKsOF3Tsv9iUj0w@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alejandro,

On Wed, 25 Nov 2026 at 23:18, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:

> > Date: 2026-11-26 00:00:03+0200
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > On Wed, Nov 25, 2026 at 10:03:55PM +0100, Alejandro Colomar wrote:
> > > str_has_prefix() returns the prefix length on match and 0 on mismatch=
,
> > > so the mistmatch case can't be told from "empty prefix matched an emp=
ty
> > > string".
> > >
> > > For instance: the OF root node's name as returned by
> > > fwnode_get_name() is "" and will return 0 for any name matched agains=
t
> > > it and since len is 0 too, fwnode_name_eq() will return true.
> > >
> > > Let's use strprefix() instead, which also makes this function simpler=
.
> >
> > ...
> >
> > > Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j=
4lb3flk>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j=
4lb3flk>
> >
> > What is this?
>
> git-am(1) has --message-id and the corresponding am.messageId, which
> stores the Message-ID from the email header field from which the patch
> is taken, to document where the patch was taken from.  It is stored by
> git-am(1) right below the last trailer tag from the patch (which should
> be the 'Signed-off-by' of the author), and before the 'Signed-off-by'
> appended by git-am(1) itself.
>
>         $ MANWIDTH=3D64 man git-am | grep -A5 messageId
>              am.messageId
>                  Add a Message-ID trailer based on the email header to
>                  the commit when using git=E2=80=90am(1) (see git=E2=80=
=90interpret=E2=80=90
>                  trailers(1)). See also the --message-id and
>                  --no-message-id options.
>
> It's useful to document where those tags come from, in case it's
> historically useful.
>
> I've extended its use to other tags I take from emails.
>
> > Is it documented tag nowadays?
>
> It is not documented in the kernel, AFAIK.  It is documented in
> git-am(1).  I included it, because I find it useful.  Feel free to drop
> it if it's not wanted (I can remove in in v8 if it's not wanted).

Please drop them, the tooling (b4) can find the origin regardless.

BTW, the kernel way to link to emails in commits is using Link:-tags, e.g.
Link: https://lore.kernel.org/avrSUUM3HMgxTNpl@kekkonen.localdomain

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
