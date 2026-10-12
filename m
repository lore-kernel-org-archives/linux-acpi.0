Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E9339389
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828794; cv=none; b=IoJsEIY/+kknkCRaHe1Cca+XJBAFUNNjcq4ChOpxsz6Eokb+SBvX41/OFgEE26mS46gTdjucybayiwkiQHx/4xrEvODOmrbPsSx+YFxrzVGpoTwhKHIMYb9DO/LtcwQ7zBapHURzBVyp1ZbdnjsYX5PC74k1FglYgBRUpC42ZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828794; c=relaxed/simple;
	bh=qYihUqXQowOU9ZYLKuiLBwFCSKqT10FUjO6tSOCCPbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiLhEZen5MMxI32Q0bwZehQxN7jnaPKWWL8kykhCjcbxw48FbUsPanXlLEn/LJm+GkXiKG1VTc9qU2TPMAvNeOWlXN7ZgLQ3OkVceUc0UtDsI7LgV/SbA773Yylv9Ur3gkQWs6zwLvV+ufWYN0AZQeWGgndmIuYGc0up2CijQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0aWCuz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0aWCuz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C31F008A4
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828793;
	bh=Cyr/bHNMJGLzkq1DQHY5KRZ0FoizA8PV+QZEQ8qhgAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A0aWCuz/vGIpJSDiCnXNAx4EESt1jsoESJpFVjE7YI9R1NlaefHyfvFc+zGkWR6zM
	 Gr56Usm3rlmxlXfhO8PDHNZlR2lOWZ3i9YSkfDBIY86MO1Qem3+Hn5kKOlVRFedAlT
	 bgxRNDEIbpPwesPkHRx8dHeylyPZ+qWd2L3m9ixQuOlko/0ys6ecTC9iUDTbdP+DMr
	 debGdLOzv+03YzfZFMa33x5Dj2auzEvmGm8aar3oINniPgvG4hj1V+UQsrVLBkj9TW
	 RWBAnbFbev0OicOYnNNrrdUiEJiokMvTm7nUWUikGn56WP/84CyfxdXMJ/sfy7tR5H
	 6rY3s+b3eA+jg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so1555500e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 11:13:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwEtHl56NFcoo0DoIiy0voJbgJ6UtCekW38SfoWfoz+6LWuQJzLp970EGpYspJK0RVz/4uZcoTOvAZV@vger.kernel.org
X-Gm-Message-State: AFq9FYInmmLIWQoAY9KuQPGBkEq4jSjDAXEn6JCb8GqDPm27tB1q52Ig
	WEUJnmpx72Rf2N2FrfVW1nXY+ragEIYl+BsqbBoxH8XG59dG8j39xQpyiFHSMiJCQHY3QsMgZ1v
	s1NYbH2fHAEHXq9EWhrVfYhrMsgZu7CI=
X-Received: by 2002:a05:6512:3044:b0:5bc:b8b1:3e03 with SMTP id
 2adb3069b0e04-5bcde6c25f6mr3342409e87.25.1791828791862; Mon, 12 Oct 2026
 11:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009072401.52509-1-chitranshmandhaniya@gmail.com>
 <20261010124830.116750-1-chitranshmandhaniya@gmail.com> <96f4dc4d-eb5c-4af2-86e4-8d10f87b3d9d@kernel.org>
In-Reply-To: <96f4dc4d-eb5c-4af2-86e4-8d10f87b3d9d@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:11:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gw0Q_OCD4-OVcJZSmHMmP3d4_0GhXDex8gGTsB=tZ61A@mail.gmail.com>
X-Gm-Features: AclHuK8NBEXVTr0Oet1SN3N4AVDNaREBDJQxdM3dEvmpyS6iP9buBYY9vugnfGU
Message-ID: <CAJZ5v0gw0Q_OCD4-OVcJZSmHMmP3d4_0GhXDex8gGTsB=tZ61A@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: video: force native backlight on Dell OptiPlex
 AIO 7410 35W
To: Hans de Goede <hansg@kernel.org>, chitranshmandhaniya@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chitransh_Mandhaniya@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi,
>
> On 10-Oct-26 14:48, chitranshmandhaniya@gmail.com wrote:
> > From: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>
> >
> > The Dell OptiPlex AIO 7410 35W (board 01KP8D) declares DELL0501 in its
> > ACPI DSDT (status =3D 0x0F) even though no UART scalar board is physica=
lly
> > present. This causes acpi_video_get_backlight_type() to return
> > acpi_backlight_dell_uart, which makes i915 skip registering
> > intel_backlight. The dell-uart-backlight driver then times out talking
> > to the absent board and the probe fails, leaving the machine with zero
> > backlight control.
> >
> > A BIOS update fixes this on some models (e.g. OptiPlex 7420, board
> > 0914RT) by setting DELL0501 _STA to 0, but Dell has not shipped a
> > corrected BIOS for the 7410 even in the latest release (1.37.0,
> > 2026-05-28).
> >
> > Add a DMI quirk to force native backlight on this model so that i915
> > registers intel_backlight and brightness control works out of the box.
> >
> > Tested on:
> >   - OptiPlex AIO 7410 35W (01KP8D, BIOS 1.37.0) -- confirmed
> >     acpi_backlight=3Dnative produces working intel_backlight (raw,
> >     max=3D96000), DMI quirk has the same effect.
> >   - OptiPlex AIO 7420 35W (0914RT, BIOS 1.27.0) -- DELL0501 absent in
> >     updated BIOS, intel_backlight works natively (no regression).
> >
> > Signed-off-by: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied as 7.4 material, thanks!
