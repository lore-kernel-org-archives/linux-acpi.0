From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/4] ACPI, APEI, Some fixes and ERST debug support for 2.6.36
Date: Mon,  2 Aug 2010 15:48:21 +0800
Message-ID: <1280735305-15379-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53447 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab0HBHsh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 03:48:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

[PATCH 1/4] ACPI, APEI, Fix a typo of error path of apei_resources_request
[PATCH 2/4] ACPI, APEI, Rename CPER and GHES severity constants
[PATCH 3/4] ACPI, APEI, Manage GHES as platform devices
[PATCH 4/4] ACPI, APEI, ERST debug support
