Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794307951;
	b=Io+Z6+zejtQ+foKY4uPmmCIX4DE19MizbNLkIIf7v9+5+a7FwhoG4QjP4dnd7J1+/HcB
	 AjuCR+7effEkoLBQfLfjN2SRfhHSrkyMxmdllhpuMeewfbhXeRkKv2lN6pbcvK84P+cB8
	 UqqK8B5zdOt1hKwpEEvZEKltvG2OT/48KH04gLH5o1MTT3Td1kb9YWxukBRkPSWbFNGxT
	 peN0FT0Pwe3ImTNT0uuuh8gi6jZRtGB9l+rFwTp/f9iX7y4V/U3G+x1uo6/hiNSa3yZhI
	 yKcS5kBjIvlCwqt97wLg/k7CGy/0UIc0zXSoxE9aW2UTvB+bMZ5+pwDwHYIs+rdq0Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
	b=PXTknle0Av9cPmHHBHw8ULGCMo4xaGk9UAZg2TOyHyUjMKcSUTaMptPWc/FvV96nhM08
	 ZzybrLV9nnNnHrGkxSpwwEp28Vi1gnyQz6vVp8AXJmWRuBFxwIhVJPqhBnBXsQnXpZ+we
	 zIu+daeOELf5eM5TjrFuHEECQY1QRAFilS1wUni/ruR5qNDQNlMZcsj+R8I04pF1PkB1q
	 +zrkVLhDYkY/GCD7/1yn/uVB2pu+QyyvHKrikjcVZlswInCQkLWE/KUvYM8OUH21MXEVD
	 rX6Y4C6W682veQQ9Xu6WF7jyMhjvSqJylrI5gfR5rjpuFvHIR8lkLV5ATTK3cxHR8Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2yKUg4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42002606A333
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 10:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42002606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2yKUg4k
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b308fca7c3so17389117b3.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 02:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794307950; cv=none;
        d=google.com; s=arc-20260327;
        b=WD9QBmHB+JBC+jlc99G8CdwILSr/LkXMogPFnDEATNTa8LYp7FL5TjfR1IlgSeUErd
         lJR6qbsN2hcf9qVrCLqX9RDWBur7jf1XHGSoCDa2nViFDIgJkyX7XsiG9K9dbnc+R1XA
         KyLTW4ZuuJKzMKfknYfWM89IaOTYakQ3y5tm01u7RFrpWjx8Obuc9e0yKbQJfrfIhCat
         UC+wSQZ6XpNN5FApPVSug/FBrLvDe0m2zOpPHmUgg7r7EjVc4lQEgebTLoVQs8NwjktH
         IsS7KSWRnACaICiRxEb75jlFKDIpM31247fBRduhPGku7FJmAG8xO6jnJql8d/5ky978
         0HoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        fh=VSQS4c+VcsaF404fyf3QB3QWF4HxG4aa5/bnG0HMuLE=;
        b=GEoVQJ2UE8DABRvIstxSPPvneUbWi3SQyc5m+D5F2+TNlRKweF1nZB6r9u6aqeUad9
         /oOTdBFECpTLKxcURsmG7lYThE1EtMiT2nNyfjETEqwwYyJ7zEZcwh22XRiK+MLkK0fG
         m7s55v6aUyfMVOeFn9Uhb0BJqohrX+3WMBy1tV+DF9J6A9AYC9SXkelnA+uSwJprHcvZ
         +i+UwuNfH7a9EKyiMN7SG6iNilHwyytqxkx6IyhZAiy7Lr76eHYEqKYvrHFOcQ3VaW2p
         INTfJYwSA42dJPX9bWRm8K3CpITXFE4fHuhuR6tVfgvqdOsc02dbDyE8G4s9F32CbZIP
         F0vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307950; x=1794912750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        b=G2yKUg4kkkNyrAQLdA+svzeZn6bsiQXP/vEdrNCmE3xn8ePwe7ypVchrXLzPlmsfmW
         lzJ/znIv2TTl48zXBASM/vBEzAZQnZV3IFI5K7mcP1Sn/aQJmC0Q+3u8jnETQdK+OdKT
         UMrinFt0wmlR5B7U/Wi6+upm+BxqtF+PZgq6G7oUC/R/Rve1Wc3Qgg9fKoBY1jL0KR5y
         wgYtSJTLX2BHOwgJdKHSOoj+wx6LNeG9PNM34mQWbkp45RbZKXP4v4JWPrUO0bsZObJ2
         PjKKSQAC6V527ZMIejd5C4uGw2iRY5wETwfo5byFtMVf+095etPOYZnI4Z26jWNMjqMB
         xylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307950; x=1794912750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        b=Uc/7YbhS3ML3+ZXaAZ1LSUsnua9T/j1i815eO3TGXHmRth0rvndutedNU90Snfrtl5
         BFAGOBZ3xMsKjIUcAHayMUrr8Rt8RLj5C12Y6nHKW+p4wcdQwWGz61hTDZ4fyOwQg4YJ
         NZYirVt97QRXFvIbcBXCY7KJXMtn9koXdbFtefA2spIVsDdGAwvI8oWYrTQxn7Yp2uhr
         FWh2t08FmMauMNjkLLYcqK/92rvyeVvyvw7vmAQ2/14HKObNZmHP4Xa8fIa0sJ8UfiLU
         oIkso+QJEnwBNYvXc7tlUXSj/Y5IChksE8DQRCiXZh0+FgUtiaWFaYwwCFDlfPVubDtr
         UAAQ==
