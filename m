Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447B33509A
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548601; cv=none; b=bKi+xJ4T9Cq8gAP62nrncQv24cNL8x3aYtlkKfuSpOddYAxnSal4cTBv/ql49Yr6gQJg5mWBPtTBNLvGjLlSwpBdDRHZ6mz/x2H7OttxVfdcd+4gE4iM8w4PhD77B3IHPZFP9q8k1oLBpMMK54VLUKomhn9PNcfUH/FteS2pyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548601; c=relaxed/simple;
	bh=B3MiaxlBHCItTEXkunnaZHjgsbKerYuSCijvUA6ZIx8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P79NUbcBNjlUfNDBX+3be2frduiMFFaXPgwiYbhkbcNhK4CdorIbMbd73NKewGAXK19wyiv2RmzQWD3SIUE5/dx7/CEdKXnXcxyK4ABqF/spSibWkXo3yYpSaWxKGOmZrr5EAOp/OO74HkdlfXetgSVICTiGgMB/WyylWlz0sxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Y4bNQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Y4bNQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1845C116C6
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548600;
	bh=B3MiaxlBHCItTEXkunnaZHjgsbKerYuSCijvUA6ZIx8=;
	h=From:Date:Subject:To:Cc:From;
	b=j8Y4bNQtPJMmSUG+ldlZOSGkgBXWkZ8/hknXQA4rkkW9Kl+dQ56NZJbOK/ewaNWkp
	 aadWCiI9Tdg72Agf2AaooWbJMpz6TCZigruh8Ai4zurkTxgn7XvpMNY3/Mpr5JRpJi
	 jH7deS+1Y9VFEt4RFHkpIpc91/ZZo7hCiwIRCXtwIJwVKn35Ju/zj6+TGJQg8Iguyo
	 9ogWGm99McXvIVr/asXYvRpuOiR1yTnYGYhqPEpMQy3H7OWx1jAomT+CpoECXlHT96
	 Ldk9skK7GlDkNvjGCtXy+NXRzjb0n+gBiXPh//TGhft3dmwD2Ckb1UovQMjfta8zNq
	 E7qCLnRvlo0ww==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d9e22176a7so613325a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 11:10:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YzyrIEcM+/P0/3zHVv+VPMo+SchgpEYj6xx7SKPLywX/qaLQASs
	1cQxQAwdoF1m1I6y8x3igJU2hM1GLzBafWAL5KlZBW4jf8FzJXFlYaX+G7q3a7k3DUa5wQpCCzo
	FprpknUNJ1y8+6O+iI16MoyLExEzFSDQ=
X-Received: by 2002:a05:6870:f602:b0:41c:63f2:bfb8 with SMTP id
 586e51a60fabf-41ca6ddbb48mr4201753fac.13.1774548599776; Thu, 26 Mar 2026
 11:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 19:09:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMiiJojiagbnUPMW4w_6EsP7P0GqVTGWJm51-Ha71PHQ@mail.gmail.com>
X-Gm-Features: AQROBzAoZQadVw0JovZCcqfwELTd2xkAtA_jjSxi5AWskeVTqNAr6AQsMRtSMBU
Message-ID: <CAJZ5v0hMiiJojiagbnUPMW4w_6EsP7P0GqVTGWJm51-Ha71PHQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for v7.0-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc6

with top-most commit f6484cadbcaf26b5844b51bd7307a663dda48ef6

 ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

on top of commit c369299895a591d96745d6492d4888259b004a9e

 Linux 7.0-rc5

to receive an ACPI support fix for 7.0-rc6.

This prevents use-after-free from occurring on reduced-hardware ACPI
platforms when -EPROBE_DEFER is returned by ec_install_handlers()
during ACPI EC driver initialization (Weiming Shi).

Thanks!


---------------

Weiming Shi (1):
      ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

---------------

 drivers/acpi/ec.c | 2 ++
 1 file changed, 2 insertions(+)
