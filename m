From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/2] ACPI, APEI, use general HEST table parsing in AER firmware_first setup (resend)
Date: Thu, 11 Mar 2010 10:14:56 +0800
Message-ID: <1268273698-21940-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15543 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab0CKCSk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Mar 2010 21:18:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org


Changelog:

v2:

- Setup firmware_first for every PCIE end point instead of just root point.

- Wrap firmware accessing in a function instead of raw hardware, because HEST
 parsing involved.
