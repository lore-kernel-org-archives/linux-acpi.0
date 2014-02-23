From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / PCI / PM: Delay resuming runtine-suspended devices during system-suspend
Date: Mon, 24 Feb 2014 00:18:22 +0100
Message-ID: <1853950.oxM3KDpyLu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63640 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752222AbaBWXGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2014 18:06:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <bhelgaas@google.com>

Hi All,

The PCI bus type and the ACPI PM domain resume runtime-suspended devices during
their .prepare() callbacks, which is suboptimal.

One problem caused by that is increasing the time of system suspend if there
are many runtime-suspended devices to resume during it (because the .prepare()
callbacks are executed sequentially).

The following two patches are intended to improve that one aspect slightly
in those two subsystems.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
