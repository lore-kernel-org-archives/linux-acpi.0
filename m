Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421676;
	b=WpI9S6jIgrKMzBAoJr8IEKh40JK4WRYs09fX48BpBpHwoh4holrgwnMQAzGQlr5Jy46/
	 HNSt4KjHbLmowmgkFX+PCD+Ss/M8bW5yKMAxRwYZXkbBrhL1+cX7jfKXrq7mv/fQZOvum
	 0vUDi3HxMzuGsk4V/bYhSKkwUErR/t4kP1+3laNLlmUWNiEbpmrNokEnaum9GbkidHtkN
	 b+6wP2TBW2ZnWb9DpL569rXq47+Oc2AE6j2E7YUb9r3b2f1rdYVRxL+jfleibQsWG0Jvs
	 LX+Zt4OyI+WzejZp2Rt5uAEO0EROACFQvyY9sl6/+LEiR295YyZlH9qWBNitKMh7Nag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421676;
	h=Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:DKIM-Signature;
	bh=WkQB7qDFPVZGub3RTV6RHc3gNA986fIdMZHw4FaBpKE=;
	b=PqbsBc0mBpUz03mLELEt7Jo/5wxXtxw8/f6BGGt2L2l/G/qIA6kpBvfe7Q/O9v6g67Ra
	 fjN1nXS56N2OQxMTTrHwMWZmoCMPKozeyYfAqEQHEqJLYc+OqmeX+Jj8YOS0epfSNpmCS
	 lGhcWBtIQRVa84lm3I3tImfF6gcyorNU/m5z9VIhmy49kSSz9dv0mfqdeJ8R1cgvfxcel
	 eh84EJG5VmwuO4Q33GmzTpqeJJvROVbDt0dh316zeifI3+nkgl58Fu7jqX69Rj5U96z9c
	 rXXAlt/D2mcezPyNIr09gvuQ0bCMN2xYOKXnJeB+g3lC8iHHC9fAzLb/NjZgO6b1ZOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=Q1FxhUA2;
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5B606DA6F
	for <linux-acpi.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=Q1FxhUA2
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828A3FDC18
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421676; cv=none; b=D+Gceat42qACmYLZvB8HDBBAiz6jPyUthD9OxeZYxsOnlc9WSUUiNn6/imS6Dko4UyvKq0vMIG7x8Fg/5d5hLvBDW++H9nDyyoR0PeNFR9SynYQ+TfSbhrPFQKxJ0Klh6KwVMYzIqpmd9n7mnt74zuEgMDOhvBS+PcoOHYyL8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421676; c=relaxed/simple;
	bh=7XMXx1Y7exmnq8CDw6ZcXKJ1xd2nrPwkUnm6kz2V26M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfXPQdhf5fzHq/XCDeIhuOds7id8IPZK7DaLCpt4zofGa5qCwAxQZgM5TQzLq7XCQgv/zASNNFUZa2cicwDnb7b1DUrXbSADGkRhorI8ce+Irl7FZ/+Ngz3Hqj8y7GocrxXsPgUpzzAImlk7yYJ7oieB4447I3vQ6DTWE1VcQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=Q1FxhUA2; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 8136261134
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:54:32 +0200 (CEST)
Received: (qmail 28266 invoked by uid 990); 19 Oct 2026 14:54:32 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 16:54:32 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: leonard@lausen.nl,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Ivan Hu <ivan.hu@canonical.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ACPI: Work around Samsung Galaxy Book 930XDB firmware errors
Date: Mon, 19 Oct 2026 16:54:16 +0200
Message-ID: <20261019145421.47181-1-leonard@lausen.nl>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999969) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7XMXx1Y7exmnq8CDw6ZcXKJ1xd2nrPwkUnm6kz2V26M=;
	b=Q1FxhUA2qSv9UrISvCXPVWNroaQCDNyfK9oPlpMB/PtstW3V4rLHIes4mUnbwdz03uUd+/seiV
	TbF4zY1mxPLpUwLNgZ+iphBvVDOvGPEz1/9RYzb+njjOrKiGW+6Sww/rJfCvNck8EfNxC4KrY7zK
	doSk1dRfuiBjaRj+sjzE7OvUictr6gpuKP3YZ+wIznMOlVFq5HN6zPlhK9+Iz8MpbLp7CJ/D/jsS
	mFeuNl/TbvSWrWTKqccjMh+44dIi5OAqwxZFJ5wE+z4Wa7E65ESywbo6s0wDc36xuWvuTbtkHw+H
	BFU280bjc3h225cBZ98xN0Y243n/r7NkcU/VJbetcFiasPcbr9m3Lg8YkMfYwClIUmCW9wRxRcXw
	L0O6Tawqo8QraIPxkKS9LCmwN1+oLRmsF0PRIICCi3xC0B8GpVVseUqnw9nhfJZJbqVnXLOlHV6/
	V5DMGXverJFdSfaxz52E8R7Dr62M1eGmWgCqFyouLD3AP8swjhCr4zKzSvelX2yNuJ7qa9wm2JN/
	etJ73HrcN7/AnPSN9EJVZcsLWVucDfX6W42B8O3FCjyrKBcsxlc7Jnhvu+RbX++OCrIgd7nDX7+3
	tFb8IdRzI41Oqng6Gm729DZdOPeTLQmH+xyaVizZMgmCFqotGfoqSiqxSCs6r4BE/+FrXe7GaQxp
	4=

