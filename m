Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFF309F08
	for <linux-acpi@vger.kernel.org>; Sun,  6 Sep 2026 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719511; cv=pass; b=cmkkvRMHqHOyU06R4ZerfP/9XsMRrzfIcJtDSCdZVJutpKFYAYb6daV7bj41LDYqkPGpOPnnLhJhykzDYph7MXVmM3sxWQwIrTkyDS/92+Mt4jz/DURkQc8ri33tIVWbdnP7Oq4/F5sV0B5dRT96jOrhRqeNtf+yby7KXoplp6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719511; c=relaxed/simple;
	bh=pvvJqd7Euafnh/j2/YsbTiW/PcrYqSgdLGzLkgxVrCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edlaATZfoywp0MxO7EdGyO8lrqYbR9WIUciEvYtiHhZCQniyw1ZZaF9okTqZ5D/lJN6G4NbziCC9Ak58fKbp5DIaxV3HeWd2xdwEQU//2z+5n+IgXOytDkIgiyNrW8Q+snifm863wCctWQMJijZcncHlNeiHWjLZTKW76R79NUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evd1MPP2; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evd1MPP2"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-85b293528a9so33927537b3.1
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 11:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788719509; cv=none;
        d=google.com; s=arc-20260327;
        b=kSQDy6qBBzMgIeS+N13SQ13CAaRnDJPWsj2IYa1yXil7Oqcs1RNtLxZmbffgBWK4Kr
         DiuW/h+M7OUlWrw+nUSC9XJd+lgT0LJ5Lg8SacNZD26B8Y7ClcRKlHLeHpO1N05mEeeK
         tQ/XzUWmRYJcjdQMeHPpJKNDbKmdoJpioqL0ntsbeZeNbyYbJPW6/V2Eo+r8/hIL7fm7
         E5LoZJ3iJR2XZfc+bLOUIfrbfaohUvuqmdc3luOxN2g1vBM/Rm9V+c68lWapsYpl+X+p
         uZQvfLdVVAZ9faXZNerTJ6TDzeaZOGOiJKD1sfoY75QXjUJXFcQGds8bQ3WqVe46jbZ9
         AvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        fh=PB7/8cfhhSefuTtiORO7qdMceV8f4IKow4e/RVayT7M=;
        b=c2YAyVeLFOAtHEzZpOy7afSYbrQsnPQlWJpJ//fpwSH4ROKUlOjjliNGp5DG/zith2
         QiwsSsYC6kFXO1j0h0+TVj3izm7ImGSr24HDg/Qm6CWgJ2dc/LAiio7KGi22vRNzNZCQ
         q+QnAvPxG+co7uflkqW4lecvV9rwhdLHRLKHw3mh9XJ+lyQcav403vScrFrTZBv9Nkxt
         7YbfJxqGvCNNis8YcH2uRfWMyq8r8xWSeaBgogw4DpD/OHnUDa95vhszy9Mm3SBf5WyU
         l/o9tvbNWHUOVs5xIqo9qywvkQirFdX415tamBF6JhnmOvS51TzlXWfMm6592Gj1bQwx
         Jqtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719509; x=1789324309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        b=Evd1MPP2ae9RI8xQA/e4mGF7AG0IOTfrpmqWKNKTPZCFpMP1iagR2rLpyDykWRpdL1
         0BXcOJRac/vAIRNq4hYL95a/jACbSDRyza/flWGaM0PjaCpXOSTBjBZKQxDihp2TabKn
         9pTMrKSFHnuiYFB21Z7jC9HpHkVjKSrkc9pyGLNb2y7Q3emyER7+gY/AbNB5jo2OeCzT
         9JZK1xhUryo2gELVDELa+x9KwW4SDD1wcA9Nej2R9kNMG2h5bzFJp1AUpnDnTF7mM7Ma
         x4zbMLCa7qADhqMxxMLXeKSUyYfcfWpLlEucO2lfmwN8KS3GVxugpLZPYBYgOAg63TjR
         rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719509; x=1789324309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        b=mDqeRfohwFKNhiT7sUiNNqHPZGfWMaSnku610Uy0VMvM44a0IbfWiZ2oHnq9004m58
         DqED7MazQp81gcbBDsOyjRJg6j1Zeh5lbpJRcGPA+sFaGx/Hv7uUAfMMuoBmFs7NSm7o
         basjROpOIb6EYC+g/wv6IZr50WfvzuZgbrUwfLNSsNeZNXRnC37ufghXbZvGqNTy0HKh
         OtvVD8X2kN+Qxv/8EEEHkkscGuXqEwIeeHTrwFPTsl1lg4enucU+JSqU3QMp7IYUgOYV
         lbL5obtBaFbrc9QiVwM+otqDTHI298UldM+HPYFT5xPx20lR8LGRUHyfslxeCH6/OE8g
         FZ2w==
