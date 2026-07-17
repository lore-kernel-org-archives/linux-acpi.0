Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF6AD24;
	Fri, 17 Jul 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329867; cv=pass; b=q6+4Rss57kDPKPjqJQdBQ7sKqpbxQEKKfRGdP1WIHdDIh7pd7l59GXfg0IQWBYaaPip/MaCcKS+dO1S/hYYTJZrMv73akNciSh+LxGTq+IMV95ha0b8DZmg0yB2/yZNK2B3+cYRJ1KCFUdorBdPQvbGrwlX5zHnxlYot7bAR5rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329867; c=relaxed/simple;
	bh=t5wEfnTKtmrm8Lkb7LvWdorp3JkxNMTs3ikTtL+FIkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u9vrBWgEUO0v/FWeWGEhPat+dUwzjEbuSgBy9CBs8gFNtlG0U5DjioErQjBW3SO1kpkb3RrCC/upL/n++uZUp7dDxPiGs6MGn7Ik0LLPAb8ZcLS/1HYHBb5ZVKCpJCk4HQ4CcuQklRDDkppYixAY19N39MRaBR4c/tYeJdvYGEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=k1tFKbDv; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="k1tFKbDv"
ARC-Seal: i=1; a=rsa-sha256; t=1784329849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kttSpPTkyOtWTQjTxlNNwF4EvMDWD8Y9VNxai5nIiLwGS3ePmlVODy8B8Erl/ZeDl55w+sJBfuErJUx3mN90xmuQsZytEbkWy4a1Va5TsD6t8ghzqcQs+Exzms6ey+4ExCLO9TTdaiu+DB9+3qimYxiKaLe2OmwjOpqckSDCFjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784329849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PLs4pkUlK7gEqb32j00iSoOf/g7Fj2JZUO2f/m/mOzI=; 
	b=MnxudwXvLbdXYwLRtbV8OFlZEAkbPxYXZJLeADsPhMTQ3sbDnuV1hAX8QNBM/7TUTaVRlqo3NBWVoLqA6vSOlrRwWkm0hVHdIb0t8KfFHVgDqYpdIHU7juA36Dy5A7Z9Jzo6JOauOI5L3qB3xuFtsSR5qFqGSGBrSeeAGMnRZEc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784329849;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=PLs4pkUlK7gEqb32j00iSoOf/g7Fj2JZUO2f/m/mOzI=;
	b=k1tFKbDviM51wzUaURHxwRoolT61eQ4qvjcDImzl/7TYtnyDWoIPVYUfCVhsn7Bl
	NJp6Vj3BuT+5J2yivQm142omSvn7X7Mo08K1o4DzSmnIrFJYZ7/vHRDFRkm1zSsBAzK
	nROFu00g/o8ilMsWZCEyGd31bgUIoBBEC+pupMYsqz97sd0C82P17ScIXGhmd/0eCKn
	8W2GYMxvyH4nra7DFu6yCDgVud7CXBu+dFhjcA/WtiQaH14w/zWKgEiGXbzQHqinOc0
	IOPXnDD/uo/VIY9EQAapd51b/tLk9DUUKCHSkH2hL7qfA3tDHXa+BTPqWcvAM1Spdis
	SsiaWJHDxg==
Received: by mx.zohomail.com with SMTPS id 178432984450140.415999884926464;
	Fri, 17 Jul 2026 16:10:44 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v4 0/3] ACPI: battery: Do not generate too much pressure on
 ACPI methods
Date: Sat, 18 Jul 2026 07:10:18 +0800
Message-Id: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNTQrCMBCG4atI1kYySX9deQ9xkaRTHcFGkliU0
 rubVkRxobj8YOZ5BxbQEwa2XgzMY0+BXJdGtlwwe9DdHjk1aTMpZCFyKbjJuLZn4kbHiP7GOxe
 pJatjeuS1aMoKtGollCwRZ48tXWd+u3vscDFHtHEyp4sDhej8be73MN09U+X3VA9ccKmEMthUa
 IXZeNftVyeHbCr18mUVAD8smawMK2yKHDTk8GGpfyyVrLZWtVCVtLnO3qxxHO8OuBZVcQEAAA=
 =
