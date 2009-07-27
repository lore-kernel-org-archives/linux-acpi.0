From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Dynamic configure max_cstate
Date: Mon, 27 Jul 2009 13:30:13 +0800
Message-ID: <1248672613.2560.604.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:23979 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752613AbZG0FaE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2009 01:30:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: yakui_zhao <yakui.zhao@intel.com>

When running a fio workload, I found sometimes cpu C state has
big impact on the result. Mostly, fio is a disk I/O workload
which doesn't spend much time with cpu, so cpu switch to C2/C3
freqently and the latency is big.

If I start kernel with idle=poll or processor.max_cstate=1,
the result is quite good. Consider a scenario that machine is
busy at daytime and free at night. Could we add a dynamic
configuration interface for processor.max_cstate or something
similiar with sysfs? So user applications could change the
max_cstate dynamically? For example, we could add a new
parameter to function cpuidle_governor->select to mark the
highest c state.

Any idea?

Yanmin


