Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544D554092
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097186; cv=none; b=TDygAMilTnxobXZOCTuYuU8SbTpGjWj620ifzekEVHI/3Ds7CZJKFZbjUGopYjwkdS0Op7twlb83HRlVZr7lKHagFbhApdl8tythxYgbth3Gkj3HC4Kmo5XBqGA5xAxoOq24oLTKqa4RL1j7dg7JuzjCVcWZF9mwVMCHMIgzwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097186; c=relaxed/simple;
	bh=hrlCH9bzL3wQFkP8Dl5t7uU03FK2JQXMx7nlOZUrYdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcpehBYEBm/tt4kOoZDtK+qxf7LwtBQhbGHwagxla1bxyrvxiQIYfphxAVaJyaj6si6zfpL1HKNfiBRs1/vQsfToSXluMeopwPzcKb8DPjklb6prW056XUDrGBKqoaz579FlVJ2R3KB1f/HhCVQpo35gzlvWc8Ab1+0+9M3uI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM4sL2pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM4sL2pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA91F0089C
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097184;
	bh=sLrO2hmcFpnne5QQQOnTpSRNPsAvFT7pPHSA2SgpJPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DM4sL2peDwNx5GyP7tf7gNGFlHgupOvoxOtDUIzN+B1iMUcYrAej9304m+Il85Id8
	 M5ZjsziV4I3s1vwEfneGeRTDepl2Gw/B8gTX4YqDltnxZYxiQX7hh0zwoD0inEXvu3
	 v+tepXY8adu2p+tBVO5Z8j+MiZWF/mLgzub1DdSig03WnO1R2eebqyWA/O/aQSlfg7
	 d5ayurmCcJ2TZZDZVC9lO6NwY9eNrncMmS4yhEwR8VVGHxP0ycDZaMn7J+cIUOS+O5
	 p5cl1NmhihjSYwA19HywE9hASOuzmzhlAAuTMfRlg2oernnuLAXU2hJUgYuNpXAeII
	 fg/N5D8MNbKSA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c9954ccbso2756234e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 10:13:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByemmsGtkUJkVTPU0vAZl3fhdP6wfAT6I4mAWaiEMdk0MePSHuLcjEvJda+0GoWd5NblCfB5cGUT4MU@vger.kernel.org
X-Gm-Message-State: AFuF++l1lBd/krEesTFhBzjVQUl0g7CbQvrwhB3zb4bFRKe1q/a297pJ
	sEjh4A4wIQO1hQJC1IJB+EMDiLzPeWLktJOkfyG2kZZ5X0J3BrUzy9Zyr7CizFxb/MvWvMfwZdJ
	hKod/vOtyav84bAoJK22ETAb1hvX4HjE=
X-Received: by 2002:a05:6512:33c2:b0:5ad:58c8:5de8 with SMTP id
 2adb3069b0e04-5b8c18136afmr4545100e87.1.1790097182615; Tue, 22 Sep 2026
 10:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
 <20260919124605.12429-3-johannes.goede@oss.qualcomm.com> <CAJZ5v0j3yWe5+xUxbwJZSWq-Ap_Bz-hj025c-tFwni9M-1FhzA@mail.gmail.com>
 <533be9c3-be2a-428d-9b59-11f68562764f@oss.qualcomm.com>
