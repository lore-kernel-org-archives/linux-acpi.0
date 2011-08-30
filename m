From: Huang Ying <ying.huang@intel.com>
Subject: [RFC 0/2] ACPI, APEI, EINJ, Fix RAM accessing
Date: Tue, 30 Aug 2011 14:28:27 +0800
Message-ID: <1314685709-7280-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54850 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1H3G2d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Aug 2011 02:28:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

Some APEI firmware implementaiton will access injected address
specified in param1 to trigger the error when injecting memory error.
This may cause resource conflict with RAM and RAM accessing issue
in ACPI atomic IO support.  This patchset fixes this.

[RFC 1/2] ACPI, APEI, EINJ, Fix resource conflict on some machine
[RFC 2/2] ACPI, Add RAM mapping support to ACPI atomic IO support

Best Regards,
Huang Ying
