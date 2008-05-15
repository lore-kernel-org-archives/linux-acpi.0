From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/5] pci-acpi: improvement for _OSC evaluation
Date: Thu, 15 May 2008 15:17:22 +0900
Message-ID: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36155 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYEOGSr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:18:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

Hi,

Here are some improvement patches for _OSC evaluation on PCI.

- [PATCH 1/5] pci-acpi: remove duplicate code for _OSC
- [PATCH 2/5] pci-acpi: use local buffer for _OSC
- [PATCH 3/5] pci-acpi: add flag to indicate query had been done
- [PATCH 4/5] pci-acpi: remove unused variable in __pci_osc_support_set
- [PATCH 5/5] pci-acpi: minor cleanups for _OSC

For details, please see the header of each patch.

Thanks,
Kenji Kaneshige

