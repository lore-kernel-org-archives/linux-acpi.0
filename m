From: Chen Gong <gong.chen@linux.intel.com>
Subject: Parameter check for EINJ error injection - V2
Date: Mon, 20 May 2013 03:20:31 -0400
Message-ID: <1369034433-13666-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21061 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374Ab3ETH1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 May 2013 03:27:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org

[PATCH 1/2 V2] ACPI/APEI: Add parameter check before error injection
[PATCH 2/2 V2] ACPI/APEI: Update einj documentation for param1/param2

These two patches are employed to enhance the check for param1/param2
when einj is used. Param1/param2 are very subtle for the guy
who lacks of experience. These two patches add some extra checks to
avoid happening further errors to confuse users.
