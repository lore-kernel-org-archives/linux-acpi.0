From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v3 0/5] ACPI, APEI, APEI basic support
Date: Mon, 28 Dec 2009 14:12:19 +0800
Message-ID: <1261980744-4450-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7038 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbZL1GMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 01:12:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


APEI stands for ACPI Platform Error Interface, which allows to report
errors (for example from chipset) to the operating system. This
improves NMI handling especially. In addition it supports error
serialization and error injection.

This patchset provides basic support for APEI, some important parts
such as ERST, HEST generic error source and BEST are still missing
because they are not finalized yet.

The HEST tabling parsing code will be used by PCIE AER intialization
code to prevent touching PCIE root port in firmware first mode. EINJ
can be used to test some RAS related code such as MCE and PCIE AER.


v3:

 - Use acpi_os_read/write_port.

 - Fix error message for firmware bug.

 - Remove hest_exit.

v2:

 - Separate pre-map + atomic read/write into atomicio.c from
   apei-base.c and in separated patch.
