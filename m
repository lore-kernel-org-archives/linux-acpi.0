From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/2] fix bug 13620
Date: Tue, 28 Jul 2009 10:43:57 +0800
Message-ID: <1248749037.3166.64.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54416 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbZG1Cmb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jul 2009 22:42:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

http://bugzilla.kernel.org/show_bug.cgi?id=13620

Patch 1: ACPICA: revert acpi_os_validate_address() removal
Patch 2: ACPICA: fix leak of acpi_os_validate_address

Applied on top of Len's linux-acpi-2.6/test branch.

Lin Ming

