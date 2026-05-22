Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BC390C9F
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454905; cv=none; b=Mz3QBoELF16kCS0MoFe5zLDA2fAAlnt3YrG3vZMM3IbmvC6W2WDVwly58FyaAlMD6b0QfUKxa3A4ER5v1oPBzkfy3vnQqAhPZWN8dfnbi3SXpfBbYdpWyKB1t38h3LQZFO9eLUl3iQe2trk/9aHL9uzcIDsHCTD4VwY4QxiM6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454905; c=relaxed/simple;
	bh=qG2fpS8Bp8PBVnw1VsQ3FC3OcFZwdseL7ptkKXKtlJw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dacxhvQ2am5iO6gaE6LkQh8jsuEW+99jdeka29VWWpGIowg/koTSaZ7Q6FEzBlutXNkDswQqnXrsg0txMs8qvEBY/jQoppgy1va444RdvlfKsUHyG4w5qFBRLRVQ6czlmpBXoHNWmt/T7H5IfBZ1aDirvNUF8Y0AjepRRJ9w4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6RG1e2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6RG1e2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD191F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454903;
	bh=ia2a5ddOD6+3aaTxcULmJ18Vjiomx635zcxNcvdP1gE=;
	h=From:Date:Subject:To:Cc;
	b=e6RG1e2r5Gfu6AVRkO9ALZQQx9+4raNivLx+RoUW/zEUbFNtsHX/dPe/pTTqgGX7d
	 /XEyDxNcqWTU05k1GWs6VDtqPXarr2DmBGzIS4pCEghyf8uLFZr+8gH++W1Vb9tJwM
	 IMmxl8YqJF5IXQ1VZxG+ujOY1f25rlhwihj09liAu+GyetS0RLakZPmQV0rh8ATPzt
	 bXmgfcPif2rkekYw/UnEMdAurmI12HRS0M2B+uRf8DJ0UBC57FMORO3Ry7IxHLZhP9
	 Bie0KKQqVF34+MbTw/VdCXtTi1WRAd99to6qBxB0li74NTVJwihUOOesnXIf31e5A6
	 6rrvX1+y2G6xA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so6983690e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 06:01:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvDiAtDudRGaXjQYLOJx/HVnT7Da9gsg1BjjJePpvCmcbiIfJM
	dB0pmEhjxA5I9YHcN+gXFq1sG1o0exQDspWL9Q0voeV/fskDVhQpgdiDGEjE/vHJ7x+t+1vubcl
	ujF49mobrI0sT/b4tF6sRWYWulsocQbs=
X-Received: by 2002:a05:6512:131e:b0:5aa:10e2:29ab with SMTP id
 2adb3069b0e04-5aa32397b7bmr1217511e87.18.1779454891032; Fri, 22 May 2026
 06:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 15:01:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
X-Gm-Features: AVHnY4IpAjG-EGAqLgAfm-IfCQn4MNT_0R4Xfzd8yU9-N1FyxCZft1iwbmzXSes
Message-ID: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for v7.1-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc5

with top-most commit c35cb4fc7231702d1e9952aec1a442f3e27df6f5

 ACPI: battery: Fix system wakeup on critical battery status

on top of commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8

 Linux 7.1-rc4

to receive an ACPI support fix for 7.1-rc5.

This unbreaks system wakeup on critical battery status in the ACPI
battery driver inadvertently broken during the 7.0 development cycle.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: battery: Fix system wakeup on critical battery status

---------------

 drivers/acpi/battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
