Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B2569F39
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097570; cv=none; b=PvRWRAxEHApg8OF8Nu4OEdQIZp52LYkVLW8vFqKut6vWckvg+knFRpRKTxCWtfXgytwtriD8ot0FGcN0x7djPKMsInqDuD0jObLhaUEhdfG2T07ub1v4WiL96G5tjg/wHkXdDPKAGV9Y4Wrj4APaf3UaXKyR0ehyZWNJIxwOhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097570; c=relaxed/simple;
	bh=Anpn2JsNX7GMHpoKMyKf1prDu4o1VmMkDZdtFXOrjsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCb7lzWTrflzI/eRmg0bMrHWQ6i+d8DG2WGzFbq+jssLOQFC1bWCbRiGQZJhU8X8DS8XN5axDS2EOx7oyYB7qpQQug2yxq/bQrUDLmjPra5dakrKYvFv/AEGbLZja8A3GUgvzAS/s7CRGN2yaLk1pFoyMx9cLw93DtW1RQMwDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6k2CPm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6k2CPm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F24C1F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097568;
	bh=1Dj+TwW37BcBP5eniO0avWX/aE1diBe1dLklTbSIsTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m6k2CPm+n1uyNrWeq26m11eZBUWI2CUg3RfSf+XRZRON0zZk0SEVkNetSD+cpFv/v
	 Ep/vxNRHMrqiZ91iNPLvan6UKhDJDrlgQ3EJVbkfQPL3egesHvZkslQ5/wGz/+5Z5m
	 MIg7kubzvpj9T24s8gB2M8Ln38F/iDLg6IYwBcaD3SpUZnt01hjiyPs+H+V+13KDkb
	 cjdXWAhGa0QjlsF49mpY7RUUjTXY+ouGTVU53UGU3mdjdg1GDJagYBAgyzJufpDmlu
	 exoRMfWyUBIK/Mym1SZqin/6SGvHBIvoJ7DKWES4X1hkr08i6HemgU9qska4mKVn19
	 tzf06dB5VSIwA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so322331fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 10:19:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBylRRr7ejxyWDiIy1FMd7wtGp45HdNQBXyBGzdmUxMFrSpjfpq+f2pEv5ZYI7/iJDjkgYYD5vKOoHSQ@vger.kernel.org
X-Gm-Message-State: AFuF++l6RXcp93L6OGsMqlSfBh7VsSRIVykzaNXCMpqzB4y9LvWU3ClC
	wq4ktPBceOYUUX+XM/iEw8k6dvpI8tEVp4gFF0mEJrN6rLNnicn+mOI86b6wCo8ZdFpQ5S5/NW1
	2KEHd3ItqD66WqJwt1pWb7tPzjv5ZJeY=
X-Received: by 2002:a2e:a596:0:b0:3a5:b524:e28c with SMTP id
 38308e7fff4ca-3a5fbf4ddeamr31137541fa.11.1790097566854; Tue, 22 Sep 2026
 10:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
 <20260919124605.12429-2-johannes.goede@oss.qualcomm.com> <CAJZ5v0g3WvT9jUkpaAtFOk+DttCU1JrrUBRzokFwSffnJvjHzQ@mail.gmail.com>
 <f464eb1f-42f7-4e6b-a0e7-a549fc58fc6c@oss.qualcomm.com>
In-Reply-To: <f464eb1f-42f7-4e6b-a0e7-a549fc58fc6c@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 19:17:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hd_afX=6=5GjMxeOG+7Y28gwrpYFqi2F0z-mh3JOd_2g@mail.gmail.com>
X-Gm-Features: AcwNN1V-J4tkvKXJPV3uVV5tCxQIpM6DA8KkjP-m4_bW-eHWCMpB6tg0nxL2D0s
Message-ID: <CAJZ5v0hd_afX=6=5GjMxeOG+7Y28gwrpYFqi2F0z-mh3JOd_2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Skip acpi_scan_dep_init() for processor devices
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:13=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 22-Sep-26 17:32, Rafael J. Wysocki (Intel) wrote:
> > On Sat, Sep 19, 2026 at 2:46=E2=80=AFPM Hans de Goede
> > <johannes.goede@oss.qualcomm.com> wrote:
> >>
> >> acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
> >> the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
> >> never contain any deps for that device, making the acpi_scan_dep_init(=
)
> >> call a no-op.
> >>
> >> Make acpi_add_single_object() only call acpi_scan_dep_init() for devic=
es
> >> with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().
> >>
> >> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >> ---
> >>  drivers/acpi/scan.c | 27 ++++++++++++++-------------
> >>  1 file changed, 14 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 40bbf9e322c2..38ac6c470a9f 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1873,25 +1873,26 @@ static int acpi_add_single_object(struct acpi_=
device **child,
> >>                 return -ENOMEM;
> >>
> >>         acpi_init_device_object(device, handle, type, acpi_device_rele=
ase);
> >> +
> >> +       if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {
> >> +               mutex_lock(&acpi_dep_list_lock);
> >> +               /*
> >> +                * Hold the lock until the acpi_tie_acpi_dev() call
> >> +                * below to prevent concurrent acpi_scan_clear_dep()
> >> +                * from deleting a dependency list entry without
> >> +                * updating dep_unmet for the device.
> >> +                */
> >> +               release_dep_lock =3D true;
> >> +               acpi_scan_dep_init(device);
> >> +       }
> >> +
> >
> > Instead of doing the above, I'd prefer to add a type =3D=3D
> > ACPI_BUS_TYPE_DEVICE check to the dep_init check below:
>
> I can do that and that works if we just drop the RFC 2/2 patch from
> this series from consideration for now.
>
> The reason was done the way it is done, is because we should not
> call acpi_scan_init_status(device) for thermal-zone devices while
> in the RFC 2/2 patch we do want to call acpi_scan_dep_init() for
> thermal-zone devices.
>
> So just making this 2 separate if blocks, each with their own
> condition without nesting, makes things easier and it also moves
> the comment about acpi_scan_init_status() directly above that call,
> where as atm the comment sits above the whole if and then there is
> this intermediate comment:
>
> >>         /*
> >>          * Getting the status is delayed till here so that we can call
> >>          * acpi_bus_get_status() and use its quirk handling.  Note tha=
t
> >>          * this must be done before the get power-/wakeup_dev-flags ca=
lls.
> >>          */
> >> -       if (type =3D=3D ACPI_BUS_TYPE_DEVICE || type =3D=3D ACPI_BUS_T=
YPE_PROCESSOR) {
>
> before the actual acpi_scan_init_status() call which the higher up
> comment is about.
>
> So IMHO the result of splitting this into 2 ifs results in more
> readable code. And it makes life easier if the conditions under
> which to call acpi_scan_dep_init() vs acpi_scan_init_status()
> diverge further from one another.
>
> With all that said. I'm happy to make the requested change for v2,
> which leads to less churn / code moving around.

So for now let's do it this way and make all of the changes related to
the [2/2] in that patch.  The reason for making them would be clearer
this way IMO.
