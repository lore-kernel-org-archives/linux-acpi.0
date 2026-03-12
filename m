Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37F2FBDFD
	for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339505; cv=none; b=VhDEdNBxyI81Uuh55VI4UlkmBWQ6wA01kwJu01uMPCxefvkgRBDccY82m3A57KiLZS6enZvbyS+QParALkZ8xMk/P97zG73B7eo5+g5dxigmTR/7JTg+xe7XLFJcUcTnSsGUcBz3RXU3f6kLSOmqgQFE1+oPZ88QOmQkHA6xkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339505; c=relaxed/simple;
	bh=TO3d4r8rsho6Jp5Lk1ze9qJNYHgHppe6DD5Uqjlfsm4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XNaBORUmOIMlSViMksc0DM2q9HMxvEt6Laq3xyxrFBaJDrvJWeOAiuYlvid3HmqVsR35g5rIVcBBEaFTIx70fTyYAwX+atVYOKnArcpXqszTW+ejT+9BkkbbANK8eNynw+QBeeshGUFSGIyItiXV1F8J2PvapHuANAaiBg4ySzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp5vHM+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp5vHM+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05D2C4CEF7
	for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773339504;
	bh=TO3d4r8rsho6Jp5Lk1ze9qJNYHgHppe6DD5Uqjlfsm4=;
	h=From:Date:Subject:To:Cc:From;
	b=Pp5vHM+Z2Amd7kRzzR4oF2L+HHlekqtULEfB81iGaVevzM5l/q8/UL3BEPi0DTcZu
	 QWIFtEOxq4arJHvGaDgCOEiZY/445h+rDpu+h3poC0oFba56sA4Xts+6lmAoNExffQ
	 Q1zImLjs6+MTYoqQnFAu36gNOIBA3lyVjTcJ8ep4ktgZKtHvomXzpDwwtRDehy4Otl
	 rY+leu6rdjeEB3uzhoRJ1xd8Yxl5e5TVi8KQgJWhz1CAH+HkR2d7WGTBqFu/V59CmF
	 XkEr4u/dLcOANX0CJr1Ikg+8pQ25DH04TDsyPyj4RN58kuMi5H+HwI2UC8iqEIDDGH
	 T6BQrXd76xVAQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67bd4e63606so349845eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 11:18:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHIO6LTnHaY34RGPKrFTPHPSW1wGTpzjlJMYgHlQYvJegxWKRf
	PfkolT4rY+ylNfN9sgxkfkYsZAqILmyp8reb1oB6K5u7J5+srB1XY+ZQt0LgHIFIQ4zQSHf9CuP
	OAUjiKmWIANnKcrMsDtuyg+J0liPr6h8=
X-Received: by 2002:a05:6820:440a:b0:67b:b01c:5887 with SMTP id
 006d021491bc7-67bdaa6c4ebmr167849eaf.56.1773339503837; Thu, 12 Mar 2026
 11:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 19:18:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jJzsUrrtnwh2-zya7qrEZdQx1YzNO__G_ptcv4UEiHEA@mail.gmail.com>
X-Gm-Features: AaiRm51advr1avx64dRgcQ5Nlvs1cEyjFqXHpeoxhbgcmJ37xMohckT26CMB9yE
Message-ID: <CAJZ5v0jJzsUrrtnwh2-zya7qrEZdQx1YzNO__G_ptcv4UEiHEA@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.0-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc4

with top-most commit 97d9960f355cca99960eb44cd1bba1d7ba1073ee

 Merge branch 'acpi-osl'

on top of commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681

 Linux 7.0-rc3

to receive ACPI support fixes for 7.0-rc4.

These address a recent regression related to the ACPI video bus
driver conversion to a platform one and make some sparse warnings
go away:

 - On some platforms, the ACPI companion object of the ACPI video
   bus platform device is shared with multiple other platform
   devices which leads to driver probe issues, so replace that
   device with an auxiliary one (which arguably is a better match
   for the given use case) and update the ACPI video bus driver
   accordingly (Rafael Wysocki)

 - Address sparse warnings in acpi_os_initialize() by adding
   __iomem to a local variable declaration (Ben Dooks)

Thanks!


---------------

Ben Dooks (1):
      ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()

Rafael J. Wysocki (1):
      ACPI: video: Switch over to auxiliary bus type

---------------

 drivers/acpi/Kconfig         |  1 +
 drivers/acpi/acpi_platform.c |  2 +-
 drivers/acpi/acpi_video.c    | 45 ++++++++++++++++++++++----------------------
 drivers/acpi/osl.c           |  2 +-
 drivers/acpi/scan.c          | 45 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 25 deletions(-)