This series addresses two firmware errors on my Samsung Galaxy Book
930XDB (NP930XDB-KF2US): repeated FAN0._FST errors when the fan is running,
and a wrong namespace lookup in PEG0._STA.

The tested system identifies itself as:
  System vendor: SAMSUNG ELECTRONICS CO., LTD.
  Product name: 930XDB/931XDB/930XDY
  BIOS version: P11RFX.067.230331.SP (03/31/2023)

Patch 1 ports Ivan Hu's already accepted ACPICA parser fix [1]. This is a
prerequisite for patch 3, which uses acpi_install_method() to replace
PEG0._STA before namespace initialization evaluates it. Patch 2 skips the
broken fan status method and its notification handling while preserving
legacy fan control. Both firmware quirks match the vendor and full DMI
product string.

Testing on this machine includes a successful Linux 7.3 (7.3.0+) boot
with both quirks enabled. I have also been running the original versions
of these fixes during general laptop use, including suspend/resume, and
fan behavior has been fine.

Additional validation during preparation:
  - All five changed C files build on x86_64 with W=1.
  - All patches pass scripts/checkpatch.pl --strict.
  - acpiexec fixtures reproduce the original PEG0 lookup error and verify
    that the replacement returns 0 or 0x0f according to the root PG0E field.
  - A fixture of FAN0._FST reproduces the reference/Add error at nonzero
    speed and confirms that the zero-speed path can succeed.

A separate platform/x86 patch accepts notification 0x71 in the Samsung
Galaxy Book driver. It has no dependency on this ACPI series.

[1] https://github.com/open-acpica/acpica/commit/19429ef91ebfb2144c918038dce13e297b4ef051

Ivan Hu (1):
  ACPICA: Initialize ParserState.AmlEnd in AcpiInstallMethod

Leonard Lausen (2):
  ACPI: fan: Ignore broken _FST on Samsung Galaxy Book 930XDB
  ACPI: x86: Repair broken PEG0._STA on Samsung Galaxy Book 930XDB

 drivers/acpi/acpica/nsxfname.c |  1 +
 drivers/acpi/bus.c             |  2 ++
 drivers/acpi/fan_core.c        | 31 +++++++++++++++++---
 drivers/acpi/x86/utils.c       | 53 ++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h        |  2 ++
 5 files changed, 85 insertions(+), 4 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0

