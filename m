Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5723CCA1A
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432490; cv=none; b=X06dHVSiR961qlmyRJpHGuUXcFdMxIMvSOo0v5hJOySzc7RK0mD8ewei/IZFO+WBzkXllLqod6bP6INIZz2cq7URkfhjI2MJhBW/PbkDOyDK2rklDQIiuQnflA1IQy4oBEmU5Y+7nJvvRhjqrSlMyxLEk1gnhezeKhOT38A4WdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432490; c=relaxed/simple;
	bh=LQwUnypcwB5TpcIStvsk/uttr3yYU5WOZ/7+CL7AFEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Jcp+EvjWivhTfQlrqTXhSVEZdUSetLNxM/vifMgbjcGbmjLMnduBZaQ4lGnu9kjYBg+Pnm3zb92wJhJe89pkr39sXtKXh2kmt2l30BUPzqQJnDIokYX5p0qefUmVTcjsgtZpQJeXs4cpj0TG62BE3Uye1f7P6Tm1V/TINQPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvK8GCAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvK8GCAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCFCC2BCB3
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773432490;
	bh=LQwUnypcwB5TpcIStvsk/uttr3yYU5WOZ/7+CL7AFEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fvK8GCAb5UJ65h2gjqrmOlMS7pBtOiA1/SvHdDENMoDz0V+0EknF1V1Lw9nUIs7wq
	 z3MhqobQmUYnofMZeMMOPfumRaECXBEQp0VEkbUrMTB8+u5M9SYEqLMePhLQESnh4k
	 a3NT9FENTMJnjpsoV9TdTUmGUlBg/28W+GJk1/nGT/h44PPs8QuA0x+YeRyyFg/DTS
	 incwkQPuyTkW6OdcKn5nvjTRjsyTI2T3vwdabs8imZCoBZqOudvOPzYIvuusl3kl5y
	 wKww0oqanAhshAg8Sh/Rs0OBjRZ1QAqz20g4DRodFgc1+ouzjDZxVoJVHaqdNwrkln
	 vpWK9TShMyEMw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d75e74f5adso2605320a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 13:08:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXm3lKcJwwuiPjcCh9np9ZtEBX7A4krMMTk9xTcTmi+YosOJF1HucHOkQbbGLUdk78/MJ23FzL/girh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhe4T38/egdjvFQmDAzTx10IMYM3q9+M69mTwEUSBCH/qL3+ln
	WgBORsWYxhiqE1w/k6j4USu246XM/G4cK01tjbcIFyW6McSz5Uk000bgjvDtKCnymcKur6UEQhB
	HKERABYm0Doo452OIwj4WhgFNUm65Aa4=
X-Received: by 2002:a05:6820:616:b0:676:83f9:c8ef with SMTP id
 006d021491bc7-67bdaa809a8mr2892172eaf.65.1773432488920; Fri, 13 Mar 2026
 13:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <20251226102656.6296-2-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-2-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 21:07:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iPt6uFskHjO=Zj-vyExioM2Vypp05sTLQ-6QZeQi4ibQ@mail.gmail.com>
X-Gm-Features: AaiRm52nsUO5wpAuMVTCXlDT9rJm7RpRBMZd65XjVyq_fo0Lu4H7RgMSXklK5Mc
Message-ID: <CAJZ5v0iPt6uFskHjO=Zj-vyExioM2Vypp05sTLQ-6QZeQi4ibQ@mail.gmail.com>
Subject: Re: [RFC v1 1/8] Documentation: PM: Add documentation for Runtime
 Standby States
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> Introduce the runtime standby state ABI, which allows for firing the
> Modern Standby firmware notifications found in Windows during runtime.
> These notifications allow to make systems that support them look
> suspended.

The "look suspended" thing is misguided IMV.

I'd rather say something like

 This will allow "dark mode" indicating the lack of system activity
related to running user workloads.

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-power         |  20 ++++
>  .../admin-guide/pm/standby-states.rst         | 100 ++++++++++++++++++
>  Documentation/admin-guide/pm/system-wide.rst  |   1 +
>  3 files changed, 121 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/standby-states.rst
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/te=
sting/sysfs-power
> index d38da077905a..16378be2dc13 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -39,6 +39,26 @@ Description:
>                 See Documentation/admin-guide/pm/sleep-states.rst for mor=
e
>                 information.
>
> +What:          /sys/power/standby

I've already commented on this in my reply to the cover letter.

> +Date:          February 2026
> +Contact:       Antheas Kapenekakis <lkml@antheas.dev>
> +Description:
> +               The /sys/power/standby file allows userspace to inform th=
e
> +               kernel of the current runtime standby mode depending on u=
ser
> +               activity. The options are "active", "inactive", "sleep",
> +               and "resume". Only the ones supported by the platform wil=
l be
> +               available. Depending on the mode, the appearance of the d=
evice
> +               will change (e.g., keyboard backlight will turn off as pa=
rt of
> +               "inactive"), and its thermal envelope might be affected.
> +
> +               Reading from this file returns the available standby mode=
s,
> +               with the current one enclosed in square brackets. Writing=
 one
