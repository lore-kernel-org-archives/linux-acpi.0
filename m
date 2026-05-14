Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D993382F1
	for <linux-acpi@vger.kernel.org>; Thu, 14 May 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792654; cv=none; b=BjgArVzHJc4XaIeLaapMwv8tgJ2dLNUVzviqp+gAriqerX7/X25/WWroTDT4LKgoq3w4ThwwlvxCs3fatf07dS+rxPvFHKp7MnxUJNMTvomlm2wr9KkDkqXJ/x9xT1cJ0MV28QIXTLtBPGWs8eXh8QFAAYDMJTZni3Ck7DpX48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792654; c=relaxed/simple;
	bh=5OsU3wxFrgG9kobK9BXvQZ8CDRMahAxyhwl5eQvdhd4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gljmviEEOtnJumCt4zFo1JcZVOGo/c3DllPGFhYYfswAaxW/YgED+73o23kXx9zMqbBEp7ur5FtBNk6wxywwMVZQNvxoeBHk8E0CII3OsJFwfKaJVFnHU3vDl0zg9Q5UVuDOXkIJtKlOqXp16Z087qjuo5vObCJHZ5iAWkf6+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Tor1UD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Tor1UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD95C2BCB3
	for <linux-acpi@vger.kernel.org>; Thu, 14 May 2026 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792653;
	bh=5OsU3wxFrgG9kobK9BXvQZ8CDRMahAxyhwl5eQvdhd4=;
	h=From:Date:Subject:To:Cc:From;
	b=T4Tor1UDTtNkc7qutmYJeAH6qiv7yFH6fHlAbOVIPgEWULJkL18Y9vMqbXHy3uWTU
	 Vf9NtO99LTw1N2mLKwLUnOxJi8m+017Lx46zIBoEU6uP/lFkgjhQeO7ksgY1iIgVtp
	 I3SBPRHNMMipA9kG5krP8bxq4FzBtQngMKwalP/2gfgz+EUwZEASO8FiQJ2hO6rCHE
	 oistngRR5aKQIFDv+3DE1Rsj/suJhn86/puzFZVtxNUkcnn0w2sY7otleIsM3vY31p
	 /T5QM/U0TRvzHZARz/cx0PZ4lDB2qQfhB8YRi3SK/Vd8zKu/S0b1XxcVGqxhwYuw08
	 AGgbd+FtAK+pw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e97e73234so77418151fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2026 14:04:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCtN+vMAypUWhaNfU66X4ylB1yS2Wfex5DTmVYpkoPTAyIfyLT
	a2TR+VPN6FdtMwwM8qqYYSYnpcKEHNyjSE1K0ASX50mWSfqgX7XlIINAlel6XStSUr531yaaAKu
	3NlpLtNQv6lN/ZFzKf49ex+owZ3b87vU=
X-Received: by 2002:a05:6512:124d:b0:5aa:b6a:9255 with SMTP id
 2adb3069b0e04-5aa0e740a7bmr188428e87.42.1778792652092; Thu, 14 May 2026
 14:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 May 2026 23:04:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFKtzK1iGBire4=g5rJa8Rtk1SX96dFBb1uRMFEYJwCg@mail.gmail.com>
X-Gm-Features: AVHnY4K-I4UZJfTw5qzaWZn3TGbiTWdbPm5mQLBKLLlYD1rG1TRe9jZjMtfjGJg
Message-ID: <CAJZ5v0gFKtzK1iGBire4=g5rJa8Rtk1SX96dFBb1uRMFEYJwCg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.1-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc4

with top-most commit af149b667b9472bf981591a6d27efdecd331005a

 Merge branch 'acpi-cppc'

on top of commit 5d6919055dec134de3c40167a490f33c74c12581

 Linux 7.1-rc3

to receive ACPI support fixes for 7.1-rc4.

These fix several platform drivers that use the ACPI companion of the
given platform device without checking its presence, which may lead
to a NULL pointer dereference or other kind of malfunction if the
driver is forced to match a device without an ACPI companion via
driver override, and restore debug log level for some messages in
the ACPI CPPC library:

 - Check ACPI_COMPANION() against NULL during probe in several core
   ACPI device drivers (Rafael Wysocki)

 - Restore log level of messages in amd_set_max_freq_ratio() (Mario
   Limonciello)

Thanks!


---------------

Mario Limonciello (1):
      Revert "ACPI: CPPC: Adjust debug messages in
amd_set_max_freq_ratio() to warn"

Rafael J. Wysocki (2):
      ACPI: driver: Check ACPI_COMPANION() against NULL during probe
      ACPI: PAD: xen: Check ACPI_COMPANION() against NULL

---------------

 arch/x86/kernel/acpi/cppc.c      | 6 +++---
 drivers/acpi/ac.c                | 6 +++++-
 drivers/acpi/acpi_pad.c          | 6 +++++-
 drivers/acpi/acpi_tad.c          | 6 +++++-
 drivers/acpi/battery.c           | 6 +++++-
 drivers/acpi/button.c            | 9 +++++++--
 drivers/acpi/ec.c                | 6 +++++-
 drivers/acpi/hed.c               | 6 +++++-
 drivers/acpi/nfit/core.c         | 6 +++++-
 drivers/acpi/pfr_telemetry.c     | 6 +++++-
 drivers/acpi/pfr_update.c        | 6 +++++-
 drivers/acpi/sbs.c               | 6 +++++-
 drivers/acpi/sbshc.c             | 6 +++++-
 drivers/acpi/thermal.c           | 2 +-
 drivers/acpi/tiny-power-button.c | 6 +++++-
 drivers/xen/xen-acpi-pad.c       | 6 +++++-
 16 files changed, 76 insertions(+), 19 deletions(-)
