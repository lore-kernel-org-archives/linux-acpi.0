Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4623911D6
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090583; cv=none; b=kuag5GhoTVcORNCKqXjGkbbUFaJayPw29xpfbj5TEYRxW3O0c3rpisGCLxWRixXC1bdAcCzNNXdBRikNryener35ppEspdVxtNnSVaCy6+YBBc/Poo1P4IVvbSHIxsgoyZqYDScFfpduVya7pAjeIfIvE6XCcgGegZ8T/IcJfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090583; c=relaxed/simple;
	bh=+LsdRFwNrxcLR2BNHazwFmHsaAT9kbfzRXnlP22Duss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP/WbHWiyuR4MSV+2f6dJnfVqZYWaahpuf4Am1+GmQfjhHkqj/Q3uaWIXjkb18N4MCSDO4kaMIozv3ZTw8Z0LDBAjGPp+5ScZTs7HTt4VW2PHtE6T7wr/WNAuKpToHqbXQMiU/FNIx4XJRfYAwgQ9qw8wp0eJPy6YuYiQAHlmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbeJaOgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbeJaOgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3071F00893
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090581;
	bh=6+0MKUYycgrHq2RIL1Iybwb7XWGM6Xwsghk/wqMMVFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YbeJaOgVXBanLP5sJP7bj2/zfZWs/hOsJnHjs7iWyHuP8rpD8rPPeG5bNfZXzdEab
	 O8BW9v/lNH20fjNRoO0BRIBNDuHo2veAmACjwhbVYs+wcx98zNHkBRXSsn+z9f8E5E
	 reRKPSp2/ykV6CVcKTa1BVsX0gjly8UPgDFpubVToVriJSAcCuqU92V9EfIHT1Bo0g
	 bQkvfO/2QWtjJRCYWVYyLALi05S8HxDRzsOB/fhp3kgNthXN6+GslFfpBlrrpckg4P
	 QkEFN2qIlzbmZ56Y7v0zKtacicNDWJlhZHX3PAROFZyMN9axaY/MgC+q9zAUM7+D+m
	 jyGYpQxT2iMrA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49c068e85so37692141fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 08:23:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwiURAKgY54BDPG13GKCT+3YcWmes/HLaJQMf3dbj6cZ5NBPFM1Hgs6IyTEopyN5hdPqRejbpKaR31Q@vger.kernel.org
X-Gm-Message-State: AFuF++lfwbSzHnRHrXD8paXoE7mxqhc0TkE4TAdnh+N8+DYGLIRrkQPY
	JcwapU0jJedFQy7Egd75MxR4GuHX+RAnP0RLShhoRDzZSLckwAjx4hkNu9RqN5e5+TPBsZrgPBl
	OFvzU5LAsd6ulZeOt0uP9HeR73Em3PJc=
X-Received: by 2002:a2e:be0e:0:b0:3a5:dc83:d74b with SMTP id
 38308e7fff4ca-3a5fbf02579mr36859761fa.7.1790090580042; Tue, 22 Sep 2026
 08:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy@arm.com>
 <CAJZ5v0j72dht4wiVcoFmk2Rt1pvPL7Yrr_29jihzfKAb3Pu24g@mail.gmail.com> <7d0fa712-bbc4-441c-90c2-38e9faeee228@arm.com>
In-Reply-To: <7d0fa712-bbc4-441c-90c2-38e9faeee228@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 17:21:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKDgssBn0xBYJ9q--PDbcjyqO0_2rjXOYY+yGhwoLS0g@mail.gmail.com>
X-Gm-Features: AcwNN1VqUeyi7MnRhhWgtmbYpShlIAhpQCKa7X9mV9Hn745nQU8m3n6eh6tXzhQ
Message-ID: <CAJZ5v0gKDgssBn0xBYJ9q--PDbcjyqO0_2rjXOYY+yGhwoLS0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Provide !ACPI stub for acpi_device_uid()
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:17=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 22/09/2026 12:40 pm, Rafael J. Wysocki (Intel) wrote:
> > On Fri, Sep 18, 2026 at 5:27=E2=80=AFPM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>
> >> While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
> >> already have stubs for !ACPI, the basic acpi_device_uid() getter does
> >> not. As with acpi_device_hid(), add one for the convenience of portabl=
e
> >> drivers who just want the string itself - in fact they are so much ali=
ke
> >> that we can simply alias the exact same stub definition.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   include/acpi/acpi_bus.h | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index 1a45e0d521d8..ed309ea4785d 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -963,6 +963,7 @@ static inline const char *acpi_device_hid(struct a=
cpi_device *device)
> >>   {
> >>          return "";
> >>   }
> >> +#define acpi_device_uid acpi_device_hid
> >>
> >>   static inline bool
> >>   acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld)
> >> --
> >
> > Sashiko has reservations that look valid:
> >
> > https://sashiko.dev/#/patchset/513319f19ed6b0b6d4c76dc517074531966b98f5=
.1789745223.git.robin.murphy%40arm.com
>
> Oops, indeed apparently I missed that acpi_device_pnp::unique_id isn't
> actually const - it probably should be IMO, but that would be a whole
> other patch.
>
> FWIW I can't see that the return value itself actually matters here
> since !ACPI code couldn't have a valid acpi_device to legitimately call
> this with at runtime. In fact even for compile-testing, references
> should usually be under a condition like has_acpi_companion() which
> would lead to them getting DCE's under !ACPI without needing the stub -
> this was really just for completeness to shut up annoying Sashiko noise
> on that point.

But I think that returning NULL in the !ACPI case would be more
consistent with the ACPI case anyway.