> +               of the above strings to this file causes the kernel to
> +               transition to it.
> +
> +               See Documentation/admin-guide/pm/standby-states.rst for m=
ore
> +               information.
> +
>  What:          /sys/power/disk
>  Date:          September 2006
>  Contact:       Rafael J. Wysocki <rafael@kernel.org>
> diff --git a/Documentation/admin-guide/pm/standby-states.rst b/Documentat=
ion/admin-guide/pm/standby-states.rst
> new file mode 100644
> index 000000000000..af7f32721d1c
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/standby-states.rst
> @@ -0,0 +1,100 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Runtime Standby States
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Copyright: |copy| 2026 Antheas Kapenekakis
> +
> +:Author: Antheas Kapenekakis <lkml@antheas.dev>
> +
> +This document describes the runtime standby states ABI available in the =
Linux
> +kernel, which is designed as a generic superset of the s0ix/Modern Stand=
by
> +firmware notifications. Devices with these notifications support hardwar=
e states
> +where they look like they are asleep, while still performing basic compu=
tation.
> +Specifically, those are "Sleep", "Inactive", and "Active" states, with a=
n
> +additional state "Resume". Transitioning between these states follows th=
e
> +flowchart below.
> +
> +Runtime Standby States
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The following runtime standby are supported::
> +
> +    <S2idle> =E2=86=94 <Sleep> =E2=86=94 <Inactive> =E2=86=94 <Active>
> +        =E2=86=92       =E2=86=92  <Resume>  =E2=86=91
> +
> +.. _s2idle_drips:
> +
> +
> +.. _s2idle_active:
> +
> +Active
> +------
> +
> +The "Active" state is the default state of the system and the one it has=
 when
> +it is turned on. It is the state where the device is on, and the user is
> +interacting with it.
> +
> +.. _s2idle_screen_off:
> +
> +Inactive
> +----------
> +
> +The "Inactive" state is a state in which users have stopped interacting =
with
> +the device, e.g., 5 seconds after the displays have turned off due to in=
activity
> +or due to the user pressing the power button. It is the responsibility o=
f
> +userspace to keep track of user interaction so it can inform the kernel =
to
> +transition to this state. The response to this state for devices that su=
pport
> +is to turn off their keyboard backlight, and some might pulse their powe=
r light.
> +
> +.. _s2idle_sleep:
> +
> +Sleep

The term "sleep" has already been allocated (sorry about that) and it
means any non-working states of the system, that may include ACPI S3,
ACPI S4 (hibernation), suspend-to-idle etc.

Some other name needs to be used here to avoid confusion with the
existing terminology.

> +-----
> +
> +In the sleep state, certain devices will limit their thermal envelope so=
 it is
> +safe for them to be put into a bag and still perform basic computation s=
uch as
> +fetching email. Then, some devices will pulse their power light. Userspa=
ce can
> +use this state to perform basic tasks such as wake-up checks while maint=
aining
> +the appearance the device is asleep.
> +
> +.. _s2idle_resume:
> +
> +Resume
> +------
> +
> +The resume state is a transient state that may only be entered from the =
sleep
> +state. It can be used to notify hardware that the device should boost it=
s
> +thermal envelope as preparation for the user interacting with it. As in,=
 it
> +undoes the thermal envelope effects of the "sleep" state while keeping i=
ts
> +appearance.
> +
> +S2idle
> +-----
> +
> +The "S2idle" state in the diagram corresponds to suspending normally by =
writing
> +``mem`` to ``/sys/power/state``. Userspace is fully frozen, and the kern=
el parks
> +the CPUs and turns off most devices. It is shown in the graph as a refer=
ence.
> +If the runtime standby state is not "sleep" when entering s2idle, the ke=
rnel
> +will first transition to "sleep" before entering s2idle.

Overall, I personally don't like the terminology used above too much.

You seem to be talking about a state machine, but there really isn't
one.  The state of the system after evaluating PNP0D80 _DSM function 3
(screen off) need not be different from its preceding state, and even
so the difference may be relatively small.

I would rather describe all of this in terms of indicating certain
conditions to the user.  For instance, "inactive" is written to
/sysfs/attribute/to/be/determined to indicate to the user that there's
no activity in the system related to running user workloads.

It's almost like selecting "work profiles" for the platform.

> +
> +Basic ``sysfs`` Interface for runtime standby transitions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The file :file:`/sys/power/standby` can be used to transition the system=
 between
> +the different standby states.

I'm not sure if the effects of using this interface (or its future
replacement) can be referred to as "transitions".  Some devices will
be affected, but the general state of the system will not be changed
as a result of using them.

> The file accepts the following values: ``active``,
> +``inactive``, ``sleep``, and ``resume``. File writes will block until th=
e
> +transition completes. The system will cross all states shown in the flow=
chart
> +above to reach the desired state. It will return ``-EINVAL`` when asking=
 for an
> +unsupported state or, e.g., requesting ``resume`` when not in the ``slee=
p``
> +state. If there is an error during the transition, the transition will p=
ause on
> +the last error-free state and return an error.
> +
> +The file can be read to retrieve the current state (and potential ones) =
with the
> +following format: ``[active] inactive sleep resume``. Only supported sta=
tes
> +will be shown.
> +
> +Userspace may transition between all supported states including s2idle
> +arbitrarily, except for the ``resume`` state which may only be requested=
 from
> +the ``sleep`` state.
> \ No newline at end of file
> diff --git a/Documentation/admin-guide/pm/system-wide.rst b/Documentation=
/admin-guide/pm/system-wide.rst
> index 1a1924d71006..411775fae4ac 100644
> --- a/Documentation/admin-guide/pm/system-wide.rst
> +++ b/Documentation/admin-guide/pm/system-wide.rst
> @@ -8,4 +8,5 @@ System-Wide Power Management
>     :maxdepth: 2
>
>     sleep-states
> +   standby-states
>     suspend-flows
> --
