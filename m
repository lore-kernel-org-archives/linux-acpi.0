From: Chen Gong <gong.chen@linux.intel.com>
Subject: Parameter check for EINJ error injection - V3
Date: Wed, 22 May 2013 22:32:01 -0400
Message-ID: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806Ab3EWCin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 22:38:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org

[PATCH 1/2 V3] ACPI/APEI: Add parameter check before error injection
[PATCH 2/2 V3] ACPI/APEI: Update einj documentation for param1/param2

These two patches are employed to enhance the check for param1/param2
when einj is used. Param1/param2 are very subtle for the guy
who lacks of experience. These two patches add some extra checks to
avoid happening further errors to confuse users.

V3: only update the 1st patch based on Tony and Boris' suggestion.
V2: only update the 1st patch based on Boris' suggestion.
