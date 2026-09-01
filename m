Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF14766A8
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280335; cv=none; b=D9Q9/5hQEcmUbJEOn8RQw1cVgjwNGWVrcqLtDF6JZlCPyivm/kpeLjkg4Ocj7YJLfeJwvR0z4Y8xvrIZC9p8DPpavDFEK/HmUiY8PjeuoEFOvamK+MivJNeNEFNCg3jCVp0VOrTRdISKiS+GMg2A12LYDetkeKILcREqFHYFDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280335; c=relaxed/simple;
	bh=p4GObHGaJ5CEWbDCuhA6lpqninXfQCRLaBbM7efY+I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7rXr2+odY2U43jsGSbEZkfFIelnBZFOAxHlX9jGix6floXueUA6Ed7zK96zbVyVv8w5i0dlzj/JcjqCKVznQZhlCdASxKZaXMVgwZVWCsO/8dAm/iPf/Oh6qE+37QHU0ADmdgwXfv6QqJqwGc9U7V9UFsCwsK6hr3oV7nHqeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en/DMJ+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en/DMJ+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522431F00A3E
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280334;
	bh=n7PsGS51DMFD9X2awrSyQeuUAIWY2ojuh4Ip9J/3AzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=en/DMJ+B4O0/lZDAjP2LwhNUDO6ZaRsmMhWKlLtrQpNY8IJwbMlZm5nFRJAB5C92w
	 J64nx6gY8vnF+TtbL5dqkhKPe2TXGAPq2gJJR3jDr3vJce7fG+n9YLUlal20vUV0TE
	 CtekgujcmEInVMOKHq2qcDSHIc2rOebUafVxl2KjmRMtyzeNp0MbYQ2FGbubJC75w2
	 e7kKBZuUUCqnuJYXXS0IhU/uBaekk3XLIEsSN2CC5oGuahjravyQwQIoaVfUoBz6xk
	 wpqmEqWZLqrM4ZT08V1v5EE8XAiRVcalzWYiZ7K1inhoQ+sEUk2onTRHBoTSourZYb
	 ODcsJihWcBH2A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a305310ddaso251691fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Sep 2026 09:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWa3mu8PoLgn6k8W9pUqQmWByUyqj+razNiZx8ZyHIMQGgB7/lknzzEWY0MUskRfjr+0isLLbRr6rb@vger.kernel.org
X-Gm-Message-State: AFuF++lU9jgAGaFMMnF+EGKETF2mDKj55iM95FhP8Q49kBnavfcxKfsJ
	jl88/Ntxyouf8jtuIUtw9AzqyfaVjYgfkg8N6RegRykpYJl7dz0+GAI4Nxry3WnjIlbdYM92OU3
	x25hxpo3m+/XWvK0fjCvvhLBjvCF2gH0=
X-Received: by 2002:a2e:a9a1:0:b0:3a2:72c:cde9 with SMTP id
 38308e7fff4ca-3a339661bb1mr22065241fa.4.1788280332554; Tue, 01 Sep 2026
 09:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6314925.lOV4Wx5bFT@rafael.j.wysocki> <apaCk3qmZ5hO_aNC@ashevche-desk.local>
In-Reply-To: <apaCk3qmZ5hO_aNC@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 18:31:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKCLBuSQX0EnzEftQZaq4ZSCpTFOGP5u4cx2gxieJpLQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wzb093icNUrYCJFMRArZKM-wbAwOubP5kdL57VnOA0hhP0Kg3PeTHwRNw
Message-ID: <CAJZ5v0jKCLBuSQX0EnzEftQZaq4ZSCpTFOGP5u4cx2gxieJpLQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Drop two fields from struct acpi_device_pnp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:45=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 31, 2026 at 10:07:10PM +0200, Rafael J. Wysocki wrote:
>
> > There are two fields in struct acpi_device_pnp, device_name and
> > device_class, that were supposed to be populated and used by device
> > drivers, but they have never been used consistently and now they
> > are only set for the bus object in acpi_set_pnp_ids() (and never
> > read afterward).
> >
> > Drop them along with all of the associated symbols except for
> > MAX_ACPI_CLASS_NAME_LEN and the acpi_device_class typedef that
> > are used by the ACPI netlink messaging code.  Move those two
> > definitions closer to the struct acpi_bus_event that refers to
> > the acpi_device_class type.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > +#define MAX_ACPI_CLASS_NAME_LEN              20
> > +typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
>
> Are you planning to use this in some future code?
>
> >  struct acpi_bus_event {
> >       struct list_head node;
> >       acpi_device_class device_class;
>
> Otherwise I would go with complete replacement of the above to simple
>
>         char acpi_device_class[20];
>
> here.

This is in use in the Thinkpad driver.

It might be replaced with something else, but that would be a separate patc=
h.
