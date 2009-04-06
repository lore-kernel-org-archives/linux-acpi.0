From: venkatesh.pallipadi@intel.com
Subject: [patch 0/2] acpi x86: Make aperf mperf MSR usage in acpi_cpufreq read only
Date: Mon, 06 Apr 2009 11:26:06 -0700
Message-ID: <20090406182606.706570000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41278 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbZDFS2H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Apr 2009 14:28:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Patchset makes aperf mperf MSR access in acpi_cpufreq read only. This
enables other kernel and usaer level components to share read access
to these MSRs.

-- 

