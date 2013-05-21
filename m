From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 1/2 V2] ACPI/APEI: Add parameter check before error
 injection
Date: Tue, 21 May 2013 20:19:16 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA69843@ORSMSX106.amr.corp.intel.com>
References: <1369034433-13666-1-git-send-email-gong.chen@linux.intel.com>
 <1369034433-13666-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23968 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab3EUUT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 May 2013 16:19:56 -0400
In-Reply-To: <1369034433-13666-2-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

+	/* ensure param1/param2 existed */
+	if (!(param_extension || acpi5))
+		goto inject;
+
+	/* ensure injection is memory related */
+	if (type & ACPI5_VENDOR_BIT) {
+		if (vendor_flags != SETWA_FLAGS_MEM)
+			goto inject;
+	} else if (!(type & MEM_ERROR_MASK))
+		goto inject;

Maybe a comment before all these three goto blocks saying why we are jumping
around.  Perhaps:

	/* We need extra sanity checks for memory errors. Other types leap directly to injection */

+
+	/*
+	 * When error injection type is memory related, param2 is the address
+	 * mask of param1. This mask is used to ensure that the final address
+	 * (param1 & param2) is meaningful. If param2 has a *weird* style
+	 * like 0xf0f0f0f0f0f0f0f0, it means the injection address can be
+	 * anywhere around param1, and that must be forbidden. In that reason,
+	 * PAGE_MASK is employed to avoid injection address discontinuous.
+	 * If one finds a special case not to satisfy this requirement, please
+	 * fix it.
+	 */
+	pfn = PFN_DOWN(param1 & param2);
+	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
+		return -EINVAL;

This has too much comment (rare!) and is still too complicated. Split the tests apart?

	/*
	 * Disallow crazy address masks that give BIOS leeway to pick injection address
	 * almost anywhere. Insist on page or better granularity
	 */
	if ((param2 & PAGE_MASK) != PAGE_MASK)
		return -EINVAL;

	/* make sure target address is normal memory */
	pfn = PFN_DOWN(param1 & param2);
	if (!page_is_ram(pfn))
		return -EINVAL;

