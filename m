From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / scan: Fix and cleanup related to acpi_bus_get_device()
Date: Wed, 30 Jan 2013 23:02:06 +0100
Message-ID: <1451967.YMyGeCCNtu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34421 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075Ab3A3V6A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2013 16:58:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>

Hi All,

One fix and one cleanup related to acpi_bus_get_device() follow:

[1/2] Fix acpi_bus_get_device() check in acpi_match_device()
[2/2] Clean up acpi_bus_get_parent()

On top of linux-pm/linux-next.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
