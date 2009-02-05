From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/2] PCI/ACPI: move _OSC code to pci_root.c (v.2)
Date: Thu, 05 Feb 2009 23:18:07 +0900
Message-ID: <498AF51F.7070200@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:40245 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZBEOSR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2009 09:18:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>, Alex Chiang <achiang@hp.com>

Hi,

Here are updated version (v.2) of "PCI/ACPI: move _OSC code to
pci_root.c" patches. Patches are

  - [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
  - [PATCH 2/2] PCI/ACPI: rename pci_osc_control_set()

ChangeLog
---------
[v.1 -> v.2]
  - Change the debug message.
    [old]: "_OSC FW not grant req. control."
    [new]: "Firmware did not grant requested _OSC control"
    (Based on the feedback from Andrew Patterson and Alex Chiang)

  - Rename pci_osc_control_set() to acpi_pci_osc_control_set() and
    move _OSC related definitions from include/linux/pci-acpi.h to
    include/linux/acpi.h.
    (Based on the feedback from Andrew Patterson)

Thanks,
Kenji Kaneshige

