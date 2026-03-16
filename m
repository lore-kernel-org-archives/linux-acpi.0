Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D73DB64B
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690754; cv=none; b=DshgxpB66Ib5+k2QB3UCr26lPb8xIoNDWORKJi/teISKM6Phk0ecGZI+dEKt0f3MPZiN8LH9i83EbKSOmdYXydcezQOtRM6S0+4loY+UxaRAYaQiTkS914FXfb18VMQrcbyBhMf0Cz+aJZ45oTiib2euYvOdku36WExQDzHctyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690754; c=relaxed/simple;
	bh=JNTiHjdml+S1O13bIVkWNV4B9NriyFt4pcBydPBsYls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClAZtI3NHBmLfx2NgAjlpDpZopQX0VVNhIk13UeNWBNM6DUFacZzLcNu9tamGBfmch/H5TaL8FrQFyljfLHG1ELb9yFM3LntBHGkDx4zg7ZK6Wz3/gKidBOyyoC6OCYu1O+ftdB+ecYlDaWPdcfp/3NwJPdthqCVd23YDLGYnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KIFx2vxb; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KIFx2vxb"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 6711DBBFFF
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:52:26 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 11E69BC01E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:52:25 +0200 (EET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2E4F4202354
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 21:52:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773690744;
	bh=NY/Chvq+jdnHgvo2uf48SUE/RoJLE7a888d3JMk2flA=;
	h=Received:From:Subject:To;
	b=KIFx2vxb99pmjYfSwcw4H2T4CcUb5lj1FMTrMsQdbjCW4PxpNy8a0vw90Z2XKyL86
	 f0GmMZEEJmvAAIQf4cmqo2I5cwGP2jT7PVORx5nxAbJN2OdH8PACsGBSfcw03pn8mJ
	 keQ39hTjjBSpvPhacMVRkxh5IBBNBNAjTf/hLi4Ixo/rIfbg2pKXG2n85QpbUCeawC
	 cz0rQpmaSwQfxDawe6SVtgs5is9yfX8GbLjqh7QfF/HowEVtZjFJOUpcs9Mx/7sfbT
	 v80boBzzbZlmvRgudAvGti4SsWwsHMtn2N8JEJirTtDE1G+3deEPBE8/Ua4efCCH3f
	 1VyG/RtPI/ZTg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so60245005ad.2
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 12:52:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqYimSU48YTtUQRyzxwqcuA/RAkXnoc4BWiOpGUCm4ofd8bnflVgG97Y9pDFygTQXN/TcfE9ARW2p0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Np0W87L26i0gB8AOXQ4SGC1CPnn+/3lQbc2XKTbyxIdq1w8Q
	X2CQtgK/xc503QaToswgmjmtIrDk1Ci+5BiHbs14lU81FaGqu0K9N9Y0qX759Qmy1oVuhNy0ahz
	dCqXEZCk9GeXtrIMaIjQh8IrlUB2Lib0=
X-Received: by 2002:a17:903:2301:b0:2ae:4150:3118 with SMTP id
 d9443c01a7336-2aeca920ec7mr141904225ad.12.1773690742543; Mon, 16 Mar 2026
 12:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 20:52:10 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
X-Gm-Features: AaiRm52QilbXnCH2b2cdqxTWrKNVt3rVdbe-fu1HmNyjxYetNsLqBYbW9kR_M9A
Message-ID: 
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
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
 <177369074459.3157863.3969079120248155879@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 13 Mar 2026 at 20:36, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> First of all, sorry for the huge delay.
>
> This is one of the things that are kind of hard to get to due to other
> stuff going on all the time.

Hi,
thanks for the review. I will go through the emails, asking for
clarifications where appropriate and address the rest out of band. I
am not in a rush irt this series so it is ok from my side.

> On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > This series introduces a new runtime standby ABI to allow firing Modern
> > Standby firmware notifications that modify hardware appearance from use=
rspace
> > without suspending the kernel. This allows userspace to set the inactiv=
ity
> > state of the device so that it looks like it is asleep (e.g., flashing =
the
> > power button) while still being able to perform basic computations.
>
> I'm not particularly convinced about the "standby" terminology because
> it is easily confused with the "standby" system state defined by ACPI
> (S1).  It is not a similar thing, nor even close.
>
> Admittedly, I was not a fan of the idea to allow user space to trigger
> PNP0D80 device _DSM functions by itself, but now I've changed my mind
> because I can see a valid use case for that.
>
> Namely, if you wanted to indicate to the user that there's no activity
> in the system beyond general maintenance, turning off "lights" would
> be reasonable, but that has a little to do with "standby".  The term
> "dark mode" would be a better match IMV because this is a mode in
> which the system can operate and specifically not a state (the system
> can be in various states, for example working or sleeping, while in
> that mode).

/dark_mode seems a bit verbose/out of place. Perhaps something closer
to activity.

activity_hint / idle_hint perhaps?

> > It is a more fleshed out implementation of [1] and a rewritten version =
of [2]
> >
> > The first part of this series implements the plumbing that moves the ex=
isting
> > DSMs from being called at the end of the suspend sequence to the beginn=
ing,
> > where they are called through a transition function. Then, the last pat=
ch
> > exposes this transition function through /sys/power/standby to allow us=
erspace
> > to interact with it.
>
> So in accordance with the above, /sys/power/standby is not a very
> fortunate choice of the name of this interface and I'm totally
> unconvinced that it belongs to /sys/power/ because its role is not
> really power management (and it is ACPI-only for the time being).

Hm, most of the changes / implementation resides in the pm subsystem
and it is related to the s2idle suspend flow.

I assume that when it stops being ACPI only provided we reach a design
that allows for that, the related callbacks would also nest in pm ops.

Where could a more appropriate directory in sysfs be? I would still
tend towards /sys/power

Antheas

> > In this way, the core series can be tested while not exposing the new A=
BI
> > to userspace until ensured to be stable.
> >
> > For more information, see the first patch in this series with documenta=
tion.
> >
> > Because this series is a major rewrite, I have not tested it much and t=
here
> > might be minor logic issues. In addition, due to confusion with the
> > "screen off" terminology, I opted to rename the "screen off" state to
> > "inactive". This way, it is applicable to devices that do not have scre=
ens.
> >
> > To test this series, it is recommended to enable logs with:
> >
> > sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
> > file drivers/acpi/x86/s2idle.c +p
> > file kernel/power/suspend.c +p
> > EOF
> > echo 1 | sudo tee /sys/power/pm_debug_messages
> >
> > Here are some commands afterwards:
> >
> > echo "active" | sudo tee /sys/power/standby; cat /sys/power/standby
> > echo "inactive" | sudo tee /sys/power/standby; cat /sys/power/standby
> > echo "sleep" | sudo tee /sys/power/standby; cat /sys/power/standby
>
> Why do you need the "sleep" thing in addition to /sys/power/state ?
>

