From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] fixes to ACPI subsystem which assumes cpuidle is always enabled.
Date: Tue, 15 Jan 2013 17:23:22 -0500
Message-ID: <1358288604-24620-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24974 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab3AOWXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jan 2013 17:23:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: konrad@kernel.org, xen-devel@lists.xensource.com

Attached are two patches to the ACPI subsystem and the cpuidle drivers.

The fixes are to deal with the case when cpuidle_disabled returns true
and we try to hotplug CPUs on/off. 

 drivers/acpi/processor_idle.c | 3 +++
 drivers/idle/intel_idle.c     | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