X-Forwarded-Encrypted: i=1; AKwUvByBFLIa9tclt0kmkHP0CfSuu+9pno+2GvxbTCALklfiz0TdB0xffJ6h/6ZzNJ8axUad0dtuyctiTYzz@vger.kernel.org
X-Gm-Message-State: AFuF++m0cvw6qDmZEPKEuy5B07SRl3MMEDsXrsoeArskqKTaX5k5GrAh
	KshZRwcZNXgaYbH4A51OP9Be9cPQ7udmXKzwOiAILnApVdJp0zoawLxqZubBklLTLoa2UQeuQl7
	R1sw4ZuNHyEV7liicCD7OswlWFXE+kZY=
X-Gm-Gg: AYBFou3pSM8+e8IcD+zCwc4r/q8v5RdoJU8t7u9pwwEolN3E+7C13fVqoVZ95o/37PG
	XuWXmTQQbP8TIx4Vdksu08JFaJfJ339bBtSJhNQua9loSqznPUmbtLS7rjvS6KyeATWFHtxboxh
	/Ce1Vv2ABPYLTG7p0pQkWsu1OHvJZBGKDJ27iUwtP/2N8D2IPis0J1fKpsby0i1YfYixWaY4GOq
	hC9yXFCnaXjYCeIT6ez/ILp0X0f9FFsQifM7IHQzlN8LsrDl9XtzemRO15liJ5rlFWBQSEIhu2E
	JSvq5vhiFngjlfN6uDuJcWwr02/ILKcbnm//Z98FwGdGOTUFoD4Md3j2X4nR61MEOEg61wHssrm
	9ylo=
X-Received: by 2002:a05:690e:43cd:b0:66f:c1bc:403a with SMTP id
 956f58d0204a3-66fc1bc490emr1136508d50.27.1788719508881; Sun, 06 Sep 2026
 11:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955564.O9o76ZdvQC@rafael.j.wysocki> <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>
 <apbPV_tsyYVzvEVt@kernel.org>
In-Reply-To: <apbPV_tsyYVzvEVt@kernel.org>
From: Julien <julien82453@gmail.com>
Date: Sun, 6 Sep 2026 20:31:38 +0200
X-Gm-Features: AcwNN1XY9sFlhyINrgcYqoQq92RQCKR2qxwUOv8SXLhPuRgwGnTe1uxZUxAdUfE
Message-ID: <CAJOGg3z22-G_+izney69i3AhesqwX-u0Coj74zXSjb-RzSCdvw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap completely
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-integrity@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 3:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Sat, Aug 29, 2026 at 12:43:30AM +0200, Julien wrote:
> > On Thu, Aug 20, 2026 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> > > with resource overlaps") attempted to avoid platform device registrat=
ion
> > > errors due to overlaps of resources of the same type returned by the
> > > same _CRS object in the ACPI tables.  It did that by combining two or
> > > more overlapping resources into one, but it went too far and also
> > > caused resources that overlap completely to be combined which broke
> > > the arm-cmn driver that expects two MMIO resources to be present for
> > > each device it binds to and it expects those two resources to overlap
> > > completely.
> > >
> > > Address this issue by adding checks for completely overlapping
> > > resources to acpi_platform_adjust_resources() and add a comment
> > > explaining what is done there.
> > >
> > > Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices =
with resource overlaps")
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > > Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@a=
x162/
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * It is better to check for complete overlaps both ways as suggest=
ed
> > >      by Sashiko.
> > >
> > > @Julien: I would appreciate testing this on the machine that needed
> > > commit f234fdaae1ca.
> > >
> > > ---
> > >  drivers/acpi/acpi_platform.c |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > --- a/drivers/acpi/acpi_platform.c
> > > +++ b/drivers/acpi/acpi_platform.c
> > > @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
> > >         for (i =3D 0; i < count; ) {
> > >                 struct resource *res =3D &resources[i];
> > >
> > > -               if (resource_type(new_res) !=3D resource_type(res) ||
> > > +               /*
> > > +                * Look for overlaps of resources of the same type th=
at would
> > > +                * cause resource insertion to fail down the road.
> > > +                */
> > > +               if (__resource_contains_unbound(res, new_res) ||
> > > +                   __resource_contains_unbound(new_res, res) ||
> > > +                   resource_type(new_res) !=3D resource_type(res) ||
> > >                     !resource_union(new_res, res, new_res)) {
> > >                         i++;
> > >                         continue;
> > >
> > >
> > >
> >
> > I have tested this on commit 1b78070aaef6. It seems the patch is
> > already included in it.
> >
> > TPM device still works. Here are the logs.
> > acpi MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded due to overlap
> > tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
> >
> > If in the future if I need to make tests again, should I do them on
> > the Linus Torvalds' branch?
>
> What was the hardware where this happens?
>
> Sorry, if I've ignored it (if it was mentioned previously).
>
> BR, Jarkko

It is the Acer Aspire ES1-572. I reported it here
https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe=
4EiurZf3kPU5A5Bw@mail.gmail.com/.
