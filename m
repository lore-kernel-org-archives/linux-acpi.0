Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705302;
	b=txayaK6z5Hh1AH39K9d6f0+q5IHSr9/RkllK0n3gRhORBifGWKMHLLCxGhkfdBpqkCB9
	 p+PS3CKyOWUVVyUTKJc3aiqlPORx7lGnOqScpr3hf5LA1fR7LNg5RWYxrGEd5Xb4RtJpi
	 rxxZLurLZFtCxCoE1i2z0sB5v63BGODfk+yoJIYhgDVhfJwbvTMQ4AeitLZb3tHMMQQke
	 3xA2J2nAFwXS68GYeKMp1NG/4fx5rbepCa91oPfhSjD1jIF7YkClr9mrUYsbW+64YKj3E
	 gT9MK5ywcXO3gmR/7ug54sM6V7uqnYugyS+VtZm+xUQjfl2WY2EEkiVABHmKAijRfmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705302;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+4nWIKPEPbVU+/d8v2r18grz0OisG3omtzIuS+nUgBo=;
	b=0DG1q/TPLNmDQCIwVRU9OnLjLMzdd8cL1IuFNmd5v3cDcHs+w9BR+qfD3HzHWywmk7II
	 YYN0aTnGylTnMVCSRvl+wDoiCYPPelZLanvcp325YWgubuypvcljm01cjv64XepDFAnkl
	 +hJeBu+Hts4S5Lgb/V4S/Q+RmhnDscAzC6bvRPgR6WtupNBPDT6rh+HlYVPOrCKM9ceea
	 bMV49SRxVWsS18VGyk5gMOpOC4ZArXxbqD+gPOyDnANYwjzrD6xC/GdAOnFBAIBmeUANX
	 izT2ydrcwrXe4J8orm0qgfBmyVhVVCCTJrnVF9MApjAVisiFY7ZphaX4+aWGFgQxFJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5bpqt6J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED66606A31C
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5bpqt6J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FD91F000D0
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705301;
	bh=+4nWIKPEPbVU+/d8v2r18grz0OisG3omtzIuS+nUgBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q5bpqt6JrbN7V/hyYHRABYZ0hr2lTw2p4JIRvllEXeG1YWrtYWHTh22afjysq5tcB
	 SFR7FLbBEWxIhQ3n4+X3z9VnePwpPJrIUMvn0DgO+WbMQCUKDYUNBaUYZXDns+CnqN
	 XF2jPuJf/Pro/qZ1FiyhEHElx79epjw5yTvRq64MvxJNLLEJcVYZ6c6O2Hoe+j2/Qc
	 oymTkZT6zRdR6N4hFnGdr/aV+VB4Yr1prRYDAP4r6nYmW+3ssyJtocnBQXi6G8UX8y
	 gK7RY50KrWIO8NjwqOpDhtuDO1co1miAZ19MNoqP/FJXc6vM3tq+CGefrz2EYbznTn
	 kPaTK9E/mRjCA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso6350645e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 07:01:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEREd8y20qr0YAH/weWYMtNmgLDjlWSEP/zPHAz4IV71DTEPZOoWoxHEC+wUw3J5Z2Rd+OeZxn+ataQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9DX110o3VOSNHq15afqrzqePwdJHKnV5BISshQAa2KVLh0v5l/
	HFtjX6FI6U5hX+sDTwNiqMANLukyDq/2tWlCnoBE1aQpSWDTek+iURqh53JTIqumcmd3yD82HYT
	nt6HXYa1mBfIG6fEwon8bzhwV6H4S9XU=
X-Received: by 2002:a05:6512:6ce:b0:5c1:4f8a:8f5 with SMTP id
 2adb3069b0e04-5c1bc817e5cmr5687419e87.25.1795705300282; Thu, 26 Nov 2026
 07:01:40 -0800 (PST)
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
 <CAJZ5v0hVX0vQ3oy_jiSAqERc4tmTZECFbsGfRi3=3Gz1Q2+H1w@mail.gmail.com> <8733sniquk.fsf@beagleboard.org>
