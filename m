From: Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH 0/2]linux-next: fix two bugs in ACPI EC driver
Date: Thu, 11 Sep 2008 11:17:43 +0800
Message-ID: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37586 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbYIKDR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 23:17:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, astarikovskiy@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi all,

These patches fix two bugs in ACPI EC driver.
First one fix ec read and write data bug.
Second one fix ec EC_FLAGS_GPE_STORM flag always set bug.

Thanks,
Kevin


