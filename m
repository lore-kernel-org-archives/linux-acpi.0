From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] ACPI scan and hotplug fixes for 3.14
Date: Mon, 04 Nov 2013 01:17:12 +0100
Message-ID: <5839747.7HXXGHmMBd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752031Ab3KDAKE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Nov 2013 19:10:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>

Hi,

The following three patches fix some issues that we have in the common ACPI
hotplug infrastructure.

If anyone sees any problems with them, please let me know.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
