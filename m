Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702910;
	b=KENseWjMd+opfCIQg0IOYfdeRa9VQXWmgeqOhRUq5KEfB0ffflW/eqsJnXLX+7hZ+E86
	 I2GsQc7xlfKt04paSwitXpAmXffEqUtfvrn2z1EUM/v1hEMWSRpGSNYvBM3rhXMFApePz
	 GswEafB3c2GTBZkB13dmVNusbZNGXcyvk9u4DxVlQjxSuSzSz6X2xnFmaRZlKUcF1ioTG
	 r+DZnER0jW65c39IRMU20OEzmSL94a+l/kamMS7KpuYsEOajeiUd/0dTmrEBqiPGjnUpN
	 qbgGQMVy9bNGDzzEYEGAL6tRCc+tExV+qVUpPh1wLTspIgoP/KzZJU6Fm5WO9qwcjdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702910;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9NViZmMEOl1X7qIRFFoLuLTK7TtaBpQ57fO6MNiswOA=;
	b=43QzTQUmknRgiC/II2P6heUsre3glLwkV3QM2L5IdPgCXqXGBSQ+Y6FeTxJxRUIkEC/z
	 dkpcTTjdhHzBddnuKrK869RtMVbTC1YmDZ67aj+ZxbmDjzljb7qFUtg3TTIAujkwe8s/9
	 I5GtdP6+T05QnGfhVhHZOpUQ7oD1jtomtAKqbiGDoOHy9Lcilq6+LqFOBoGC9yG42dhD9
	 52VSc8frUYP/bqIbm1HnaCWxDWEaAhNh05kKneeV/wQ8HHsUP5QTKucv1U/ZaZodhIe7F
	 +LcxGINf1GtWLDNne89xCTOIhuiMxIgsarzNnFDDRCtZse3PhTmOoWE9SOWyBrsWBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwCavgSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AB606A321
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwCavgSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA30A1F000C6
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702909;
	bh=9NViZmMEOl1X7qIRFFoLuLTK7TtaBpQ57fO6MNiswOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VwCavgSdoJDfyctl0IavPQq1WxdVoTCML6Z2iK0lXqN/mwMTYCA8VApCpNbfdPkDX
	 Q9DvrfjFxLg9rGuPEBjU8Zwl7KDyWOyk1EfkBcBSjHXwlLOpUnRM/24UJyG6GzY/Co
	 Q9IYXdhNUEGhXao/u2WWjtffGR5Z7G9yoPxiu22aY2F4y6wbHati0tBtfDze6CPBg+
	 /fFpyyUxGWiaUqTvnoIYH6rVoJCTdiBp04cdpyr86sJw9vI6F51tikqI+7CK6qjP74
	 V69uTypXJ8UlJ1KyqtOGQ7e/SW+f2ary2R8OqTIfYpoecwLxU5tusJ5rkgzm13Azsk
	 a7WXNqpsVgK9Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so56814881fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 06:21:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF78O1kt+PvIgF31HphjazUFe0WlyHWy1UiG83OxlDv3jFmOeB7caEjNBC4O6lr3VjK2LdJJKA5/YzV@vger.kernel.org
X-Gm-Message-State: APuU4Z9oQOhdQA2dpjOl4EBoeR+Ve06eraKSSpIBAEixKijjhMA+P4J6
	QRtADECIBIAY+HG727HiAkxdM8rqHd4IdUGe2j17WzagdgHKjVhQkbJW0j3MQ/IsAO1V360aljh
	jfNgE+IS9oq1gtBhfi9lH/gy7Rsz5kMg=
X-Received: by 2002:a05:6512:400b:b0:5c1:5169:7d9b with SMTP id
 2adb3069b0e04-5c1bc85ed2cmr5735938e87.34.1795702908225; Thu, 26 Nov 2026
 06:21:48 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-ssd-fix-v1-1-ee8ef43190b1@beagleboard.org>