X-Change-ID: 20260520-b4-acpi-battery-notification-90d781a3f217
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Avraham Hollander <anhollander516@gmail.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

The acpi_battery_notify() and acpi_battery_get_property() callbacks
sometimes generate too much pressure on corresponding ACPI methods. On
some devices with fragile ACPI implementation, these methods share the
same mutex protecting EC accesses (hence slow to execute) with a lot of
other EC-related methods. Such pressure on them eventually leads to a
catastrophic situation that a bunch of ACPI method calls fail to acquire
the same mutex due to timeout. The firmware of these devices doesn't
handle mutex acquisition failure gracefully and return garbage data,
causing even more chaos.

For acpi_battery_notify(), a very common pattern in EC queries that
emits two consecutive battery notifications with event IDs 0x80 and 0x81
updates battery state and calls power_supply_changed() twice within a
short period, generating significant pressure on _STA, _BST and
_BIX/_BIF methods. Not only that, power_supply_ext properties may also
rely on some other ACPI methods, so both uevent assembling and userspace
processes call them. It becomes a nightmare when all these methods share
the same ACPI mutex and hence vulnerable to lock starvation. Even worse,
after the first uevent reaches userspace, some userspace processes start
to read all battery properties in order to refresh their internal
states, which competes with the second notification's handling and
uevent assembling, exacerbating the lock starvation.

For acpi_battery_get_property(), it generates too much pressure on the
_BST method because of the lack of synchronization. In detail, it
sometimes nullifies the cache mechanism of acpi_battery_get_state() when
multiple processes read power supply properties simultaneously, which
usually happens after a uevent. Normally, emitting a uevent implies that
the cache must have been refreshed due to power_supply_uevent() reading
all properties, so the mentioned processes should have seen cache hits.
Unfortunately, these fragile devices' power_supply_ext properties are
somehow slow to read after battery events, resulting in cache expiration
before power_supply_uevent() finishes. Hence, once the uevent reaches
userspace, the _BST method will be executed multiple times within a
short period due to userspace processes reading all properties again.

Improve acpi_battery_notify() by merging at most 16 consecutive battery
notifications within 10ms using a delayed work, so that they only
refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
the underlying ACPI methods.

Fix acpi_battery_get_property() by introducing a mutex to protect all
accesses to battery properties, so that acpi_battery_get_property() can
take the advantage of the mutex and synchronize itself. This also
prevents potential race conditions, e.g., when multiple tasks read power
supply properties simultaneously, or when other callbacks are called
during its execution.

Since the series touches acpi_battery_alarm_store(), also convert the
use of sscanf("%lu\n") into the more preferred kstrtoul() beforehand.

With the series, the lock starvation issue on mentioned devices is
greatly improved according to the feedback from one of the device
owners.

Tested-by: Avraham Hollander <anhollander516@gmail.com>
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>

---
Changes in v4:
- Rebase and adopt devres-based resource management
- Refactor acpi_battery_notify() to hold the mutex across the entire
  function to improve readability and drop unnecessary variables (thanks
  Rafael J. Wysocki)
- Link to v3: https://patch.msgid.link/20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe

Changes in v3:
- Address Sashiko's concerns on my last-minute changes:
  - Set the number base to 10 in order not to break the ABI
  - Do not overwrite the initial value of `ret' in
    acpi_battery_get_property()
  - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151%40rong.moe
- Link to v2: https://patch.msgid.link/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe

Changes in v2:
- Address Sashiko's concerns:
  - Return from acpi_battery_notification_worker() early when the fifo
    is empty
  - Use pr_err_ratelimited() for potential event storms
  - Add missing `\n' in a printk message
  - Use a separated mutex to protect all properties instead of reusing
    update_lock
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Minimalize the critical section of acpi_battery_notify()
- Rearrange the series
- Dropped Tested-by from patch 3 due to massive rewrite
- Link to v1: https://patch.msgid.link/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe

---
Rong Zhang (3):
      ACPI: battery: Merge consecutive battery notifications
      ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
      ACPI: battery: Protect all properties with a separated mutex

 drivers/acpi/battery.c | 244 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 187 insertions(+), 57 deletions(-)
---
base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
change-id: 20260520-b4-acpi-battery-notification-90d781a3f217

Thanks,
Rong