In-Reply-To: <8733sniquk.fsf@beagleboard.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 26 Nov 2026 16:01:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iXaM6+_unQ5U7y5j2z_woPpQjQ13tOTb-RZHep7hJf-A@mail.gmail.com>
X-Gm-Features: Aa3M54ovbQoVx0vdv95m6-nR230cjM7J8TmAxyLzsAQ0eFRknmhCdYXN5IBOflU
Message-ID: <CAJZ5v0iXaM6+_unQ5U7y5j2z_woPpQjQ13tOTb-RZHep7hJf-A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: power: Add serialize_power_on_quirk
To: Ayush Singh <ayush@beagleboard.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 3:56=E2=80=AFPM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> "Rafael J. Wysocki (Intel)" <rafael@kernel.org> writes:
>
> > On Tue, Nov 24, 2026 at 1:16=E2=80=AFPM Ayush Singh <ayush@beagleboard.=
org> wrote:
> >>
> >> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan), the NVMe drive i=
n
> >> the second M.2 slot is frequently lost after resuming from s2idle:
> >>
> >>   pcieport 0000:00:02.1: broken device, retraining non-functional down=
stream link at 2.5GT/s
> >>   pcieport 0000:00:02.1: retraining failed
> >>   pcieport 0000:00:02.1: Data Link Layer Link Active not set in 100 ms=
ec
> >>   nvme nvme1: Disabling device after reset failure: -19
> >>
> >> The _ON methods of the two M.2 slots' power resources update a clock
> >> control register shared by both slots without any locking, and sleep i=
n
> >> the middle of the update. Since the root ports are resumed
> >> asynchronously, the two methods can run concurrently, and one of them
> >> can undo the other's change, leaving that slot's reference clock
> >> disabled. Its link then never trains.
> >>
> >> Evaluate power resource _ON methods one at a time on this machine.
> >> With this, 20/20 s2idle cycles succeeded, versus failure within 1-2
> >> cycles before. Also tested in normal laptop usage for a few days.
> >>
> >> The same symptom has been reported on the closely related IdeaPad Pro =
5
> >> 14AKP10 (83JL) [0], which may need this quirk as well, but it is not
> >> included here as it could not be tested.
> >>
> >> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
> >>
> >> Assisted-by: claude-opus-5-5
> >> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> >> ---
> >> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan, BIOS QFCN29WW),
> >> the NVMe drive behind root port 00:02.1 (ACPI GPP3) is lost on nearly
> >> every s2idle resume, while the drive in the other M.2 slot (GP10) alwa=
ys
> >> comes back. Updating to the latest BIOS did not help, and neither did
> >> disabling SSD power management via kernel parameters or recovering the
> >> device from userspace.
> >>
> >> The "broken device, retraining non-functional downstream link at
> >> 2.5GT/s" / "retraining failed" messages come from the Target Speed qui=
rk
> >> reacting to a link that cannot train at all. The actual cause is a rac=
e
> >> between the two slots' power resource _ON methods in firmware, which
> >> can leave one slot's reference clock disabled, as described in the
> >> patch. I can share the relevant AML and debug logs if useful.
> >>
> >> Testing: 20/20 s2idle cycles with real S0i3 residency, versus failure
> >> within 1-2 cycles without the patch. I have also done normal daily use
> >> testing outside of synthetic suspend.
> >>
> >> The IdeaPad Pro 5 14AKP10 (83JL) appears to have the same problem on
> >> the same root port [0]. I don't have one to test, so it is not in the
> >> DMI table.
> >>
> >> I went with a DMI quirk that serializes power resource _ON methods
> >> on this machine only. If serializing them unconditionally, or some
> >> other approach, is preferred, I'm happy to rework it.
> >>
> >> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
> >
> > So there is acpi_evaluate_object_exclusive() now and you can use it
> > for _ON evaluation.
> >
> > It will serialize the method with other things too, but that's not a bi=
g deal.
> >
> >> ---
> >>  drivers/acpi/power.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> >> index 23a4e207a01e..b997d98f38c4 100644
> >> --- a/drivers/acpi/power.c
> >> +++ b/drivers/acpi/power.c
> >> @@ -64,6 +64,10 @@ struct acpi_power_resource_entry {
> >>
> >>  static bool hp_eb_gp12pxp_quirk;
> >>  static bool unused_power_resources_quirk;
> >> +static bool serialize_power_on_quirk;
> >> +
> >> +/* Serializes _ON evaluation when serialize_power_on_quirk is set */
> >> +static DEFINE_MUTEX(power_on_lock);
> >>
> >>  static LIST_HEAD(acpi_power_resource_list);
> >>  static DEFINE_MUTEX(power_resource_list_lock);
> >> @@ -362,13 +366,27 @@ void acpi_device_power_remove_dependent(struct a=
cpi_device *adev,
> >>                 acpi_power_resource_remove_dependent(entry->resource, =
dev);
> >>  }
> >>
> >> +static acpi_status acpi_power_evaluate_on(acpi_handle handle)
> >> +{
> >> +       acpi_status status;
> >> +
> >> +       if (!serialize_power_on_quirk)
> >> +               return acpi_evaluate_object(handle, "_ON", NULL, NULL)=
;
> >> +
> >> +       mutex_lock(&power_on_lock);
> >> +       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
> >> +       mutex_unlock(&power_on_lock);
> >> +
> >> +       return status;
> >> +}
> >> +
> >>  static int __acpi_power_on(struct acpi_power_resource *resource)
> >>  {
> >>         acpi_handle handle =3D resource->device.handle;
> >>         struct acpi_power_dependent_device *dep;
> >>         acpi_status status =3D AE_OK;
> >>
> >> -       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
> >> +       status =3D acpi_power_evaluate_on(handle);
> >
> > So I'd replace acpi_evaluate_object() above with
> > acpi_evaluate_object_exclusive().
>
> Sure, that sounds good. Just to confirm though, I should do that only for
> devices with the quirk though, right? i.e. behind a conditional. Or do yo=
u
> mean that it should use acpi_evaluate_object_exclusive unconditionally?

I would just use it unconditionally.

The extra locking overhead is small here and there are other locks
acquired by the AML interpreter anyway.
