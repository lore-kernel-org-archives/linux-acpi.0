Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245509;
	b=4WNuKYDPdxZm/Ogqr81gUDcEMEkgMD1CPqvJitrtsQmxTOHZFNotkV8vFA6F96O8Imv1
	 XMveSKoTqg6GrIQAfcTYWwIRI1+jUOQ+IheG7NUSbI3Fvcw8Y57kQ3pmi7UxkqQv0XvMy
	 WMP7Ltuw3KY4OVuLvPjPafadbbuGI2NW016YZELWYUwvfOK/WNPbwYYP4Cak7vIdCcuaH
	 e8lsorqXWnfY7chbj71ZrBIuNOQ/dJ9XieVKAvA1IQhgjKwDb4mPHNFmzz0DQiJ+Roun6
	 F3Mib7TeIWoCr/kcNsEc6bvPsTMTjyeWosur+cYs5KXt0z3GG5NkAe9lpG6KfRMjbKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245509;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mLWRi7clyZ+2BRBX+H9GIcjpPPjDx5uTisgqIATOnMU=;
	b=0hNlCn+aEPOyLrXPzpHIHsvjXD4fNVqxxUnLU6KQmVBA5NJh/PKJVJV0yeukcyo08XMl
	 CyOev6eax4nffy6VZm7IOFs/Uy0SYGIz6h7W7qrKHb5beZ8hH9VSkn1oaf9tpqikBJrEL
	 ETOKwByIa2kygaHVBuVClBJaK7KS6PFAt/rmgMqH49Bzm6R1Xgtx4ZJrtkN3I4t5AA+r7
	 WvEfKKEKaZL0xeF/ZVfT0HVR8Lv/DilXgVFTEqbEi9ZHfcf/vXB5lPNaspS6WaFc6QVgB
	 vdJHImfuHwb80GQ20msPlR4APzpZjaf8M+k8A97oWVYR+/RSHrYsxCtdYuPgN9zci1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMfOwbqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034E606A31A;
	Thu, 29 Oct 2026 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMfOwbqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFC51F01825;
	Thu, 29 Oct 2026 03:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245509;
	bh=mLWRi7clyZ+2BRBX+H9GIcjpPPjDx5uTisgqIATOnMU=;
	h=From:To:Cc:Subject:Date;
	b=FMfOwbqz73MnWDatkNOqsl3lcye24le8SkN4ZQjTQGDzNtSMpN53PSs2/fxmznou5
	 4ZjQzNGCR9qnwUq4CpvIcxJbKUkqz5uY8ug+k3xyzNgtPl3S9aUmn7tERrK+BvvikG
	 Yp4xxY0teHKFmse+gv44+NXoQHpXa7GVZX/2jvRcU0mOZCdKKAf57q5GpHrdmXSLZe
	 jp3I6221fCGQ2bTJHOGcdJHnVR8nNZryPwbB6UfgtGwmM6TDMmGFE8fI9Gq/ivWLCs
	 ksZQKVLXjtKKhzLsBv9wVm59hoa+/pNlZQGJMYdu7UnJzfEeNew2gfxQwIS/cgHRdq
	 K4b/quBwV+EkQ==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com,
	syzbot+a265816368571f78ab88@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 0/2] ACPI: scan: Do not hold physical_node_lock across device_offline() and device_online()
Date: Wed, 28 Oct 2026 23:45:05 -0400
Message-ID: <20261029034507.2721580-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

syzbot has reported a lockdep cycle between physical_node_lock and the
CPU hotplug locks, which comes from acpi_bus_offline() holding the ACPI
device's physical_node_lock while it offlines a CPU.  Patch 2 stops
holding physical_node_lock across device_offline() and device_online().

Patch 1 is new in v2.  It makes acpi_bus_offline() print the
"Offline failed." message itself, while the device cannot go away,
instead of passing the device to acpi_scan_try_to_offline() for
printing after the lock has been released.

Changes since v1:
 - New patch 1 (Rafael).
 - Patch 2: keep physical_node_lock held across put_device() and leave
   the loop with break (Rafael).
 - Patch 2: move the comments of the helpers next to their loops
   (Rafael).
 - Patch 2: the changelog no longer claims that physical_node_lock only
   protects the list of physical nodes.

Tested in a QEMU q35 guest with lockdep: the reproducer no longer
triggers the report, CPU and DIMM hot-removal through QMP and sysfs
eject work, and when a DIMM cannot be removed because one of its memory
blocks fails to go offline, the other blocks are put back online and
"memory memory32: Offline failed." is printed, as before.

v1: https://lore.kernel.org/r/20261028161600.1524682-1-sashal@kernel.org


Sasha Levin (2):
  ACPI: scan: Print the offline failure message in acpi_bus_offline()
  ACPI: scan: Do not hold physical_node_lock across device_offline() and
    device_online()

 drivers/acpi/scan.c     | 108 ++++++++++++++++++++++++++++++++--------
 include/acpi/acpi_bus.h |   1 +
 2 files changed, 89 insertions(+), 20 deletions(-)

-- 
2.53.0

