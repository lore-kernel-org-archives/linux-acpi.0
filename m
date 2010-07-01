From: Huang Ying <ying.huang@intel.com>
Subject: [BUGFIX 0/2] ACPI, APEI, Fix two bugs of APEI implementation
Date: Thu,  1 Jul 2010 16:29:01 +0800
Message-ID: <1277972943-1475-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28759 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab0GAI3I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 04:29:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

Fix two bugs of APEI implementaiton.

[BUGFIX 1/2] ACPI, APEI, Fix a typo of error path of apei_resources_request
[BUGFIX 2/2] ACPI, APEI, Rename CPER and GHES severity constants
