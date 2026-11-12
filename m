Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487611;
	b=R1Io3MxmPOVT9yK9Nl6MUVhxBcNz42OCzIUlYdbC+XvqzHmRUBRsNRx34qQJSyh1N69W
	 +ZCOlQL5vF/9fRzox/9RYWmISao0e+JBbhFO5Pfq6RdDVYXFsuckLocY2EIwajfFASpgi
	 OzWxxNv9kRLESvUbtetSlLHOqx3JMVAbZ1iF0zzDnWcGcCEABbobw9MF4cF+sryNtPFrJ
	 yxy1WKcsrm2j9IKI4SV4iOcYwxCTmkpPWdWrzGtLe2kA7N8KNwBUukYohHeJ4XeHRQTdj
	 c5V8KmdhTIRz/LL8+BU9qDWd4KJShvnjvH1UR7JBdrCtq8un+HyYj6/MjFpexrYy1HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487611;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SKx5XnqpFxmzXIHE6O+2xtdoRnFRPkkgy3sCH7aU4Iw=;
	b=YcR78Gd9w5DTfAiHhOPIq/B4AMGIgI7N+yAxYgZiswH2Qg26NPpkdbNTIRk0a6EeNe7b
	 7QzlEYfN7wPHLULvBTiPOPWvga7NqjV4BUFeotImDjJxr4KnEtno1j2p9r+4jioYQft84
	 pGQAV6AI93sTqm45M40V1MoAtmpNoWqGOrEPUOvXSN7PrlEgUXiZPEAc90FJbPbmGRhhk
	 DKMgRLrzVuIDyVOIrvAD7l8NpICmegY1WNTJHo6qliwgqTMBN1YEGKPJ3L2z1NPlaE4P6
	 MpoyTZ+4+wb5yxEU63dMq+0N3nIgZ1Pjjj/WmQ4YDTwThL9QT170IEsoE6VtwsanXWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDIffL+J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D4606A327
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDIffL+J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711CB1F00A06
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487611;
	bh=SKx5XnqpFxmzXIHE6O+2xtdoRnFRPkkgy3sCH7aU4Iw=;
	h=From:Date:Subject:To:Cc;
	b=fDIffL+JhthfLIsCGsh+rOnadZuLUQO2OCMj6fXd3ReIx9fHnY7ee74wolDmh3gxi
	 CpqJEEC/iPZ5g39D+g2GhZqASJTcqSxVHQWhP4B1amBGvCPh4c3Jbhzp6Ur9J7hsrT
	 imHNz5jLb9JV1wVwlboyuR+ctNQZwFr7Mym0MhSUJq7txGQ6I82++D6wfXBWtt7nfj
	 pzhuPxHA3JoQW/LEigsx0RziPSjRDxBfjgiyhNsG9c4q19ShrbEhA28obe7wSu/eeu
	 +TdBK6ILJR6C5b0SO9t1rbiyUJOG/L8zNA4+fxvVE15osmKKXFz/03TA+8vypLuL6N
	 BKG5p8SDs/yQw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3acff56a300so37602301fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 04:46:51 -0800 (PST)
X-Gm-Message-State: APuU4Z+P1Vnr4RTAQp49V67foSFJ6M2Lrd9TlyzLAIOf44cqUHuTe0qT
	o1mEtNwdQwOgtD0/THny4r1hltaL4wM7iafj+sFaqEEo5qbzZ+kHC1YKQ7xf1+YbH3PpYtl2YZE
	/NERX9uUMt7mH8OYwADi9KIneyxpukRk=
X-Received: by 2002:a05:651c:a324:b0:3ab:2a19:8625 with SMTP id
 38308e7fff4ca-3ae1266c798mr13362901fa.4.1794487609931; Thu, 12 Nov 2026
 04:46:49 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 13:46:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEHWcCX=1cDRUstU5m=9_PQqfD-PgJfrF4jo=0hk4NWA@mail.gmail.com>
X-Gm-Features: AclHuK8mt_wd5S8LnVA8XFElid_4ewR-fH-4OHvi9tIdQ2IzC5u0ab_yFDCYkQw
Message-ID: <CAJZ5v0gEHWcCX=1cDRUstU5m=9_PQqfD-PgJfrF4jo=0hk4NWA@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for 7.4-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.4-rc3

with top-most commit 756a3f9e02913ca1616ee8ed4598b1208ab8e9fb

 Merge branches 'acpi-scan' and 'acpi-apei'

on top of commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

 Linux 7.4-rc2

to receive ACPI support fixes for 7.4-rc3.

These fix a mistake in the ACPI APEI GHES code causing recoverable CPU,
memory, CXL and vendor-specific errors reported through GHES to never
show up in a vmcore, address a potential deadlock related to ACPI
device hotplug that causes lockdep to complain and give up, and fix
up the recently added support for _Ixx GPEs:

 - Make recoverable CPU, memory, CXL and vendor-specific errors reported
   through GHES show up in vmcores by fixing a broken error severity
   check in ghes_log_hwerr() (Breno Leitao)

 - Avoid printing diagnostic messages for ACPI device objects after
   dropping reference to them (Sasha Levin)

 - Avoid holding the physical_node_lock for ACPI device objects across
   device_offline() and device_online() due to a potential deadlock that
   causes lockdep to complain and turn itself off (Sasha Levin)

 - Avoid spurious system wakeups from suspend-to-idle on platforms where
   an _Ixx GPE is shared by user-wakeup and background events (Saranya
   Gopal)

Thanks!


---------------

Breno Leitao (1):
      ACPI: APEI: GHES: Fix severity check in ghes_log_hwerr()

Saranya Gopal (1):
      ACPI: s2idle: Handle shared _Ixx GPEs without an EC

Sasha Levin (2):
      ACPI: scan: Print the offline failure message in acpi_bus_offline()
      ACPI: scan: Do not hold physical_node_lock across
device_offline() and device_online()

---------------

 drivers/acpi/apei/ghes.c  |   2 +-
 drivers/acpi/ec.c         |  10 ++---
 drivers/acpi/internal.h   |   6 +--
 drivers/acpi/scan.c       | 108 +++++++++++++++++++++++++++++++++++++---------
 drivers/acpi/sleep.c      |  11 ++++-
 drivers/acpi/sleep.h      |   8 ++++
 drivers/acpi/x86/s2idle.c |  61 ++++++++++++++++++++++++++
 include/acpi/acpi_bus.h   |   1 +
 8 files changed, 176 insertions(+), 31 deletions(-)
