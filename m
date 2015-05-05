From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 0/7] minor cleanups for ACPI processor driver
Date: Tue,  5 May 2015 10:46:31 +0800
Message-ID: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34401 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965397AbbEECr3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 22:47:29 -0400
Received: by pacyx8 with SMTP id yx8so177878271pac.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2015 19:47:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set are some minor cleanups for ACPI processor driver
to address the comments which raised by Rafael in ARM64 ACPI core
patches. I rebased this patch set on top of current Linus's tree.

v2:
 - rebased on top of 4.1-rc2

Hanjun Guo (7):
  ACPI / processor: remove cpu_index in acpi_processor_get_info()
  ACPI / processor: remove phys_id in acpi_processor_get_info()
  ACPI / processor: Introduce invalid_logical_cpuid()
  Xen / ACPI / processor: use invalid_logical_cpuid()
  Xen / ACPI / processor: Remove unneeded NULL check in
    xen_acpi_processor_enable()
  ACPI / processor: return specific error instead of -1
  ACPI / processor: Introduce invalid_phys_cpuid()

 drivers/acpi/acpi_processor.c     | 20 +++++++++-----------
 drivers/acpi/processor_core.c     | 10 +++++-----
 drivers/acpi/processor_pdc.c      |  5 +----
 drivers/xen/xen-acpi-cpuhotplug.c | 12 +++---------
 include/linux/acpi.h              | 10 ++++++++++
 5 files changed, 28 insertions(+), 29 deletions(-)

-- 
1.9.1