X-Forwarded-Encrypted: i=1; AL+hErHSuw7ZPArSU5wO++nUSDbjlEOAVxdeOYMjendLZZ9Oqq2rx1IusaTSUmkY8OLh5ThN5fRAut0CEW+h@vger.kernel.org
X-Gm-Message-State: APuU4Z/kjwxCRGCJQ5f/ARyjAMCz5p2G4OQEJOQY7enV5/4jKcX6xLK/
	g/LDXNCMQPP7oENQ+eLxWdzYnpeWlQLQDJB+d+QPTqwN0pMEXSV0p1q9Bvi8Jg8pSVNdNjJbAUS
	Je1xfxxSEI57JtdVqEz7c41pSrwekoYM=
X-Gm-Gg: AYBFou0JTn1VMfrxPYZ1gilJ22v+U7q/lmoaYspFlqnufWMqJ/4HmZ+c/EvJv8ECvxY
	ec614ReSKMInXVvVZq5+UKepPMKL85Yoai1NqYb8NGATrpUKP1bJ0ThnevtiISRkXwW2BwyKgMO
	Gpydsibvoy80EdU3FTkhX+vxE9wY5vdVs7TNFoXkDvUn3waBJdwmOTjpaMSxr+XQKPbNP04Psv0
	B73L2OW3phEwG+X81pgGpixqaOyqAwcD8Ud5zZITfsw5Nd/HgcjBs1OBbrzHMbELZ0o1bjN8oF5
	BnXuV1hGn2n9YVcG9H2jj7xGAKqWavqhdegCYzqi7MRIuvfA2XsJBB8zA+U31FIPXN0b6jKM8JP
	hviXF7AatF9kw9Z5ksOCVsrr9R+F7nnUEITNr4WHGyq4Bqbb/hClSKvl44wConPFz67VHyTRTpk
	RYRboYpjIzI6zFqm5zTXnrxr1pH9SNJZ6dX9oOnAQoYXTUmkHUmFgWJkuEqpThzKiHOkmhRByMi
	iRrVZEqA34ZTQb05nZLDz6iQLN/qvr8YiIeHcd0ERmudrUxTJTOxYau3LC+Xg==
X-Received: by 2002:a05:690c:4804:b0:8b3:4022:d81b with SMTP id
 00721157ae682-8b39281e93amr14763687b3.4.1794307950215; Tue, 10 Nov 2026
 02:52:30 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local> <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local> <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com> <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
In-Reply-To: <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Nov 2026 12:51:53 +0200
X-Gm-Features: AclHuK_OONOCVTyFsjjRyXe2igkmpzvumbiGAvSGjLyAIyl_gOSbE4gZk1U_Cc4
Message-ID: <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:50=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
> On Tue, Nov 10, 2026 at 11:12:02AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2026 at 11:00=E2=80=AFAM Bartosz Golaszewski <brgl@kern=
el.org> wrote:
> > > On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski w=
rote:

...

> > > PS: is there a way of using match_string() with non-const data?
> >
> > Why? It's an input parameter, it returns an index. Whatever you
> > provide will be not modified.


> What I mean is that the following change

> +               ret =3D match_string(merged, n1, sec_props.array[i]);
> +               if (ret >=3D n1) {
>                         merged[count++] =3D sec_props.array[i];
>                         sec_props.array[i] =3D NULL;
>                 }
>
> Results in:

> drivers/base/property.c: In function =E2=80=98fwnode_property_get_names=
=E2=80=99:
> drivers/base/property.c:607:36: error: passing argument 1 of =E2=80=98mat=
ch_string=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-t=
ypes]

> And I don't see a good way of working around it without doing:
>
>         match_string((const char *const)merged, n1, sec_props.array[i]));
>
> which is ugly.

Ah, got it! But why is the "merges" char ** and not char * const *? I
believe that will fix the issue.

--=20
With Best Regards,
Andy Shevchenko
