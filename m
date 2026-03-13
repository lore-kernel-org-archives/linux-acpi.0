Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F63E0229
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430583; cv=none; b=TvMmvbc0Iw8EWkgOkCIWvZt2zxTVle7k4VhmasVL8e7VTD49G0L4ZAQrPb1c1gCT4zmsdkr20T8XqURQoqa8cYHD5bd1Q0ZkPnBDxxxG1crgzYnMHrayDf3dA9bNpt0mU97ShonXTyVxFPEtCUo1/NKLT2X09JtjKgFv6N9SpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430583; c=relaxed/simple;
	bh=XQ/gcUv9YR8al6PeVWo1s71e2tRS0bwFgmBNdmbUArU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUa2QjIa+Z76f4sy28QJgOnR4tkPkgyCHGpgkeWKfvN+IedQOQ7zy4vQKxX7SzWEcUcxyJASi4IKjecHp1zoh/FQQlFy57X3GG7PBM/jSYB/jm+wS4fL6HUfjjA/HlTgCUFnvGfdI82Kgycd9fXWE6j9JDZygv9OpqIq8Jqsjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV8vzNVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV8vzNVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E6C2BCB4
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773430582;
	bh=XQ/gcUv9YR8al6PeVWo1s71e2tRS0bwFgmBNdmbUArU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lV8vzNVjImZtfkCNJgTLZR//H/JK82gVgYSOGT5rb1UIAfKiS8x5T+WVVFLgwMP28
	 JGHU/ylJgXySJ8iiuPFAxjwmrwEYM4jOHfYC7PhdykAFuyVgKLd/5nqC8QAiat/Ex3
	 hpTqj9f5P6TWrsnk8iPt0vuEYPtlI2hC1CvOW+NdDpQytaqKeoCKVDDjdfgdjPgTGQ
	 2sf9sYYR8O9AMxbzl7cblVu0JHJFLHKDSHZ5WUJq4bLIhTbFA4WK1r4Mt6RL1gzM54
	 RKLVYBHssFoyV6puxKfYEEEm+DlxSF3zPkBEIgDzwtUSt9gdgZvzYaGaiz6H+TPox4
	 KmuQvKHQAGY2w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-463f00cda04so1617072b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 12:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW9HMD5w+C1CrehrJOGK/69/M1AX/m8mO3A3+riZGiB/5FkZogqrpH0xxfjSyOd6Wf5fgOuRPXxizw@vger.kernel.org
X-Gm-Message-State: AOJu0YxWESNy7B3hBEPgk0hVqmTPjC8daoCjJOtbv15fv8op4KAKLzN/
	nJ9dtYNTf0xSyk9hJEnlPp3Ui2g5TXC+ZwOxcpaZVouB5d3qFSs4Y0lGuoHMtoxbCeYmDGSUaAt
	yUKNJK0TpB+bOZEapzNA48N5kj/Wtai8=
X-Received: by 2002:a05:6808:8683:b0:467:1ad3:7f2 with SMTP id
 5614622812f47-46757531547mr1709364b6e.33.1773430581272; Fri, 13 Mar 2026
 12:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 20:36:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
X-Gm-Features: AaiRm53auHJeLzXnIxSdc6PSEA_FwIarrMtJfN0AM2sF3AytM3SDwaWsn26Oiyk
Message-ID: <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all, sorry for the huge delay.

This is one of the things that are kind of hard to get to due to other
stuff going on all the time.

On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> This series introduces a new runtime standby ABI to allow firing Modern
> Standby firmware notifications that modify hardware appearance from users=
pace
> without suspending the kernel. This allows userspace to set the inactivit=
y
> state of the device so that it looks like it is asleep (e.g., flashing th=
e
> power button) while still being able to perform basic computations.

I'm not particularly convinced about the "standby" terminology because
it is easily confused with the "standby" system state defined by ACPI
(S1).  It is not a similar thing, nor even close.

Admittedly, I was not a fan of the idea to allow user space to trigger
PNP0D80 device _DSM functions by itself, but now I've changed my mind
because I can see a valid use case for that.

Namely, if you wanted to indicate to the user that there's no activity
in the system beyond general maintenance, turning off "lights" would
be reasonable, but that has a little to do with "standby".  The term
"dark mode" would be a better match IMV because this is a mode in
which the system can operate and specifically not a state (the system
can be in various states, for example working or sleeping, while in
that mode).

> It is a more fleshed out implementation of [1] and a rewritten version of=
 [2]
>
> The first part of this series implements the plumbing that moves the exis=
ting
> DSMs from being called at the end of the suspend sequence to the beginnin=
g,
> where they are called through a transition function. Then, the last patch
> exposes this transition function through /sys/power/standby to allow user=
space
> to interact with it.

So in accordance with the above, /sys/power/standby is not a very
fortunate choice of the name of this interface and I'm totally
unconvinced that it belongs to /sys/power/ because its role is not
really power management (and it is ACPI-only for the time being).

> In this way, the core series can be tested while not exposing the new ABI
> to userspace until ensured to be stable.
>
> For more information, see the first patch in this series with documentati=
on.
>
> Because this series is a major rewrite, I have not tested it much and the=
re
> might be minor logic issues. In addition, due to confusion with the
> "screen off" terminology, I opted to rename the "screen off" state to
> "inactive". This way, it is applicable to devices that do not have screen=
s.
>
> To test this series, it is recommended to enable logs with:
>
> sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
> file drivers/acpi/x86/s2idle.c +p
> file kernel/power/suspend.c +p
> EOF
> echo 1 | sudo tee /sys/power/pm_debug_messages
>
> Here are some commands afterwards:
>
> echo "active" | sudo tee /sys/power/standby; cat /sys/power/standby
> echo "inactive" | sudo tee /sys/power/standby; cat /sys/power/standby
> echo "sleep" | sudo tee /sys/power/standby; cat /sys/power/standby

Why do you need the "sleep" thing in addition to /sys/power/state ?
