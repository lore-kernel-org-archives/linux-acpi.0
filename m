From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI, APEI: Add validation check before GHES error is
 recorded
Date: Thu, 29 Mar 2012 17:07:14 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F15B73074@ORSMSX104.amr.corp.intel.com>
References: <1333004952-12403-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54378 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759847Ab2C2RHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2012 13:07:19 -0400
In-Reply-To: <1333004952-12403-1-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

+	if (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)
+		m.addr = mem_err->physical_addr;

At the moment "addr" is the only useful value in this record ... so
if we find that we can't supply it because we don't know it - then the
record has no value, and we might as well not send it.

E.g. start the function with:

	if (!(mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS))
		return;

-Tony
