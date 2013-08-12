From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 0/2] Protect cpu map updates from ACPI processor
Date: Mon, 12 Aug 2013 09:45:52 -0600
Message-ID: <1376322354-13026-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:4632 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab3HLPrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Aug 2013 11:47:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, isimatu.yasuaki@jp.fujitsu.com, Toshi Kani <toshi.kani@hp.com>

CPU system maps are protected with reader/writer locks.  The reader
lock, put_online_cpus(), assures that the maps are not updated while
holding the lock.  The writer lock, cpu_hotplug_begin(), is used to
udpate the cpu maps along with cpu_maps_update_begin().

However, the ACPI processor handler updates the cpu maps without
holding the the writer lock.  This patchset fixes this problem.

---
The patchset is based on linux-next of the pm tree.

---
Toshi Kani (2):
 CPU hotplug: Export cpu_hotplug_begin() interface
 ACPI: Acquire writer lock to update cpu maps

---
 drivers/acpi/acpi_processor.c | 21 ++++++++++++++++-----
 include/linux/cpu.h           |  2 ++
 kernel/cpu.c                  |  4 ++--
 3 files changed, 20 insertions(+), 7 deletions(-)

