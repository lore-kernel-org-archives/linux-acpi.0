Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B71F30A9
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104433; cv=none; b=MgNh85doVNstNhrPp9JW8x50xSyk8iPDhh1L3s8EBXota8uljzGBnMqllXHxUvdq0YV8nnBjo4ahQ8JYg5CZNV5eE7kDX1kqoYOL8exBMvfPWcBjgqzHwf2yEK7ZYeNUxyuscjFNvAFZkea2HcqGB9WTLlcQOkb7Y+CAaZnSVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104433; c=relaxed/simple;
	bh=p4XO1ZsrfCvm+JRvGMocTQQ7CwSGJ4XFbOeDEwwHdyo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TibsCHDHUQnLwjtY9wLpI2PJASct4BZcDnbZGTgrP2jE6oWYdqEI9N4QX5tu1V50BIz4QfnFgWT2npGjId6NgzxplS+MJp1ik5aASTahJPM/WEiGX1hj5wP4YOpVOLIXQEI/S2BYEEsCZN151eYVqs3KkRkYSnldB+knrf48kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+X78nSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+X78nSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D301F00A3D
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783104431;
	bh=WSHkPufvRxell47S5RaReeupVMfOx71kVBmiWgWD1iQ=;
	h=From:Date:Subject:To:Cc;
	b=X+X78nStVxeaL5nfx8HTBtlF+s+rK3RPaOGaKKKaBQtLLa8gNInKY+zueFxSM4Iqp
	 5BkDbzRG+e6S25XBdber0lF7S53wUL1Zz+9YaBDgoSnCSe5bPvO7Q6B5nyJnYrL2IB
	 DvRGk++DCXZ6jOYCKB7sHFHKUFMg0hbuzVsYsEYuynxU7tj9fJQLsco8czCl0pyYn7
	 brVahAYgXWWacKDy4rKRTgYNBZdEINYJgjsh01E9EMJlDujZtF1tl1jpomuobnXzJn
	 XPJX83ukFkTp09QcAsapzwUp/QAUj/altLMAmlLdKG8YMelObbja5XfqodGxjAOyzx
	 4DrvquiLkIVnw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b355f96afso7908891fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 11:47:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzn2Dq5rW8ivN8D2jyKs9/mp54rG6Vo9xXZmFjqzVHh2xlUH3vh
	EBBXEcC4kaSKvF7Js5hHQlQVjopRVpadqstdA3ttK4UGnzPXSx9O3lwt6Xhxs4A8oD/4I3Ozb2Q
	/CmemSa8GvaNMTF9EpZaqNjHjN9L0x6M=
X-Received: by 2002:a05:6512:6416:b0:5ae:ba7a:1790 with SMTP id
 2adb3069b0e04-5aed5086ce1mr31552e87.11.1783104429901; Fri, 03 Jul 2026
 11:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 20:46:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
X-Gm-Features: AVVi8CeUgRVgM-oCHm1cpnM1k3L51q5X2SY13dyxn_ThSaCHUPETglsVPIpJM5Q
Message-ID: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for 7.2-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.2-rc2

with top-most commit 973772c7cf647cf4da6badd86c484f9b350eea18

 Merge branch 'acpi-tad'

on top of commit dc59e4fea9d83f03bad6bddf3fa2e52491777482

 Linux 7.2-rc1

to receive ACPI support fixes for 7.2-rc2.

These fix a coding mistake in the ACPI TAD (Time and Alarm Device)
driver introduced by one of its previous updates and get rid of the ugly
#ifdef __KERNEL__ conditional compliation in acpi_ut_safe_strncpy() by
redefining that function as an alias for strscpy_pad():

 - Add a missing ACPI_TAD_AC_WAKE capability check omitted by mistake to
   the ACPI TAD driver (Xu Rao)

 - Define acpi_ut_safe_strncpy() as an alias for strscpy_pad() which is
   viable because that function is only called from kernel code (Rafael
   Wysocki)

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPICA: Define acpi_ut_safe_strncpy() as strscpy_pad() alias

Xu Rao (1):
      ACPI: TAD: Check AC wake capability before enabling wakeup

---------------

 drivers/acpi/acpi_tad.c           |  2 +-
 drivers/acpi/acpica/acutils.h     |  2 --
 drivers/acpi/acpica/utnonansi.c   | 16 ----------------
 include/acpi/platform/aclinuxex.h |  1 +
 4 files changed, 2 insertions(+), 19 deletions(-)
