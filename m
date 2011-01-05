From: yakui.zhao@intel.com
Subject: [Patch 0/3] Pmtools: Add the support of dumping ACPI table through /sys/firmware/acpi/tables
Date: Wed,  5 Jan 2011 09:35:30 +0800
Message-ID: <1294191333-7381-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1AEBei (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jan 2011 20:34:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Hi
    This patch set is to add the support of dumping ACPI table through the
interface of /sys/firmware/acpi/tables. It contains the following three patches.
They are based on pmtools-20101221 under 
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

	[Patch 1/3]: Clean up patch (Complain the table name of dynamic SSDT table
with the wrong checksum)

	[Patch 2/3]: Prefer dumping the ACPI table through /sys/firmware/acpi/tables
	This patch adds the support of dumping ACPI table through the interface of
/sys/firmware/acpi/tables. And this mechansim is preferred. In case it fails in
dumping ACPI table, it will then fall back to the conventional dumping mechanism
by mapping /dev/mem.(For example: when the system is booted with ACPI disabled,
we can't dump ACPI table through /sys/firmware/acpi/tables any more).

	[Patch 3/3]: Add one option to dump ACPI table through mapping /dev/mem.
	

Best regards.
    Yakui
