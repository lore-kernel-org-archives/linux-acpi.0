Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494A3E49CD
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462838; cv=none; b=rlX3DEuduUlIDocjPiSGCpE1tIObVztIMeSNxHjRA51A16xJkRmHRoP9wfzXdTZv2R4le+sauST5qOFGIT+nLPtcnPMoJpiNog72bSrNT+BB3P2Hdn7l/oKJR+qvuBC9e19ymyZcuaQiV3GID0FyHuXsUCTeBZKKZq9Eo+1nXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462838; c=relaxed/simple;
	bh=a38zLmnOCRxTfCzU6JuKXvEZ05d9zhYuKPYQ9NR+2DY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iCRbvpA0PLdNPuwd809PeEmItX7Vy6UcndPFdlJaiw7Lpozn0ST0kwV8wFlHK4bfJJmbrpiq7SvEucqaG4kk7DRCd7fqFAB0eaS//78fmTtlm04KF2/na6fcSLWShiuPdsChqs2cF9dn0FLd2FySQWN67dRouQk+eEc4X030kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLo2h9zB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLo2h9zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793EF1F000E9
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788462823;
	bh=AviD2jWxYHfZvz61DIoalDQAlzqCBRNm7rLSTMxyOGU=;
	h=From:Date:Subject:To:Cc;
	b=dLo2h9zBwzn2aSFWBsGgy/3NVAkPzEY3hO4HO4DnmRHMYYM/HxhW6258Qhg+E1wlA
	 g9a/8cnX0JLuFjPPxAZrSwRq79XyCw3NHqIppr+OOZaHXRva1a0mUZVoB1ZfyHaQH1
	 4PdOr2bmdC7j2yYWCbOmRK0SK0qluyoQeAyFSbRBUpFIu5ECA2uvFrpPoIOhNfIbRC
	 YJhK4TVFnsolHX5Fy3BrGs9wx+ycsd9P//bn44lOThjbOIssHdndLUyGR6mYifbRNZ
	 I7VOZ/KOUlD4OP63iJRsqnHhhtZkfenmZaseRWEFTZKvestPxByvS6McUUIpbe928h
	 9wruAmSbknS9g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so3309371fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 12:13:43 -0700 (PDT)
X-Gm-Message-State: AFuF++lGWjN6kbOR8GjM12Ofnewn6adjwBiereGteykRcldjWgfzVZtA
	L8KkFq86GXElXEI8r/4R+1RIObEuwE51ZNQ2mXu2MdxFsp5SZZ0K/2OjNL52YooFfAT0D0G5Bik
	9Mw+xCtOySnNRn5/C07X1dBCVa/MPxWo=
X-Received: by 2002:a2e:be89:0:b0:3a3:5a01:a7c1 with SMTP id
 38308e7fff4ca-3a371b8043dmr1483041fa.7.1788462821873; Thu, 03 Sep 2026
 12:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 3 Sep 2026 21:12:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j1-NvoTJsKoZ0DONSe+7YzEVde4RUn9V3HsXqAikNQcQ@mail.gmail.com>
X-Gm-Features: AcwNN1WNDc_ThcDCynHjMAmBkNX5IoH_D7pEBmU6kNcc8wagobgEo6PLsTPG-IU
Message-ID: <CAJZ5v0j1-NvoTJsKoZ0DONSe+7YzEVde4RUn9V3HsXqAikNQcQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support update for 7.3-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.3-rc2

with top-most commit 4a819ee5f2834330656d6ac168c4c8cf27fdeec2

 ACPI: bus: Drop two fields from struct acpi_device_pnp

on top of commit cee9395acd8043be0644b25c34bfa86623f2b935

 Linux 7.3-rc1

to receive an ACPI support update for 7.3-rc2.

This drops two structure fields that have no more users after
changes merged recently.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: bus: Drop two fields from struct acpi_device_pnp

---------------

 drivers/acpi/scan.c     |  4 ----
 include/acpi/acpi_bus.h | 11 +++--------
 2 files changed, 3 insertions(+), 12 deletions(-)
