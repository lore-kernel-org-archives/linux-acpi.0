From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/5] ACPI video: cleanups and fixes for the recent
	buggy _BQC/_BCL/_BCM BIOSes
Date: Tue, 10 Mar 2009 16:03:23 +0800
Message-ID: <1236672203.2820.118.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbZCJICd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 04:02:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, all,

here is the patch set I made recently, including some cleanups and fixes
for the Thinkpad/Asus laptops with buggy _BQC/_BCL/_BCM implementation.

The first two patches checks if ACPI video driver fails to set/get the
current brightness level, which is not done before.

patch 3/4/5 are used to fix three different problems.

1. the brightness levels when machine is on AC/Battery are not exported
   by _BCL.
2. The supported brightness levels are reversed in the _BCL method.
3. Index values are used in _BQC/_BCL/_BCM method.

The patches have not been tested yet.
I send them here to see if someone has better ideas about these issues.
Any comments are welcome. :)

thanks,
rui
   


