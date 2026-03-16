Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB33E929D
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690910; cv=none; b=BMWccE4BJq+iUsBhXzuZX+yz+V7IWXuv+xVBNwqTUF+Co7kWcOY7GUTKg6f/PUpBtbsDel/PFrQcnTq5wfwrXGwCcPnf7KITdX1VQwV63YoQ5iAAOO4CqubERDSMme71MzjwCDHzxP1cDMTgJ7ezV0W/oB8D43bT13MvQ/xhL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690910; c=relaxed/simple;
	bh=xEmsQEx0iA6JVbcSG31ujUihFLICeJ2tCPW4bAloo3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlCqNzKEVJiA56UwWZtvpL/K1MIzreG9pYTKVo6yLMdbeUn91XTbOfEYhaj3CfzEnELQfkAwmd2MfUwIDqtM1NtchZHzFQ7dwMNK3wxJX+ENETeBSLqGQH1yUVkYD3arJCxUv17FBRdBD2AwLaJTWk72EC9Lu0OOfHYEaONUK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YzIHMU9S; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YzIHMU9S"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 9988DC7E19
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:55:07 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id A46F1C7E15
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:55:06 +0200 (EET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 9AC6E1FEF26
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:55:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773690906;
	bh=obmUc3yvfxFFYCBj3OG4KsBuKmlpApJ5RC7HVFQhwVg=;
	h=Received:From:Subject:To;
	b=YzIHMU9SHJOwXTtnEAAmG6twdDHj2c1Ga/jd8v23JTEegNXk+O2+JEXTlk5o8Ly/3
	 bIdI+HIaD8IykQau6ogcZ2JHO/twJqOHYekSU/Jpb02cXybg5JsxUbVNGXwiDHvR74
	 fm+AQLSNSP4KwOEZ1UCTdNYBf3L9OhcjC/bcCc6njOYjLH3Y/PKKYI+OECQfnrEFFH
	 7KlpWijPCDSurhfRuK5GCbWQQyHxx7AL2jWdIdfXiyKfW59+0MwzHIZbhpxkAsjlZS
	 BFVGDQ/UlCF7NDx4LIbLOs6gMW5yqkTXErX8lf34+3CW5pNrVO0wMZyV9kCMrntOoP
	 TZLJ+2OAvgydA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-829759ca646so3045102b3a.2
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 12:55:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUI8wSXEGdqcMztR1D9HfIC4LkjIOFzj/ye7gNbxzrjgIWzSHMTAslZU4A/1sEpfOfzzU9eB2+QM1tC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9dy6WAVWjdIaz/9rdA7WhEtFEi0JYiDIrVAQlg8m3zX0GK+M
	cq3efk0YDpxf2dsZ9dI65WF3ibM5HBzIKednoIOMs39P50O4FpkxcJasn8GSeBh2QUqtbNjoATF
	FP3W4x4U2shEbP0YCAQne48NQeFaOQqQ=
X-Received: by 2002:a05:6a20:431f:b0:398:7036:7378 with SMTP id
 adf61e73a8af0-398ece00a17mr13324072637.66.1773690903255; Mon, 16 Mar 2026
 12:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <20251226102656.6296-2-lkml@antheas.dev>
 <CAJZ5v0iPt6uFskHjO=Zj-vyExioM2Vypp05sTLQ-6QZeQi4ibQ@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0iPt6uFskHjO=Zj-vyExioM2Vypp05sTLQ-6QZeQi4ibQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 20:54:52 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE6ZoiXdn-eqY+fn9DKVq5obuNv_WBZeuX3Mxz4xH4NRg@mail.gmail.com>
X-Gm-Features: AaiRm51Fgo0HMrvlSQlUWYaUz9OwMG_yAZKG3RKslJYK0ki-fO7rNOIseSyabmQ
Message-ID: 
 <CAGwozwE6ZoiXdn-eqY+fn9DKVq5obuNv_WBZeuX3Mxz4xH4NRg@mail.gmail.com>
Subject: Re: [RFC v1 1/8] Documentation: PM: Add documentation for Runtime
 Standby States
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
	sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177369090563.3172783.14696786763249851198@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 13 Mar 2026 at 21:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > Introduce the runtime standby state ABI, which allows for firing the
> > Modern Standby firmware notifications found in Windows during runtime.
> > These notifications allow to make systems that support them look
> > suspended.
>
> The "look suspended" thing is misguided IMV.
>
> I'd rather say something like
>
>  This will allow "dark mode" indicating the lack of system activity
> related to running user workloads.
>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  Documentation/ABI/testing/sysfs-power         |  20 ++++
> >  .../admin-guide/pm/standby-states.rst         | 100 ++++++++++++++++++
> >  Documentation/admin-guide/pm/system-wide.rst  |   1 +
> >  3 files changed, 121 insertions(+)
> >  create mode 100644 Documentation/admin-guide/pm/standby-states.rst
> >
> > diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/=
testing/sysfs-power
> > index d38da077905a..16378be2dc13 100644
> > --- a/Documentation/ABI/testing/sysfs-power
> > +++ b/Documentation/ABI/testing/sysfs-power
> > @@ -39,6 +39,26 @@ Description:
> >                 See Documentation/admin-guide/pm/sleep-states.rst for m=
ore
> >                 information.
> >
> > +What:          /sys/power/standby
>
> I've already commented on this in my reply to the cover letter.
>
> > +Date:          February 2026
> > +Contact:       Antheas Kapenekakis <lkml@antheas.dev>
> > +Description:
> > +               The /sys/power/standby file allows userspace to inform =
the
> > +               kernel of the current runtime standby mode depending on=
 user
> > +               activity. The options are "active", "inactive", "sleep"=
,
> > +               and "resume". Only the ones supported by the platform w=
ill be
> > +               available. Depending on the mode, the appearance of the=
 device
> > +               will change (e.g., keyboard backlight will turn off as =
part of
> > +               "inactive"), and its thermal envelope might be affected=
.
> > +
> > +               Reading from this file returns the available standby mo=
des,
> > +               with the current one enclosed in square brackets. Writi=
ng one
> > +               of the above strings to this file causes the kernel to
> > +               transition to it.
> > +
> > +               See Documentation/admin-guide/pm/standby-states.rst for=
 more
> > +               information.
> > +
> >  What:          /sys/power/disk
> >  Date:          September 2006
> >  Contact:       Rafael J. Wysocki <rafael@kernel.org>
> > diff --git a/Documentation/admin-guide/pm/standby-states.rst b/Document=
ation/admin-guide/pm/standby-states.rst
> > new file mode 100644
> > index 000000000000..af7f32721d1c
> > --- /dev/null
> > +++ b/Documentation/admin-guide/pm/standby-states.rst
> > @@ -0,0 +1,100 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Runtime Standby States
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Copyright: |copy| 2026 Antheas Kapenekakis
> > +
> > +:Author: Antheas Kapenekakis <lkml@antheas.dev>
> > +
> > +This document describes the runtime standby states ABI available in th=
e Linux
> > +kernel, which is designed as a generic superset of the s0ix/Modern Sta=
ndby
> > +firmware notifications. Devices with these notifications support hardw=
are states
> > +where they look like they are asleep, while still performing basic com=
putation.
> > +Specifically, those are "Sleep", "Inactive", and "Active" states, with=
 an
> > +additional state "Resume". Transitioning between these states follows =
the
> > +flowchart below.
> > +
> > +Runtime Standby States
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The following runtime standby are supported::
> > +
> > +    <S2idle> =E2=86=94 <Sleep> =E2=86=94 <Inactive> =E2=86=94 <Active>
> > +        =E2=86=92       =E2=86=92  <Resume>  =E2=86=91
> > +
> > +.. _s2idle_drips:
> > +
> > +
> > +.. _s2idle_active:
> > +
> > +Active
> > +------
> > +
> > +The "Active" state is the default state of the system and the one it h=
as when
> > +it is turned on. It is the state where the device is on, and the user =
is
> > +interacting with it.
> > +
> > +.. _s2idle_screen_off:
> > +
> > +Inactive
> > +----------
> > +
> > +The "Inactive" state is a state in which users have stopped interactin=
g with
> > +the device, e.g., 5 seconds after the displays have turned off due to =
inactivity
> > +or due to the user pressing the power button. It is the responsibility=
 of
> > +userspace to keep track of user interaction so it can inform the kerne=
l to
> > +transition to this state. The response to this state for devices that =
support
> > +is to turn off their keyboard backlight, and some might pulse their po=
wer light.
> > +
> > +.. _s2idle_sleep:
> > +
> > +Sleep
>
> The term "sleep" has already been allocated (sorry about that) and it
> means any non-working states of the system, that may include ACPI S3,
> ACPI S4 (hibernation), suspend-to-idle etc.
>
> Some other name needs to be used here to avoid confusion with the
> existing terminology.
>
> > +-----
> > +
> > +In the sleep state, certain devices will limit their thermal envelope =
so it is
> > +safe for them to be put into a bag and still perform basic computation=
 such as
> > +fetching email. Then, some devices will pulse their power light. Users=
pace can
> > +use this state to perform basic tasks such as wake-up checks while mai=
ntaining
> > +the appearance the device is asleep.
> > +
> > +.. _s2idle_resume:
> > +
> > +Resume
> > +------
> > +
> > +The resume state is a transient state that may only be entered from th=
e sleep
> > +state. It can be used to notify hardware that the device should boost =
its
> > +thermal envelope as preparation for the user interacting with it. As i=
n, it
> > +undoes the thermal envelope effects of the "sleep" state while keeping=
 its
> > +appearance.
> > +
> > +S2idle
> > +-----
> > +
> > +The "S2idle" state in the diagram corresponds to suspending normally b=
y writing
> > +``mem`` to ``/sys/power/state``. Userspace is fully frozen, and the ke=
rnel parks
> > +the CPUs and turns off most devices. It is shown in the graph as a ref=
erence.
> > +If the runtime standby state is not "sleep" when entering s2idle, the =
kernel
> > +will first transition to "sleep" before entering s2idle.
>
> Overall, I personally don't like the terminology used above too much.
>
> You seem to be talking about a state machine, but there really isn't
> one.  The state of the system after evaluating PNP0D80 _DSM function 3
> (screen off) need not be different from its preceding state, and even
> so the difference may be relatively small.
>
> I would rather describe all of this in terms of indicating certain
> conditions to the user.  For instance, "inactive" is written to
> /sysfs/attribute/to/be/determined to indicate to the user that there's
> no activity in the system related to running user workloads.
>
> It's almost like selecting "work profiles" for the platform.

The current code implementation is as a state machine. Of course, this
is an implementation detail and need not be exposed to docs.

I will try to reword.

> > +
> > +Basic ``sysfs`` Interface for runtime standby transitions
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The file :file:`/sys/power/standby` can be used to transition the syst=
em between
> > +the different standby states.
>
> I'm not sure if the effects of using this interface (or its future
> replacement) can be referred to as "transitions".  Some devices will
> be affected, but the general state of the system will not be changed
> as a result of using them.

