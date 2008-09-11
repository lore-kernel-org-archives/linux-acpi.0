From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 0/5] device wakeup event support v2
Date: Thu, 11 Sep 2008 14:30:37 +0800
Message-ID: <20080911063037.698427944@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYIKGiZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 02:38:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, david-b@pacbell.net

This series add device wakeup event detection support. This is the base to
implement runtime device suspend/resume, though we don't support it now.
But David said USB is approaching to this. See this bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.

changes v1 -> v2:
1. scan pci bridge for PME. Current implementation is just doing scan if target device is a bridge
2. move device_receive_wakeup_event() call to pci, and provide an API (pci_handle_wakeup_event()) for non-ACPI & non-PCIe platform
3. fixed a lot of coding style issues

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
-- 
