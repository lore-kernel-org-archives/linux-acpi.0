From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: trace, RAS: New eMCA trace event interface
Date: Tue,  4 Mar 2014 04:23:15 -0500
Message-ID: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58561 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410AbaCDJps (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2014 04:45:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: arozansk@redhat.com, linux-acpi@vger.kernel.org

[PATCH 1/2] trace, RAS: Add basic RAS trace event
[PATCH 2/2] trace, RAS: Add eMCA trace event interface

This patch series adds new eMCA trace event interface.
To avoid conflict with existed interface, I add one
new unified trace event stub in the kernel.
