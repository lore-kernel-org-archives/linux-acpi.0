Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C062241686
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932083; cv=none; b=FZpyvWuButhkzCZra3CQ1PJhApXn5U7TCh8NISrvDnnGAKUQkwPbdSlv3VVidbQei5yUkIbKY83AdkfK1qNUAY/gTWwvLtFX5COFy0Mb7WqZz/9/HOfCGNnY41xR7iU7fTrRFIpyXHKjDXfAqzCUB6l1HEMWzGc3eu1pGh59+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932083; c=relaxed/simple;
	bh=WbxtKhIbMOejm7liR9/rPZ2UBXbDbt5sTcDBrPI2dz8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FX7HWMhtiJ798RMrEwNvPwTHe1KseFggdOz1MkQKB7OyZiYfGRKy9J7eOWxhbr17lCJ7hpfH9ePZbT7ZEEUiWBVaVaVUX2oeMRqLVUX7iETaP5P1N9More8bnV9DnvQI4SR/KI2zROpyPZMCFUqY8Ys6b0jncFWvRxQE9YMZhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvS5K8E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvS5K8E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BF01F00A3E
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787932076;
	bh=qmXa71VaIDs5omcsqKx45QoxRAq7MtBZj++ZHm+Bdv8=;
	h=From:Date:Subject:To:Cc;
	b=jvS5K8E4KkB/E1j418TdtZwXAFvRI0RuP/kESm+6126lT/RjM1s9Q993blbABqXFR
	 ztR25Ykvy4XE47cfWfjwXKRv57sgUixxJPHUhIG0csd2W0fZX1CPL91id9PhW86K1e
	 Fo76vMUVHSPiJCSJ9FhuPo/44u/GLFhrb1QmWEZ9vWmxMEgqekb9vWTPyTeWdTRT8m
	 Y2rVW6b7+J1ldNphCaDLw7g6yNn6F7CcDMLmw2awlJUweyAQ6pah64u3gjzfc0l+Dq
	 3lBqx/uLnwnQsqtUKM9JX4BC68uIMCkXK/JF6ApjWwwEs0X+aMZTftxOOQIklb/Ocy
	 Q3GTyDWtyIi7Q==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a1a3bb6c5dso10122981fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 08:47:56 -0700 (PDT)
X-Gm-Message-State: AFuF++n5ammku1lD4E2N0Ku3Jqc2mJysWzlA4NLM4n871FxM+ZV7JjLP
	S2v2xH3Jg2q6Z8nxIINY3GyGpUhi7r1AmrAVpd6CrVSGgJsxgoyWz7rr2+CVSKEmGJo6phXH+Rl
	7Cw+wjHliLD63z+D2HD187vAA95/bfUc=
X-Received: by 2002:a05:651c:3056:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3a301b63a84mr14800961fa.9.1787932075015; Fri, 28 Aug 2026
 08:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 28 Aug 2026 17:47:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
X-Gm-Features: AcwNN1XihMrn46N5cOvdT5tW7nCNPj8V133tEWIw2xxTC4zbFKe8B_SebPzgxLU
Message-ID: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.3-rc1-3

with top-most commit 3b446d169a93e6abae9a93535369fa18bbcbefd9

 Revert "ACPI: scan: Defer device power initialization"

on top of commit 3382bfbca58c7d5ee3f31a7b37fbeb208e98e656

 Merge tag 'acpi-7.3-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent ACPI support fix for 7.3-rc1.

This reverts an incomplete recent commit that may cause ACPI device
power management to stop working.

Unfortunately, I only realized that the problem was there after the
commit in question had gone in and AI did not catch it either.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Defer device power initialization"

---------------

 drivers/acpi/power.c | 1 -
 drivers/acpi/scan.c  | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)
