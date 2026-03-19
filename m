Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6C3D3305
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923785; cv=none; b=YqxNpHGFuvS01onMIE6qHKyrYYGlZtbDhYbGilutZApKge3vYosRVZeIqCS42TSpqLrTZslOZr+CX6ZyptLME6En6JakxgvAMSiGuSBg0bRaYWxnWFpkn35NAXzs1WcIatOMAXs/eXOm2lMgtWKsQ4ZjHWgP2W4dUZTka8fkWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923785; c=relaxed/simple;
	bh=YnGRqsDKmtSOv+QfLHRe7wPRolgGrOtfpW3jV2ZegmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkTX7fzQcWQdP+QDRyQfY3ExFa9hMm505rnvNqKOX5DEdQwbtWD2G60+oQ6DBvve7pzNQgPUPcXqt1SJSzTFM7TIHvP4QwE3P52NI0BguRvi7HU/9D6bKvFLfakNhxjLrn4Nbxlggdb5BEiwpMbkhKI9YTDM4KpFjWIqOANoGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kyX50gOX; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kyX50gOX"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id DFA23C3E52
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 14:36:13 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 61B9BC39AE
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 14:36:13 +0200 (EET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 41EB71FF873
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 14:36:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773923772;
	bh=W8SiqmmPG/mw2NrnS49PZWhp3veB7TKcE+G98wmw0ZY=;
	h=Received:From:Subject:To;
	b=kyX50gOXy4fa3unwDH7jZm3OBAit/J9e5GVZ53wfvhTDvhS77vUbq41xi8f3pu7mY
	 1Q+SbNmWBdqcf6hkq97Uld7vn4Lr6yVCj3P8le8xreiig+I13zI7uUEAYv/B9iOxe+
	 qaG2ZO/y/2hxRO3CnHADW0Dul8J/HLw/oZUzfj4FhH1fqQM603w59TujEV53w+5z4U
	 5jZxKF0DzmLBcGu2tL2zqtJwIk0hh6q3/WFkayB6bgRyVBgrrkZ5FMCsVYFEfHnFqK
	 jUbM3M9Ly4tPJnvrBR6vHYtQzgbDhqjIu8oRZFF4YDRrWgEvrEgBjpMaRxyYv9L1ji
	 Iiqfx6pBQ0Chw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ad9516a653so3608795ad.0
        for <linux-acpi@vger.kernel.org>;
 Thu, 19 Mar 2026 05:36:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVc3kS5BkpO0aRcR/RrSlTLKvYSt6XEN2oXZCJ6A2CnWrjt7K+ZOYoZyBb4XSI9/MY//o4b4gqIJNS@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAz0T0nWjF9xLZwkYusSlDnL1MuyrTo8ZfhIARwB27lrQwkTx
	vBShVRHsWLYIlM5YFMsxl1A+P3W/kkxLnEtLxyuDGR/B1POEThpTW589FyGiGXTwCNTc0KJmVcP
	62TmlBatVbWO2Vvy0gGOIdgsnYxQsbwk=
X-Received: by 2002:a17:903:1666:b0:2b0:59c4:e9dc with SMTP id
 d9443c01a7336-2b06e332609mr69886215ad.22.1773923770894; Thu, 19 Mar 2026
 05:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
 <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
In-Reply-To: <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Mar 2026 13:35:59 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
X-Gm-Features: AaiRm531aC2ir-5WLLCOxJvp5tEjJKGub8lAu4gwmSJ3rFGD9ZplwEFZL0TtCcc
Message-ID: 
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177392377275.3168431.3778480003723721779@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 3/17/26 07:09, Rafael J. Wysocki wrote:
> > On Tue, Mar 17, 2026 at 12:57=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 3/16/26 22:52, Antheas Kapenekakis wrote:
> >>>> So in accordance with the above, /sys/power/standby is not a very
> >>>> fortunate choice of the name of this interface and I'm totally
> >>>> unconvinced that it belongs to sys/power because its role is not
> >>>> really power management (and it is ACPI-only for the time being).
> >>> Hm, most of the changes / implementation resides in the pm subsystem
> >>> and it is related to the s2idle suspend flow.
> >>>
> >>> I assume that when it stops being ACPI only provided we reach a desig=
n
> >>> that allows for that, the related callbacks would also nest in pm ops=
.
> >>>
> >>> Where could a more appropriate directory in sysfs be? I would still
> >>> tend towards /sys/power
> >>
> >> Question is whether anyone outside of ACPI will ever need the generic
> >> interface. Making it generic based on guesswork could be a wasted effo=
rt
> >> that Rafael and others will have to maintain. The mode file could go
> >> under /sys/firmware/acpi if interface is made ACPI-specific.
> >
> > Well, experience shows that it may end up the other way around.
> >
> > People once thought that the platform profile interface would be
> > ACPI-specific and we ended up having to extend it via
> > platform_profile_class.
> >
> > I'm thinking that something similar may take place in this case.
> > Platforms that don't use ACPI may also want to define platform
> > triggers to somehow adjust platform settings and those may be
> > different from "inactive" or "snooze".
> >
>
> At which point you would almost wonder if this should be super general
> like "foreground_workload_type".
>
> Then this could be expanded for other uses later such as full screen
> video playback or full screen gaming.

Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAULT,
3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
complexity.

> There could be hooks for scheduler too in the future from this hint too
> then.

Wouldn't it be better to defer to userspace? I'm not sure this would
have a meaningful difference in any case.

The states could be used to power off certain non-MS capable
components that cannot be inferred to be powered off in any case.
E.g., external lights, EC fans, in a centralized way that's tuned by
manufacturers.

Currently, it is adhoc.

> >> Will be good if you could demonstrate a need in making interface
> >> generic, if there are any devices on your mind that could make use of =
it
> >> right away. Old interface can be deprecated if a better new appears.
> >>
> >> Either way is okay to me, but Rafael is the PM expert and I'd do as he
> >> wants it to be.
> >
> > Thanks, much appreciated.
> >
> > I just want to make one thing clear.  Linux does not implement
> > anything like modern standby and that's for a reason, so I don't want
> > this thing to be advertised as "Linux modern standby" in any shape or
> > form.

Sure.

Antheas

