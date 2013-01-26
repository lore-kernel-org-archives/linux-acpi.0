From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / scan: Additional changes
Date: Sat, 26 Jan 2013 23:39:04 +0100
Message-ID: <1581701.fnbebHrKch@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56741 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692Ab3AZWhs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jan 2013 17:37:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>

Hi All,

The following patches make two more changes to the ACPI namespace scanning
code that I think are more-or-less useful:

[1/2] Introduce lock to prevent acpi_bus_scan() from running in parallel with
      acpi_bus_trim() to avoid removing device nodes while we're setting
      them up.
[2/2] Change the scanning of fixed device nodes to work along the lines of
      acpi_bus_scan().

Patch [1/2] should apply on top of the acpi-scan branch, but [2/2] needs the
entire linux-pm.git/linux-next branch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