As said above, the implementation uses transition logic. This is not
needed to be reflected in the documentation.

> > The file accepts the following values: ``active``,
> > +``inactive``, ``sleep``, and ``resume``. File writes will block until =
the
> > +transition completes. The system will cross all states shown in the fl=
owchart
> > +above to reach the desired state. It will return ``-EINVAL`` when aski=
ng for an
> > +unsupported state or, e.g., requesting ``resume`` when not in the ``sl=
eep``
> > +state. If there is an error during the transition, the transition will=
 pause on
> > +the last error-free state and return an error.
> > +
> > +The file can be read to retrieve the current state (and potential ones=
) with the
> > +following format: ``[active] inactive sleep resume``. Only supported s=
tates
> > +will be shown.
> > +
> > +Userspace may transition between all supported states including s2idle
> > +arbitrarily, except for the ``resume`` state which may only be request=
ed from
> > +the ``sleep`` state.
> > \ No newline at end of file
> > diff --git a/Documentation/admin-guide/pm/system-wide.rst b/Documentati=
on/admin-guide/pm/system-wide.rst
> > index 1a1924d71006..411775fae4ac 100644
> > --- a/Documentation/admin-guide/pm/system-wide.rst
> > +++ b/Documentation/admin-guide/pm/system-wide.rst
> > @@ -8,4 +8,5 @@ System-Wide Power Management
> >     :maxdepth: 2
> >
> >     sleep-states
> > +   standby-states
> >     suspend-flows
> > --
>

