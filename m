From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: New eMCA trace event interface V4
Date: Wed, 11 Jun 2014 04:34:44 -0400
Message-ID: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31757 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841AbaFKJDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2014 05:03:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, rostedt@goodmis.org
Cc: linux-acpi@vger.kernel.org

v4 -> v3: shrink trace size & adjust trace format.
v3 -> v2: adjust RAS subsystem format & bunch of minor adjustments.
v2 -> v1: merge the comments from Tony Luck & Borislav Petkov.

