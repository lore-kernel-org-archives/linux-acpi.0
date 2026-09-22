Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD953D9E5
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084212; cv=none; b=ouey+sYqY3mLUCqAwKee9FxAfIxSQsQ8V6a3UnsMHe/Jj17iLas6vFzmIQyrHZX3f+VCA2UOIWXonDNv+W7p17gLnX+LMCf8oCf+VwPPTbFc+FitiSEZmTuEAH/BWGatjZ/0Ad8V938ogJOQriH/QA0WKYiocfeblrE5NFqHTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084212; c=relaxed/simple;
	bh=gfzFvThNAV9zy8pd8VY7fn4jgkyYLh3yl0POVsX6s0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WARsCRiRLTbEehIIgW32KWjEupbebIJkLyd0ltWRo5Nl0cs2b9Ne6X8TLasdNLGFzE+y+3aGlTywl38Li/2dH2Dj58BVgjUBJsYjfzAI8bu39Ms3fX8mHFP2Y43VHdZZ+WAeY4Ooy9iu9QxI3RjbjbVSZoRUdIBVb5nNYOSIEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVOK6ovm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVOK6ovm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82BA1F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084210;
	bh=FUTinfl2ZDtfzuGVEtjBHB3M02RBYlvXKoE36V7yST0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cVOK6ovmBZybw+Y7B1jfSxD483oVjeUYgqZ8fqF1VHlCP/9D+CbUWOTW08LXOPaUs
	 U5t4Lchm5e8pYxqV5ZoRMyC2QiUfJC3ywMnSN0XmhmjfStyqPusmiUIJ4BiMcfIllc
	 QfBVHMjO/fRCKxZHzJS74mFZN1Ru9PMVkIjDr0CkZrWl4wC5fXcJ59L4fLRQxq3feY
	 3o/2hol4Pg0LoiQuWo0TwTNKR7IFTUx74U/okBI/4Qep2yQVGTchQZdevf3B5WCtXo
	 sPPmF0mj5SYPtgcpr9HUuUYIfNcdAdxVrJoY2gxiRR2IcnVdAe4fbSBDDf7vhgSaUA
	 YGZzKz7TSfmpg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d0ad9b89so33457681fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 06:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzB37X6eoa0Hw/4lkH3cRGflRtO0G7XAy8B32Jrr9oK0vfr6sHBMQzca+WUGt8EJh8Y0MWsctKynE5p@vger.kernel.org
X-Gm-Message-State: AFuF++lR7LnC3UA2zbYkxpmcF8Nwoc1jvgP0Yrk+m379rnTnpiudOjds
	Q0QT/7h+Oyc2sqnslMj5m0d7bdKrj6kfiJTuxW9587HG67m5K2tMCSlPJGIQU6Il6kgE1c/VMo9
	omgfGoJR/yEyXRvZUAX++Xhcuri5qFdU=
X-Received: by 2002:a05:651c:19a8:b0:3a3:2ff2:f818 with SMTP id
 38308e7fff4ca-3a5fbff8474mr31186781fa.13.1790084209218; Tue, 22 Sep 2026
 06:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com> <20260919124605.12429-3-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260919124605.12429-3-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 15:35:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3yWe5+xUxbwJZSWq-Ap_Bz-hj025c-tFwni9M-1FhzA@mail.gmail.com>
X-Gm-Features: AcwNN1WOeMWX9bPB8CGjXgFoJBdlXFGVHjiSKFjOfD1p9S0zPGrEBYrl6i9DJYg
Message-ID: <CAJZ5v0j3yWe5+xUxbwJZSWq-Ap_Bz-hj025c-tFwni9M-1FhzA@mail.gmail.com>
Subject: Re: [RFC 2/2] ACPI: scan: Handle _DEP for thermal devices
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 2:46=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Add _DEP handling for thermal devices. Just like with normal devices this

I'd say "thermal zone devices" because that's what it really is about
and s/normal/other/.

> will only delay enumeration for devices with dependencies on devices
> which are in the acpi_honor_dep_ids[] list.
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/acpi/scan.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 38ac6c470a9f..af2bd6cc51b8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1874,7 +1874,7 @@ static int acpi_add_single_object(struct acpi_devic=
e **child,
>
>         acpi_init_device_object(device, handle, type, acpi_device_release=
);
>
> -       if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {
> +       if ((type =3D=3D ACPI_BUS_TYPE_DEVICE || type =3D=3D ACPI_BUS_TYP=
E_THERMAL) && dep_init) {
>                 mutex_lock(&acpi_dep_list_lock);
>                 /*
>                  * Hold the lock until the acpi_tie_acpi_dev() call
> @@ -2074,7 +2074,7 @@ static void acpi_scan_init_hotplug(struct acpi_devi=
ce *adev)
>
>  u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
>
> -static u32 acpi_scan_check_dep(acpi_handle handle)
> +static u32 acpi_scan_check_dep(acpi_handle handle, acpi_object_type acpi=
_type)

I'd rather pass a bool as a second arg, that is

static u32 acpi_scan_check_dep(acpi_handle handle, bool check_hid)

>  {
>         struct acpi_handle_list dep_devices;
>         u32 count =3D 0;
> @@ -2094,7 +2094,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>          * 2. ACPI nodes describing USB ports.
>          * Still, checking for _HID catches more then just these cases ..=
.
>          */
> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, =
"_HID"))
> +       if (!acpi_has_method(handle, "_DEP") ||
> +           (acpi_type =3D=3D ACPI_TYPE_DEVICE && !acpi_has_method(handle=
, "_HID")))

so this becomes

           (check_hid && !acpi_has_method(handle, "_HID")))

>                 return count;
>
>         if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices))=
 {
> @@ -2134,7 +2135,7 @@ static acpi_status acpi_bus_check_add(acpi_handle h=
andle, bool first_pass,
>                         acpi_mipi_check_crs_csi2(handle);
>
>                         /* Bail out if there are dependencies. */
> -                       if (acpi_scan_check_dep(handle) > 0) {
> +                       if (acpi_scan_check_dep(handle, acpi_type) > 0) {

and this becomes

                       if (acpi_scan_check_dep(handle, true) > 0) {

>                                 /*
>                                  * The entire CSI-2 connection graph need=
s to be
>                                  * extracted before any drivers or scan h=
andlers
> @@ -2160,6 +2161,10 @@ static acpi_status acpi_bus_check_add(acpi_handle =
handle, bool first_pass,
>                 break;
>
>         case ACPI_TYPE_THERMAL:
> +               /* Bail out if there are dependencies. */

Perhaps "unmet dependencies"?

> +               if (first_pass && acpi_scan_check_dep(handle, acpi_type) =
> 0)

               if (first_pass && acpi_scan_check_dep(handle, false) > 0)

> +                       return AE_CTRL_DEPTH;
> +
>                 type =3D ACPI_BUS_TYPE_THERMAL;
>                 break;
>
> --
