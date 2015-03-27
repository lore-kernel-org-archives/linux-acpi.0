From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 0/7] minor cleanups for ACPI processor driver
Date: Fri, 27 Mar 2015 21:55:04 +0800
Message-ID: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34071 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbC0Nzp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 09:55:45 -0400
Received: by pdbni2 with SMTP id ni2so97319434pdb.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2015 06:55:44 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set are some minor cleanups for ACPI processor driver
to address the comments which raised by Rafael in ARM64 ACPI core
patches, so this patch set is on top of ARM64 ACPI core patches
the git tree is

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
branch for-next/acpi.

Rafael, I assume this patchset will be taken with your tree if
it makes sense, any rebase work needed please let me know.

the last patch - ACPI / processor: Introduce invalid_phys_cpuid()
will cut u64 mpidr to int, but I think it is ok for error values,
correct me if I'm wrong.

Comments are welcomed.

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

