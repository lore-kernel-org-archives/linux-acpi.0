Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BB322C73
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536174; cv=none; b=PpLQf9v7SSWhxXdj3e8RLlxBuhZMT8llrh16ZEJB7IDxV+ZAcD//ECpDNw2zVjWHs/loB+yv3ElqscYverzVAQxm4acckUIUZSCTXVzpGvtpO7xCdFMPPpESMw+M7ET0ZO1YHp9b+AQ2P74Hq0397R0CFKontFBkrQlT3Xp4XJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536174; c=relaxed/simple;
	bh=Heg1qKwJNbpnpiNSZ7pcG17dhllkUQpztZGWwQ5+SVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdoWEoTWYgIRBQYQJtqxsXsfUqErTtLCPg48lDJ8iLW0q1WMQtWe8q1XbDaqIgYif7MAvJBhbmxYe7eJsNC1JUeg3AQ0h/Ar66oiq3tplpRN5rhVzTJvOq+4BXaXvzVm1Wa/15kRKGJ90/uCEV/qLoJwT/zfJW4DW25PdQgwQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8qj0oE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8qj0oE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403381F00A3D
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536173;
	bh=uvNIA4pyIqQL809luPFORZ74KYFo/MOzx/1VeZaBUZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f8qj0oE12goM07b4JT5BbteG+FIvXVe48/CpLRcScvsteGJ/d4nHD1MaH7xg8qchl
	 zGEjA8LPCW9iacoufz0tjMV+gW8NoLnPkqBw33/vSWMBCG5Qkgx5kEyKhs5KG0j52i
	 3E8IdIynzwLcSd9UdxP8h//es9tsoUH96evCzZD/6U1I+iSeq1JtWyubH++tdTMGNY
	 PcKwH5jc+SRvAoP25sSu9d7pFKRxkUT+wrUE7RczZkFfa/1mN66UgYBAEh//sXd6/K
	 bLqMcy8u32aPdrmusxIkJ2LnrLb3bvTn4IFJAWA5+meBV/nRrUGQ0EL0DPUVwPX9VM
	 ase5k+2ANcE/Q==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b013084dc2so891353e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 05:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoTJkMMrEFTTQRs2NOZ4nWU3Zx+WfsyQ3FPuAtDpFN8KNf9j5ZKN7o4y+T3A7PDKJnr3DumD8x1MCCh@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBa4Nvz1p2/VTqstEoJkAGXB1UNO9NvFJI3gRLwepP/fDUq36
	Ldy7JaUBX+aN6rJfHcccklwqP28dXUxLO0B5WDfS+M+r6PLUX8BPmwoAg+5JzRVCvBHaVfFjCnV
	CYThy49+8MfFYqwTI1nOhKopvJ4UvrQk=
X-Received: by 2002:a05:6512:b03:b0:5ae:bfd6:1bc1 with SMTP id
 2adb3069b0e04-5b44e2e6205mr746144e87.14.1786536171731; Wed, 12 Aug 2026
 05:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4764923.LvFx2qVVIh@rafael.j.wysocki> <2283799.irdbgypaU6@rafael.j.wysocki>
 <annxkiYsyfa4nh6z@ashevche-desk.local>
In-Reply-To: <annxkiYsyfa4nh6z@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 14:02:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjJ7N-gRXPrk2=K+4-y3Oim0TE7xbj9hnZc4VbJDuU1A@mail.gmail.com>
X-Gm-Features: AUfX_my3sMLdAIa5wO0Ddxr9xtFglwUrnEE9TXMA67JaFe1BHTYwwVuAQvbOiwk
Message-ID: <CAJZ5v0gjJ7N-gRXPrk2=K+4-y3Oim0TE7xbj9hnZc4VbJDuU1A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ACPI: bus: Introduce acpi_bus_get_primary_device()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 10, 2026 at 01:33:41PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The function used for obtaining the first "physical" device for which
> > the given ACPI one is the ACPI companion, acpi_get_first_physical_node(=
),
> > may return a stale device pointer (mostly in theory) because
> > acpi_unbind_one() may run as a whole after dropping the ACPI device's
> > physical_node_lock in acpi_get_first_physical_node() and before it
> > returns.  The last reference to the "physical" device may be dropped
> > then before the pointer to it is returned to the caller.
> >
> > If that happens and the acpi_get_first_physical_node() caller invokes
> > get_device() on the pointer obtained from it, which is done by the
> > majority of its callers, a use-after-free will occur.
> >
> > To prepare for addressing this problem, introduce a new function for
> > getting the first "physical" device associated with the given ACPI one
> > (the "primary physical device") that will also reference count the
> > device in question before returning a pointer to it.
> >
> > Make that new function and acpi_get_first_physical_node() share the
> > physical node list lookup code.
> >
> > No intentional functional impact.
>
> ...
>
> > +static struct device *primary_physical_device(struct acpi_device *adev=
)
> > +{
> > +     if (list_empty(&adev->physical_node_list))
> > +             return NULL;
> > +
> > +     return list_first_entry(&adev->physical_node_list,
> > +                             struct acpi_device_physical_node, node)->=
dev;
>
> This is open-coded list_first_entry_or_null().

You're right, I forgot about this one.

I'll send an update of this particular patch shortly.

> I see the ->dev, so having temporary variable will suit this
>
>         struct ... *...;
>
>         ... =3D list_first_entry_or_null(...);
>         if (...)
>                 return ...->dev;
>
>         return NULL;
>
> > +}
>
> --