In-Reply-To: <20261124-ssd-fix-v1-1-ee8ef43190b1@beagleboard.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 26 Nov 2026 15:21:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVX0vQ3oy_jiSAqERc4tmTZECFbsGfRi3=3Gz1Q2+H1w@mail.gmail.com>
X-Gm-Features: Aa3M54opN4gk-nTWG6yQJqgBUovVz7TGWI-wAPZSR9QW9UrT87kO3jbcfX1HyMg
Message-ID: <CAJZ5v0hVX0vQ3oy_jiSAqERc4tmTZECFbsGfRi3=3Gz1Q2+H1w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: power: Add serialize_power_on_quirk
To: Ayush Singh <ayush@beagleboard.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:16=E2=80=AFPM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan), the NVMe drive in
> the second M.2 slot is frequently lost after resuming from s2idle:
>
>   pcieport 0000:00:02.1: broken device, retraining non-functional downstr=
eam link at 2.5GT/s
>   pcieport 0000:00:02.1: retraining failed
>   pcieport 0000:00:02.1: Data Link Layer Link Active not set in 100 msec
>   nvme nvme1: Disabling device after reset failure: -19
>
> The _ON methods of the two M.2 slots' power resources update a clock
> control register shared by both slots without any locking, and sleep in
> the middle of the update. Since the root ports are resumed
> asynchronously, the two methods can run concurrently, and one of them
> can undo the other's change, leaving that slot's reference clock
> disabled. Its link then never trains.
>
> Evaluate power resource _ON methods one at a time on this machine.
> With this, 20/20 s2idle cycles succeeded, versus failure within 1-2
> cycles before. Also tested in normal laptop usage for a few days.
>
> The same symptom has been reported on the closely related IdeaPad Pro 5
> 14AKP10 (83JL) [0], which may need this quirk as well, but it is not
> included here as it could not be tested.
>
> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan, BIOS QFCN29WW),
> the NVMe drive behind root port 00:02.1 (ACPI GPP3) is lost on nearly
> every s2idle resume, while the drive in the other M.2 slot (GP10) always
> comes back. Updating to the latest BIOS did not help, and neither did
> disabling SSD power management via kernel parameters or recovering the
> device from userspace.
>
> The "broken device, retraining non-functional downstream link at
> 2.5GT/s" / "retraining failed" messages come from the Target Speed quirk
> reacting to a link that cannot train at all. The actual cause is a race
> between the two slots' power resource _ON methods in firmware, which
> can leave one slot's reference clock disabled, as described in the
> patch. I can share the relevant AML and debug logs if useful.
>
> Testing: 20/20 s2idle cycles with real S0i3 residency, versus failure
> within 1-2 cycles without the patch. I have also done normal daily use
> testing outside of synthetic suspend.
>
> The IdeaPad Pro 5 14AKP10 (83JL) appears to have the same problem on
> the same root port [0]. I don't have one to test, so it is not in the
> DMI table.
>
> I went with a DMI quirk that serializes power resource _ON methods
> on this machine only. If serializing them unconditionally, or some
> other approach, is preferred, I'm happy to rework it.
>
> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t

So there is acpi_evaluate_object_exclusive() now and you can use it
for _ON evaluation.

It will serialize the method with other things too, but that's not a big de=
al.

> ---
>  drivers/acpi/power.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 23a4e207a01e..b997d98f38c4 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -64,6 +64,10 @@ struct acpi_power_resource_entry {
>
>  static bool hp_eb_gp12pxp_quirk;
>  static bool unused_power_resources_quirk;
> +static bool serialize_power_on_quirk;
> +
> +/* Serializes _ON evaluation when serialize_power_on_quirk is set */
> +static DEFINE_MUTEX(power_on_lock);
>
>  static LIST_HEAD(acpi_power_resource_list);
>  static DEFINE_MUTEX(power_resource_list_lock);
> @@ -362,13 +366,27 @@ void acpi_device_power_remove_dependent(struct acpi=
_device *adev,
>                 acpi_power_resource_remove_dependent(entry->resource, dev=
);
>  }
>
> +static acpi_status acpi_power_evaluate_on(acpi_handle handle)
> +{
> +       acpi_status status;
> +
> +       if (!serialize_power_on_quirk)
> +               return acpi_evaluate_object(handle, "_ON", NULL, NULL);
> +
> +       mutex_lock(&power_on_lock);
> +       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
> +       mutex_unlock(&power_on_lock);
> +
> +       return status;
> +}
> +
>  static int __acpi_power_on(struct acpi_power_resource *resource)
>  {
>         acpi_handle handle =3D resource->device.handle;
>         struct acpi_power_dependent_device *dep;
>         acpi_status status =3D AE_OK;
>
> -       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
> +       status =3D acpi_power_evaluate_on(handle);

So I'd replace acpi_evaluate_object() above with
acpi_evaluate_object_exclusive().

>         if (ACPI_FAILURE(status)) {
>                 resource->state =3D ACPI_POWER_RESOURCE_STATE_UNKNOWN;
>                 return -ENODEV;
> @@ -1096,6 +1114,24 @@ static const struct dmi_system_id dmi_hp_elitebook=
_gp12pxp_quirk[] =3D {
>         {}
>  };
>
> +static const struct dmi_system_id dmi_serialize_power_on[] =3D {
> +       /*
> +        * On the Lenovo Yoga Pro 7 14AKP10, the _ON methods of the M.2 s=
lot
> +        * power resources update a shared clock control register without
> +        * locking and sleep in the middle of the update. When the root p=
orts
> +        * are resumed concurrently, one slot's reference clock can end u=
p
> +        * disabled and its NVMe drive is lost after resume.
> +        */
> +       {
> +               /* Lenovo Yoga Pro 7 14AKP10 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83KG"),
> +               },
> +       },
> +       {}
> +};
> +
>  static const struct dmi_system_id dmi_leave_unused_power_resources_on[] =
=3D {
>         {
>                 /*
> @@ -1156,4 +1192,7 @@ void __init acpi_power_resources_init(void)
>         hp_eb_gp12pxp_quirk =3D dmi_check_system(dmi_hp_elitebook_gp12pxp=
_quirk);
>         unused_power_resources_quirk =3D
>                 dmi_check_system(dmi_leave_unused_power_resources_on);
> +       serialize_power_on_quirk =3D dmi_check_system(dmi_serialize_power=
_on);
> +       if (serialize_power_on_quirk)
> +               pr_info("Serializing power resource _ON methods\n");
>  }
>
> ---
> base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
> change-id: 20261122-ssd-fix-6b7ab639796d
>
> Best regards,
> --
> Ayush Singh <ayush@beagleboard.org>
>
>
