From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Add new eMCA trace event interface
Date: Fri, 28 Mar 2014 01:52:56 -0400
Message-ID: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6519 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbaC1GQt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2014 02:16:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

[PATCH 1/5] trace, RAS: Add basic RAS trace event
[PATCH 2/5] CPER: Adjust code flow of some functions
[PATCH 3/5] trace, RAS: Add eMCA trace event interface
[PATCH 4/5] trace, eMCA: Add a knob to adjust where to save event log
[PATCH 5/5] trace, AER: Move trace into unified interface

This patch series add new eMCA trace event interface. To avoid conflict with
existed interface, a new unified trace event stub in the kernel is used.
New trace interface is mutually exclusive with console message via
a knob under debugfs. This knob is a reference counter. When it is opened,
the counter will be increased, whereas the counter will be decreased
if it is closed. Once this counter is greater than 0, the trace will be
used, otherwise, message will be routed to the console.

In the last patch, I merge older AER trace interface into new unified
trace interface.
