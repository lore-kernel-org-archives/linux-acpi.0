Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DA30BB8C
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972391; cv=none; b=pLE1x87bc3Xg/xi9nN1+BBlpa7OPQzcBw+hz+JZUZcjMOElzHMC1NaQmcVdMHr/CqmeixtdIYJ9oDqj5ql9Ti5TMyokdRzwiv0Yr59z8hjgLchEQEHpkCP/XmuYp6rmm7UNlpg7YoWtfnoFWOtowWayweN5GVPlpfDjk3xPdU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972391; c=relaxed/simple;
	bh=9Snr45FvV8UrTHh9rxDNlvImGS1gAbieYHpxyhm8BX0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I+K2VY171vd/EmGj2YtOFDGWllgFZWB3V8eqiGAeoANRTe6EOxzp+AeSpKRSS2TbtkILXH5oiWlcRz4mXFBaoEQXV4rtMs3J2Eau/ZeIrGPE4cGRwqjCyLUSFhdAFEDBG1lD6bQHs9aBqkVZWmuMbaryeNH+3qbMpLK/ufNp7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXMM84xp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXMM84xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA3BC2BCB4
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 19:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972390;
	bh=9Snr45FvV8UrTHh9rxDNlvImGS1gAbieYHpxyhm8BX0=;
	h=From:Date:Subject:To:Cc:From;
	b=lXMM84xp9uuQjkjkOiIuT/f+FKlOiq758QsL+92Ug+DMONqluZjyqyMtX+jvvh7Rm
	 eMt7BWzYAxaD4okktsEF1HvACTDQAbKWMjVHsjZjU9JxKRysDh6g1Df1lyOX2foBCg
	 uQ4Bo2znrmnXZIf4TvFyTD0YipGsKepaS3wXZCYrd7No7454blmlZ2Hk7tqaKlQREK
	 vYAgdnxGKYERFV52e0zXD8LlNLegSRjrKd5YNX7ELIdWIU2W5vEDoYbZfMw6kKSgjC
	 mZ3satzoMbXRseUs7u1fkTExUAhhNK7iw8DakQg48j95QWJAmkruyVHhRFHXDmbTP9
	 t5ofLora12SCQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a40502e63bso6469790e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 12:26:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YwESEurqNZe2sllVTtBimw3iwKBbhiWy0mW7chPEtBKZ01JDh+Z
	odwgTZb6Lwn7gB5QCW+U4dXtJRzgbNEmJUx0WGcoBNeqTGKHVZ2WY9NztaBXcLr5guoeN2NjOOe
	876gep861hPYK2sING7Mj2ZnxDlK7D28=
X-Received: by 2002:a05:6512:2241:b0:5a2:a174:8958 with SMTP id
 2adb3069b0e04-5a4172e3102mr9613603e87.35.1776972388969; Thu, 23 Apr 2026
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Apr 2026 21:26:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxGGpHwOMr5MX7igEUUXEUcVcmvenJCz50yhU83Ce43Q@mail.gmail.com>
X-Gm-Features: AQROBzCdiRwXFmfYM0OtjBlSe6gdecibdGAVdNScy-VkL6rfN1NkoB_ykEO6a_M
Message-ID: <CAJZ5v0hxGGpHwOMr5MX7igEUUXEUcVcmvenJCz50yhU83Ce43Q@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc1-2

with top-most commit beca8264d502bbe8509141432c73ab7a816a4076

 Merge branches 'acpi-scan', 'acpi-apei' and 'acpi-video'

on top of commit 2e31b16101834bdc0b720967845d6a0a309cf27b

 Merge tag 'acpi-7.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI support fixes for 7.1-rc1.

These fix two potential refcount leaks in error code paths in the ACPI
core code, address a recently introduced build breakage related to the
CPU UID handling consolidation, fix up a recently added MAINTAINERS
entry, fix the quirk list in the ACPI video bus driver, and add a new
quirk to it:

 - Add an acpi_get_cpu_uid() stub helper to address an x86 Xen support
   build breakage (Arnd Bergmann)

 - Use acpi_dev_put() in object add error paths in the ACPI core to
   avoid refcount leaks (Guangshuo Li)

 - Adjust the file entry in the recently added NVIDIA GHES HANDLER entry
   in MAINTAINERS to the actual existing file (Lukas Bulwahn)

 - Add backlight=3Dnative quirk for Dell OptiPlex 7770 AIO to the ACPI
   video bus driver (Jan Sch=C3=A4r)

 - Move Lenovo Legion S7 15ACH6 quirk to the right section of the quirk
   list in the ACPI video bus driver (Hans de Goede)

Thanks!


---------------

Arnd Bergmann (1):
      ACPI: add acpi_get_cpu_uid() stub helper

Guangshuo Li (1):
      ACPI: scan: Use acpi_dev_put() in object add error paths

Hans de Goede (1):
      ACPI: video: Move Lenovo Legion S7 15ACH6 quirk to the right section

Jan Sch=C3=A4r (1):
      ACPI: video: Add backlight=3Dnative quirk for Dell OptiPlex 7770 AIO

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in NVIDIA GHES HANDLER

---------------

 MAINTAINERS                 |  2 +-
 drivers/acpi/power.c        |  2 +-
 drivers/acpi/scan.c         |  2 +-
 drivers/acpi/video_detect.c | 25 +++++++++++++++++--------
 include/linux/acpi.h        |  6 ++++++
 5 files changed, 26 insertions(+), 11 deletions(-)
