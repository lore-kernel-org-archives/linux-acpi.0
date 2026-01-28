Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9C30AAA9
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633208; cv=none; b=pH3MGaNsWKtuX82dAp1KjmUFK2acWRGRtY4jcwB10XU7XlcLa7zepjOddxtU4Vxzk6g09c826hvzNzbL34Z5ALeKFqD7oXAZWrGRbi6dmvGFmYQtkGygA4ZE47vViaFK+Xpbwiv9X1ug2bTNxr+gAw6RxLguwQD3d/Q+QVffHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633208; c=relaxed/simple;
	bh=b8OeO+k/KBoXIIpxZQPupwF2T1DGRXPpqx+TJiYFyrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj0pnhLtiqP6aG9Ltzd9HDVyTF9apWgM66KdbP234/81krDbQvVVt5KwlXRpXj6ep8q9cULB0y25JdAoHCn1iSU6g2UQmElJIwL0dgWIAN6KFs91vN7Y9TQqk+mkNkqqAqXicuXxUFCSMMOfUqrrBM9odKNtFApwKs+MdubRvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMRtBe/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMRtBe/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA72C4AF09
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769633208;
	bh=b8OeO+k/KBoXIIpxZQPupwF2T1DGRXPpqx+TJiYFyrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YMRtBe/WYX5jTk5SD+58QsmmjC/JWi5/idzkhOQQNPMWIZtCeOa5rxg7G2W2ndPoj
	 GvDjf7BjcXxGVZNz4qeeWLo+rBasukK0E7b0xk15qoH/TVrC7gvZk1DMIbDupcirS4
	 akAX4PxyskPQDfqqwYSIlRe4ziDk9DegOsbRhP9lmichyMahUYJgOH1WR2B+/UsaY/
	 0lBUzFpZ7PLxCVP26sqOwBkCiIq+ujH7uWACeHbjwqIWUHe1Vae8GWWTQWTdpiXUT/
	 PPZ5jKmEcP6xZc/+2zQJb/Q/2eZ4tOR0Nr7q5MMM/rIUmjvIWLZOkdyFn83ECJDe85
	 t+N1g/68R4/9A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662feac8228so161917eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 12:46:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyS8q/CFIJmKSaAI1oEDv3pG+gl0jS1vifUFvlI09Fq53IOkULB
	foeA6xDUAFg+kjsXCY9mEqhKh2RYpXOidNTsJhpa6lHUEjMmvgcZsC2ZIt0aN3iNcCZJGnT8wdw
	ABXqppaj+r6jOh4c1jYkWgblrCwb6cQc=
X-Received: by 2002:a05:6820:839a:b0:662:f3f6:bf6b with SMTP id
 006d021491bc7-662f3f6bff2mr3258443eaf.80.1769633207035; Wed, 28 Jan 2026
 12:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127200121.1292216-1-riemenschneiderjakob@gmail.com> <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
In-Reply-To: <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 21:46:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1Uw9jOa-2WpDnYEKpD61D141aC5wb6aKv7ZeOFVB=fw@mail.gmail.com>
X-Gm-Features: AZwV_QgDQrZIKL7ugzwmN-LAZ10q4Q2Pl5b0vImPWTafWoorgUA9DAsPXhrtCb0
Message-ID: <CAJZ5v0i1Uw9jOa-2WpDnYEKpD61D141aC5wb6aKv7ZeOFVB=fw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9
 (Turn On Display)
To: Antheas Kapenekakis <lkml@antheas.dev>, 
	Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Antheas Kapenekakis <antheas@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:06=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> On Tue, 27 Jan 2026 at 21:01, Jakob Riemenschneider
> <riemenschneiderjakob@gmail.com> wrote:
> >
> > Windows 11, version 22H2 introduced a new function index (Function 9) t=
o
> > the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
> >
> > According to Microsoft documentation, this function signals to the syst=
em
> > firmware that the OS intends to turn on the display when exiting Modern
> > Standby. This allows the firmware to release Power Limits (PLx) earlier=
.
> >
> > Crucially, this patch fixes a functional issue observed on the Lenovo Y=
oga
> > Slim 7i Aura (15ILL9), where system fans and keyboard backlights fail t=
o
> > resume after suspend. Investigation linked shows the EC on this device
> > turns off these components during sleep but requires the Function 9
> > notification to wake them up again.
> >
> > This patch defines the new function index (ACPI_MS_TURN_ON_DISPLAY) and
> > invokes it in acpi_s2idle_restore_early_lps0(). The execution order is
> > updated to match the logic of an "intent" signal:
> >
> > 1. LPS0 Exit (Function 6)
> > 2. Turn On Display Intent (Function 9)
> > 3. Modern Standby Exit (Function 8)
> > 4. Screen On (Function 4)
> >
> > Invoking Function 9 before the Modern Standby Exit ensures the firmware
> > has time to restore power rails and functionality (like fans) before th=
e
> > software fully exits the sleep state.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-firmware-notifications#turn-on-display-notificat=
ion-function-9
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220505
> > Suggested-by: Antheas Kapenekakis <antheas@antheas.dev>
>
> LGTM, no need for rby, sby covers it.
>
> Consider closes + reported by from bugzilla if there is a V3, I
> typically use lkml@antheas.dev but that is small.
>
> I will defer to Rafael now

Applied as 6.20 material (changed Link: to Closes: for the BZ link), thanks=
!
