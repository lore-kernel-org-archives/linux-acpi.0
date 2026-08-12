Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F7432E9F
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535675; cv=none; b=RfbteUiIhBpLdXHNWRW00Sc8sibtGcW6Ew8HZui/G8aU1QfxP8yAG3VKxxU6+n81JnhFg3baJjP+msFThTanLljbrOTDtY7iqNxd4Wkw/V0/V5T3XsnrOBSo1wgY7yG1PhmQYEmPt5XoFDyNk+7Etmjcp1dN9ePBhW8ZzGNrfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535675; c=relaxed/simple;
	bh=V04oxIiOKaX6Qwfu0eDUjyyTbHP20bfp6ABfCqjPL6g=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLmLtxeFdxo5sLSVaPVlF4ntktoevrf93H0xspKj5dCVBM0wyJhZrzI8/1nk/CY2UcsBQt2TnymYxNQGNPZE6v7Q/UxTPM36bxHbXrF03/d0YivxPlkfdrzp8cPYovWEGuIFQGeVVFXTgukAYn5a7JTpFR8vG3G4atLwqOyEDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9RuMmW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9RuMmW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2D21F00A3D
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535673;
	bh=V04oxIiOKaX6Qwfu0eDUjyyTbHP20bfp6ABfCqjPL6g=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=l9RuMmW8rXRK4n7GY3/TLToVenL4lNuQ2H9FEPnwaFYgtgQzm9PdVI8yZp/vkNOC8
	 rFhbZ43y1S8p9pLsExr1Eb5E365IGB/pb/nVDP69oxSC5iSt3P6q1+O8ya5ATbWsJu
	 X0fe/k4Wf69aK0tyr0W17chOi5itBHBIaox3gSAOqPRNuvbaZJrUYLJ8WVFbBVxAzD
	 3a67lIBoGm27I2I7IOPpXLAMoYs4KvZiM7Zdyj4AZmB2QSKxKw82SlPUD3BzdKXZnO
	 YiHiC5Vvp9cMMBtaLEN7PpdJP5q8w6M8+snhz/kgdSgAV/br8YzDnpAooYFSEa35ou
	 hUFmB2TcuPJ4g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeba09900bso657193e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 04:54:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9RUj50kKBnm7d4vni4Pssu+yHFBVrtPCJCXLHZHbZn4jI/vduyaKezmj2UQuPpI7M3rN2a9L0oDBV@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEdFOKuQCorzGCIkPx07xlfraWR64guoByuds6gfe3g3rVNRp
	simFNby09irufLKXMZo0kJUh0Sfmf/X/aiq3VHfooOQfOWFImFzSPlW6MUa9j3SzYdm/oREeB/d
	f/+wpeXLzuGHuT00j+5+RUwtTFwvaIoEzQrTqAM80Qg==
X-Received: by 2002:ac2:5463:0:b0:5ae:befc:97a7 with SMTP id
 2adb3069b0e04-5b44e2e5fa1mr499708e87.13.1786535672419; Wed, 12 Aug 2026
 04:54:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 06:54:30 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 06:54:30 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <anwxWXfqSt2bM8iy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808155513.2221976-1-xnorigc@gmail.com> <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local> <ans3pcNFEDVBYXXT@ashevche-desk.local>
 <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com> <anwxWXfqSt2bM8iy@ashevche-desk.local>
Date: Wed, 12 Aug 2026 06:54:30 -0500
X-Gmail-Original-Message-ID: <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
X-Gm-Features: AUfX_mwRSu2nv_pAqWc4B38gMnuPXDZtrNBE8z0sltLQ5Ti2JdbI-jy8r8iop4E
Message-ID: <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air FA401GM
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2026 10:39:53 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Aug 12, 2026 at 01:23:53AM -0700, Bartosz Golaszewski wrote:
>> On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
>> >> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
>> >> > On Sat, Aug 8, 2026 at 9:42=E2=80=AFPM Andy Shevchenko
>> >> > <andriy.shevchenko@linux.intel.com> wrote:
>> >> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
>
> ...
>
>> >> > > If AMD people will be quick enough to tag this, I will include in=
 my PR to
>> >> > > Linus W. on next week.
>> >> >
>> >> > To Bartosz?
>> >> > It's gpiolib...
>> >>
>> >> Oh, true, I have also pin control stuff to send!
>> >
>> > Okay, I have checked if I have anything to Bart and it seems I mixed t=
hat with
>> > pin control stuff. So, Bart, if you feel confident about this patch, y=
ou can
>> > take it directly. Here is my formal tag for that
>> >
>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Is this a bugfix? I'll be OoO until the end of August starting on Friday=
 with
>> the exception of a single day to catch up on email. I'll be sending my P=
Rs for
>> v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?
>
> On one hand there is no rocket science behind this patch (that's why I ga=
ve my tag),
> but if you strictly want AMD to confirm, then postpone, so it's up to you=
 to decide.
>

If this is not an important bugfix, then let me postpone it until next cycl=
e.

Bart
