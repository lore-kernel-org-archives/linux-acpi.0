From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/11] RFC: various ACPI core cleanups
Date: Wed, 05 Nov 2008 16:17:32 -0700
Message-ID: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:7064 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYKEXRd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:17:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

This series improves the ACPI debug documentation, improves
modularity, makes Kconfig options a little more consistent,
and removes some initcalls to reduce link order dependencies.

Comments welcome.

Bjorn