In-Reply-To: <533be9c3-be2a-428d-9b59-11f68562764f@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 19:11:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6EqXdSoMcF3iS3qqGPR=VFP2WQ7k1OkXxNXyrWXc5-w@mail.gmail.com>
X-Gm-Features: AcwNN1Vj-Wu_65g5K0CuyLjMSjVv6jJDqgdA-amWVq7ZTyrBXAsOdGFxVQZVq6Y
Message-ID: <CAJZ5v0j6EqXdSoMcF3iS3qqGPR=VFP2WQ7k1OkXxNXyrWXc5-w@mail.gmail.com>
Subject: Re: [RFC 2/2] ACPI: scan: Handle _DEP for thermal devices
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2026 at 7:07=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 22-Sep-26 15:35, Rafael J. Wysocki (Intel) wrote:
> > On Sat, Sep 19, 2026 at 2:46=E2=80=AFPM Hans de Goede
> > <johannes.goede@oss.qualcomm.com> wrote:
> >>
> >> Add _DEP handling for thermal devices. Just like with normal devices t=
his
> >
> > I'd say "thermal zone devices" because that's what it really is about
> > and s/normal/other/.
> >
> >> will only delay enumeration for devices with dependencies on devices
> >> which are in the acpi_honor_dep_ids[] list.
> >>
> >> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >> ---
> >>  drivers/acpi/scan.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 38ac6c470a9f..af2bd6cc51b8 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1874,7 +1874,7 @@ static int acpi_add_single_object(struct acpi_de=
vice **child,
> >>
> >>         acpi_init_device_object(device, handle, type, acpi_device_rele=
ase);
> >>
> >> -       if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {
> >> +       if ((type =3D=3D ACPI_BUS_TYPE_DEVICE || type =3D=3D ACPI_BUS_=
TYPE_THERMAL) && dep_init) {
> >>                 mutex_lock(&acpi_dep_list_lock);
> >>                 /*
> >>                  * Hold the lock until the acpi_tie_acpi_dev() call
> >> @@ -2074,7 +2074,7 @@ static void acpi_scan_init_hotplug(struct acpi_d=
evice *adev)
> >>
> >>  u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
> >>
> >> -static u32 acpi_scan_check_dep(acpi_handle handle)
> >> +static u32 acpi_scan_check_dep(acpi_handle handle, acpi_object_type a=
cpi_type)
> >
> > I'd rather pass a bool as a second arg, that is
> >
> > static u32 acpi_scan_check_dep(acpi_handle handle, bool check_hid)
> >
> >>  {
> >>         struct acpi_handle_list dep_devices;
> >>         u32 count =3D 0;
> >> @@ -2094,7 +2094,8 @@ static u32 acpi_scan_check_dep(acpi_handle handl=
e)
> >>          * 2. ACPI nodes describing USB ports.
> >>          * Still, checking for _HID catches more then just these cases=
 ...
> >>          */
> >> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handl=
e, "_HID"))
> >> +       if (!acpi_has_method(handle, "_DEP") ||
> >> +           (acpi_type =3D=3D ACPI_TYPE_DEVICE && !acpi_has_method(han=
dle, "_HID")))
> >
> > so this becomes
> >
> >            (check_hid && !acpi_has_method(handle, "_HID")))
> >
> >>                 return count;
> >>
> >>         if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_device=
s)) {
> >> @@ -2134,7 +2135,7 @@ static acpi_status acpi_bus_check_add(acpi_handl=
e handle, bool first_pass,
> >>                         acpi_mipi_check_crs_csi2(handle);
> >>
> >>                         /* Bail out if there are dependencies. */
> >> -                       if (acpi_scan_check_dep(handle) > 0) {
> >> +                       if (acpi_scan_check_dep(handle, acpi_type) > 0=
) {
> >
> > and this becomes
> >
> >                        if (acpi_scan_check_dep(handle, true) > 0) {
> >
> >>                                 /*
> >>                                  * The entire CSI-2 connection graph n=
eeds to be
> >>                                  * extracted before any drivers or sca=
n handlers
> >> @@ -2160,6 +2161,10 @@ static acpi_status acpi_bus_check_add(acpi_hand=
le handle, bool first_pass,
> >>                 break;
> >>
> >>         case ACPI_TYPE_THERMAL:
> >> +               /* Bail out if there are dependencies. */
> >
> > Perhaps "unmet dependencies"?
>
> Ack to all the above and thank you for the in depth review of this
> RFC patch.
>
> Note atm there are no consumers for this patch since there are
> no HIDs that thermal-zones are known to depend on in
> the acpi_honor_dep_ids[] list.
>
> So unless you want to take this upstream in preparation of any
> such acpi_honor_dep_ids[] list entries showing up in the future,
> this patch is not intended to go upstream for now.

OK

> Which leaves me to the question do you want a v2 RFC for
> the archives with your comments addressed?

Not really, but if you need it to be there so you can point someone to
it, please send.

> This is relevant for your review of patch 1/2, since your
> requested changes there clash with this patch.

Yeah, so please send the updated [1/2] if you want me to pick it up.

Thanks!
