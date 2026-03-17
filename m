Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9F3B8BCB
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749378; cv=none; b=ubJc0s0+BF0G8Mt0dU+FA0xJ6RnstS2dVMjX6QInNXxBhBFcn4oOiuqeiW3WqXquWeyJLfposQv86/BkqoUrkeo7upbyNrufvsKcS4fCXT6q6GMuHW6gpiI7FZncvCi0bQ3kbxzieF5k/GG5K3q83PLVeG6jUhv/txkNfD7et88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749378; c=relaxed/simple;
	bh=uygTYnmGgnFJ7wAR36RhWuxTSCwi18T/AnJ9RFs8oz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOJFvhfPzQ028kJ6CkMVgp/g3B50RsUVc927gf7aHqimlwrLa/NyVplBDgDwDfDWnMOiREEeByUi9oKOzPxdPm/kxlNh1gt30P6orHwoS/bBY530AUg2waIInXmed5VkhTXn3+jt77f54blsbZ/TSjWPThemv18IUNW1g+qXeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGDbJJxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGDbJJxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F015C4CEF7
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749378;
	bh=uygTYnmGgnFJ7wAR36RhWuxTSCwi18T/AnJ9RFs8oz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oGDbJJxrDMgQCc951IGCVTDrvsXai4GzCjTNhuirRadRxShnItSY4HNOFnWh2c69k
	 edHjn6pqAH1uI2B84HswUwl483ZU3DbQ29QmSCRnXRIH3WBQi8qjP40BCNplu/4rSw
	 3BwLlCqme35xJldn/kENO8OfIuvrqGrXSLn2cTlmX01EbDBoKl8vF95deMBlK57w/f
	 xY2VRf00aDUZnppNbfVR/J8Hv/WA6aN+Of3BttsnpIgtKMUaiSz9/Aga8xa/4dTxF7
	 Bje3XlLLXAc2e+kmzdaILB0pWC8n0a5XnAK22Wnl6YNCnxq8DB6fcBf+sraH43afU9
	 AgRvNnY1ipUhg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4673790ab85so3719559b6e.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 05:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhYjvzngbFyv4Z1EZoOmCiQd5sEicxV5vDpmaEiAMwnXXuFuUOz4+EoThVOsYVN0onFSan0WN8NykK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvs7MGFtZi3xlEOiSoDNw0eX/YhZ3S+8Ybt7Cil7Rnt4e/1WrZ
	LAcqCj0+NzymdJtpYnyYN6riQh6jPyy7Zod5J/x+GphG+zk54Pfzt6+3FV8DDuKaZ/bg+hTiCl1
	DzIf1O9ff7isaV2jjKDM7WvEZDsyv8rc=
X-Received: by 2002:a05:6808:16aa:b0:467:15dc:b35b with SMTP id
 5614622812f47-467570ecd49mr9356326b6e.3.1773749377543; Tue, 17 Mar 2026
 05:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com> <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
In-Reply-To: <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 13:09:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
X-Gm-Features: AaiRm50B3nrzGY1cxf164rsSEqZ1JQKzk859rejhZzWlfwMAIm0YZpNKFDlQlKM
Message-ID: <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com, 
	sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:57=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/16/26 22:52, Antheas Kapenekakis wrote:
> >> So in accordance with the above, /sys/power/standby is not a very
> >> fortunate choice of the name of this interface and I'm totally
> >> unconvinced that it belongs to sys/power because its role is not
> >> really power management (and it is ACPI-only for the time being).
> > Hm, most of the changes / implementation resides in the pm subsystem
> > and it is related to the s2idle suspend flow.
> >
> > I assume that when it stops being ACPI only provided we reach a design
> > that allows for that, the related callbacks would also nest in pm ops.
> >
> > Where could a more appropriate directory in sysfs be? I would still
> > tend towards /sys/power
>
> Question is whether anyone outside of ACPI will ever need the generic
> interface. Making it generic based on guesswork could be a wasted effort
> that Rafael and others will have to maintain. The mode file could go
> under /sys/firmware/acpi if interface is made ACPI-specific.

Well, experience shows that it may end up the other way around.

People once thought that the platform profile interface would be
ACPI-specific and we ended up having to extend it via
platform_profile_class.

I'm thinking that something similar may take place in this case.
Platforms that don't use ACPI may also want to define platform
triggers to somehow adjust platform settings and those may be
different from "inactive" or "snooze".

> Will be good if you could demonstrate a need in making interface
> generic, if there are any devices on your mind that could make use of it
> right away. Old interface can be deprecated if a better new appears.
>
> Either way is okay to me, but Rafael is the PM expert and I'd do as he
> wants it to be.

Thanks, much appreciated.

I just want to make one thing clear.  Linux does not implement
anything like modern standby and that's for a reason, so I don't want
this thing to be advertised as "Linux modern standby" in any shape or
form.
