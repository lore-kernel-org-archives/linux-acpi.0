From: Thomas Renninger <trenn@suse.de>
Subject: Fixups for ACPI initrd table override
Date: Fri, 22 Feb 2013 14:12:20 +0100
Message-ID: <1361538742-67599-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56748 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789Ab3BVNMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2013 08:12:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net

These are rather minor fixups for code correctness.
Except the dependency for X86 which avoids build errors on IA64.

Sooner or later this X86 dependency (max_low_pfn_mapped) should vanish
from ACPI code, but for now just get the build failure quickly fixed with
an easy patch (the Kconfig one).

