From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI: Rework acpi_bus_trim()
Date: Mon, 14 Jan 2013 22:33:57 +0100
Message-ID: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40751 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab3ANVdf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2013 16:33:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>

Hi All,

This series of patches changes the way acpi_bus_trim() works so that,
eventually, it walks the namespace twice detaching (ACPI) drivers from
device nodes being removed in the first pass and removing the device
nodes in the second pass.

The first two patches are just cleanups removing unused stuff:

[1/5] Remove the ops field from struct acpi_device (unrelated to the rest).
[2/5] Drop the second argument of acpi_device_unregister().

The next three patches actually rework acpi_bus_trim() in three steps:

[3/5] Drop the second argument of acpi_bus_trim() (all callers pass 1 in there
      anyway.
[4/5] Reimplement acpi_bus_trim() using acpi_walk_namespace().
[3/5] Make acpi_bus_trim() carry out two passes as described above.

I'm aware of the fact that this will conflict with the patches that Yinghai
posted a few days ago, but in my opinion the changes here are prerequisite for
the Yinghai's patchset.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
