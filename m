Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582CFC433FE
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Mar 2022 14:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCQOOE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCQOOD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:14:03 -0400
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D861FE566
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 07:12:46 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id E8339168F9E;
        Thu, 17 Mar 2022 15:03:45 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id kz3hNcE/M2Id8zMAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 15:03:45 +0100
Date:   Thu, 17 Mar 2022 15:03:40 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@kernel.org
Cc:     vit@kabele.me, r.marek@assembler.cz, devel@acpica.org,
        mingo@redhat.com, robert.moore@intel.com, linux-kernel@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] platform/x86, apcica: Sanitize EBDA pointer from memory
Message-ID: <YjM/vI268K+vH3jH@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@kernel.org, linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When testing custom virtualization platform, we noticed that in cases
where the memory is initialized with random pattern, the Linux guest
tends to crash on EPT violation.

It turns out that (at least two) codepaths during boot do not check the
validity of EBDA pointer retrieved from BDA memory at address 0x40e.
In case that the returned address is over 640K, the kernel happily
touches the VGA memory (which was not present in our setup, hence the
EPT violation).

This may be problematic in other virtualized environment too, but it can
probably also happen on bare metal when booted with legacy free (e.g.
UEFI without CSM) firmware, because the BDA may not be initialized and
the VGA range might not be properly decoded.

The third patch of the series adds workaround for the situation where
EBDA is smaller than 1KiB and the ACPI code scanning for RSDP table
bumps to the VGA memory.

The two acpcia patches can eventually be squashed together, it's up to you.

I tested these patches on my lenovo laptop (and in QEMU if that counts).

Vit Kabele (3):
  platform/x86: Check validity of EBDA pointer in mpparse.c
  acpica: Check that the EBDA pointer is in valid range
  acpica: Do not touch VGA memory when EBDA < 1KiB

 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 drivers/acpi/acpica/tbxfroot.c   | 25 ++++++++++++++++++-------
 4 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.30.2

