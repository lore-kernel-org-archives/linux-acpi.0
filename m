Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07B3B6C0B
	for <linux-acpi@vger.kernel.org>; Thu, 28 May 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992722; cv=none; b=fK+qmukVtZneG+KPe0CmM4LlWPh+V9hKaqy/NDfSlhc03jVY0xk3G2RoOoL5Y5XACUrP5TTnd7zrmDXns8jDcHcto01T4lrgGuOaNKOvS7Ss0Vgvc08v9alOZX30ZqJPIN7hhAoyQrgb9c2jgWOjzLl7eGwRjebAEqJlSnH+kS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992722; c=relaxed/simple;
	bh=fIIT2vdEHvHdicqVZbAmrGdJun95PGdzg0tFOgQza8E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cknH8FuIN6nlGhPJOxGBomGrQTOpuLxPzUl47xO3QqS/P9F+cqRwTuoOOero10/l2kRDAdtaEeDEFr5es8iDIBm6TNDs9yBkUzWDa61TIb2olLlAUrmIdBvopwE3GBneLp/WUgnFvxFWRmI3H0DZKP4xliKwFrBg/t+4nrks50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpu4XojZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpu4XojZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169A31F00A3A
	for <linux-acpi@vger.kernel.org>; Thu, 28 May 2026 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992721;
	bh=pFyK2U4R61X6if5MUrkHg5iOPGy6yuWM/F8LiQeP4Nk=;
	h=From:Date:Subject:To:Cc;
	b=hpu4XojZ2qT2NtFOGjm3UhW7wi73bKQQAYoK5ylhUYXMieM+seb/MPr+oEtrrM9He
	 uNgFq1m1zXVdBk5vZ2vVL/s/OcZcJUdE/q6r4s3fUSBDbb1WKBQFnS/PX+xzR/9FdU
	 njrNHJxjuHHeyfCxVPUd29bOmjb+2pL4xMu9Hr8jF49NFD49hc9LBn7ia/CUj+37hT
	 jmMrt8znpEX+fRF3upjAahyUFiXrHcJZoxFWnSGfZ1mECFb3z/sMkc237mLf5U/zr1
	 EhkmdCUb1ULDs0c0mpnmGVH2UShewmGZpKQavidmKIiyQsCRjIwZABBQU/tra2kDG1
	 8w5DhSZB/0TcA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa4bb157c6so2595652e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 28 May 2026 11:25:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyekKgB2SGuMqq8w7Q0p7Ejvd5p3so/YdZ+LDkGj9V/EfmXDxSv
	s/JSIzpcIQPLXTH+h+ugvYkdQ2xv88CS95uF3T6P4fqkS/UqNtAu0FmMCZjnZYji46LN2P0viw+
	1RZjMjvKxAOjyMAbmcTuwO4L8jntQq7o=
X-Received: by 2002:a05:6512:603:20b0:5aa:b6b:a3f0 with SMTP id
 2adb3069b0e04-5aa57e758f8mr54966e87.44.1779992719521; Thu, 28 May 2026
 11:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 May 2026 20:25:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHsq95Hn7YTaswya=XR9om4+_Chrdc35TqxrvGzHAQCw@mail.gmail.com>
X-Gm-Features: AVHnY4IHIfFH689co8uGk5ICek287Bl2y9BVyH3EIkAMGToD237K8P4BeMnr6z4
Message-ID: <CAJZ5v0iHsq95Hn7YTaswya=XR9om4+_Chrdc35TqxrvGzHAQCw@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.1-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc6

with top-most commit 3109f9f38800841e46769e95e1ba11f1f8c7b230

 ACPI: button: Add missing device class clearing on probe failures

on top of commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d

 Linux 7.1-rc5

to receive ACPI support fixes for 7.1-rc6.

These fix three issues in the ACPI button driver: a possible crash due
to a button press after unloading the driver (introduced during the 6.15
development cycle), function keys breakage on Toshiba Tecra X40 due to
missing ACPI events (introduced during the 7.0 development cycle), and
a missing probe rollback path item that has not been added by mistake
during a recent update.

Thanks!


---------------

Rafael J. Wysocki (3):
      ACPI: button: Fix ACPI GPE handler leak during removal
      ACPI: button: Enable wakeup GPEs for ACPI buttons at probe time
      ACPI: button: Add missing device class clearing on probe failures

---------------

 drivers/acpi/acpica/evxfgpe.c | 50 +++++++++++++++++++++++++++++++++++--------
 drivers/acpi/button.c         | 25 +++++++++++++++++++++-
 include/acpi/acpixf.h         |  5 +++++
 3 files changed, 70 insertions(+), 10 deletions(-)
