From: Thomas Renninger <trenn@suse.de>
Subject: X86 cpuidle cleanups V3
Date: Tue, 17 Jan 2012 22:40:06 +0100
Message-ID: <1326836408-23177-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53861 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab2AQVkP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 16:40:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: shaohua.li@intel.com

V3: - Fix a critical typo in
      [PATCH 1/2] ACPI processor: Remove unneeded variable passed by
    - Make checkpatch clean

This prepares physical CPU hotplug functionality for the intel_idle
and acpi_processor (cpuidle/throttling) driver.
This still needs:
  - split up of processor_add function into
    1) A minimum part just registering the core, not trying to init
       anything, because cpu_data(cpu) is not initialized yet
       (feature flags, model, family, all zero), MSRs cannot get
       executed as the cpu is still offline at ACPI hotplug time
    2) A part doing throttling/cpuidle intitialization when it's
       safe to do so
  - Only do minimum registration at ACPI CPU hotplug event time. Delay
    and do full cpuidle/throttling init when the physically hotplugged
    CPU is onlined via echo 1 >/sys/../cpuX/online the first time

   Thomas
       

