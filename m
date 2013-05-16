From: Chen Gong <gong.chen@linux.intel.com>
Subject: Parameter check for EINJ error injection
Date: Wed, 15 May 2013 22:29:05 -0400
Message-ID: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319Ab3EPCfl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 May 2013 22:35:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org

[PATCH 1/2] ACPI/APEI: Add parameter check before error injection
[PATCH 2/2] ACPI/APEI: Update einj documentation for param1/param2

There two patches are employed to enhance the check for param1/param2
when einj is used. Param1/param2 are very subtle for the guy
who lacks of experience. These two patches add some extra checks to
avoid happening further errors to confuse users.

