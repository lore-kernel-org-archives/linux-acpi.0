Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9692560ADB
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001592; cv=none; b=dFVJ3/w+oP/ECU1tyLaAJvVR7uQi+K6+WIKUZ5FG8wGC/7vo1qn++A7Y0HSv2Hn1jISiz1QuyG0xWwHmMxxwOYZTnVn02TsBkBipaS9UtpfJz6j3GRYKQI224deibB35WCE/Dc/78+CdgDcKvQOLDt56N/1NgjN9989ND5sPBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001592; c=relaxed/simple;
	bh=qCVt23NPLz+BzoAjfmW00Y/LFtzE1ShjP0EoMBiCiHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJUBhGcyGx6QeJbuffATv9ynAcq1sfzCZR4CuHbDkBOravjfincuVyiy9eHswy4sslT1anyALHngRPDe9B9Mhmp4+SYiRMOGeaqVYU906zvkLbLDO3bVPljI3hnHAf7z27GEHFSrsGt/7gw0yJCP4klcy9VN2hW76nUrDalARuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hImGocuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hImGocuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF811F000C7
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792001591;
	bh=sFBK0Ld7Sq4nf3GX+t6/QlOXpIDT+j0rm9SIXjlrgZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hImGocuO0FaryyRAUlKb9/7Pj/W7gJ3wvJ27cp2EvfQJh5zcRFirWV+xdXEekwRYt
	 BNM2Y/BfQ0WNy7VMYeCiY3M0nAQCsV/U21s23xNoZF3QgBS1+HRUYpovRFgWG1KNmw
	 PcteKm19GHYj4Urx0sLJUJ3O//hdDdsS/VV0pV1wZsHGvRCf/BdpPNVyOX2pYtF9T4
	 IXHCO1ydVqLTqQMLJCzOs89sjte7v46LC2990TvqL0fpTFyvCWk/yYRj5DbtkQqgC2
	 CnOLleCuLSJvfVU9BqTcRqq/o9KztwYJWkfCJ4wJl2blbD7peNHIsIY8hRpXfxJMkl
	 VKKg3Q12OOx3A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bce4e278baso1431002e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 11:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTESY/KtCUIri5bLdz6FuAKJpIaE9KR/ArCG2qlTbhP6pDTvd8Tx8RFsOnvBALpkRsrr43sozYACHE@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ92shfpl8l5sRElD+JwKpiR0OH7MqNF3lWkcKzmSS5yY1a8lu
	u491DdBZGUCs4j8KiRnBgazjkbKVSZ5+ifp4AXtxASSjqdLGXthG0Kqd3NSdacRMevPrlCVhVWX
	GYzBBvr78CFzvY86LSqCqIlfPLQRz11U=
X-Received: by 2002:ac2:51c8:0:b0:5bc:f2d3:f949 with SMTP id
 2adb3069b0e04-5be37942bc8mr721935e87.25.1792001589751; Wed, 14 Oct 2026
 11:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923082932.1049270-1-uajain@igalia.com> <20260923082932.1049270-2-uajain@igalia.com>
 <CAJZ5v0i0UPcGiiAxNbjUnzn=8D2jcTCo_wtM8aMbOKhqb37EDA@mail.gmail.com> <497522185b0d5edd0898edab04934d2a@igalia.com>
In-Reply-To: <497522185b0d5edd0898edab04934d2a@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 20:11:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmFT_eV+f9majTDTCLV4m0eNCR5RurdpcAqrFYYZQrGA@mail.gmail.com>
X-Gm-Features: AclHuK8OWDKJgitWmaduupJ1CDDdVRxSuDyCn1-asoiak_irYygGw2Sb06VwtQM
Message-ID: <CAJZ5v0jmFT_eV+f9majTDTCLV4m0eNCR5RurdpcAqrFYYZQrGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: battery: Query Battery charge time ("_BCT") method
To: Umang Jain <uajain@igalia.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:31=E2=80=AFPM Umang Jain <uajain@igalia.com> wrot=
e:
>
> On 2026-10-12 17:15, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Sep 23, 2026 at 10:28=E2=80=AFAM Umang Jain <uajain@igalia.com>=
 wrote:
> >>
> >> Add plumbing for querying the Battery Charge Time ("_BCT") method.
> >> If present, set ACPI_BATTERY_BCT_PRESENT in battery flags to denote
> >> that the method is supported in ACPI.
> >>
> >> Signed-off-by: Umang Jain <uajain@igalia.com>
> >> ---
> >>  drivers/acpi/battery.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> >> index 670853ec3a4d..a1b7a821abaf 100644
> >> --- a/drivers/acpi/battery.c
> >> +++ b/drivers/acpi/battery.c
> >> @@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
> >>  enum {
> >>         ACPI_BATTERY_ALARM_PRESENT,
> >>         ACPI_BATTERY_XINFO_PRESENT,
> >> +       ACPI_BATTERY_BCT_PRESENT,
> >>         ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
> >>         /* On Lenovo Thinkpad models from 2010 and 2011, the power uni=
t
> >>          * switches between mWh and mAh depending on whether the syste=
m
> >> @@ -110,6 +111,7 @@ struct acpi_battery {
> >>
> >>         struct mutex property_lock; /* Protects properties below. */
> >>         unsigned long update_time;
> >> +       unsigned long long charge_time;
> >
> > This doesn't need to be unsigned long long.  As per the spec, unsigned
> > int should be sufficient.
>
> Last thing before I send out v3, this is the function param-type for the
> acpi_evaluate_integer()
>
> In include/acpi/acpi_bus.h,
>
> acpi_status
> acpi_evaluate_integer(acpi_handle handle,
>                       acpi_string pathname,
>                       struct acpi_object_list *arguments, unsigned long l=
ong *data);

Yes, so you need an unsigned long long for calling that function, but
then you can copy the value to a variable of a different type (a u32,
say) if the given object is defined to return a value within the scope
of that type.  Of course, you should validate the returned value
before doing so, but it generally needs to be validated before being
used anyway.
