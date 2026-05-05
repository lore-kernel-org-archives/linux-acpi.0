Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A3480DE9
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995290; cv=none; b=Z6z5xAzvS2r8U7aqUSV3xaGQ7O1Wh/LIgmiaMfyPLlsKtTofa3G7fl6/lvsPHTtSWIS/PluHILYoQVtdy/x3QQkEIelS6DVFzQovVQVuPFCQQHvFGzbdqbdv2/KAVxUdjlcWIftky1+wA/zBXRbv75LlRb0ypyQFfjlaOX6i8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995290; c=relaxed/simple;
	bh=QYXPi3d343akmcX88w3+8AzI9/5KadQ2vrm5A2Ln/FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdbE6cemeVlueLM+ckGnKJ9jPfPA8BObsgYOb1AqzHj7P3oFPCugdRQz7yOzdfWIfvACaVekv04LdHPaskqzputX9k2bcCgJvNvNWIzm5sZLxwgvI0U0V/0eyXjq31H0eagqHH65mpGnSE0745KHck+BU15jOjp4KuFqzh3SJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5CW6wqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5CW6wqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C12DC2BCB4
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777995289;
	bh=QYXPi3d343akmcX88w3+8AzI9/5KadQ2vrm5A2Ln/FI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L5CW6wqU2Jjj+VvUIbVhwrOtI8by7AFVObztq+9EDZlkvGoLL9kWA8j2+vdz+JvaV
	 Y3BxxamYBKh2+pIKIUupRxE4ccjWS8UH0ZwcBvLYtZbb9ZKXGeRcIl8hUgvd4l9bq+
	 GVa66m8r4cr2waXuVxRO+fPAqPynvqA4BNDezNFss+EosSQUpoioR1+/CEZVyPeNV5
	 yfnpMwDLEpLCe8NPxEPB4M/J+wM1VignqZ1UBeTVLwYHOLoUHrp6Vwt5wiaJw2goIt
	 G4Fr07Vru7zwh6KOcyMFGslD4QNK1/bU1NYIzdX0oiJDjd8ImZx6mimbMwauQppvE0
	 LLfzfEKqEAgJw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3938cc204a7so27665581fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 08:34:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Jpeg60+2CYnBNWtWEwIkXNR7O0Ol/+lGdGhiUkbnG/4i67JSOR3eaLeZPoSQLBq53GshyCoPGbU7x@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3nIBPEbTRjzmq4f4EdPfxlV6Y9ljISb44MWHCPoq/PtMRtZu
	qxQD8is//VRr0xkZStDA1DTvni3s2vijJ9MUlKTg6Y9ABDGpmXmXQ0p9/aNgObZevz+tOxuGr9y
	wPn6YTW1w+9KG0oDOClh8yLQdxW0h8HQ=
X-Received: by 2002:a05:6512:39d0:b0:5a3:f309:47e4 with SMTP id
 2adb3069b0e04-5a8631c0d8emr5840888e87.32.1777995287930; Tue, 05 May 2026
 08:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426-omen-16-backlight-fix-v1-1-62364f268ea6@zohomail.in> <e6ca711b-e134-426b-8df0-94323ac0f806@zohomail.in>
In-Reply-To: <e6ca711b-e134-426b-8df0-94323ac0f806@zohomail.in>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 May 2026 17:34:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQbBRR6HaJF6wiPqxoVrzEaNrK8WTY_YN52AQA2b+QGw@mail.gmail.com>
X-Gm-Features: AVHnY4JoRPa4CljSwlgpxChr8-Fsy1bTZndB8kMQhiMbmO5h9GOrlEQ49U56w1M
Message-ID: <CAJZ5v0hQbBRR6HaJF6wiPqxoVrzEaNrK8WTY_YN52AQA2b+QGw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: force native backlight on HP OMEN 16 (8A44)
To: Shivam Kalra <shivamkalra98@zohomail.in>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:22=E2=80=AFPM Shivam Kalra <shivamkalra98@zohomail=
.in> wrote:
>
> On 26/04/26 19:38, Shivam Kalra via B4 Relay wrote:
> > From: Shivam Kalra <shivamkalra98@zohomail.in>
> >
> > The HP OMEN 16 Gaming Laptop (board name 8A44) has a mux-less hybrid
> > GPU configuration with AMD Rembrandt (Radeon 680M) and NVIDIA GA104
> > (RTX 3070 Ti). The internal eDP panel is wired to the AMD iGPU.
> >
> > When Nouveau loads without GSP firmware, the ACPI video backlight
> > device (acpi_video0) gets registered alongside the native AMD
> > backlight (amdgpu_bl2). In this state, writes to amdgpu_bl2 update
> > the software brightness value but fail to change the physical panel
> > brightness.
> >
> > Force native backlight to prevent acpi_video0 from registering.
> > Confirmed that booting with acpi_backlight=3Dnative resolves the issue.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
> > ---
> > This patch adds a DMI quirk to force native backlight control on the
> > HP OMEN 16 Gaming Laptop (board name 8A44), which has a mux-less
> > hybrid GPU configuration with AMD Rembrandt (680M iGPU) and NVIDIA
> > GA104 (RTX 3070 Ti).
> > On this laptop the internal eDP panel is wired to the AMD iGPU. The
> > amdgpu driver registers amdgpu_bl2 as the native backlight device.
> > When the Nouveau driver is loaded without GSP firmware (as is the
> > case on v6.17 where GSP is not the default for Ampere GPUs), writes
> > to amdgpu_bl2 fail silently =E2=80=94 the brightness sysfs value update=
s
> > but the physical panel brightness does not change.
> > Testing:
> > - Tested on HP OMEN 16 with AMD Ryzen 9 6900HX + NVIDIA RTX 3070 Ti.
> > - On v6.17, without this quirk, brightness control is broken.
> > - On v6.17, booting with acpi_backlight=3Dnative restores correct
> >    brightness control. This patch applies that workaround
> >    automatically via DMI match.
> > - On v6.18+, the issue does not reproduce because commit
> >    e0ed674acbac ("drm/nouveau: Remove DRM_NOUVEAU_GSP_DEFAULT
> >    config") made GSP firmware the default for Ampere, which avoids
> >    the ACPI conflict entirely.
> > I have only tested this on v6.17 and v7.0. I am leaving it to the
> > stable/LTS maintainers to determine whether this quirk should be
> > backported, as I have not verified the stability of the GSP firmware
> > path on intermediate releases.
> >
> > Thanks,
> > Shivam Kalra
> > ---
> >   drivers/acpi/video_detect.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 0a3c8232d15d..458efa4fe9d4 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -916,6 +916,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
> >               DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
> >               },
> >       },
> > +     {
> > +      .callback =3D video_detect_force_native,
> > +      /* HP OMEN Gaming Laptop 16-n0xxx */
> > +      .matches =3D {
> > +             DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +             DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-=
n0xxx"),
> > +             },
> > +     },
> >
> >       /*
> >        * x86 android tablets which directly control the backlight throu=
gh
> >
> > ---
> > base-commit: 27d128c1cff64c3b8012cc56dd5a1391bb4f1821
> > change-id: 20260425-omen-16-backlight-fix-73fb8bc4a2b9
> >
> > Best regards,
> > --
> > Shivam Kalra <shivamkalra98@zohomail.in>
> >
> >
> Hey,
>
> A gentle thread bump. If you have any suggestions let me know.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4b506ea5351a1f5937ac632a4a5c35f6f796cc41

It looks like I have not responded to the patch, sorry about that.
